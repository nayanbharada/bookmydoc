from django.db import models
from django.contrib.auth import get_user_model


# Create your models here.

class Hospital(models.Model):
    CHOICES = (
        ('hospital', 'Hospital'),
        ('clinic', 'Clinic')
    )
    name = models.CharField(max_length=50)
    is_type = models.CharField(max_length=8, choices=CHOICES)
    website = models.URLField()
    address = models.CharField(max_length=500, blank=True)
    no_of_opd = models.IntegerField(default=0)
    user = models.OneToOneField(get_user_model(), on_delete=models.CASCADE,
                                blank=True, related_name='hospital')

    def __str__(self):
        return self.name + "  " + self.is_type


class HospitalRequest(models.Model):
    CHOICES = (
        ('hospital', 'Hospital'),
        ('clinic', 'Clinic')
    )

    name = models.CharField(max_length=50)
    email = models.EmailField()
    mobile = models.CharField(max_length=10)
    type = models.CharField(max_length=8, choices=CHOICES)
    username = models.CharField(max_length=20)
    website = models.URLField()

    def __str__(self):
        return self.name + " " + self.type


class Images(models.Model):
    hospital = models.ForeignKey(Hospital, on_delete=models.CASCADE, related_name='hospital', blank=True, null=True)
    image = models.ImageField(upload_to='images')
