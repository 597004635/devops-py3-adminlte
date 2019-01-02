from django.db import models

class GameServer(models.Model):
    channel        = models.CharField('渠道',max_length=20, db_index=True, null=True)
    gameid          = models.IntegerField('游戏id',db_index=True, null=True)
    hostname        = models.CharField('主机名',max_length=50, null=True)
    servername      = models.CharField('游戏区服名',max_length=50, db_index=True, null=True)
    inner_ip        = models.CharField('内网IP',max_length=32, null=True)
    # out_ip          = models.CharField('公网IP',max_length=32, db_index=True,null=True)
    db_ip           = models.CharField('DBIP',max_length=32, null=True)
    status_choices  = ((0,'已关闭'),(1,'运行中'))
    status          = models.SmallIntegerField(choices=status_choices,default=0)
    def __str__(self):
        return "{} {} {}".format(self.servername, self.inner_ip, self.get_status_display())
    class Meta:
        db_table = "games_server"
