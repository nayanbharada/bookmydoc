from django.conf.urls import url
from django.core.mail import EmailMessage
from django.contrib import admin
from django.contrib.auth import get_user_model
from BookMyDoc.settings import EMAIL_HOST_USER
from .models import Hospital, HospitalRequest, Images

User = get_user_model()


# Register your models here.
class HospitalRequestAdmin(admin.ModelAdmin):
    list_display = ('name', 'type', 'email')

    def save_model(self, request, obj, form, change):
        # print(obj.id)
        random_pass = User.objects.make_random_password()
        user = User(
            username=obj.username,
            first_name=obj.name,
            email=obj.email,
            is_type="hospital",
            mobile_number=obj.mobile
        )
        user.set_password(random_pass)
        user.save()
        hospital = Hospital(
            name=obj.name,
            is_type=obj.type,
            website=obj.website,
            user=user
        )
        hospital.save()
        html_content = 'Your password is:- <p><strong>' + random_pass + '</strong></p>'
        subject = 'Bookmydoc hospital account password'
        to_mail = obj.email

        msg = EmailMessage(subject, html_content, EMAIL_HOST_USER, [to_mail])
        msg.content_subtype = "html"
        msg.send()
        obj.delete()
        print(random_pass)


admin.site.register(Hospital)
admin.site.register(HospitalRequest, HospitalRequestAdmin)
admin.site.register(Images)
