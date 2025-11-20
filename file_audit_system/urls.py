from django.contrib import admin
from django.urls import path, include
from django.contrib.auth import views as auth_views
from django.conf import settings
from django.conf.urls.static import static
from auditor import views as auditor_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('auditor.urls')),
    path('register/', auditor_views.register, name='register'),
    path('login/', auditor_views.user_login, name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)