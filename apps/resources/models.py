from django.db import models

class Idc(models.Model):
    name        = models.CharField("idc 字母简称", max_length=10, default="", unique=True)
    idc_name    = models.CharField("idc 中文名字", max_length=100, default="")
    address     = models.CharField("具体的地址，云厂商可以不填", max_length=255, null=True)
    phone       = models.CharField("机房联系电话", max_length=20, null=True)
    email       = models.EmailField("机房联系email", null=True)
    username    = models.CharField("机房联系人", max_length=32, null=True)

    class Meta:
        db_table = "resources_idc"
        permissions = (
            ("view_idc", "访问idc列表页面"),
        )

class Product(models.Model):
    service_name    = models.CharField("业务线的名字", max_length=32)
    module_letter   = models.CharField("业务线字母简称", max_length=10, db_index=True)
    op_interface    = models.CharField("运维对接人", max_length=150)
    dev_interface   = models.CharField("业务对接人", max_length=150)
    pid             = models.IntegerField("上级业务线id", db_index=True)

    def __str__(self):
        return self.service_name


class Status(models.Model):
    name = models.CharField("状态名", max_length=10, unique=True)
    class Meta:
        db_table = "resources_status"

class Server(models.Model):
    idc             = models.ForeignKey(Idc, null=True)
    server_type     = models.CharField("云主机/物理机",max_length=20, null=True)
    sn              = models.CharField(max_length=60, null=True)
    hostname        = models.CharField(max_length=50, db_index=True, null=True)
    inner_ip        = models.CharField(max_length=32, null=True, unique=True)
    out_ip          = models.CharField(max_length=32, null=True)
    server_conf     = models.CharField(max_length=100, null=True)
    status          = models.ForeignKey(Status, null=True)
    remark          = models.TextField(null=True)
    service_id      = models.IntegerField(db_index=True, null=True)
    server_purpose  = models.ForeignKey(Product,null=True)
    create_date     = models.DateField(null=True)
    check_update_time = models.DateTimeField(auto_now=True, null=True)


    def __str__(self):
        return "{} [{}]".format(self.hostname, self.inner_ip)

    class Meta:
        db_table = 'resources_server'
        ordering = ['id']




