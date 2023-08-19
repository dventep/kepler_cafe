from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required
from .models import Product

# Create your views here.


@login_required
def inventory_list(request):
    inventory = Product.objects.all()
    context = {
        'tittle': 'Inventory List',
        'Inventory': inventory

    }
    return render(request, 'inventory/Producto/vistaPrincipalProductos.html', context=context)