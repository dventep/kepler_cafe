from django.db import models
from django.db.models.deletion import CASCADE
from datetime import date
from django.utils import timezone
from django.contrib.auth.hashers import make_password

class Question(models.Model):

	"""
	----------
	Description
	    En está clase se almacenarán todas las preguntas o cuestionarios que se le quieren realizar a los clientes.
	----------
	Parameters
        name : Char
            Nombre del producto.
        description : Char
            Descripción del producto.
        creation_date : Datetime
            Fecha de creación.
	"""
	name = models.CharField('Nombre', max_length=50, default='', unique=True)
	description = models.CharField('Descripción', max_length=300, default='')
	creation_date = models.DateTimeField('Fecha de creación', default=timezone.now)
	
	class Meta:
		verbose_name = "Pregunta"
		verbose_name_plural = "Preguntas"
		ordering = ["name", "pk"]

	def __str__(self):
		return f"ID {str(self.pk)} - {self.name}"

class Question_Answer(models.Model):
	"""
	----------
	Description
		Esta tabla permite almacenar las respuestas o apreciaciones que tienen los clientes de preguntas.
	----------
	Parameters
		score : char
			Puntuación.
		description : char
			Descripción.
		creation_date : char
			Fecha de creación.
		question : FK Question
			Relación con la tabla Pregunta.
		product : FK Product
			Relación con la tabla Producto.
	"""
	score = models.IntegerField('Puntuación', blank=True, null=True, default=None)
	description = models.CharField('Descripción', max_length=250,  blank=True, null=True, default=None)
	creation_date = models.DateTimeField('Fecha de creación', default=timezone.now)
	question = models.ForeignKey('Question', related_name="question_question_answer", on_delete = models.CASCADE, verbose_name = "Pregunta")
	product = models.ForeignKey('Inventory.Product', related_name="product_question_answer", on_delete = models.CASCADE, verbose_name = "Producto", blank=True, null=True, default=None)


	class Meta:
		verbose_name = ""
		verbose_name_plural = 'Cargos'
	def __str__(self):
		return f"ID {self.pk} - {self.name}"