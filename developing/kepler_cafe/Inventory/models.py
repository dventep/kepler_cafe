from django.db import models
from django.db.models.deletion import CASCADE
from datetime import date
from django.utils import timezone
from django.contrib.auth.hashers import make_password

class Product(models.Model):

	"""
	----------
	Description
	    En está clase se almacenarán todos los productos.
	----------
	Parameters
        name : Char
            Nombre del producto.
        money_unit_price : Float
            Valor monetario unitario 
        point_unit_price : Int
            Valor de puntos unitario 
        description : Int
            Descripción del producto.
        quantity : Float
            Cantidad de unidades del producto
        weight : Float
            Peso del producto.
        measure_unit : Char
            Unidad de medida.
        status : Bool
            Estado del producto.
        category : FK Category
            Relación con la tabla Categoría.
	"""
	name = models.CharField('name', max_length = 255, null=False)
	money_unit_price = models.FloatField('Valor monetario unitario', default=0)
	point_unit_price = models.IntegerField('Valor de puntos unitario', default=0)
	description = models.CharField('Descripción', max_length = 250, default="")
	quantity = models.IntegerField('Cantidad', default=0)
	weight = models.FloatField('Peso', default=None, null=True, blank=True)
	measure_unit = models.CharField('Unidad de medida', max_length = 50, null=True, blank=True, default=None)
	status = models.BooleanField('Estado', default=True)
	creation_date = models.DateTimeField('creation date', auto_now_add = True)
	category = models.ForeignKey('Category', related_name="category_product", on_delete = models.CASCADE, verbose_name = "Categoría")
	
	class Meta:
		verbose_name = "Producto"
		verbose_name_plural = "Productos"
		ordering = ["name", "pk"]

	def __str__(self):
		return f"ID {str(self.pk)} - {self.name}"

class Category(models.Model):
	"""
	----------
	Description
		Esta tabla permite almacenar las categorías de los productos.
	----------
	Parameters
		name : char
			Nombre de la categoría
		description : char
			Descripción de la categoría
	"""
	name = models.CharField('Nombre', max_length=50, default='', unique=True)
	description = models.CharField('Descripción', max_length=250, default='')

	class Meta:
		verbose_name = "Categoría"
		verbose_name_plural = 'Categorías'
	def __str__(self):
		return f"ID {self.pk} - {self.name}"