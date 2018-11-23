from django.conf.urls import url, include
from resources import idc, product, server

urlpatterns = [
    url('^idclist/$', idc.IdcListView.as_view(), name='idc_list'),
    url('^idcadd/$', idc.CreateIdcView.as_view(), name='idc_add'),
    url('^idcedit/(?P<pk>[0-9]+)?/$', idc.EditIdcDetailView.as_view(), name='idc_edit'),

    # url('^product_detail/(?P<pk>[0-9]+)?/$', product.ProductDetailView.as_view(), name='product_detail'),
    # url('^product_add/$', product.ProductAddView.as_view(), name='product_add'),

    url('^productmanage/$', product.ProductManageView.as_view(), name='product_manage'),
    url('^productadd/$', product.ProductAddView.as_view(), name='product_add'),
    url('^productget/$', product.ProductGetView.as_view(), name='product_get'),

    url('^srever_list/$', server.ServerListView.as_view(), name='server_list'),
    url('^srever_add/$', server.AddServerView.as_view(), name='server_add'),

]
