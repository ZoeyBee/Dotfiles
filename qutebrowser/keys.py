def keys(c, config):
    c.bindings.key_mappings = {'<Ctrl-[>': '<Escape>', '<Ctrl-6>': '<Ctrl-^>',
                               '<Ctrl-M>': '<Return>', '<Shift-Return>': '<Return>',
                               '<Enter>': '<Return>', '<Shift-Enter>': '<Return>',
                               '<Ctrl-Enter>': '<Ctrl-Return>'}
    c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}',
                           'y': 'https://youtube.com/results?search_query={}',
                           # 'y': 'https://invidious.exonip.de/search?q={}',
                           'r': 'https://reddit.com/r/{}',
                           'w': 'https://en.wikipedia.org/w/index.php?search={}',
                           'rp': 'https://redditp.com/r/{}',
                           'rt': 'https://www.rottentomatoes.com/search/?search={}',
                           'ra': 'https://proxyrarbg.org/torrents.php?search={}&category%5B%5D=14&category%5B%5D=48&category%5B%5D=17&category%5B%5D=44&category%5B%5D=45&category%5B%5D=47&category%5B%5D=50&category%5B%5D=51&category%5B%5D=52&category%5B%5D=42&category%5B%5D=46&category%5B%5D=18&category%5B%5D=41&category%5B%5D=49&category%5B%5D=23&category%5B%5D=25&category%5B%5D=27&category%5B%5D=28&category%5B%5D=40&category%5B%5D=32&category%5B%5D=33',
                           '13': 'https://1337x.to/search/{}/1/',
                           'sound': 'https://soundcloud.com/search?q={}',
                           'i': 'http://www.imdb.com/find?ref_=nv_sr_fn&q=+{}&s=all',
                           'a': 'https://wiki.archlinux.org/index.php?search={}',
                           'am': 'https://www.amazon.co.uk/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords={}',
                           'e': 'https://www.ebay.com/sch/i.html?_from=R40&_nkw={}&_sacat=0',
                           'pj': 'https://www.prisjakt.no/raw.php?query={}',
                           'pt': 'https://peer.tube/search?search={}',
                           'g': 'https://github.com/search?utf8=%E2%9C%93&q={}&type=',
                           'l': 'http://gen.lib.rus.ec/search.php?req={}&open=0&res=25&view=simple&phrase=1&column=title',
                           'p': 'https://www.protondb.com/search?q={}',
                           'z': 'https://www.zalando.no/dame/?q={}',
                           'm': 'https://www.med24.no/soek?query={}',
                           'b': 'https://www.blush.no/search?q={}',
                           'vcv': 'https://vcvrack.com/plugins#{}',
                           's': 'https://sortere.no/privat/sok/{}',
                           'd': 'https://www.digikey.no/products/en?keywords={}'
    }

    def randomize_user_agent(c):
        return c.format('spawn --userscript randomize_user_agent.py -c')
    def navbind(bind, link):
        config.bind('d' + bind,         randomize_user_agent('{} \'open ' + link + '\''))
        config.bind('d' + bind.upper(), randomize_user_agent('{} \'open -t ' + link + '\''))

    config.unbind('J',  mode='normal')
    config.unbind('K',  mode='normal')
    config.unbind('H',  mode='normal')
    config.unbind('L',  mode='normal')
    config.unbind('d',  mode='normal')
    # config.unbind('th', mode='normal')
    # config.unbind('tl', mode='normal')
    config.unbind('?',  mode='normal')
    config.unbind(';t', mode='normal')
    config.unbind(';t', mode='normal')

    config.bind('I', 'config-source')
    config.bind('x', 'tab-close')
    config.bind('J', 'tab-prev')
    config.bind('K', 'tab-next')
    config.bind('h', 'back')
    config.bind('l', 'forward')
    config.bind('H', 'back -t')
    config.bind('L', 'forward -t')
    config.bind('?', 'open -t qute://help/img/cheatsheet-big.png')

    config.bind('<Ctrl-J>', 'scroll-page 0 0.5')
    config.bind('<Ctrl-K>', 'scroll-page 0 -0.5')

    navbind('y', 'https://youtube.com')
    # navbind('y', 'https://invidious.exonip.de/feed/popular/feed/subscriptions')
    navbind('p', 'https://peer.tube')
    navbind('a', 'https://archlinux.org')
    navbind('e', 'https://ebay.com')
    navbind('r', 'https://reddit.com')
    navbind('m', 'https://protonmail.com/login')
    navbind('g', 'https://gmail.com')
    navbind('f', 'https://facebook.com')
    navbind('s', 'https://soundcloud.com/stream')
    navbind('i', 'https://discordapp.com/channels/@me')
    navbind('b', 'https://bitbucket.org')
    navbind('k', 'https://www.khanacademy.org/')
    navbind('t', 'https://www.twitter.com/')

    config.bind('dnm', 'open -t https://moss-avis.no')
    config.bind('dnn', 'open -t https://www.nrk.no/')
    config.bind('dnb', 'open -t https://www.blikk.no/')
    config.bind('dnv', 'open -t https://www.vg.no/')
    config.bind('dns', 'open -t https://toot.site/home')
    config.bind('dnk', 'open -t https://klassekampen.no/')
    config.bind('dna', 'open -t https://brakmakern.com/')
    config.bind('dny', 'open -t https://www.yr.no/en/forecast/daily-table/1-46556/Norway/Viken/Moss/Moss')

    config.bind(',s',  'open -t qute://settings')
    config.bind(',B',  'bookmark-list -t')
    config.bind(',ba', 'bookmark-add')
    config.bind(',bd', 'bookmark-del')
    config.bind(',S',  'spawn --userscript add_js_entry.py')
    config.bind(',dt', 'hint links spawn transmission-remote -a {hint-url}')
    config.bind(',dd', 'hint links spawn yt-dlp -r 800k -o "~/Downloads/%(title)s.%(ext)s" {hint-url}')
    config.bind(',dD', 'spawn youtube-dl -r 800k -o "~/Downloads/%(title)s.%(ext)s" {url}')
    config.bind(',da', 'hint links spawn yt-dlp -r 800k -f bestaudio -o "~/Downloads/%(title)s.%(ext)s" -x --audio-format opus --audio-quality 0 {hint-url}')
    config.bind(',dA', 'spawn yt-dlp -r 800k -f bestaudio -o "~/Downloads/%(title)s.%(ext)s" -x --audio-format opus --audio-quality 0 {url}')
    config.bind(',m',  'hint links spawn mpv {hint-url}')
    config.bind(',M',  'spawn mpv {url}')
    config.bind(',D',  'download')
    config.bind(',e',  'spawn --userscript emacspaste')
    config.bind(',p',  'tab-pin')
    config.bind(',f',  'spawn --userscript qute-pass --password-only')
    config.bind(',ts', 'set content.javascript.enabled true {url}')
