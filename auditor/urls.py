from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('upload/', views.upload_file, name='upload_file'),
        path('logout/', views.logout_view, name='logout'),  # ✅ Add this line
    path('file/<int:pk>/', views.file_detail, name='file_detail'),
    path('file/<int:pk>/delete/', views.delete_file, name='delete_file'),

]