import re
from django import forms
from patient.models import Patient
from .models import Hospital, get_user_model, HospitalRequest, Images

User = get_user_model()


class HospitalUserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'mobile_number',
                  'profile_image']
        help_texts = {
            'username': None

        }

    def clean(self):
        cleaned_data = super().clean()
        mobile_number = cleaned_data.get("mobile_number")
        mob = re.match(r'^[6-9]\d{9}$', mobile_number)
        if mob is None:
            raise forms.ValidationError("mobile no must be 10 digits ")


class HospitalProfileForm(forms.ModelForm):
    address = forms.CharField(required=True)

    class Meta:
        model = Hospital
        fields = '__all__'
        exclude = ('is_type', 'user')


class AddDoctorForm(forms.ModelForm):
    first_name = forms.CharField(required=True)
    last_name = forms.CharField(required=True)

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'username', 'email', 'mobile_number', 'gender']
        help_texts = {
            'username': None
        }

    def clean(self):
        cleaned_data = super().clean()
        mobile_number = cleaned_data.get("mobile_number")
        mob = re.match(r'^[6-9]\d{9}$', mobile_number)
        if mob is None:
            raise forms.ValidationError("mobile no must be indian and 10 digits ")

        if User.objects.filter(username=cleaned_data['username']).exists():
            raise forms.ValidationError("this username is all_ready exists.")
        else:
            if HospitalRequest.objects.filter(username=cleaned_data['username']).exists():
                raise forms.ValidationError("this username is all_ready exists.")


class HospitalRequestForm(forms.ModelForm):
    class Meta:
        model = HospitalRequest
        fields = ['name', 'email', 'mobile', 'username', 'website', 'type']
        labels = {
            "name": "Hospital/Clinic Name",
        }

    def clean(self):
        cleaned_data = super().clean()
        mobile_number = cleaned_data.get("mobile")
        mob = re.match(r'^[6-9]\d{9}$', mobile_number)
        if mob is None:
            raise forms.ValidationError("mobile no must be 10 digits ")

        if User.objects.filter(username=cleaned_data['username']).exists():
            raise forms.ValidationError("this username is all_ready exists.")
        else:
            if HospitalRequest.objects.filter(username=cleaned_data['username']).exists():
                raise forms.ValidationError("this username is all_ready exists.")


class PatientForm(forms.ModelForm):
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
    )
    first_name = forms.CharField(required=True)
    last_name = forms.CharField(required=True)
    mobile_no = forms.CharField(widget=forms.TextInput(attrs={'id': 'mobile_no'}))
    email = forms.EmailField(required=True)
    gender = forms.ChoiceField(required=True, choices=GENDER_CHOICES)

    # birth_date = forms.DateField(required=False)

    class Meta:
        model = Patient
        fields = ['first_name', 'last_name', 'mobile_no',
                  'email', 'gender']


class UploadImages(forms.ModelForm):

    class Meta:
        model = Images
        fields = ['image']
        exclude = ('hospital', )
