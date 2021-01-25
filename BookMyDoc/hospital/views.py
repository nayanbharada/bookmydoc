import datetime
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.mail import EmailMessage
from django.shortcuts import render, redirect
from django.http import HttpResponse, JsonResponse
from django.template.loader import render_to_string
from django.views.generic import View, UpdateView, FormView, ListView
from BookMyDoc.settings import EMAIL_HOST_USER
from .forms import HospitalProfileForm, HospitalUserForm, AddDoctorForm, \
    HospitalRequestForm, PatientForm, UploadImages
from .models import Hospital, get_user_model, HospitalRequest, Images
from doctor.models import DoctorProfile, Appointment, DocTimeSlot
from django.core.exceptions import ObjectDoesNotExist
from datetime import datetime, timezone


# Create your views here.

def index(request):
    return HttpResponse("hospital index")


class HospitalDashboard(LoginRequiredMixin, View):
    template_name = 'hospital/hospital_dashboard.html'

    def get(self, request):
        return render(request, self.template_name, {})


class HospitalProfile(LoginRequiredMixin, UpdateView):
    form_class = HospitalProfileForm
    second_form_class = HospitalUserForm
    template_name = 'hospital/hospital_profile.html'

    def get(self, request, *args, **kwargs):
        user = request.user
        hospital_profile = Hospital.objects.get(user=user.id)
        user_profile = get_user_model().objects.get(id=user.id)
        form = self.form_class(instance=hospital_profile)
        user_form = self.second_form_class(instance=user_profile)
        return render(request, self.template_name, {'form': form, 'user_form': user_form})

    def post(self, request, *args, **kwargs):
        user = request.user

        hospital_profile = Hospital.objects.get(user=user.id)
        user_profile = get_user_model().objects.get(id=user.id)
        form = self.form_class(request.POST, instance=hospital_profile)
        user_form = self.second_form_class(request.POST, request.FILES, instance=user_profile)
        if form.is_valid() and user_form.is_valid():
            form.save()
            user_form.save()
            return HttpResponse("success")
        else:
            return render(request, self.template_name, {'form': form, 'user_form': user_form})


class AddDoctor(LoginRequiredMixin, FormView):
    template_name = 'hospital/add_doctor.html'
    form_class = AddDoctorForm

    def get(self, request, *args, **kwargs):
        form = self.form_class

        users = request.user.hospital

        if users.is_type == "clinic":

            try:
                clinic_doc = DoctorProfile.objects.get(hospital_id=users.id)
            except ObjectDoesNotExist:
                clinic_doc = None

            if clinic_doc is None:
                return render(request, self.template_name, {'form': form})
            else:
                messages.error(request, 'You can not add multiple doctor.')
                return redirect('hospital:hospital_dashboard')

        else:
            return render(request, self.template_name, {'form': form})

    def post(self, request, *args, **kwargs):
        form = self.form_class(request.POST)

        if form.is_valid():
            hospital_id = request.user.hospital

            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            username = form.cleaned_data['username']
            email = form.cleaned_data['email']
            mobile_number = form.cleaned_data['mobile_number']
            gender = form.cleaned_data['gender']

            random_pass = get_user_model().objects.make_random_password()
            User = get_user_model()

            user = User(
                first_name=first_name,
                last_name=last_name,
                username=username,
                email=email,
                mobile_number=mobile_number,
                gender=gender,
                is_type="doctor"
            )
            user.set_password(random_pass)
            user.save()

            doc_profile = DoctorProfile(
                hospital_id=hospital_id.id,
                user_id=user.id
            )
            doc_profile.save()
            html_content = 'Your password is:- <p><strong>' + random_pass + '</strong></p>'
            subject = 'Bookmydoc Doctor account password'
            to_mail = email
            msg = EmailMessage(subject, html_content, EMAIL_HOST_USER, [to_mail])
            msg.content_subtype = "html"
            msg.send()
            print(random_pass)
            messages.success(request, 'doctor add successful.')
            return redirect('hospital:add_doctor')
        else:
            return render(request, self.template_name, {'form': form})


class HospitalClinicRequest(FormView):
    template_name = 'hospital/hospital_request.html'
    form_class = HospitalRequestForm

    def form_valid(self, form):
        form.save()
        messages.success(self.request, 'Hospital/clinic request send successful')
        return redirect('user:index')


class AllDoctorListView(ListView):
    template_name = 'hospital/all_doctor_list.html'

    def get(self, request, *args, **kwargs):
        hospital_id = request.user.hospital.id
        doctor_lists = DoctorProfile.objects.filter(hospital_id=hospital_id)
        return render(self.request, self.template_name, {'doctor_lists': doctor_lists})


class AppointmentTimeSlotView(LoginRequiredMixin, View):
    template_name = 'doctor/appointment_time_slot.html'
    form_class = PatientForm

    def get(self, request, *args, **kwargs):
        doc_id = kwargs.get('pk')
        data = DoctorProfile.objects.get(id=doc_id)
        return render(request, self.template_name, {'data': data})

    def post(self, request, *args, **kwargs):
        doc_id = kwargs.get('pk')

        date = request.POST.get('select_date')
        convert_date = datetime.strptime(date, "%m/%d/%Y").date()
        day_of_week = convert_date.strftime("%A")

        current_date = datetime.now().date()
        current_time = datetime.now().time().strftime('%H:%M')
        convert_time = datetime.strptime(current_time, "%H:%M").time()

        if convert_date == current_date:
            match_booking = Appointment.objects.filter(date=convert_date, doctor_id=doc_id,
                                                       status__in=[Appointment.Booked, Appointment.Ongoing,
                                                                   Appointment.Completed])

            exclude_data = []
            for i in match_booking:
                exclude_data.append(i.time_slot_id)

            doc_time_slot = DocTimeSlot.objects.filter(doc_id=doc_id, days=day_of_week,
                                                       from_time__gte=convert_time).exclude(id__in=exclude_data)

            if not doc_time_slot:
                messages.error(request, "This date in any time slot is not available.")
                html = render_to_string(request=request, template_name='doctor/available_time_slot.html',
                                        context={'doc_time_slot': doc_time_slot})

                return JsonResponse(data={'html': html})

            else:
                form = self.form_class

                html = render_to_string(request=request, template_name='doctor/available_time_slot.html',
                                        context={'doc_time_slot': doc_time_slot,
                                                 'form': form})

                return JsonResponse(data={'html': html})

        else:
            match_booking = Appointment.objects.filter(date=convert_date, doctor_id=doc_id,
                                                       status__in=[Appointment.Booked, Appointment.Ongoing,
                                                                   Appointment.Completed])

            exclude_data = []
            for i in match_booking:
                exclude_data.append(i.time_slot_id)

            doc_time_slot = DocTimeSlot.objects.filter(doc_id=doc_id, days=day_of_week).exclude(id__in=exclude_data)

            if not doc_time_slot:
                messages.error(request, "This date in any time slot is not available.")
                html = render_to_string(request=request, template_name='doctor/available_time_slot.html',
                                        context={'doc_time_slot': doc_time_slot})
                return JsonResponse(data={'html': html})
            else:
                form = self.form_class
                html = render_to_string(request=request, template_name='doctor/available_time_slot.html',
                                        context={'doc_time_slot': doc_time_slot,
                                                 'form': form})
                return JsonResponse(data={'html': html})


class AppointmentBookView(LoginRequiredMixin, View):
    form_class = PatientForm

    def post(self, request):
        date = request.POST.get('selected_date')
        convert_date = datetime.strptime(date, "%m/%d/%Y").date()
        selected_slot_id = request.POST.get('selected_slot')
        selected_time_slot = DocTimeSlot.objects.get(id=selected_slot_id)

        form = self.form_class(request.POST)

        if form.is_valid():
            patient = form.save()

            appointment = Appointment(
                hospital_id=selected_time_slot.hospital_id,
                patient_id=patient.id,
                doctor_id=selected_time_slot.doc_id,
                date=convert_date,
                time_slot_id=selected_time_slot.id,
                created_by=request.user,
                status=Appointment.Booked
            )
            appointment.save()
            messages.success(request, 'appointment is successful booked.')
            return redirect('hospital:doc_list')
        else:
            messages.error(request, 'your form data is not valid.')
            return redirect('hospital:doc_list')


class UploadHospitalImages(LoginRequiredMixin, View):
    template_name = 'hospital/upload_images.html'
    form_class = UploadImages

    def get(self, request):
        form = self.form_class()
        context = {'form': form}
        html_form = render_to_string(self.template_name,
                                     context,
                                     request=request,
                                     )
        return JsonResponse({'html_form': html_form})

    def post(self, request):
        data = dict()
        form = self.form_class(request.POST, request.FILES)
        login_hospital = request.user
        if form.is_valid():
            instance = form.save(commit=False)
            instance.hospital_id = login_hospital.hospital.id
            instance.save()
            messages.success(request, 'Hospital image will be add.')
            data['form_is_valid'] = True
            return JsonResponse(data)
        else:
            data['form_is_valid'] = False
            context = {'form': form}
            data['html_form'] = render_to_string(self.template_name,
                                                 context,
                                                 request=request,
                                                 )
            return JsonResponse(data)


class AllHospitalImages(LoginRequiredMixin, View):
    template_name = 'hospital/all_hospital_images.html'

    def get(self, request):
        login_hospital = request.user
        hospital_images = Images.objects.filter(hospital_id=login_hospital.hospital.id)
        return render(request, self.template_name, {'hospital_images': hospital_images})


class HospitalDeleteImage(LoginRequiredMixin, View):
    template_name = 'hospital/all_hospital_images.html'

    def get(self, request, **kwargs):
        hospital_image_id = kwargs.get('pk')
        hospital_image_obj = Images.objects.get(id=hospital_image_id)
        hospital_image_obj.delete()
        messages.success(request, 'Hospital image will be deleted.')
        return redirect('hospital:all_hospital_images')


class AllDocList(LoginRequiredMixin, View):
    template_name = 'hospital/doc_list.html'

    def get(self, request):
        login_hospital = request.user
        all_doc = DoctorProfile.objects.filter(hospital_id=login_hospital.hospital)
        return render(request, self.template_name, {'all_doc': all_doc})


class DeleteDoc(LoginRequiredMixin, View):
    template_name = 'hospital/doc_list.html'

    def get(self, request, **kwargs):
        doc_id = kwargs.get('pk')
        print(doc_id)
        doc_obj = DoctorProfile.objects.get(id=doc_id)
        doc_obj.delete()
        messages.success(request, 'Doctor will delete successful.')
        return redirect('hospital:all_doctor_list')