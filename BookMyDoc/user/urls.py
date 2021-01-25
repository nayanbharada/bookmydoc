from django.urls import path, include
from . import views
from .views import RegisterView, LoginView
from django.contrib.auth import views as auth_views

app_name = 'user'
urlpatterns = [
    path('', views.IndexView.as_view(), name="index"),
    path('about_us', views.AboutUsView.as_view(), name="about_us"),
    path('contact', views.ContactView.as_view(), name="contact"),
    path('register/', RegisterView.as_view(), name="register"),
    path('login/', LoginView.as_view(), name="login"),
    path('login_mixin', views.LoginMixin, name="login_mixin"),
    path('logout/', views.logout_view, name="logout"),
    path('index_login', views.index_login, name="index_login"),
    path('password_reset/', auth_views.PasswordResetView.as_view(), name='password_reset'),
    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('%5reset/done/', auth_views.PasswordResetCompleteView.as_view(),
         name='password_reset_complete'),
]
