# Generated by Django 4.0.3 on 2023-08-30 16:37

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Interaction', '0004_question_answer_user'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='question_answer',
            options={'verbose_name': 'Respuesta a pregunta', 'verbose_name_plural': 'Respuestas a preguntas'},
        ),
    ]
