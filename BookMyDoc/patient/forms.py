from django import forms
from django.forms import ModelForm
from .models import Patient
from django.contrib.auth import get_user_model


class PatientProfileForm(forms.ModelForm):
    class Meta:
        model = Patient
        fields = '__all__'
        exclude = ('user', 'first_name', 'last_name', 'mobile_no', 'email', 'gender')


class UserProfileForm(forms.ModelForm):
    class Meta:
        model = get_user_model()
        fields = ['username', 'first_name', 'last_name',
                  'email', 'mobile_number', 'gender',
                  'profile_image']
        help_texts = {
            'username': None
        }



