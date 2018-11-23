from django.conf.urls import url
from .views import *

urlpatterns = [
    url('^apply/$', ApplyView.as_view(), name='apply'),
    url('^apply_list/$', ApplyListView.as_view(), name='apply_list'),
    url('^deploy/(?P<pk>[0-9]+)?/$',  DeployTestView.as_view(), name='deploy'),
    url('^deploy/test/(?P<pk>[0-9]+)?/$',  DeployTestView.as_view(), name='test_deploy'),
    url('^deploy/pro/(?P<pk>[0-9]+)?/$',   DeployProView.as_view(), name='pro_deploy'),
    url('^deploy_history/$', DeployHistoryView.as_view(), name='deploy_history'),
    url('^detail/(?P<pk>[0-9]+)/$', DeployDetailView.as_view(), name='detail'),

    # 获取某个项目的所有标签(版本)
    url('^get_project_versions/$', GetProjectVersionsView.as_view(), name='get_project_versions'),
]
