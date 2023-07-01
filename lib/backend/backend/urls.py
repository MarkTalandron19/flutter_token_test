from django.contrib import admin
from django.urls import path
from django.urls import re_path, include
from rest_framework.authtoken import views
from api.views import AccountView

urlpatterns = [
    re_path('admin/', admin.site.urls),
    re_path('api/', include('api.urls')),
    path('info/', AccountView.get_user_info),
    path('auth/', views.obtain_auth_token),
]