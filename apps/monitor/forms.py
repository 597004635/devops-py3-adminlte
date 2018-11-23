from django import forms

class CreateGraphForm(forms.Form):
    title           = forms.CharField(required=True)
    subtitle        = forms.CharField(required=False)
    unit            = forms.CharField(required=True)
    measurement     = forms.CharField(required=True)
    field_expression= forms.CharField(required=False)
    auto_hostname = forms.CharField(required=True)
    yaxis_formatter = forms.CharField(required=False)
    tooltip_formatter = forms.CharField(required=False)

    def clean_title(self):
        title = self.cleaned_data['title']
        if not self.isavailable(title):
            raise forms.ValidationError('标题输入有误，请输入正确的标题')
        return title

    def clean_unit(self):
        unit = self.cleaned_data['unit']
        if not self.isavailable(unit):
            forms.ValidationError('单位输入有误，请输入正确的单位')
        return unit

    def clean_measurement(self):
        measurement = self.cleaned_data['measurement']
        if not self.isavailable(measurement):
            forms.ValidationError('measurement输入有误，请输入正确的measurement')
        return measurement

    def clean_auto_hostname(self):
        auto_hostname = self.cleaned_data['auto_hostname']
        if auto_hostname == "1":
            return True
        return False

    def clean_yaxis_formatter(self):
        yaxis_formatter = self.cleaned_data["yaxis_formatter"]
        return yaxis_formatter.strip()

    def clean_tooltip_formatter(self):
        tooltip_formatter = self.cleaned_data["tooltip_formatter"]
        return tooltip_formatter.strip()

    def isavailable(self, str):
        str = str.strip()
        if not str:
            return False
        return True
