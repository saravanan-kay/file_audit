from django.contrib import admin
from django.utils.html import format_html
from django.utils import timezone
from .models import UploadedFile, AuditReport


@admin.register(UploadedFile)
class UploadedFileAdmin(admin.ModelAdmin):
    list_display = [
        'original_filename', 
        'user', 
        'file_type', 
        'integrity_status_colored',
        'file_size_formatted',
        'uploaded_at',
        'reviewed_status'
    ]
    list_filter = ['file_type', 'integrity_status', 'uploaded_at', 'reviewed_by']
    search_fields = ['original_filename', 'user__username', 'sha256_hash']
    readonly_fields = [
        'sha256_hash', 
        'perceptual_hash', 
        'file_size', 
        'uploaded_at', 
        'analyzed_at'
    ]
    fieldsets = (
        ('File Information', {
            'fields': ('user', 'file', 'original_filename', 'file_type', 'file_size')
        }),
        ('Integrity Data', {
            'fields': ('sha256_hash', 'perceptual_hash', 'integrity_status', 'analyzed_at')
        }),
        ('Admin Review', {
            'fields': ('reviewed_by', 'reviewed_at', 'admin_notes'),
            'classes': ('collapse',)
        }),
    )
    date_hierarchy = 'uploaded_at'
    
    def integrity_status_colored(self, obj):
        colors = {
            'clean': 'green',
            'suspicious': 'orange',
            'modified': 'red',
            'error': 'gray'
        }
        return format_html(
            '<span style="color: {}; font-weight: bold;">{}</span>',
            colors.get(obj.integrity_status, 'black'),
            obj.get_integrity_status_display()
        )
    integrity_status_colored.short_description = 'Integrity Status'
    
    def file_size_formatted(self, obj):
        size = obj.file_size
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size < 1024:
                return f"{size:.2f} {unit}"
            size /= 1024
        return f"{size:.2f} TB"
    file_size_formatted.short_description = 'File Size'
    
    def reviewed_status(self, obj):
        if obj.reviewed_by:
            return format_html(
                '<span style="color: green;">✓ Reviewed</span>'
            )
        return format_html(
            '<span style="color: orange;">Pending</span>'
        )
    reviewed_status.short_description = 'Review Status'
    
    actions = ['mark_as_reviewed', 'mark_as_clean', 'mark_as_suspicious']
    
    def mark_as_reviewed(self, request, queryset):
        updated = queryset.update(
            reviewed_by=request.user,
            reviewed_at=timezone.now()
        )
        self.message_user(request, f'{updated} file(s) marked as reviewed.')
    mark_as_reviewed.short_description = 'Mark selected as reviewed'
    
    def mark_as_clean(self, request, queryset):
        updated = queryset.update(integrity_status='clean')
        self.message_user(request, f'{updated} file(s) marked as clean.')
    mark_as_clean.short_description = 'Mark as clean'
    
    def mark_as_suspicious(self, request, queryset):
        updated = queryset.update(integrity_status='suspicious')
        self.message_user(request, f'{updated} file(s) marked as suspicious.')
    mark_as_suspicious.short_description = 'Mark as suspicious'


@admin.register(AuditReport)
class AuditReportAdmin(admin.ModelAdmin):
    list_display = [
        'uploaded_file',
        'confidence_score',
        'metadata_mismatch',
        'suspicious_software',
        'created_at'
    ]
    list_filter = ['metadata_mismatch', 'suspicious_software', 'created_at']
    search_fields = ['uploaded_file__original_filename', 'detection_summary']
    readonly_fields = ['uploaded_file', 'created_at']
    
    fieldsets = (
        ('Basic Information', {
            'fields': ('uploaded_file', 'detection_summary', 'confidence_score', 'created_at')
        }),
        ('Detection Flags', {
            'fields': ('metadata_mismatch', 'suspicious_software', 'hash_collision')
        }),
        ('Image Analysis', {
            'fields': (
                'has_exif', 
                'exif_software', 
                'exif_datetime_original', 
                'exif_datetime_modified',
                'exif_anomalies'
            ),
            'classes': ('collapse',)
        }),
        ('PDF Analysis', {
            'fields': (
                'pdf_creator',
                'pdf_producer',
                'pdf_creation_date',
                'pdf_modification_date',
                'pdf_page_count',
                'pdf_anomalies'
            ),
            'classes': ('collapse',)
        }),
    )