#from utils.mycelery import  app
import traceback
from django.core.mail import send_mail
from celery import task
from django.conf import settings

@task(name='work_order.tasks.func_name')    #appname为当前app注册的名字
def func_name():
    print("ok")

func_name()
