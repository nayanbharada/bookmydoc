import re
from django import forms
from .models import User, Contact
from django.core.validators import validate_email
from django.core.exceptions import ValidationError


class RegisterForm(forms.ModelForm):
    first_name = forms.CharField(required=True,
                                 widget=forms.TextInput(attrs={'placeholder': 'enter your first name'}))
    last_name = forms.CharField(required=True,
                                widget=forms.TextInput(attrs={'placeholder': 'enter your last name'}))
    username = forms.CharField(required=True,
                               widget=forms.TextInput(attrs={'placeholder': 'enter your username'}))
    email = forms.EmailField(required=True,
                             widget=forms.TextInput(attrs={'placeholder': 'enter your email'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'placeholder': 'enter your password'}))

    mobile_number = forms.CharField(required=True,
                                    widget=forms.TextInput(attrs={'placeholder': 'enter your mobile number'}))

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'username', 'email', 'password', 'mobile_number']
        help_texts = {
            'username': None
        }

    def save(self, commit=True, *args, **kwargs):
        instance = super(RegisterForm, self).save(commit=commit)
        instance.set_password(self.cleaned_data.get('password'))
        instance.save()
        return instance

    def clean(self):
        cleaned_data = super().clean()
        mobile_number = cleaned_data.get("mobile_number")
        mob = re.match(r'^[6-9]\d{9}$', mobile_number)
        if mob is None:
            raise forms.ValidationError("mobile no must be 10 digits ")


class LoginForm(forms.Form):
    username = forms.CharField(required=True,
                               widget=forms.TextInput(
                                   attrs={'placeholder': 'enter your username'}))
    password = forms.CharField(required=True, widget=forms.PasswordInput(attrs={'placeholder': 'enter your password'}))


class ContactForm(forms.ModelForm):
    message = forms.CharField(widget=forms.Textarea(attrs={"rows": 5, "cols": 20}))

    class Meta:
        model = Contact
        fields = ['name', 'email', 'subject', 'message']
        exclude = ('created_date',)

