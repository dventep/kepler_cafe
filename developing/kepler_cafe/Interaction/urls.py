from django.contrib import admin
from django.urls import path
from django.urls import include

from .views import Survey_Me, Survey_Do

urlpatterns = [
    path('surveys/me/', Survey_Me, name='surveys_me'),
    path('surveys/do/', Survey_Do, name='surveys_do')
]