from django.db import models
from django.contrib.auth.models import AbstractUser
from datetime import datetime


# Create your models here.

class User(AbstractUser):
    STATUS = (
        ('patient', 'Patient'),
        ('doctor', 'Doctor'),
        ('hospital', 'Hospital'),
    )

    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
    )

    is_type = models.CharField(max_length=10, choices=STATUS, default='patient')
    mobile_number = models.CharField(max_length=12)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    profile_image = models.ImageField(upload_to='images')


class Contact(models.Model):
    name = models.CharField(max_length=50)
    email = models.EmailField()
    subject = models.CharField(max_length=300)
    message = models.CharField(max_length=700)
    created_date = models.DateField()


class Carousel(models.Model):
    image = models.ImageField(upload_to='images')
