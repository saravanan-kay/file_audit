from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib import messages
from django.db import transaction
from django.utils import timezone
from django.core.paginator import Paginator
from .models import UploadedFile, AuditReport
from .file_analyzer import FileAnalyzer
from .forms import FileUploadForm
import os


def register(request):
    """User registration view"""
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            username = form.cleaned_data.get('username')
            messages.success(request, f'Account created for {username}!')
            login(request, user)
            return redirect('dashboard')
    else:
        form = UserCreationForm()
    return render(request, 'registration/register.html', {'form': form})


def user_login(request):
    """User login view"""
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                messages.success(request, f'Welcome back, {username}!')
                return redirect('dashboard')
    else:
        form = AuthenticationForm()
    return render(request, 'registration/login.html', {'form': form})

def logout_view(request):
    logout(request)
    return redirect('login')


@login_required
def dashboard(request):
    """User dashboard showing their uploaded files"""
    files = UploadedFile.objects.filter(user=request.user).select_related('audit_report')
    
    # Statistics
    total_files = files.count()
    clean_files = files.filter(integrity_status='clean').count()
    suspicious_files = files.filter(integrity_status='suspicious').count()
    modified_files = files.filter(integrity_status='modified').count()
    
    # Pagination
    paginator = Paginator(files, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'page_obj': page_obj,
        'total_files': total_files,
        'clean_files': clean_files,
        'suspicious_files': suspicious_files,
        'modified_files': modified_files,
    }
    return render(request, 'auditor/dashboard.html', context)


from django.db import transaction
from django.utils import timezone
from django.contrib import messages
from django.shortcuts import redirect, render
from django.contrib.auth.decorators import login_required
from .models import UploadedFile, AuditReport
from .forms import FileUploadForm
from .file_analyzer import FileAnalyzer
import hashlib


@login_required
def upload_file(request):
    """File upload and analysis view"""
    if request.method == 'POST':
        form = FileUploadForm(request.POST, request.FILES)
        if form.is_valid():
            uploaded_django_file = request.FILES['file']

            # ✅ Compute SHA256 *before* saving (read once)
            sha256_hash = hashlib.sha256()
            for chunk in uploaded_django_file.chunks():
                sha256_hash.update(chunk)
            sha256_value = sha256_hash.hexdigest()

            # Reset pointer to beginning before saving file
            uploaded_django_file.seek(0)

            # ✅ Prepare model instance but don't save yet
            uploaded_file = form.save(commit=False)
            uploaded_file.user = request.user
            uploaded_file.original_filename = uploaded_django_file.name
            uploaded_file.file_size = uploaded_django_file.size
            uploaded_file.sha256_hash = sha256_value

            # Determine file type
            ext = uploaded_file.get_file_extension()
            if ext in ['.jpg', '.jpeg', '.png']:
                uploaded_file.file_type = 'image'
            elif ext == '.pdf':
                uploaded_file.file_type = 'pdf'
            else:
                messages.error(request, 'Unsupported file type. Please upload JPEG, PNG, or PDF.')
                return redirect('upload_file')

            # ✅ Save the file and metadata now
            uploaded_file.save()

            # Check for duplicate hash
            duplicate = UploadedFile.objects.filter(
                sha256_hash=uploaded_file.sha256_hash
            ).exclude(id=uploaded_file.id).first()
            if duplicate:
                messages.warning(
                    request,
                    f'This file has been uploaded before by {duplicate.user.username} on {duplicate.uploaded_at}'
                )
                return redirect('upload_file')

            # ✅ File analysis block
            try:
                with transaction.atomic():
                    file_path = uploaded_file.file.path

                    # Analyze based on file type
                    if uploaded_file.file_type == 'image':
                        analysis = FileAnalyzer.analyze_image(file_path)
                        uploaded_file.perceptual_hash = analysis['perceptual_hash']
                    else:
                        analysis = FileAnalyzer.analyze_pdf(file_path)

                    # Integrity and audit fields
                    uploaded_file.integrity_status = FileAnalyzer.determine_integrity_status(
                        analysis['confidence_score']
                    )
                    uploaded_file.analyzed_at = timezone.now()
                    uploaded_file.save()

                    # Create audit report
                    audit_report = AuditReport.objects.create(
                        uploaded_file=uploaded_file,
                        detection_summary=analysis['detection_summary'],
                        confidence_score=analysis['confidence_score'],
                        metadata_mismatch=analysis.get('metadata_mismatch', False),
                        suspicious_software=analysis.get('suspicious_software', False),
                    )

                    # Image fields
                    if uploaded_file.file_type == 'image':
                        audit_report.has_exif = analysis.get('has_exif', False)
                        audit_report.exif_software = analysis.get('exif_software', '')
                        audit_report.exif_datetime_original = analysis.get('exif_datetime_original', '')
                        audit_report.exif_datetime_modified = analysis.get('exif_datetime_modified', '')
                        audit_report.exif_anomalies = analysis.get('exif_anomalies', '')

                    # PDF fields
                    if uploaded_file.file_type == 'pdf':
                        audit_report.pdf_creator = analysis.get('pdf_creator', '')
                        audit_report.pdf_producer = analysis.get('pdf_producer', '')
                        audit_report.pdf_creation_date = analysis.get('pdf_creation_date', '')
                        audit_report.pdf_modification_date = analysis.get('pdf_modification_date', '')
                        audit_report.pdf_page_count = analysis.get('pdf_page_count', 0)
                        audit_report.pdf_anomalies = analysis.get('pdf_anomalies', '')

                    audit_report.save()
                    messages.success(request, 'File uploaded and analyzed successfully!')
                    return redirect('file_detail', pk=uploaded_file.pk)

            except Exception as e:
                uploaded_file.integrity_status = 'error'
                uploaded_file.save()
                messages.error(request, f'Error analyzing file: {str(e)}')
                return redirect('dashboard')

    else:
        form = FileUploadForm()

    return render(request, 'auditor/upload.html', {'form': form})



@login_required
def file_detail(request, pk):
    """Detailed view of a specific file and its audit report"""
    uploaded_file = get_object_or_404(UploadedFile, pk=pk, user=request.user)
    
    try:
        audit_report = uploaded_file.audit_report
    except AuditReport.DoesNotExist:
        audit_report = None
    
    context = {
        'file': uploaded_file,
        'audit_report': audit_report,
    }
    return render(request, 'auditor/file_detail.html', context)


@login_required
def delete_file(request, pk):
    """Delete uploaded file"""
    uploaded_file = get_object_or_404(UploadedFile, pk=pk, user=request.user)
    
    if request.method == 'POST':
        # Delete physical file
        if os.path.isfile(uploaded_file.file.path):
            os.remove(uploaded_file.file.path)
        
        uploaded_file.delete()
        messages.success(request, 'File deleted successfully!')
        return redirect('dashboard')
    
    return render(request, 'auditor/delete_confirm.html', {'file': uploaded_file})