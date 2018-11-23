import  jenkins
import  time
from devops.settings import Jenkins_HTTP_URI, Jenkins_User, Jenkins_User_API_Token


# 在jenkins需要设置带参数化构建
def Jenkins_apply(project,tag):
    jenkins_server = jenkins.Jenkins(Jenkins_HTTP_URI, username=Jenkins_User, password=Jenkins_User_API_Token)
    last_build_number = jenkins_server.get_job_info(project)['lastCompletedBuild']['number']
    this_build_number = last_build_number + 1
    #判断当前是否有job在执行
    if jenkins_server.get_build_info(project,last_build_number)['building'] == False:

        jenkins_server.build_job(project, parameters={'tag': tag})
        # jenkins_server.build_job(project)

        while  True:
            #判断构建是否完成,构建完成则返回最后一次构建id,和last_build_number进行判断，成功则返回日志,否则循环
            if jenkins_server.get_job_info(project)['lastCompletedBuild']['number'] == this_build_number:
                result = jenkins_server.get_build_console_output(project, this_build_number)
                break
            else:
                continue

    else:
        result =  "The latest job is still building."
    return result
