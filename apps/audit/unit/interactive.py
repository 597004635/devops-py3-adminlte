# Copyright (C) 2003-2007  Robey Pointer <robeypointer@gmail.com>
# This file is part of paramiko.

import sys, socket
from paramiko.py3compat import u
from audit.models import AuditLog

try:
    import termios
    import tty
    has_termios = True
except ImportError:
    has_termios = False

def interactive_shell(chan,session_obj):
    if has_termios:
        posix_shell(chan, session_obj)
    else:
        windows_shell(chan)

def posix_shell(chan, session_obj):
    import select
    oldtty = termios.tcgetattr(sys.stdin)
    try:
        tty.setraw(sys.stdin.fileno())
        tty.setcbreak(sys.stdin.fileno())
        chan.settimeout(0.0)
        flag = False
        cmd = ''
        while True:
            r, w, e = select.select([chan, sys.stdin], [], [])
            # 远程有返回命令结果
            if chan in r:
                try:
                    x = u(chan.recv(1024))
                    if len(x) == 0:
                        sys.stdout.write("\r\n\033[32;1m *** Session Closed ***\033[0m\r\n")
                        break
                    if flag:
                        cmd += x
                        flag = False
                    sys.stdout.write(x)
                    sys.stdout.flush()
                except socket.timeout:
                    pass
            if sys.stdin in r:
                x = sys.stdin.read(1)
                if len(x) == 0:
                    break
                if x == '\r':
                    AuditLog.objects.create(session=session_obj,cmd=cmd)
                    cmd = ''
                elif x == '\t':
                    flag = True
                else:
                    cmd += x
                chan.send(x)
    finally:
        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, oldtty)

def windows_shell(chan):
    import threading
    sys.stdout.write("Line-buffered terminal emulation. Press F6 or ^Z to send EOF.\r\n\r\n")

    def writeall(sock):
        while True:
            data = sock.recv(256)
            if not data:
                sys.stdout.write("\r\n\033[32;1m*** Session closed ***\033[0m\r\n\r\n")
                sys.stdout.flush()
                break
            sys.stdout.write(data)
            sys.stdout.flush()

    writer = threading.Thread(target=writeall, args=(chan,))
    writer.start()

    try:
        while True:
            d = sys.stdin.read(1)
            if not d:
                break
            chan.send(d)
    except EOFError:
        # user hit ^Z or F6
        pass