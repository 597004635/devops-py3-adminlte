from django.http import JsonResponse, QueryDict
from django.views.generic import TemplateView, View, ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from influxdb import InfluxDBClient
from django.utils.http import urlquote_plus
from django.urls import reverse
from django.shortcuts import redirect
from monitor.forms import CreateGraphForm
from monitor.models import Graph
from resources.models import Product, Server
import json
import time



class CreateGraphView(LoginRequiredMixin,TemplateView):
    template_name = "monitor/influx/graph_create.html"
    http_method_names = ["get", "post", "check"]

    def get_context_data(self, **kwargs):
        context = super(CreateGraphView, self).get_context_data(**kwargs)
        try:
            client = InfluxClient()
            context["measurements"] = client.measurements
        except:
            pass
        return context

    def post(self, request):
        next_url = urlquote_plus(request.GET.get("next", None) if request.GET.get("next", None) else reverse("influx_graph_list"))
        form = CreateGraphForm(request.POST)
        if form.is_valid():
            try:
                graph = Graph(**form.cleaned_data)
                graph.save()
                return redirect("success", next=next_url)
            except Exception as e:
                return redirect("error", next=next_url, msg=e.args)

        else:
            return redirect("error", next=next_url, msg=form.errors.as_json())

    def check(self, request):
        ret = {"status":0}
        params = QueryDict(request.body)
        measurement = params.get("measurement", "")
        where = params.get("where", "")

        client = InfluxClient()
        if not measurement or  measurement not in client.measurements:
            ret["status"] = 1
            ret["errmsg"] = "measurement 不正确"
            return JsonResponse(ret)

        sql = "show series from {}".format(measurement)
        if where:
            sql += " where {}".format(where)
        result = client.execute(sql)
        ret["data"] = list(result.get_points())
        return JsonResponse(ret)


class GraphListView(LoginRequiredMixin, ListView):
    template_name = "monitor/influx/graph_list.html"
    model = Graph

class ProductGraphView(LoginRequiredMixin, TemplateView):
    template_name = "influx/product_graphs.html"

    def get_context_data(self, **kwargs):
        context = super(ProductGraphView, self).get_context_data(**kwargs)
        context["products"] = self.get_product()
        return context

    def get_product(self):
        products = Product.objects.all()
        ret = []
        #{"id":2, "name":"ms-web"}
        for obj in products.filter(pid__exact=0):
            for product in products.filter(pid__exact=obj.id):
                ret.append({
                    "id": product.id,
                    "name":"{}->{}".format(obj.service_name, product.service_name)
                })
        return ret


class InfluxApiView(LoginRequiredMixin, View):
    def get(self, request):
        # graph_id=7&graph_time=30m
        ret = {"status":0}
        graph_id = request.GET.get("graph_id", None)
        graph_time = request.GET.get("graph_time", None)
        product_id = request.GET.get("product_id", None)

        try:
            graph_obj = Graph.objects.get(pk=graph_id)
        except:
            ret["status"] = 1
            ret["errmsg"] = "graph 不存在"
            return JsonResponse(ret)

        try:
            product_obj = Product.objects.get(pk=product_id)
            if product_obj.pid == 0:
                ret["status"] = 1
                ret["errmsg"] = "业务线异常"
                return JsonResponse(ret)
        except:
            ret["status"] = 1
            ret["errmsg"] = "业务线异常"
            return JsonResponse(ret)


        client = InfluxClient()
        client.hostnames = [s["hostname"] for s in Server.objects.filter(server_purpose__exact=product_obj.id).values("hostname")]
        client.graph_obj = graph_obj
        client.graph_time = graph_time

        client.query()
        ret["series"] = client.series
        ret["categories"] = client.categories
        return JsonResponse(ret,safe=False)

class GraphGetView(LoginRequiredMixin, View):
    def get(self, request):
        productid = request.GET.get("id",None)
        outside = request.GET.get("outside", False)

        try:
            product_obj = Product.objects.get(pk=productid)
            if product_obj.pid == 0:
                return JsonResponse([], safe=False)
        except Product.DoesNotExist:
            return JsonResponse([], safe=False)

        queryset = Graph.objects.values()
        if outside:
            queryset = queryset.exclude(product__id=productid)
        else:
            queryset = queryset.filter(product__id=productid)

        return JsonResponse(list(queryset), safe=False)


class GraphManage(LoginRequiredMixin, TemplateView):
    template_name = "influx/graph_manage.html"

    def get_context_data(self, **kwargs):
        context = super(GraphManage, self).get_context_data(**kwargs)
        context["products"] = self.get_product()
        context["object_list"] = self.get_queryset()
        context.update(self.get_args())
        return context

    def get_queryset(self):
        product_id = self.request.GET.get("product", "")
        try:
            product_obj = Product.objects.get(pk=product_id)
            return product_obj.graph_set.all()
        except:
            return []

    def get_product(self):
        products = Product.objects.all()
        ret = []
        #{"id":2, "name":"ms-web"}
        for obj in products.filter(pid__exact=0):
            for product in products.filter(pid__exact=obj.id):
                ret.append({
                    "id": product.id,
                    "name":"{}->{}".format(obj.service_name, product.service_name)
                })
        return ret

    def get_args(self):
        product = self.request.GET.get("product","")
        try:
            return {"productid":int(product)}
        except:
            return {}

    def post(self, request):
        ret = {"status":0}
        product_id = request.GET.get("product", "")
        graph_id = request.POST.get("graph_id", "")

        try:
            product_obj = Product.objects.get(pk=product_id)
            if product_obj.pid == 0:
                ret["status"] = 1
                ret["errmsg"] = "请选择正确的业务线"
                return JsonResponse(ret)
        except Product.DoesNotExist:
            ret["status"] = 1
            ret["errmsg"] = "请选择正确的业务线"
            return JsonResponse(ret)

        try:
            graph_obj = Graph.objects.get(pk=graph_id)
        except Graph.DoesNotExist:
            ret["status"] = 1
            ret["errmsg"] = "请选择正确的graph"
            return JsonResponse(ret)
        product_obj.graph_set.add(graph_obj)
        #graph_obj.product.add(product_obj)
        return  JsonResponse(ret)

    def delete(self, request):
        ret = {"status":0}

        product_id = request.GET.get("product", "")
        graph_id = QueryDict(request.body).get("graph_id", "")
        try:
            product_obj = Product.objects.get(pk=product_id)
            if product_obj.pid == 0:
                ret["status"] = 1
                ret["errmsg"] = "请选择正确的业务线"
                return JsonResponse(ret)
        except Product.DoesNotExist:
            ret["status"] = 1
            ret["errmsg"] = "请选择正确的业务线"
            return JsonResponse(ret)

        try:
            graph_obj = Graph.objects.get(pk=graph_id)
        except Graph.DoesNotExist:
            ret["status"] = 1
            ret["errmsg"] = "请选择正确的graph"
            return JsonResponse(ret)
        product_obj.graph_set.remove(graph_obj)
        #graph_obj.product.add(product_obj)
        return  JsonResponse(ret)

class InfluxClient():
    def __init__(self):
        self.client = InfluxDBClient("192.168.1.50",database="collectd")
        self.measurements = self.get_measurements()
        self.categories = []        # x 轴的数据
        self.series = []            # 图形数据点
        self.hostnames = []
        self.graph_obj = None
        self.graph_time = "30m"

    def get_measurements(self):
        measurements = self.client.query("show measurements").get_points()
        return [m["name"] for m in measurements]

    def query(self):
        where = ""
        if self.graph_obj.field_expression:
            where += " and " + self.graph_obj.field_expression
        sql = ""
        for hostname in self.hostnames:
            sql += """select mean(value) as value \
from {} \
where time > now() - {} \
{} \
and host = '{}' \
group by time(10s) order by time desc;""".format(self.graph_obj.measurement, self.graph_time, where, hostname)

        result = self.client.query(sql, epoch="s")

        if len(self.hostnames) == 1:
            self.process_data(self.hostnames[0], result.get_points())
            return True

        for index, hostname in enumerate(self.hostnames):
            self.process_data(hostname, result[index].get_points())


    def execute(self,sql, **kwargs):
        return self.client.query(sql, **kwargs)


    def process_data(self, hostname, data_points):
        serie = {}
        serie["name"] = hostname
        serie["type"] = "line"
        serie["data"] = []
        categories = []
        for point in data_points:
            serie["data"].insert(0,point["value"])
            categories.insert(0, point["time"])
        self.series.append(serie)
        if not self.categories:
            self.categories = self.process_time(categories)


    def process_time(self, categories):
        ret = []
        format_str = "%Y-%m-%d %H:%M:%S"
        for point in categories:
            ret.append(time.strftime(format_str, time.localtime(point)))
        return ret
