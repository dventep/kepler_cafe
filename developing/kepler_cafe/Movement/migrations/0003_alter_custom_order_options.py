# Generated by Django 4.0.3 on 2023-08-17 02:56

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Movement', '0002_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='custom_order',
            options={'ordering': ['creation_date', 'product_shopping_car', 'purchase_detail'], 'verbose_name': 'Orden personalizada', 'verbose_name_plural': 'Ordenes personalizadas'},
        ),
    ]