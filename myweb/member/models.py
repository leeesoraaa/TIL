from django.contrib.auth.models import User
from django import forms
# Create your models here.

# 회원가입 폼(아이디, 이메일, 비밀번호 입력)
class UserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'password']

# 로그인 폼(아이디와 비밀번호만 입력받아 처리)
class LoginForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'password']
