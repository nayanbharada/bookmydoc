from django.contrib import messages
from django.core.serializers import json
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect
from django.template.loader import render_to_string
from django.views.generic import FormView, View, CreateView
from .forms import RegisterForm, LoginForm, ContactForm
from patient.models import Patient
from django.contrib.auth import authenticate, login, logout
from datetime import datetime
from .models import User, Carousel


# Create your views here.
class IndexView(View):
    template_name = 'user/index.html'

    def get(self, request):
        hospital_user = User.objects.filter(is_type="hospital")
        patient_user = User.objects.filter(is_type="patient")
        doc_user = User.objects.filter(is_type="doctor")
        carousel_images = Carousel.objects.all()
        return render(request, self.template_name, {'hospital_user': hospital_user,
                                                    'patient_user': patient_user,
                                                    'doc_user': doc_user,
                                                    'carousel_images': carousel_images})


class AboutUsView(View):
    template_name = 'user/about_us.html'

    def get(self, request):
        return render(request, self.template_name, {})


class ContactView(View):
    template_name = 'user/contact.html'
    form_class = ContactForm

    def get(self, request):
        form = self.form_class
        return render(request, self.template_name, {'form': form})

    def post(self, request):
        current_date = datetime.now().date()
        form = self.form_class(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.created_date = current_date
            instance.save()
            messages.success(request, 'message send successful.')
            return redirect('user:contact')
        else:
            print(form.errors)
            return render(request, self.template_name, {'form': form})


class RegisterView(View):
    template_name = 'user/register.html'
    form_class = RegisterForm
    success_url = "/user/"

    def get(self, request, *args, **kwargs):
        form = self.form_class()
        context = {'form': form}
        html_form = render_to_string(self.template_name,
                                     context,
                                     request=request,
                                     )
        return JsonResponse({'html_form': html_form})

    def post(self, request, *args, **kwargs):
        data = dict()
        form = self.form_class(request.POST)
        if form.is_valid():
            user = form.save()
            patient = Patient(
                user_id=user.id
            )
            patient.save()
            messages.success(self.request, 'your registration will successfull.')
            data['form_is_valid'] = True
            return JsonResponse(data)
            # return redirect(self.success_url)
        else:
            data['form_is_valid'] = False
            context = {'form': form}
            data['html_form'] = render_to_string(self.template_name,
                                                 context,
                                                 request=request,
                                                 )
            return JsonResponse(data)


class LoginView(View):
    form_class = LoginForm
    template_name = 'user/login.html'

    def get(self, request, *args, **kwargs):
        form = self.form_class()
        context = {'form': form}
        if request.user.is_authenticated:

            html_form = render_to_string(self.template_name,
                                         context,
                                         request=request,
                                         )
            return JsonResponse({'html_form': html_form})
        else:
            html_form = render_to_string(self.template_name,
                                         context,
                                         request=request,
                                         )
            return JsonResponse({'html_form': html_form})

    def post(self, request, *args, **kwargs):
        data = dict()
        form = self.form_class(request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)

                if user.is_type == "patient":
                    messages.success(request, 'Patient login successful')
                    data['form_is_valid'] = "patient"
                    return JsonResponse(data)
                elif user.is_type == "hospital":
                    messages.success(request, 'Hospital login successful')
                    data['form_is_valid'] = "hospital"
                    return JsonResponse(data)
                else:
                    messages.success(request, 'Doctor login successful')
                    data['form_is_valid'] = "doctor"
                    return JsonResponse(data)
            else:
                messages.error(request, 'username password is invalid')
                data['form_is_valid'] = False
                context = {'form': form}
                data['html_form'] = render_to_string(self.template_name,
                                                     context,
                                                     request=request,
                                                     )
                return JsonResponse(data)


def LoginMixin(request):

    return render(request, 'user/demo.html',{})


class PasswordResetCompleteView(View):

    def get(self, request):
        messages.success(request, 'Your password has been set. You may go ahead and sign in')
        return redirect('user:index')


def logout_view(request):
    if request.user.is_authenticated:
        logout(request)
        messages.success(request, 'logout successfull.')
        return redirect('user:index')
    else:
        messages.error(request, 'you are all ready logout.')
        return redirect('user:index')


def index_login(request):
    return render(request, 'index.html', {})
