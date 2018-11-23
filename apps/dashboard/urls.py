from django.conf.urls import url, include
from dashboard import users, role, power

urlpatterns = [
    url('^userlist/$', users.UserListView.as_view(), name='user_list'),
    url('^userdetail/(?P<pk>[0-9]+)?/$', users.UserDetailView.as_view(), name='user_detail'),
    url(r'^modifypasswd/$', users.ModifyPwdView.as_view(), name='modify_pwd'),
    url('^modifystatus/$', users.ModifyUserStatusView.as_view(), name='user_modify_status'),
    url(r'^usergrouppower/(?P<pk>[0-9]+)?/$', users.UserGroupPowerView.as_view(), name='user_group_power'),

    url('^grouplist/$', role.GroupListView.as_view(), name='role_list'),
    url(r'^groupdetail/(?P<pk>[0-9]+)?/$', role.GroupDetailView.as_view(), name='role_detail'),
    url(r'^groupusers/$', role.GroupUsersView.as_view(), name='role_users'),

    url(r'^powerlist/$', power.PowerListView.as_view(), name='power_list'),
    url(r'^powerdetail/(?P<pk>[0-9]+)?/$', power.PowerDetailView.as_view(), name='power_detail'),

    url(r'userlistapi/$',users.UserListApiView.as_view(), name='user_list_api'), 


]
