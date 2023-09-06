from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from django.db.models.deletion import CASCADE
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.models import BaseUserManager
from datetime import date
from django.utils import timezone
from django.contrib.auth.hashers import make_password

SELECT_YESNO = (
	(True, 'Sí'),
	(False, 'No'),
)
Select_Active = (
	(True, "Activo"),
	(False, 'Inactivo'),
)

class UserProfileManager(BaseUserManager):
	"""
		-------
		Description
			This class is used as a model for normal users creation and his privileges.
		-------
	"""
	def create_user(self, identification, email, first_name, last_name, password):
		"""
			----------
			Description
				This method is used for system users creation.
			Parameters
				email : Char
					Email is used for the record.
				user : UserProfileManager
					This is the user model with additional data required.
			----------
			Returns
				User : UserProfileManager
					Returns the created user.
		"""
		if not email:
			raise ValueError('Usuario debe tener un Email')
		email = self.normalize_email(email)
		password = make_password(password)
		user = self.model(identification = identification, email = email, first_name = first_name, last_name = last_name, password = password)
		user.save(using = self._db)
		return user

	def create_superuser(self, identification, email, first_name, last_name, password):
		"""
			----------
			Description
				This method is used for system privileges users creation.
			Parameters
				user : UserProfileManager
				    This is the user model with additional data required.
			----------
			Returns
				User : UserProfileManager
					Returns the created user.
		"""
		user = self.create_user(identification, email, first_name, last_name, password)
		user.is_superuser = True
		user.is_staff = True
		user.save(using = self._db)
		return user

class UserProfile(AbstractBaseUser, PermissionsMixin):
	"""
		----------
		Description
			This class store system users.
		----------
		Parameters
			identification: Char
				User's identification
			email : Email
				User's email.
			first_name : Char
				User's first name.
			last_name : Char
				User's last name.
			operation_center : FK
				User's operation center.
			is_active : Boolean
				Validate whether the user is active or not.
			is_staff : Boolean
				Validate whether the user is admin or not.
			objects : UserProfileManager
				Class will use for users creation.
	"""
	identification = models.BigIntegerField('Identificación', primary_key=True)
	first_name = models.CharField('Nombre', max_length = 50)
	last_name = models.CharField('Apellido', max_length = 50)
	email = models.EmailField('Email', max_length = 255, unique = True)
	phone_number = models.CharField('Número telefónico', max_length = 50)
	point = models.IntegerField("Puntos", default=0)
	salary = models.FloatField("Salario", default=None, null=True, blank=True)
	creation_date = models.DateTimeField('Fecha de creación', default=timezone.now)
	entrance_date = models.DateTimeField('Fecha de ingreso', default=timezone.now)
	birth_date = models.DateField('Fecha de nacimiento')
	inactive_date = models.DateTimeField('Fecha de inactivación', default=None, null=True, blank=True)
	date_joined = models.DateTimeField("date joined", default=timezone.now)
	is_active = models.BooleanField('Está activo', default = True, choices=SELECT_YESNO)
	is_staff = models.BooleanField('Es staff', default = False, choices=SELECT_YESNO)
	is_superuser = models.BooleanField('Es admin', default = False, choices=SELECT_YESNO)
	charge = models.ForeignKey('Charge', related_name="charge_user", default=None, null=True, blank=True, on_delete = models.CASCADE, verbose_name = "Cargo de usuario")
	objects = UserProfileManager()

	USERNAME_FIELD = 'email'

	REQUIRED_FIELDS = ['identification', 'first_name', 'last_name',]

	class Meta:
		verbose_name = "Usuario"
		verbose_name_plural = 'Usuarios'
		ordering = ['last_name', 'first_name', 'identification']

	def get_first_names(self):
		first = str(self.first_name).split(" ")
		last = str(self.last_name).split(" ") 

		return ("{} {}" .format(first[0], last[0]))

	def get_full_name(self):
		"""
			----------
			Description
				This method will handle to obtain the user complete name.

			----------
			Returns
				first_name : Char
				Returns the user's complete name.
			----------
		"""
		return (self.identification + " " + self.first_name + " " + self.last_name)
		
	from django import template

	register = template.Library() 

	@register.filter(name='has_group') 
	def has_group(user, group_name):
		return user.groups.filter(name=group_name).exists() 

	def __str__(self):
		"""
			----------
			Description
				This method will handle to obtain the user complete name when calls a instance of user class.
			----------
			Returns
				first_name : Char
				Returns the user's complete name.
			----------
		"""
		return "{} - {} {}" .format(self.identification, self.first_name, self.last_name)

class Charge(models.Model):
	"""
	----------
	Description
		Esta tabla permite almacenar los cargos de los usuarios empleados.
	----------
	Parameters
		name : char
			Nombre del cargo
	"""
	name = models.CharField('Nombre', max_length=200, default='', unique=True)

	class Meta:
		verbose_name = "Cargo"
		verbose_name_plural = 'Cargos'
	def __str__(self):
		return f"ID {self.pk} - {self.name}"
