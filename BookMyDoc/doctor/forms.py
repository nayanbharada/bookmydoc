from django import forms
from django.forms import TimeField
from .models import DoctorProfile, Qualification, DocTimeSlot,DoctorDegree, DoctorUniversity
from django.contrib.auth import get_user_model
import datetime

User = get_user_model()


class DoctorProfileForm(forms.ModelForm):
    experience = forms.CharField(required=True)

    class Meta:
        model = DoctorProfile
        fields = '__all__'
        exclude = ('user', 'hospital')


class DoctorUserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name',
                  'email', 'mobile_number', 'gender',
                  'profile_image']
        help_texts = {
            'username': None

        }


def year_choices():
    return [(r, r) for r in range(1987, datetime.date.today().year + 1)]


def current_year():
    return datetime.date.today().year


class QualificationForm(forms.ModelForm):
    degree = forms.ModelChoiceField(queryset=DoctorDegree.objects.all())
    university = forms.ModelChoiceField(queryset=DoctorUniversity.objects.all())
    year_completion = forms.TypedChoiceField(choices=year_choices, initial=current_year)

    class Meta:
        model = Qualification
        fields = '__all__'
        exclude = ('doctor_profile',)


class DocTimeSlotForm(forms.ModelForm):
    # morning_from = forms.TimeField(input_formats=['%I:%M %p'],
    #                                widget=forms.TimeInput(format='%I:%M %p'))
    # morning_to = forms.TimeField(input_formats=['%I:%M %p'],
    #                              widget=forms.TimeInput(format='%I:%M %p'))
    # evening_from = forms.TimeField(input_formats=['%I:%M %p'],
    #                                widget=forms.TimeInput(format='%I:%M %p'))
    # evening_to = forms.TimeField(input_formats=['%I:%M %p'],
    #                              widget=forms.TimeInput(format='%I:%M %p'))

    class Meta:
        model = DocTimeSlot
        fields = '__all__'
        from_time = forms.TimeField(
            widget=forms.TimeInput(attrs={'class': 'time'}))
        to_time = forms.TimeField(widget=forms.TimeInput(attrs={'class': 'time'}))

        # widgets = {'from_time': TimeField(attrs={'class': 'ui-timepicker-input'})}
        exclude = ('doc', 'hospital',)


