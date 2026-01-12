from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
import hashlib
import os


class UploadedFile(models.Model):
    FILE_TYPES = (
        ('image', 'Image'),
        ('pdf', 'PDF'),
    )
    
    INTEGRITY_STATUS = (
        ('clean', 'Clean - No Edits Detected'),
        ('suspicious', 'Suspicious - Possible Edits'),
        ('modified', 'Modified - Edits Detected'),
        ('error', 'Error During Analysis'),
    )
    
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='uploaded_files')
    file = models.FileField(upload_to='uploads/%Y/%m/%d/')
    original_filename = models.CharField(max_length=255)
    file_type = models.CharField(max_length=10, choices=FILE_TYPES)
    file_size = models.BigIntegerField(help_text="File size in bytes")
    
    # Hash for integrity
    sha256_hash = models.CharField(
        max_length=64, 
       # unique=True,
        blank=False,  # Don't allow blank
        null=False    # Don't allow null
    )
    perceptual_hash = models.CharField(max_length=64, blank=True, null=True)
    
    # Audit results
    integrity_status = models.CharField(max_length=20, choices=INTEGRITY_STATUS, default='clean')
    
    # Timestamps
    uploaded_at = models.DateTimeField(default=timezone.now)
    analyzed_at = models.DateTimeField(blank=True, null=True)
    
    # Admin review
    reviewed_by = models.ForeignKey(
        User, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True, 
        related_name='reviewed_files'
    )
    reviewed_at = models.DateTimeField(blank=True, null=True)
    admin_notes = models.TextField(blank=True)
    
    class Meta:
        ordering = ['-uploaded_at']
        indexes = [
            models.Index(fields=['user', '-uploaded_at']),
            models.Index(fields=['integrity_status']),
            models.Index(fields=['sha256_hash']),
        ]
        constraints = [
        models.UniqueConstraint(
            fields=['user', 'sha256_hash'],
            name='unique_file_per_user'
        )]

    
    def __str__(self):
        return f"{self.original_filename} - {self.user.username}"
    
    def calculate_sha256(self):
        """Calculate SHA256 hash of the file"""
        sha256 = hashlib.sha256()
        with self.file.open('rb') as f:
            for chunk in iter(lambda: f.read(4096), b""):
                sha256.update(chunk)
        return sha256.hexdigest()
    
    def get_file_extension(self):
        """Get file extension"""
        return os.path.splitext(self.original_filename)[1].lower()


class AuditReport(models.Model):
    uploaded_file = models.OneToOneField(UploadedFile, on_delete=models.CASCADE, related_name='audit_report')
    
    # Image EXIF analysis
    has_exif = models.BooleanField(default=False)
    exif_software = models.CharField(max_length=255, blank=True)
    exif_datetime_original = models.CharField(max_length=100, blank=True)
    exif_datetime_modified = models.CharField(max_length=100, blank=True)
    exif_anomalies = models.TextField(blank=True, help_text="JSON or text describing anomalies")
    
    # PDF metadata analysis
    pdf_creator = models.CharField(max_length=255, blank=True)
    pdf_producer = models.CharField(max_length=255, blank=True)
    pdf_creation_date = models.CharField(max_length=100, blank=True)
    pdf_modification_date = models.CharField(max_length=100, blank=True)
    pdf_page_count = models.IntegerField(blank=True, null=True)
    pdf_anomalies = models.TextField(blank=True)
    
    # Detection flags
    metadata_mismatch = models.BooleanField(default=False)
    suspicious_software = models.BooleanField(default=False)
    hash_collision = models.BooleanField(default=False)
    
    # Summary
    detection_summary = models.TextField(blank=True)
    confidence_score = models.DecimalField(
        max_digits=5, 
        decimal_places=2, 
        blank=True, 
        null=True,
        help_text="0-100 confidence that file is unmodified"
    )
    
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['-created_at']
    
    def __str__(self):
        return f"Audit for {self.uploaded_file.original_filename}"