from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
# from qutebrowser.api import interceptor

from settings import settings
from colors import colors
from keys import keys

import random

config.load_autoconfig(True)
settings(c, config)
colors(c, config)
keys(c, config)

# def filter_yt(info: interceptor.Request):
#     url = info.request_url
#     if (
#         url.host() == "www.youtube.com"
#         and url.path() == "/get_video_info"
#         and "&adformat=" in url.query()
#      ):
#         info.block()
# interceptor.register(filter_yt)

# toggle = False
# def randomize_user_agent(request: interceptor.Request):
#     import sys
#     sys.path.append('Dotfiles/qutebrowser')
#     from user_agents import user_agents, http_accepts
#     toggle = not toggle
#     if toggle:
#         request.send_command(f'set content.headers.user_agent \'{user_agents[random.randint(0, len(user_agents)-1)]}\'')
#         request.send_command('set content.headers.custom "{\\"accept\\": \\"' + http_accepts[random.randint(0, len(http_accepts)-1)] + '\\"}"')
#         c.content.headers.user_agent = user_agents[random.randint(0, len(user_agents)-1)]
#         c.content.headers.custom = {"accept": http_accepts[random.randint(0, len(http_accepts)-1)]}
# interceptor.register(randomize_user_agent)
