from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required
from .models import Product
from .forms import Add_inventory, UpdateInventoryForm

# Create your views here.


@login_required
def inventory_list(request):
    inventories = Product.objects.all()
    context = {
        'tittle': 'Inventory List',
        'Inventories': inventories
    }
    return render(request, 'inventory/Producto/vistaPrincipalProductos.html', context=context)

@login_required
def per_product_view (request, pk):
    inventory = get_object_or_404(Product, pk=pk)
    context = {
        'inventory' : inventory
    }
    return render(request, 'inventory/detalleProducto.html', context=context)

@login_required
def add_product(request):
    if request.method == "POST":
        add_form = Add_inventory(data=request.POST)
        if add_form.is_valid():
            new_inventory = add_form.save(commit=False)
            new_inventory.sales = float(add_form.data['cost_per_item'] * float(add_form.data['quantity_sold']))
            new_inventory.save()
            return redirect('/inventory/')
    else:
        add_form = Add_inventory()
    return render(request, "inventory/inventory_add.html", {"form": add_form})

@login_required
def delete_product(request, pk):
    inventory = get_object_or_404(Product, pk=pk)
    inventory.delete()
    return redirect("/inventory/")

@login_required
def update_inventory(request, pk):
    inventory = get_object_or_404(Product, pk=pk)
    if request.method == "POST":
        updateForm = UpdateInventoryForm()
        if updateForm.isvalid():
            inventory.name = updateForm.data['name']
            inventory.quantity_in_stock = updateForm.data['quantity_in_stock']
            inventory.quantity_sold = updateForm.data['quantity_sold']
            inventory.cost_per_item = updateForm.data['cost_per_item']
            inventory.sales = float(inventory.cost_per_item) * float(inventory.quantity_sold)
            inventory.save()
            return redirect("/inventory")
        
    else:
        updateForm = UpdateInventoryForm
    context = {"form": updateForm}
    return render(request, "inventory/inventory_update.html", {"form": updateForm}, context=context)
    
