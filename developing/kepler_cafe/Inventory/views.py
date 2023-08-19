from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

# Create your views here.
def aguita(request):
    return HttpResponse("holaMundo(print)")