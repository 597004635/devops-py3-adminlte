from django.views.generic import TemplateView, View
from resources.models import Product, Idc, Server
from django.shortcuts import redirect
from resources.forms import ProductForm
from django.core.urlresolvers import reverse
from django.http import JsonResponse
from django.contrib.auth import get_user_model
from dashboard.models import UserProfile
#from django.contrib.auth.models import User

User = get_user_model()

import json
import logging
logger = logging.getLogger('opsweb')

class ProductAddView(TemplateView):
    template_name = "resources/product/product_add.html"

    def get_context_data(self, **kwargs):
        context = super(ProductAddView, self).get_context_data(**kwargs)
        context['userlist'] = User.objects.filter(is_superuser=False)
        context['products'] = Product.objects.filter(pid__exact=0)
        return context

    def post(self, request):
        # print(request.POST)
        productform = ProductForm(request.POST)

        if productform.is_valid():
            product = Product(**productform.cleaned_data)
            try:
                product.save()
                res = {'code': 0, 'next_url': reverse('resources:product_manage'), 'result': '添加成功'}
                #return redirect("success", next="idc_list")
            except Exception as e:
                msg = "用户{} 业务线出错：{}".format(request.user.username, e.args)
                logger.error(msg)
                res['code'] = 1
                res['errmsg'] = msg
                #return redirect("error", next="idc_list",msg=e.args)
        else:
            #return redirect("error", next="idc_list",msg=json.dumps(json.loads(productform.errors.as_json()), ensure_ascii=False))
            res = {'code': 1, 'next_url': reverse('resources:product_manage'), 'result': '添加失败'}

        return JsonResponse(res)

class ProductGetView(View):
    def get(self, request):
        ret = {"status":0}

        # 1 根据product id，取指定的一条记录
        p_id = self.request.GET.get("id",None)
        p_pid = self.request.GET.get("pid",None)
        print(p_id,p_pid)
        if p_id:
            ret["data"] = self.get_obj_dict(p_id)
            print("p_id: ",ret["data"])
        # 2 根据product pid，取出多条记录
        if p_pid:
            ret["data"] = self.get_products(p_pid)
            print("p_pid: ", ret["data"])
        # 3 不传任何值，取出所有记录
        return JsonResponse(ret)

    def get_obj_dict(self, p_id):
        try:
            obj = Product.objects.get(pk=p_id)
            ret = obj.__dict__
            print(ret)
            ret.pop("_state")
            return ret
        except Product.DoesNotExist:
            return {}

    def get_products(self,pid):
        return list(Product.objects.filter(pid=pid).values())

class ProductManageView(TemplateView):
    template_name = "resources/product/product_manage.html"

    def get_context_data(self, **kwargs):
        context = super(ProductManageView,self).get_context_data(**kwargs)
        context['host_list'] = Server.objects.all()
        context['ztree'] = Ztree().get()
        return context

class Ztree(object):
    def __init__(self):
        self.data = self.get_product()

    def get_product(self):
        return Product.objects.all()

    def get(self, idc=False,async=False):
        ret = []
        for product in self.data.filter(pid=0):
            node = self.process_node(product)
            node["children"] = self.get_children(product.id,async)
            node["isParent"] = "true"
            ret.append(node)
        if idc:
            return self.get_idc_node(ret)
        return ret

    def get_children(self, id, async=False):
        ret = []
        for product in self.data.filter(pid=id):
            node = self.process_node(product, async)
            ret.append(node)
        return ret

    def process_node(self, product_obj, async=False):
        ret = {
            "name": product_obj.service_name,
            "id": product_obj.id,
            "pid": product_obj.pid
        }
        if async:
            ret["isParent"] = "true"
        return ret

    def get_idc_node(self, nodes):
        ret = []
        for idc in Idc.objects.all():
            node = {
                "name": idc.idc_name,
                "children": nodes,
                "isParent": True
            }
            ret.append(node)
        return ret
