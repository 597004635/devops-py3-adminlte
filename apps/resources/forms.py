from django import forms
from django.forms import widgets
from resources.models import Idc, Product, Server
from django.contrib.auth import get_user_model

# from django.contrib.auth.models import User

User = get_user_model()


class CreateIdcForm(forms.ModelForm):
    class Meta:
        model = Idc
        fields = "__all__"

    """
    name     = forms.CharField(required=True)
    idc_name = forms.CharField(required=True)
    address  = forms.CharField(required=True)
    username = forms.CharField(required=True)
    phone    = forms.CharField(required=True)
    email    = forms.EmailField(required=True,error_messages={'invalid':"Email格式不正确"})

    def clean_name(self):
        name = self.cleaned_data.get("name")

        try:
            Idc.objects.get(name__exact=name)
            raise forms.ValidationError("idc简称已经存在")
        except Idc.DoesNotExist:
            return name

    def clean(self):
        data = self.cleaned_data
        return data
    """


class UpdateIdcForm(forms.ModelForm):
    class Meta:
        model = Idc
        fields = ['phone', 'email', 'username', 'address']


class ProductForm(forms.Form):
    service_name = forms.CharField(required=True)
    module_letter = forms.CharField(required=True)
    op_interface = forms.MultipleChoiceField(
        choices=((u.email, u.username) for u in User.objects.filter(is_superuser=False)))
    dev_interface = forms.MultipleChoiceField(
        choices=((u.email, u.username) for u in User.objects.filter(is_superuser=False)))
    pid = forms.CharField(required=True)

    def clean_pid(self):
        pid = self.cleaned_data['pid']
        if pid.isdigit():
            if int(pid) != 0:
                try:
                    p_obj = Product.objects.get(pk=pid)
                    if p_obj.pid != 0:
                        raise forms.ValidationError("请选择正确的一级业务线")
                except Product.DoesNotExist:
                    raise forms.ValidationError("请选择正确的一级业务线")
        else:
            raise forms.ValidationError("请选择正确的一级业务线")
        return pid

    def clean_dev_interface(self):
        dev_interface = self.cleaned_data['dev_interface']
        return ",".join(dev_interface)

    def clean_op_interface(self):
        op_interface = self.cleaned_data['op_interface']
        return ",".join(op_interface)


class ServerForm(forms.ModelForm):
    class Meta:
        model = Server
        fields = "__all__"
