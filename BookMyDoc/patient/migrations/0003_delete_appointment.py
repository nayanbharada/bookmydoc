# Generated by Django 2.2 on 2020-01-31 06:58

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('patient', '0002_auto_20200131_1208'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Appointment',
        ),
    ]
