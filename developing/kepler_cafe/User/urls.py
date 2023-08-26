from django.contrib import admin
from django.urls import path
from django.urls import include
from .views import home, register_html, manage_profile, get_profiles, get_profile, save_profile

urlpatterns = [
    path('', home, name="home"),
    # path('home', home),
    path('accounts/signup/', register_html),
    path('accounts/me/', manage_profile, name="accounts_me"),
    path('accounts/profiles/', get_profiles),
    path('accounts/get_profile/', get_profile),
    path('accounts/save_profile/', save_profile),
]