from django.views.generic import TemplateView, ListView, DetailView
from django.db.models import Q
from django.shortcuts import redirect, reverse, render
from django.http import HttpResponse, JsonResponse, HttpResponseRedirect, QueryDict, Http404
from resources.models import Idc
import json, logging, traceback
from pure_pagination.mixins import PaginationMixin
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.mixins import LoginRequiredMixin
# from unit.mixins import PermissionRequiredMixin
from resources.forms import CreateIdcForm, UpdateIdcForm
from django.conf import settings

logger = logging.getLogger('opsweb')


class CreateIdcView(LoginRequiredMixin, TemplateView):
    template_name = "resources/idc/idc_add.html"

    def post(self, request):
        data = (request.POST.dict())
        webdata = CreateIdcForm(data)
        if webdata.is_valid():
            webdata.save()
            res = {'code': 0, 'next_url': reverse('resources:idc_list'), 'result': '添加成功!'}
        else:
            res = {'code': 1, 'errmsg': webdata.errors}
        return JsonResponse(res)

    """
    def post(self, request):
        idcform = CreateIdcForm(request.POST)
        if idcform.is_valid():
            #print("验证成功")
            idc = Idc(**idcform.cleaned_data)
            try:
                idc.save()
                return redirect("success",next="idc_list")
            except Exception as e:
                return redirect("error",next="idc_list",msg=e.args)
        else:
            #print(idcform.errors.as_data())
            return redirect("error",next="idc_list",msg=json.dumps(json.loads(idcform.errors.as_json()),ensure_ascii=False))
    """


class IdcListView(LoginRequiredMixin, PaginationMixin, ListView):
    # 调用自定义的权限验证
    # permission_required = "resources.idc_add"
    # permission_redirect_field_name = "user_list"
    # model = Idc
    # template_name = "resources/idc/idc_list.html"

    model = Idc
    template_name = "resources/idc/idc_list.html"
    context_object_name = "idclist"
    paginate_by = 10
    keyword = ''

    def get_queryset(self):
        queryset = super(IdcListView, self).get_queryset()
        self.keyword = self.request.GET.get('keyword', '').strip()
        if self.keyword:
            queryset = queryset.filter(Q(name__icontains=self.keyword) |
                                       Q(idc_name__icontains=self.keyword))
        return queryset

    def get_context_data(self, **kwargs):
        context = super(IdcListView, self).get_context_data(**kwargs)

        context['keyword'] = self.keyword
        return context

    def delete(self, request, *args, **kwargs):
        try:
            idc_obj = Idc.objects.get(pk=QueryDict(request.body)['id']).delete()
            res = {'code': 0, 'result': '删除成功'}
        except Idc.DoesNotExist:
            res = {'code': 1, 'errmsg': '信息不存在'}
        return JsonResponse(res)


class EditIdcDetailView(LoginRequiredMixin, DetailView):
    model = Idc
    template_name = "resources/idc/idc_edit.html"
    context_object_name = "idc_obj"
    next_url = '/resources/idclist/'

    def post(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        p = self.model.objects.get(pk=pk)
        form = UpdateIdcForm(request.POST, instance=p)
        if form.is_valid():
            form.save()
            res = {"code": 0, "result": "更新成功", 'next_url': self.next_url}
        else:
            res = {"code": 1, "errmsg": form.errors, 'next_url': self.next_url}
            logger.error("update idc  error: %s" % traceback.format_exc())
        return render(request, settings.JUMP_PAGE, res)
