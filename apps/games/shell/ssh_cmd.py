import paramiko

def op_game( host_ip, cmd_str):
    # op_arg = ['ssh',ip,cmd]
    # process = subprocess.Popen(op_arg, shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    port = 22
    username = 'root'
    key_file = '/root/.ssh/id_rsa'
    key = paramiko.RSAKey.from_private_key_file(key_file)
    try:
        ssh = paramiko.SSHClient()
        ssh.load_system_host_keys()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        pkey = paramiko.RSAKey.from_private_key_file(key_file)
        ssh.connect(host_ip, port, username, pkey=key, timeout=30)
        stdin, stdout, stderr = ssh.exec_command(cmd_str)
    except Exception as e:
        print("\033[31m%s login faild!\033[0m" % host_ip)
    finally:
        ssh.close()


def check_game( host_ip):
    # op_arg = ['ssh',ip,cmd]
    # process = subprocess.Popen(op_arg, shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    port = 22
    username = 'root'
    key_file = '/root/.ssh/id_rsa'
    cmd_str = 'pgrep -f start.sh|wc -l'
    key = paramiko.RSAKey.from_private_key_file(key_file)
    try:
        ssh = paramiko.SSHClient()
        ssh.load_system_host_keys()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        pkey = paramiko.RSAKey.from_private_key_file(key_file)
        ssh.connect(host_ip, port, username, pkey=key, timeout=30)
        stdin, stdout, stderr = ssh.exec_command(cmd_str)
        result = stdout.read()
        result = int(result)

    except Exception as e:
        print("\033[31m%s login faild!\033[0m" % host_ip)
    finally:
        ssh.close()
    print("check_result: ", result)
    return result

