from django.http import HttpResponse, JsonResponse, Http404, QueryDict, QueryDict
from django.views.decorators.csrf import csrf_exempt
from resources.models import Server, Product
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, View, TemplateView
from django.shortcuts import render, redirect, get_object_or_404
from pure_pagination.mixins import PaginationMixin
from django.core.urlresolvers import reverse
from django.utils.http import urlquote_plus
from django.db.models import Q
from resources.forms import ServerForm
import datetime, logging

logger = logging.getLogger('opsweb')

@csrf_exempt
def ServerInfoAutoReport(request):
    if request.method == "POST":
        data = request.POST.dict()
        data['check_update_time'] = datetime.datetime.now()
        try:
            Server.objects.get(uuid__exact=data['uuid'])
            Server.objects.filter(uuid=data['uuid']).update(**data)
            """
            s.hostname = data['hostname']
            s.check_update_time = datetime.now()
            s.save(update_fields=['hostname'])
            """
        except Server.DoesNotExist:
            s = Server(**data)
            s.save()
        return HttpResponse("")

class ServerListView(LoginRequiredMixin, PaginationMixin, ListView):
    model = Server
    template_name = "resources/server/server_list.html"
    context_object_name = "serverlist"
    paginate_by = 10
    keyword = ''

    def get_queryset(self):
        queryset = super(ServerListView, self).get_queryset()
        keyword = self.request.GET.get("keyword", "").strip()
        if keyword:
            queryset = queryset.filter(Q(hostname__icontains=keyword)|
                                        Q(out__icontains = keyword) |
                                       Q(inner_ip__icontains=keyword)).order_by('id')

        return queryset

    def get_context_data(self, **kwargs):
        context = super(ServerListView, self).get_context_data(**kwargs)
        context['keyword'] = self.keyword
        return context

    def delete(self, request, *args, **kwargs):
        try:
            # pk = pk=QueryDict(request.body)['id']
            # server_obj = self.model.filter(pk=pk).delete()
            server_obj = Server.objects.get(pk=QueryDict(request.body)['id']).delete()
            # print(server_obj)
            res = {'code': 0, 'result': '删除成功'}
        except self.model.DoesNotExist:
            res = {'code': 1, 'errmsg': '信息不存在'}
        return JsonResponse(res)
    #
    # def get_product(self):
    #     ret = {}
    #     # for obj in Product.objects.all():
    #     #     ret[obj.id] = obj.service_name
    #     products = Product.objects.filter(pid__exact=0)
    #     for product in products:
    #         ret[product.id] = product.service_name
    #     return ret
    #
    # def get_pagerange(self, page_obj):
    #     current_index = page_obj.number
    #     start = current_index - self.before_range_num
    #     end = current_index + self.after_range_num
    #
    #     if start <= 0:
    #         start = 1
    #     if end >= page_obj.paginator.num_pages:
    #         end = page_obj.paginator.num_pages
    #     return range(start, end+1)

class AddServerView(LoginRequiredMixin, TemplateView):
    template_name = "resources/server/server_add.html"

    def post(self, request):
        # data = (request.POST.dict())
        # webdata = ServerForm(data)
        # if webdata.is_valid():
        #     webdata.save()
        #     res = {'code': 0, 'next_url': reverse('resources:server_list'), 'result': '添加成功!'}
        # else:
        #     res = {'code': 1, 'errmsg': webdata.errors}
        # return JsonResponse(res)

        ret = {'status': 0, 'errmsg': 'ok'}
        data = QueryDict(request.body)
        data = dict(data.items())
        try:
            server = Server(**data)
            server.save()
        except Exception as e:
            msg = "user {} add server error:{}".format(request.user.username, e.args)
            logger.error(msg)
            ret['status'] = 1
            ret['errmsg'] = msg
        return JsonResponse(ret, safe=True)

class ServerModifyProductView(TemplateView):
    template_name = "resources/server/server_modify_product.html"

    def get_context_data(self, **kwargs):
        context = super(ServerModifyProductView, self).get_context_data(**kwargs)
        server_id = self.request.GET.get("id", None)
        context['server'] = get_object_or_404(Server, pk=server_id)
        context['products'] = Product.objects.filter(pid=0)
        return context

    def post(self, request):

        next_url = request.GET.get("next", None) if request.GET.get("next", None) else "server_list"
        # '/resources/server/list/?page=4'
        # server_list
        server_id = request.POST.get("id", None)
        service_id = request.POST.get("service_id", None)
        server_purpose = request.POST.get("server_purpose", None)

        try:
            server_obj = Server.objects.get(pk=server_id)
        except Server.DoesNotExist:
            return redirect("error", next="server_list",msg="服务器不存在")

        try:
            product_service_id = Product.objects.get(pk=service_id)
        except Product.DoesNotExist:
            return redirect("error",next="server_list",msg="一级业务线不存在")

        try:
            product_server_purpose = Product.objects.get(pk=server_purpose)
        except Product.DoesNotExist:
            return redirect("error",next="server_list",msg="二级业务线不存在")

        if product_server_purpose.pid != product_service_id.id:
            raise Http404
        server_obj.service_id = product_service_id.id
        server_obj.server_purpose = product_server_purpose.id
        server_obj.save(update_fields=["service_id","server_purpose"])

        return redirect(reverse("success",kwargs={"next":urlquote_plus(next_url)}))


class GetServerListView(View):
    def get(self,request):
        server_purpose = request.GET.get("server_purpose", None)
        # 获取某台机器的所有信息

        # 获取某个业务线下的所有机器列表

        if server_purpose:
            queryset = Server.objects.filter(server_purpose=server_purpose).values("id","hostname","inner_ip")
            return JsonResponse(list(queryset), safe=False)
        # ....
        return JsonResponse([], safe=False)


