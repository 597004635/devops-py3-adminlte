from django import forms
from .models import Deploy


class ApplyForm(forms.ModelForm):
    class Meta:
        model = Deploy
        fields = ['name', 'project_version', 'version_desc', 'assigned_to', 'update_detail','env']


class DeployForm(forms.ModelForm):
    class Meta:
        model = Deploy
        fields = ['name', 'project_version', 'version_desc', 'update_detail']
