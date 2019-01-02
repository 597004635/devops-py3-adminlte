import json
from audit.models import Task, TaskLog
import subprocess
from django.conf import settings
from django.db.transaction import atomic


"""处理批量任务（命令和文件传输）"""
class TaskHandle(object):

    def __init__(self, request):
        self.request = request
        self.errors = []
        self.task_data = None

    # 验证命令和主机列表的合法性
    def is_valid(self):
        task_data = self.request.POST.get('task_data')
        if task_data:
            self.task_data = json.loads(task_data)
            if self.task_data.get('task_type') == 'cmd':
                if self.task_data.get('cmd') and self.task_data.get('selected_host_ids'):
                    return True
                self.errors.append({'invalid_argument':'cmd or host_list is empty.'})

            elif self.task_data.get('task_type') == 'file_transfer':
                return True
            else:
                self.errors.append({'invalid_argument':'task_type is invalid..'})
        self.errors.append({'invalid_data':'task_data is not exist.'})

     # 开始任务，并返回任务ID
    def run(self):
        task_func = getattr(self, self.task_data.get('task_type'))
        task_obj = task_func()
        return task_obj

    # 批量任务:执行命令
    @atomic
    def cmd(self):
        task_obj = Task.objects.create(
            task_type=0,
            account=self.request.user.account,
            content=self.task_data.get('cmd'),
        )
        tasklog_objs = []
        host_ids = set(self.task_data.get("selected_host_ids"))
        for host_id in host_ids:
            tasklog_objs.append(TaskLog(task_id=task_obj.id,
                        host_user_bind_id=host_id,
                        status=3
                        )
            )
        TaskLog.objects.bulk_create(tasklog_objs, 100)

        cmd_str = "python %s %s" %(settings.MULTI_TASK_SCRIPT, task_obj.id)
        # multitask_obj = subprocess.Popen(cmd_str,stdout=subprocess.PIPE, stderr=subprocess.PIPE) # 因未加shell=True参数，排查了很久
        multitask_obj = subprocess.Popen(cmd_str, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return task_obj

    # 文件传输
    def file_transfer(self):
        task_obj = Task.objects.create(task_type=1, account=self.request.user.account, content=json.dumps(self.task_data))
        tasklog_objs = []
        host_ids = set(self.task_data.get("selected_host_ids"))
        for host_id in host_ids:
            tasklog_objs.append(TaskLog(task_id=task_obj.id, host_user_bind_id=host_id, status=3))
        TaskLog.objects.bulk_create(tasklog_objs, 100)

        cmd_str = "python %s %s" %(settings.MULTI_TASK_SCRIPT, task_obj.id)
        multitask_obj = subprocess.Popen(cmd_str, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return task_obj
