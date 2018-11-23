from django.views.generic import ListView, DetailView, CreateView,View
from django.db.models import Q
from django.http import JsonResponse, HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.shortcuts import render
from pure_pagination.mixins import PaginationMixin
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import  HttpResponse, JsonResponse, QueryDict,Http404
from django.forms.models import model_to_dict
from django.utils.decorators import method_decorator
from  django.contrib.auth.decorators import  permission_required
from django.contrib.auth.models import  Group, Permission
import json
import logging
import traceback

from django.conf import settings
from dashboard.models import UserProfile
from dashboard.forms import GroupForm

logger = logging.getLogger('opsweb')


''' 角色（用户）组： 获取列表，创建，删除 '''
class GroupListView(LoginRequiredMixin, PaginationMixin, ListView):
    model = Group
    template_name = "dashboard/group/group_list.html"
    context_object_name = "grouplist"
    paginate_by = 10
    keyword = ''

    def get_queryset(self):
        queryset = super(GroupListView, self).get_queryset()
        self.keyword = self.request.GET.get('keyword', '').strip()
        if self.keyword:
            queryset = queryset.filter(Q(name__icontains=self.keyword) )
        return queryset

    def get_context_data(self, **kwargs):
        context = super(GroupListView, self).get_context_data(**kwargs)
        context['keyword'] = self.keyword
        return context

    def post(self, request):
        form = GroupForm(request.POST)
        if form.is_valid():
            form.save()
            res = {'code': 0, 'result': '组添加成功'}
        else:
            # form.errors会把验证不通过的信息以对象的形式传到前端，前端直接渲染即可
            res = {'code': 1, 'errmsg': form.errors}
        return JsonResponse(res, safe=True)


    def delete(self, request, *args, **kwargs):
        data = QueryDict(request.body)
        pk = data.get('id')
        try:
            group_obj  = self.model.objects.get(pk=pk)
        except Group.DoesNotExist:
            res = {"code": 0, "errmsg": "组不存在"}

        if group_obj.user_set.all() or group_obj.permissions.all():
            res = {"code": 1, "errmsg": "无法删除，组内成员或者组内权限 不为空"}
        else:
            group_obj.delete()
            res = {"code": 0, "errmsg": "删除成功"}

        return JsonResponse(res, safe=True)


''' 角色(用户)组信息更新 '''
class GroupDetailView(LoginRequiredMixin, DetailView):
    model = Group
    template_name = "dashboard/group/group_edit.html"
    context_object_name = 'group'
    next_url = '/dashboard/grouplist/'
    pk_url_kwarg = 'pk'

    def get_context_data(self, **kwargs):
        context = super(GroupDetailView, self).get_context_data(**kwargs)
        context['group_has_permissions'] =  self.get_group_permission()
        context['group_not_permissions'] =  self.get_group_not_permission()
        return context

    def get_group_permission(self):
        pk = self.kwargs.get(self.pk_url_kwarg)
        try:
            group_obj  = Group.objects.get(pk=pk)
            return   group_obj.permissions.all()
        except Group.DoesNotExist:
            raise Http404

    def get_group_not_permission(self):
        pk = self.kwargs.get(self.pk_url_kwarg)
        try:
            group_obj = Group.objects.get(pk=pk)
            all_perms  =  Permission.objects.all()
            perms = [ perm for perm in all_perms if perm not  in group_obj.permissions.all()]
            return perms
        except:
            return   JsonResponse([], safe=False)


    def post(self, request, *args, **kwargs):
        permission_id_list  = request.POST.getlist('perms_selected', [])
        gid = request.POST.get('gid')
        name = request.POST.get('name')
        try:
            group = self.model.objects.get(pk=gid)
            group.permissions = permission_id_list
            group.name = name
            group.save()
            res = {"code": 0, "result": "更新成功", 'next_url': self.next_url}
        except:
            res = {"code": 1, "errmsg": '更新失败', 'next_url': self.next_url}
            logger.error("edit group  error: %s" % traceback.format_exc())

        return render(request, settings.JUMP_PAGE, res)



''' 组成员 删除'''
class GroupUsersView(LoginRequiredMixin,View):
    # 取出指定组下的所有用户信息列表
    @method_decorator(permission_required('dashboard', login_url='/'))
    def get(self,request):
        pk = request.GET.get('gid', None)
        try:
            group = Group.objects.get(pk=pk)
        except:
            return JsonResponse([], safe=False)

        users = group.user_set.all()
        #user_list = [{'username': user.username, 'name_cn':user.name_cn, 'email':user.email, 'id': user.id} for user in users]
        user_list =list(group.user_set.values('username','name_cn','email','id'))
        return  JsonResponse(user_list, safe=False)

    def  delete(self, request):
        data =  QueryDict(request.body)
        try:
            group_obj = Group.objects.get(pk=data.get('groupid',''))
            user_obj = UserProfile.objects.get(id=data.get("userid", ""))
            user_obj.groups.remove(group_obj)
            res = {'code': 0, 'result': '删除用户成功'}
        except UserProfile.DoesNotExist:
            res = {'code': 1,'errmsg':'用户不存在'}

        return   JsonResponse(res)



