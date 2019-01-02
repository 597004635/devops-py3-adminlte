from django.conf.urls import url, include
from games.views import GameServerListView, GameServerDetailView, ModifyGameStatusView

urlpatterns = [
    url('^gameslist/$', GameServerListView.as_view(), name='games_server_list'),
    url('^gamesedit/(?P<pk>[0-9]+)?/$', GameServerDetailView.as_view(), name='games_server_edit'),

    url('^modifystatus/$', ModifyGameStatusView.as_view(), name='game_modify_status'),

]
