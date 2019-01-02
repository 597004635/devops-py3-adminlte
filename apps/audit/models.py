from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()
from resources.models import Idc


class Host(models.Model):
    """主机信息"""
    hostname    = models.CharField(max_length=64, unique=True)
    ip_addr     = models.GenericIPAddressField(unique=True)
    port        = models.IntegerField(default=22)
    idc         = models.ForeignKey(Idc)
    enabled     = models.BooleanField(default=True)

    def __str__(self):
        return "%s[%s]" %(self.hostname, self.ip_addr)


class HostUser(models.Model):
    """远程主机的用户信息   (root /  pwe123)"""
    auth_type_choices   = ((0,'ssh-password'),(1,'ssh-key'))
    auth_type           = models.SmallIntegerField(choices=auth_type_choices)
    username            = models.CharField(max_length=32)
    password            = models.CharField(blank=True,null=True,max_length=128,default='')

    def __str__(self):
        return "%s[%s:%s]" %(self.get_auth_type_display(), self.username, self.password)

    class Meta:
        unique_together = ('username','password')


class HostUserBind(models.Model):
    """绑定主机和用户"""
    host        = models.ForeignKey(Host)
    host_user   = models.ForeignKey(HostUser)

    def __str__(self):
        # return "%s-%s_%s" %(self.id,self.host, self.host_user)
        return "%s" %(self.host)

    class Meta:
        unique_together = ('host','host_user')



class HostGroup(models.Model):
    """主机组"""
    name            = models.CharField(max_length=64, unique=True)
    host_user_binds = models.ManyToManyField(HostUserBind)

    def __str__(self):
        return self.name



class Account(models.Model):
    """堡垒机 账号 (1、扩展， 2、继承   user.account.host_user_bind) """
    user            = models.OneToOneField(User)
    name            = models.CharField(max_length=32)
    host_user_binds = models.ManyToManyField(HostUserBind, blank=True)
    host_groups     = models.ManyToManyField(HostGroup, blank=True)

    def __str__(self):
        return self.user.username



class Task(models.Model):
    """ 存储任务信息"""
    task_type_choices   = ((0,'cmd'),(1,'file_transfer'))
    task_type           = models.SmallIntegerField(choices=task_type_choices)
    content             = models.TextField("任务内容")
    timeout             = models.IntegerField("任务超时", default=15)
    account             = models.ForeignKey(Account)
    date                = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "%s-%s-%s" %(self.id,self.get_task_type_display(),self.content)



class TaskLog(models.Model):
    """ 任务日志"""
    task            = models.ForeignKey(Task)
    host_user_bind  = models.ForeignKey(HostUserBind)
    result          = models.TextField(default='Initialization ...')
    date            = models.DateTimeField(auto_now_add=True)
    status_choices  = ((0,'成功'),(1,'失败'),(2,'超时'),(3,'初始化'))
    status          = models.SmallIntegerField(choices=status_choices)

    class Meta:
        unique_together = ('task','host_user_bind')



class SessionLog(models.Model):
    """会话日志"""
    account         = models.ForeignKey(Account)
    host_user_bind  = models.ForeignKey(HostUserBind)
    start_date      = models.DateTimeField(auto_now_add=True)
    end_date        = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return "%s _ %s" %(self.account, self.host_user_bind)



class AuditLog(models.Model):
    """审计日志"""
    session = models.ForeignKey(SessionLog)
    cmd = models.TextField()
    date    = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "%s-%s" %(self.session, self.cmd)


class Token(models.Model):
    """ 登录主机token"""
    host_user_bind = models.ForeignKey(HostUserBind)
    val = models.CharField(max_length=128, unique=True)
    account = models.ForeignKey(Account)
    expire = models.IntegerField("超时时间(s)", default=10800)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "%s-%s" %(self.host_user_bind,self.val)

    # class Meta:
    #     unique_together = ('host_user_bind','values')




