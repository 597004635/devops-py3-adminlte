from django.views.generic import ListView, DetailView, CreateView,View
from django.db.models import Q
from django.http import JsonResponse, HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.shortcuts import render
from pure_pagination.mixins import PaginationMixin
from django.contrib.auth.mixins import LoginRequiredMixin
from  django.http import  HttpResponse, JsonResponse, QueryDict,Http404
from django.conf import settings
from dashboard.models import UserProfile
from django.contrib.auth.models import  Group, Permission
from  work_order.forms import  WorkOrderCreateForm, WorkOrderResultForm
from work_order.models import WorkOrder
from django.core.mail import send_mail
import traceback
import logging
from   work_order.tasks import send_order_email
# from django.contrib.auth import get_user_model
# User = get_user_model()

logger = logging.getLogger('opsweb')


class  WorkOrderApplyView(LoginRequiredMixin, View):
    def get(self, request):
        assign_to_sa = UserProfile.objects.filter(groups__name='sa')
        assign_to_sa_list = [{'id': assign.id, 'name_cn':assign.name_cn,} for assign in assign_to_sa]
        return  render(request, 'work_order/workorder_apply.html', {'assign_to_sa':assign_to_sa_list})

    def post(self, request, **kwargs):
        webdata  =   request.POST.dict()
        webdata['applicant']  =  request.user.id
        forms = WorkOrderCreateForm(webdata)
        if forms.is_valid():
            forms.save()
            send_order_email.delay(webdata['title'],webdata['order_contents'], [request.user.email])
            return  HttpResponseRedirect(reverse('work_order:list'))
        else:
            return  render(request, 'work_order/workorder_apply.html', {'forms': forms, 'errmsg': '工单填写格式错误'})


class WorkOrderListView(LoginRequiredMixin, PaginationMixin, ListView):
    '''
        未处理工地列表展示
    '''
    model = WorkOrder
    template_name = 'work_order/workorder_list.html'
    context_object_name = "orderlist"
    paginate_by = 10
    keyword = ''

    def get_queryset(self):
        queryset = super(WorkOrderListView, self).get_queryset()

        # 只显示状态小于2，即申请和处理中的工单
        queryset = queryset.filter(status__lt=2)

        # 如果不是sa组的用户只显示自己申请的工单，别人看不到你申请的工单，管理员可以看到所有工单
        if 'sa' not in [group.name for group in self.request.user.groups.all()]:
            queryset = queryset.filter(applicant=self.request.user)

        self.keyword = self.request.GET.get('keyword', '')
        if self.keyword:
            queryset = queryset.filter(Q(title__icontains = self.keyword)|
                                       Q(order_contents__icontains = self.keyword)|
                                       Q(result_desc__icontains=self.keyword))
        return queryset

    def get_context_data(self, **kwargs):
        context = super(WorkOrderListView, self).get_context_data(**kwargs)
        context['keyword'] = self.keyword
        return context

    def delete(self, request, *args, **kwargs):
        try:
            data = QueryDict(request.body)
            pk = data.get('id')
            work_order = WorkOrder.objects.get(pk=pk)
            work_order.status = 3
            work_order.save()
            ret = {'code': 0, 'result': '取消工单成功！'}
        except:
            ret = {'code': 1, 'errmsg': '取消工单失败！'}
            logger.error("delete order  error: %s" % traceback.format_exc())
        return JsonResponse(ret, safe=True)


class WorkOrderDetailView(LoginRequiredMixin, DetailView):
    template_name = 'work_order/workorder_detail.html'
    model = WorkOrder
    context_object_name = 'work_order'

    def  post(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        work_order = self.model.objects.get(pk=pk)

        if work_order.status  == 0:
            work_order.status = 1
            work_order.save()
            return  render(request, 'work_order/workorder_detail.html', {'work_order':work_order, 'msg': '您已经接受工单'})

        if work_order.status == 1:
            forms  = WorkOrderResultForm(request.POST)
            if forms.is_valid():
                result_desc  = request.POST.get('result_desc', '')
                work_order.result_desc = result_desc
                work_order.status  = 2
                work_order.save()
                return  HttpResponseRedirect(reverse('work_order:list'))
            else:
                return render(request, 'work_order/workorder_detail.html' , {'work_order': work_order, 'errmsg' : '必须填写处理结果!'})




class  WorkOrderHistoryView(LoginRequiredMixin, ListView):
    model =  WorkOrder
    template_name =  'work_order/workorder_history.html'
    context_object_name = 'historylist'
    paginate_by  = 10
    keyword  = ''

    def  get_queryset(self):
        queryset = super(WorkOrderHistoryView, self).get_queryset()
        #显示所有处理完毕的工资
        queryset = queryset.filter(status__gte=2)
        # 如果不是 sa组的用户只显示自己申请的工单，别人看不到你申请的工单，管理员可以看到所有工单
        if  'sa' not in [group.name for group in self.request.user.groups.all()]:
            queryset = queryset.filter(applicant= self.request.user)

        self.keyword   = self.request.GET.get('keyword', '')
        if  self.keyword :
            queryset  = queryset.filter(Q(title__icontains = self.keyword)|
                                        Q(order_contents__icontains = self.keyword)|
                                        Q(result_desc__icontains = self.keyword))
        return  queryset

    def  get_context_data(self, **kwargs):
        context = super(WorkOrderHistoryView, self).get_context_data(**kwargs)
        context['keyword'] = self.keyword
        return context