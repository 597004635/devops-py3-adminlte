from utils.mycelery import  app
import traceback
from django.core.mail import send_mail
from django.conf import settings


@app.task(name='sendmail')
def send_order_email(title, msg, To_Mail):
    if send_mail(title, msg, settings.EMAIL_FROM, To_Mail):
        print('发送成功 TO %s' % (To_Mail))
    else:
        print('发送失败 TO %s' % (To_Mail))
        traceback.print_exc()
