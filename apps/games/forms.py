from django import forms
from .models import GameServer
from django.forms import widgets
from django.conf import settings
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm, UserChangeForm


class GameServerfileForm(forms.ModelForm):
    class Meta:
        model = GameServer
        fields = "__all__"

    #     fields = ('channel','gameid','hostname','servername','inner_ip','db_ip')
    #     widgets = {
    #         'channel': forms.TextInput(attrs={'class': 'form-control'}),
    #         'gameid': forms.TextInput(attrs={'class': 'form-control'}),
    #         'hostname': forms.TextInput(attrs={'class': 'form-control'}),
    #         'servername': forms.TextInput(attrs={'class': 'form-control'}),
    #         'inner_ip': forms.TextInput(attrs={'class': 'form-control'}),
    #         'db_ip': forms.TextInput(attrs={'class': 'form-control'}),
    #     }
    #
    # def __init__(self,*args,**kwargs):
    #     super(GameServerfileForm, self).__init__(*args,**kwargs)
    #     self.fields['channel'].label = '渠 道'
    #     self.fields['channel'].error_messages = {'required': '请输入渠道'}
    #     self.fields['gameid'].label = 'GameID'
    #     self.fields['gameid'].error_messages = {'required': '请输入游戏ID'}
    #     self.fields['hostname'].label = '主机名'
    #     self.fields['hostname'].error_messages={'required': '请输入主机名'}
    #     self.fields['servername'].label = '区服名'
    #     self.fields['servername'].error_messages = {'required': '请输入区服名'}
    #     self.fields['inner_ip'].label = '内网IP'
    #     self.fields['inner_ip'].error_messages={'required': '请输入内网IP'}
    #

class GameServerUpdateForm(forms.ModelForm):
    class Meta:
        model = GameServer
        fields = ['hostname','servername','inner_ip','db_ip']
