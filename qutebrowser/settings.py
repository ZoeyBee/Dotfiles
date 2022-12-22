from javascript_whitelist import javascript_whitelist
from user_agents import user_agents, http_accepts
import random

def settings(c, config):
    # privacy
    c.content.headers.user_agent = user_agents[random.randint(0, len(user_agents)-1)]
    c.content.headers.custom = {"accept": http_accepts[random.randint(0, len(http_accepts)-1)]}
    c.content.headers.accept_language ='en-US,en;q=0.5'
    c.content.canvas_reading = False
    c.content.webgl = False
    c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'
    c.content.proxy = 'system'
    c.content.javascript.enabled = True
    # c.content.javascript.enabled = False
    # for url in javascript_whitelist: config.set('content.javascript.enabled', True, url)
    c.content.headers.do_not_track = True
    c.content.headers.referer = 'same-domain'
    c.qt.chromium.process_model = 'process-per-site-instance'
    c.content.autoplay = True
    c.content.blocking.method = 'adblock'
    c.content.blocking.adblock.lists = [
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badlists.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/thirdparties/easylist-downloads.adblockplus.org/easyprivacy.txt", "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/thirdparties/pgl.yoyo.org/as/serverlist", "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts", "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt", "https://fanboy.co.nz/fanboy-problematic-sites.txt", "https://easylist.to/easylist/easylist.txt", "https://raw.githubusercontent.com/bogachenko/fuckfuckadblock/master/fuckfuckadblock.txt"]

    # behavior
    c.input.insert_mode.auto_load = False
    c.input.insert_mode.auto_leave = False
    c.tabs.background = True
    c.editor.command = ['emacsclient', '-c', '{}']
    c.auto_save.session = True
    c.downloads.location.prompt = False
    c.downloads.location.directory = '~/Downloads/'

    # ui
    c.completion.scrollbar.width = 0
    c.tabs.position = 'top'
    c.tabs.show = 'always'
    c.tabs.favicons.show = 'always'
    c.tabs.indicator.width = 0
    c.tabs.title.format = '{current_title}'
    c.tabs.title.alignment = 'center'
    c.downloads.position = 'bottom'
    c.scrolling.smooth = True
    c.window.transparent = True
    c.completion.height = '20%'
    c.statusbar.show = 'never'
    c.hints.uppercase = True
    c.downloads.remove_finished = 1
    c.content.pdfjs = True
    c.hints.chars = 'asdfjkl'
    c.colors.webpage.preferred_color_scheme = 'dark'
    c.content.default_encoding = 'utf-8'
