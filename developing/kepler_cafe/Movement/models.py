from django.db import models
from django.db.models.deletion import CASCADE
from datetime import date
from django.utils import timezone
from User.models import UserProfile
from Inventory.models import Product

Select_Transaction_Action = (
	("out", "Compra"),
	("in", 'Recepción'),
)
Select_Order_Status = (
	("waiting", "En espera"),
	("success", 'Realizada'),
)

class Shopping_Car(models.Model):
	"""
	----------
	Description
	    En está clase se almacenarán todos los productos en el estado de confirmación de compra.
	----------
	Parameters
        quantity : Int
            Cantidad del producto.
        creation_date : Datetime
            Unidad de medida.
        user : FK User
            Relación con la tabla Usuario.
        product : FK Product
            Relación con la tabla Producto.
	"""
	quantity = models.IntegerField('Cantidad', default=0)
	creation_date = models.DateTimeField('creation date', auto_now_add = True)
	description = models.CharField('Descripción', max_length=200, default=None, blank=True, null=True)
	user = models.ForeignKey('User.UserProfile', related_name="userprofile_shopping_car", on_delete = models.CASCADE, verbose_name = "Usuario")
	product = models.ForeignKey('Inventory.Product', related_name="product_shopping_car", on_delete = models.CASCADE, verbose_name = "Producto")
	
	class Meta:
		verbose_name = "Carrito de compra"
		verbose_name_plural = "Carritos de compras"
		ordering = ["user", "product"] 

	def __str__(self):
		return f"ID {str(self.pk)} - {self.product.name} -> {self.user.first_name} {self.user.last_name}"

class Main_Purchase(models.Model):
	"""
	----------
	Description
	    En está clase se almacenarán las compras principales con las que va relacionada la compra específica.
	----------
	Parameters
        money_total_value : Int
            Valor total monetario.
        point_total_value : Int
            Valor total en puntos.
        creation_date : Datetime
            Fecha de creación.
        delivery_date : Datetime
            Fecha de entrega.
        user : FK User
            Relación con la tabla Usuario.
	"""
	money_total_value = models.FloatField('Valor total monetario', default=None, blank=True, null=True)
	point_total_value = models.IntegerField('Valor total en puntos', default=None, blank=True, null=True)
	creation_date = models.DateTimeField('Fecha de creación', auto_now_add = True)
	delivery_date = models.DateTimeField('Fecha de entrega')
	user = models.ForeignKey('User.UserProfile', related_name="userprofile_main_purchase", on_delete = models.CASCADE, verbose_name = "Usuario")
	
	class Meta:
		verbose_name = "Compra principal"
		verbose_name_plural = "Compras principales"
		ordering = ["creation_date", "delivery_date", "money_total_value", "point_total_value"]

	def __str__(self):
		return f"ID {str(self.pk)} - {self.user.first_name} {self.user.last_name} -> {self.money_total_value} ~ {self.point_total_value}"

class Purchase_Detail(models.Model):
	"""
	----------
	Description
	    En está clase se almacenarán los detalles de las compras especificando los productos.
	----------
	Parameters
        money_unit_value : Int
            Valor unitario monetario.
        point_unit_value : Int
            Valor unitario en puntos.
        quantity : Int
            Cantidad.
        main_purchase : FK Main_Purchase
            Relación con la tabla de Compra Principal.            
        product : FK Product
            Relación con la tabla de Producto.
	"""
	money_unit_value = models.FloatField('Valor unitario monetario', default=None, blank=True, null=True)
	point_unit_value = models.IntegerField('Valor unitario en puntos', default=None, blank=True, null=True)
	quantity = models.IntegerField('Cantidad', default=0)
	description = models.CharField('Descripción', max_length=200, default=None, blank=True, null=True)
	status = models.CharField("Estado de orden", max_length=50, default="", choices=Select_Order_Status)
	main_purchase = models.ForeignKey('Main_Purchase', related_name="main_purchase_purchase_detail", on_delete = models.CASCADE, verbose_name = "Compra principal")
	product = models.ForeignKey('Inventory.Product', related_name="product_purchase_detail", on_delete = models.CASCADE, verbose_name = "Producto")
	
	class Meta:
		verbose_name = "Detalle de compra"
		verbose_name_plural = "Detalles de compra"
		ordering = ["main_purchase", "product", "money_unit_value", "point_unit_value"] 

	def __str__(self):
		return f"ID {str(self.pk)} - {self.product.name} <- {self.main_purchase.user.first_name} {self.main_purchase.user.last_name} -> {self.money_unit_value} ~ {self.point_unit_value}"

class Point_Transaction(models.Model):
	"""
	----------
	Description
	    En está clase se almacenarán las transacciones de puntos que realizan los usuarios.
	----------
	Parameters
        quantity_point : Int
            Cantidad de puntos en las transacciones.
        action : Char
            Acción de la transacción.
        transaction_date : Datetime
            Fecha de transacción.
        purchase_detail : FK Purchase_Detail
            Relación con la tabla Detalle de Compra.
	"""
	quantity_point = models.IntegerField('Cantidad de puntos', default=0)
	action = models.CharField('Acción de transacción', max_length=50, default="", choices=Select_Transaction_Action)
	transaction_date = models.DateTimeField('Fecha de transacción')
	purchase_detail = models.ForeignKey('Purchase_Detail', related_name="purchase_detail_point_transaction", on_delete = models.CASCADE, verbose_name = "Detalle de compra")
	
	class Meta:
		verbose_name = "Transacción de puntos"
		verbose_name_plural = "Transacciones de puntos"
		ordering = ["transaction_date", "action", "purchase_detail",]

	def __str__(self):
		return f"ID {str(self.pk)} - {self.purchase_detail.user.first_name} {self.purchase_detail.user.last_name} -> {self.action}"




	