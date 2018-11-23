from django.conf import settings
from resources.models import Server
from monitor.models import ZabbixHost

from zabbix_client import ZabbixServerProxy

import logging
import json

logger = logging.getLogger(__name__)


class Zabbix(object):
    def __init__(self):
        self.zb = ZabbixServerProxy(settings.ZABBIX_API)
        self.zb.user.login(user=settings.ZABBIX_USER, password=settings.ZABBIX_USERPASS)

    def get_hosts(self):
        return self.zb.host.get(output=["hostid", "host"], selectInterfaces=["ip"])

    def get_groups(self):
        return self.zb.hostgroup.get(output=["groupid", "name"])

    def create_host(self, params):
        return self.zb.host.create(**params)

    def get_templates(self,hostids=None):
        if hostids:
            return self.zb.template.get(output=["name", "templateid"], hostids=hostids)
        return self.zb.template.get(output=["name", "templateid"])

    def unlink_template(self, hostid, templateid):
        return self.zb.host.update(hostid=hostid, templates_clear=[{"templateid":templateid}])

    def link_template(self, hostid, templates):
        linked_templates_ids = [t["templateid"]  for t in self.get_templates(hostid)]
        linked_templates_ids.extend(templates)
        return  self._link_template(hostid, linked_templates_ids)

    def _link_template(self, hostid, templateids):
        templates = []
        for tid in templateids:
            templates.append({"templateid": tid})
        try:
            ret = self.zb.host.update(hostid=hostid, templates=templates)
            return ret
        except Exception as e:
            return e.args



def process_zb_hosts(zbhosts):
    logger.debug("处理zabbix host信息")
    ret = []
    ip_list = []
    # {'hostid': '10254', 'host': 'yz-fang-web-01', 'ip': '10.20.1.10'}
    for host in zbhosts:
        # {'hostid': '10254', 'host': 'yz-fang-web-01', 'interfaces': [{'ip': '10.20.1.10'}]}
        try:
            ip = host['interfaces'][0]['ip']
        except KeyError as e:
            logger.error("获取ip失败，{}, {}".format(json.dumps(host), e.args))

        del host['interfaces']
        host['ip'] = ip
        ret.append(host)
        if ip in ip_list:
            logger.error("zabbix 里有多条相同ip的机器列表")
        else:
            ip_list.append(ip)
    return ret


def cache_host():
    ZabbixHost.objects.all().delete()
    # 1 取出所有zabbix里的host信息
    zbhosts = process_zb_hosts(Zabbix().get_hosts())

    for host in zbhosts:
        # {'hostid': '10254', 'host': 'yz-fang-web-01', 'interfaces': [{'ip': '10.20.1.10'}]}
        try:
            server_obj = Server.objects.get(inner_ip=host['ip'])
        except Server.DoesNotExist:
            logger.error("zabbix里的监控设备[{}]，CMDB里不存在".format(host['ip']))
        except Server.MultipleObjectsReturned:
            logger.error("zabbix里的监控设备[{}]，CMDB里存在多条记录".format(host['ip']))
        else:
            host['server'] = server_obj
            zh = ZabbixHost(**host)
            zh.save()


def create_host(serverids, groupid="2"):
    logger.debug("同步服务器到zabbix,args: serverid:{}, groupid:{}".format(json.dumps(serverids), groupid))
    ret_data = []
    if isinstance(serverids, list) and serverids:
        # 获取对应的hostname与ip
        logger.debug("查询对应的服务器信息")
        for server in Server.objects.filter(id__in=serverids):
            logger.debug("同步 {}[{}] 到zabbix".format(server.hostname, server.inner_ip))
            zb_data = {}
            zb_data["hostname"] = server.hostname
            try:
                hostid = _create_host(server.hostname, server.inner_ip,groupid)
                zb_data["status"] = True
            except Exception as e:
                zb_data["status"] = False
                zb_data["errmsg"] = e.args
            else:
                try:
                    zb = ZabbixHost()
                    zb.server = server
                    zb.hostid = hostid
                    zb.ip = server.inner_ip
                    zb.host = server.hostname
                    zb.save()
                except Exception as e:
                    zb_data["status"] = False
                    zb_data["errmsg"] = "同步成功，但缓存失败：{}".format(e.args)
            logger.debug("同步 {}[{}] 到zabbix完成：{}".format(server.hostname, server.inner_ip, json.dumps(zb_data)))
            ret_data.append(zb_data)
    return ret_data

def _create_host(hostname, ip, groupid="2", port="10050"):
    params = {

        'host': hostname,
        'interfaces': [
            {
                'dns': '',
                'ip': ip,
                'main': 1,
                'port': port,
                'type': 1,
                'useip': 1
             }
        ],
        'groups': [{'groupid': groupid}]
    }
    try:
        ret = Zabbix().create_host(params)
        logger.debug("创建zabbix host 完成：{}".format(json.dumps(ret)))
        if "hostids" in ret:
            return ret["hostids"][0]
        else:
            raise Exception(ret["hostids"][0])
    except Exception as e:
        raise Exception(e.args[0])

def unlink_template(serverid, templateid):
    try:
        server = Server.objects.get(pk=serverid)
        hostid = server.zabbixhost.hostid
    except Server.DoesNotExist:
        raise Exception("服务器不存在")
    except AttributeError:
        raise Exception("请先同步缓存")
    ret = Zabbix().unlink_template(hostid, templateid)
    if "hostids" in ret:
        return True
    raise Exception(ret[0])


def link_template(serverids, templateids):
    zb = Zabbix()
    data = []
    for serverid in serverids:
        ret_data = {}

        try:
            server = Server.objects.get(pk=serverid)
            ret_data["hostname"] =server.hostname
            hostid = server.zabbixhost.hostid
            ret = zb.link_template(hostid, templateids)
        except Server.DoesNotExist:
            ret_data["status"] = False
            ret_data["errmsg"] = "服务器不存在"
        except AttributeError:
            ret_data["status"] = False
            ret_data["errmsg"] = "该机器没有监控"
        except Exception as e:
            ret_data["status"] = False
            ret_data["errmsg"] = e.args
        else:
            if "hostids" in ret:
                ret_data["status"] = True
            else:
                ret_data["status"] = False
                ret_data["errmsg"] = ret[0]
        data.append(ret_data)
    return data

