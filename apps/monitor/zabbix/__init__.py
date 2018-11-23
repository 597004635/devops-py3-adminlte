from django.views.generic import View,TemplateView
from django.http import JsonResponse,QueryDict
from django.contrib.auth.mixins import LoginRequiredMixin

from monitor.zabbix.client import cache_host, Zabbix, create_host, unlink_template, link_template
from resources.product import Ztree
from resources.models import Server

import logging

logger = logging.getLogger(__name__)

class ZabbixCacheHostView(View, LoginRequiredMixin):
    def get(self, request):
        logger.debug("开始同步zabbix缓存, 操作人：{}".format(request.user.username))
        ret = {"status":0}
        try:
            cache_host()
        except Exception as e:
            logger.error("同步zabbix缓存失败")
        logger.debug("同步zabbix缓存完成")
        return JsonResponse(ret)


class HostRsyncView(TemplateView):
    template_name = "monitor/zabbix/host_rsync.html"

    http_method_names = ['get', 'post',  'delete', "search"]

    def get_context_data(self, **kwargs):
        context = super(HostRsyncView, self).get_context_data(**kwargs)
        context['groups'] = Zabbix().get_groups()
        context['ztree'] = Ztree().get(async=True)
        return context

    def post(self, request):
        ret = {"status":0}
        group = request.POST.get("group", "")
        server = request.POST.getlist("server", [])
        ret_data = create_host(server, group)
        ret["data"] = ret_data
        return JsonResponse(ret)

    def search(self, request):
        key = QueryDict(request.body).get("key", "")
        queryset = Server.objects.filter(hostname__icontains=key).values("id", "hostname")
        return JsonResponse(list(queryset), safe=False)


class AsyncView(View):
    def get(self, request):
        server_purpose = request.GET.get("id", None)
        ret = []
        for s in Server.objects.filter(server_purpose=server_purpose):
            z_data = {}
            z_data["id"] = s.id
            z_data["name"] = s.hostname
            ret.append(z_data)
        return JsonResponse(ret, safe=False)


class LinkTemplateView(TemplateView):

    template_name = "zabbix/link_template.html"

    def get_context_data(self, **kwargs):
        context = super(LinkTemplateView, self).get_context_data(**kwargs)
        context["ztree"] = Ztree().get()
        context["templates"] = Zabbix().get_templates()
        return context

    def delete(self, request):
        ret = {"status":0}
        params = QueryDict(request.body)
        hostid = params.get("hostid", None)
        templateid = params.get("templateid", None)

        if not hostid:
            ret["status"] = 1
            ret["errmsg"] = "参数错误，没有指定主机"
            return JsonResponse(ret)
        if not templateid:
            ret["status"] = 1
            ret["errmsg"] = "参数错误，没有指定模板"
            return JsonResponse(ret)

        try:
            unlink_template(hostid, templateid)
        except Exception as e:
            ret["status"] = 1
            ret["errmsg"] = e.args
        return JsonResponse(ret)

    def post(self, request):
        ret = {"status": 0}
        hostids = request.POST.getlist("hostids[]", [])
        templateids = request.POST.getlist("templateids[]", [])

        if not hostids:
            ret["status"] = 1
            ret["errmsg"] = "参数错误，没有指定主机"
            return JsonResponse(ret)
        if not templateids:
            ret["status"] = 1
            ret["errmsg"] = "参数错误，没有指定模板"
            return JsonResponse(ret)
        ret["data"] = link_template(hostids, templateids)
        return JsonResponse(ret)

class GetHostTemplatesView(View):
    def get(self, request):
        zb = Zabbix()
        ret = []
        servers = Server.objects.filter(server_purpose=request.GET.get("id", None))
        logger.debug("服务列表数量为：{}".format(len(servers)))
        for server in servers:
            logger.debug("获取 {} 的信息".format(server.hostname))
            data = {}
            data["hostname"] = server.hostname
            data["id"] = server.id

            if hasattr(server, "zabbixhost"):
                logger.debug("{} 有监控, hostid: {}".format(server.hostname, server.zabbixhost.hostid))
                data["monitor"] = True
                templates = zb.get_templates(hostids=server.zabbixhost.hostid)
                print(templates)
                if templates:

                    data["templates_flag"] = True
                    data["templates"] = templates
                else:
                    data["templates_flag"] = False
            else:
                logger.debug("{} 没有监控".format(server.hostname))
                data["monitor"] = False
            ret.append(data)
        return JsonResponse(ret, safe=False)
