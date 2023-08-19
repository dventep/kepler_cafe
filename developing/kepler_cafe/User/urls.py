from django.contrib import admin
from django.urls import path
from django.urls import include
from .views import register_html

urlpatterns = [
    path('accounts/signup/', register_html),

    
]