from django.contrib.auth import authenticate
from django.conf import settings
from audit.models import Token
from audit.unit.ssh_interactive import ssh_session
import subprocess, random, string, datetime, sys
from django.contrib.auth import get_user_model
User = get_user_model()



class UserShell(object):
    """ 用户登录堡垒机后的shell"""
    def __init__(self,sys_argv):
        self.sys_argv = sys_argv
        self.user = None

    def auth(self):
        """密码登录"""
        count = 0
        while count < 3:
            username = input("username: ").strip()
            password = input("password: ").strip()
            user = authenticate(username=username,password=password)
            if not user:
                count += 1
                print("\033[31;2mInvalid username or password!\033[0m")
            else:
                self.user = user
                return True
        else:
            print("You have more than 3 times. \033[31;2mAuthentication failed\033[0m")

    def auth_tgsw(self,user_name):
        dic_pwd = {'tgsw': 'tgsw12345'}
        username = user_name
        password = dic_pwd[username]
        print("pwd: ",password)
        password = dic_pwd[username]
        user = authenticate(username=username, password=password)
        if not user:
            print("\033[31;2mInvalid username or password!\033[0m")
        else:
            self.user = user
            return True




    def token_auth(self):
        """token登录"""
        count = 0
        while count < 3:
            user_input = input("Please input host token(or Enter): ").strip()
            if len(user_input) == 0:
                return
            if len(user_input) != 16:
                print("token length is 16.")
            else:
                time_obj = datetime.datetime.now() - datetime.timedelta(seconds=10800)
                token_obj = Token.objects.filter(val=user_input,date__gt=time_obj).first()
                if token_obj:
                    if token_obj.val == user_input:
                        self.user = token_obj.account.user
                        return token_obj

    # def start(self,user_name):
    def start(self):
        """启动交互程序"""
        token_obj = self.token_auth()
        """token方式登录"""
        if token_obj:
            ssh_session(token_obj.host_user_bind,self.user)
            exit()

        """用户名密码登录"""
        if self.auth():
        # if self.auth_tgsw(user_name):
            while True:
                host_groups = self.user.account.host_groups.all()
                print("\n\033[36;3m==== 欢迎登录《太古神王》堡垒机 ===\033[0m")
                print("\n\033[33;3mPlease select group host (Quit: Enter 'exit/q')\033[0m")
                for index, group in enumerate(host_groups):
                    print("%s.\t%s[%s]" %(index, group, group.host_user_binds.count()))
                print("%s.\t未分组机器[%s]" %(len(host_groups),self.user.account.host_user_binds.count()))
                try:
                    choice = input("\033[33;2mPlease select number:\033[0m").strip()
                    if choice.isdigit():
                        choice = int(choice)
                        host_bind_list = None
                        if choice >= 0 and choice < len(host_groups):
                            selected_group = host_groups[choice]
                            host_bind_list = selected_group.host_user_binds.all()
                        elif choice == len(host_groups):
                            host_bind_list = self.user.account.host_user_binds.all()
                        if host_bind_list:
                            while True:
                                print("\n\033[33;3mPlease select host (Back: Enter 'b' or Press 'q' to quit )\033[0m")
                                for index, host in enumerate(host_bind_list):
                                    # print("\t\t%s.\t%s" %(index,host))
                                    print("\t%s.\t%s[%s]" % (index, host.host.hostname, host.host.ip_addr))
                                choice1 = input("\033[33;2mPlease select number:\033[0m").strip()
                                if choice1.isdigit():
                                    choice1 = int(choice1)
                                    if choice1 >= 0 and choice1 < len(host_bind_list):
                                        selected_host = host_bind_list[choice1]
                                        ssh_session(selected_host,self.user)
                                elif choice1 == 'b':
                                    break
                                elif choice1 == 'q':
                                    sys.exit(1)

                    if choice == 'exit'or choice == 'q':
                        break

                except KeyboardInterrupt as e:
                    pass




