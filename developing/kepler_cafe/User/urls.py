from django.contrib import admin
from django.urls import path
from django.urls import include
from .views import home, register_html, manage_profile, terms_and_conditions

urlpatterns = [
    path('', home, name="home"),
    # path('home', home),
    path('accounts/signup/', register_html, name="accounts_signup"),
    path('accounts/me/', manage_profile, name="accounts_me"),
    path('terms/', terms_and_conditions, name="terms"),
]