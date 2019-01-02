环境：
  Python3.6.2 
  Django1.11.8 
  MySQL5.6

   AdminLTE2.4

其他说明：
1、资源管理 产品管理待完善
2、监控展示  influxdb 待完善
3、监控配置  zabbix主机同步等待完善





#######################################
审计模块
# https://github.com/317828332/LuffyAudit/tree/master/audit
# https://github.com/triaquae/CrazyEye
1、安装shellinbox
   yum -y install git openssl-devel pam-devel zlib-devel autoconf automake libtool
   git clone https://github.com/shellinabox/shellinabox.git && cd shellinabox
   autoreconf -i
   ./configure && make ; make install

    shellinaboxd -d -t # 在后台启动，不以https模式启动



  堡垒机账号修改家目录下的.bashrc，最后增加几行
  echo "---------欢迎登录运维堡垒机------------"
/home/denghonglin/env/py35/bin/python3 /home/denghonglin/demo/devops/audit_shell.py
echo "Bye."
logout

