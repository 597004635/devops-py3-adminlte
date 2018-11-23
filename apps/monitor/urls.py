
from django.conf.urls import include, url
from . import zabbix, influx

urlpatterns = [
    # url(r'^zabbix/', include([
    #     url(r'^cachehost/$', zabbix.ZabbixCacheHostView.as_view(), name="zabbix_cachehost"),
    #     url(r'^host/', include([
    #         url(r'^rsync/$', zabbix.HostRsyncView.as_view(), name="zabbix_host_rsync"),
    #         url(r'^async/$', zabbix.AsyncView.as_view(), name="zabbix_host_async"), # 异步加载数据
    #         url(r'^linktemplate/$', zabbix.LinkTemplateView.as_view(), name="zabbix_host_linktemplate"),
    #         url(r'^gettemplate/$', zabbix.GetHostTemplatesView.as_view(), name="zabbix_host_templates"),
    #     ])),
    # ])),
    url(r'^influx/', include([
        url(r'^get/$', influx.InfluxApiView.as_view(), name="influx_api"),
        url(r'^graph/',include([
            url(r"^create/$", influx.CreateGraphView.as_view(), name="influx_graph_create"),
            url(r"^list/$", influx.GraphListView.as_view(), name="influx_graph_list"),
            url(r"^manage/$", influx.GraphManage.as_view(), name="influx_graph_manage"),
            url(r"^get/$", influx.GraphGetView.as_view(), name="influx_graph_get"),
            url(r"^detail/$", influx.GraphGetView.as_view(), name="influx_graph_detail"),
        ])),
        url(r'^productgraph/$', influx.ProductGraphView.as_view(), name="influx_product_graph"),
    ])),
]