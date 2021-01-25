from django.db import models
from django.contrib.auth import get_user_model


# User = get_user_model()

# Create your models here.

class Patient(models.Model):
    BLOOD_GROUP = (
        ('A+', 'a+'),
        ('O+', 'o+'),
        ('B+', 'b+'),
        ('AB+', 'ab+'),
        ('A-', 'a-'),
        ('O-', 'o-'),
        ('B-', 'b-'),
        ('AB-', 'ab-'),
    )
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
    )

    birth_date = models.DateField(blank=True, null=True)
    weight = models.IntegerField(blank=True, null=True)
    height = models.FloatField(max_length=5, blank=True, null=True)
    blood_group = models.CharField(max_length=4, choices=BLOOD_GROUP, blank=True, null=True)
    pulse = models.IntegerField(blank=True, null=True)
    blood_pressure = models.IntegerField(blank=True, null=True)
    physical_disorders = models.BooleanField(default=False)
    mental_disorders = models.BooleanField(default=False)
    major_surgeries = models.BooleanField(default=False)
    diabetes = models.BooleanField(default=False)
    cancer = models.BooleanField(default=False)
    heart_attack = models.BooleanField(default=False)
    smoke = models.BooleanField(default=False)
    regular_medicine = models.CharField(blank=True, max_length=100)
    drug_allergies = models.CharField(blank=True, max_length=200)
    comments = models.CharField(blank=True, max_length=300)
    first_name = models.CharField(blank=True, null=True, max_length=200)
    last_name = models.CharField(max_length=300, blank=True, null=True)
    mobile_no = models.CharField(max_length=10, blank=True, null=True)
    email = models.EmailField(blank=True, null=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, blank=True, null=True)
    user = models.OneToOneField(get_user_model(), on_delete=models.CASCADE, related_name='patient',
                                null=True)
