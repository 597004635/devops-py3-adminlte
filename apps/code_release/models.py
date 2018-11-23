from django.db import models
from dashboard.models import UserProfile

# Create your models here.


class Deploy(models.Model):
    STATUS = (
        (0, '申请'),
        (1, '测试'),
        (2, '已上线'),
        (3, '取消上线'),
    )
    ENVS = (
        (0, '测试环境'),
        (1, '生产环境'),
    )

    name = models.CharField(max_length=40, verbose_name=u'项目名称')
    project_version = models.CharField(max_length=40, verbose_name=u'项目版本')
    version_desc = models.CharField(max_length=100, verbose_name=u'版本描述', null=True)
    applicant = models.ForeignKey(UserProfile, verbose_name=u'申请人', related_name="applicant")
    assigned_to = models.ForeignKey(UserProfile, verbose_name=u'指派人', related_name="assigned")
    update_detail = models.TextField(verbose_name=u'更新详情')
    status = models.IntegerField(default=0, choices=STATUS, verbose_name='上线状态')
    apply_time = models.DateTimeField(auto_now_add=True, verbose_name=u'申请时间')
    deploy_time = models.DateTimeField(auto_now=True, verbose_name=u'上线完成时间')
    result = models.TextField(default='', verbose_name=u'测试环境执行结果详情')
    env = models.IntegerField(default=0, choices=ENVS, verbose_name='发布环境')