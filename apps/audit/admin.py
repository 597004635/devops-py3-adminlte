# _*_ coding:utf-8 _*_
from django.contrib import admin
from audit.models import Host, HostUser, HostGroup, HostUserBind, Account, AuditLog, SessionLog, Task, TaskLog

class AuditLogAdmin(admin.ModelAdmin):
    list_display = ['session','cmd','date']
    list_filter = ['date','session']

class SeesionLogAdmin(admin.ModelAdmin):
    list_display = ['id','account','host_user_bind','start_date','end_date']
    list_filter = ['start_date','account']

class TaskLogAdmin(admin.ModelAdmin):
    list_display = ['id','task_id','host_user_bind_id','result','date']
    list_filter = ['result']

admin.site.register(Host)
admin.site.register(HostUser)
admin.site.register(HostGroup)
admin.site.register(HostUserBind)
admin.site.register(Account)
admin.site.register(AuditLog,AuditLogAdmin)
admin.site.register(SessionLog,SeesionLogAdmin)
admin.site.register(Task)
admin.site.register(TaskLog,TaskLogAdmin)