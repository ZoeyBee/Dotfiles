def colors(c, config):
    bg_color = '#272b33'
    # bg_color = '#AA1c2028'
    c.colors.webpage.bg = bg_color
    c.content.user_stylesheets = ['onedark-all-sites.css']

    theme = {'panel': {'height': 28,},
             'fonts': {'main': '12pt Roboto Slab Mono', 'status': '10pt Roboto Slab Mono',
                       'entry': '11pt Roboto Slab Mono', 'tab_bold': True, 'tab_size': 12,},
             'colors': {
                 'bg': {'normal': bg_color, 'active': bg_color, 'inactive': bg_color,},
                 'fg': {'normal': '#f3f4f5', 'active': '#896cad', 'inactive': '#878E7D',
                        # completion and hints
                'match': '#2f343f',
                        },
             }
    }
    colors = theme['colors']
    def setToBG(colortype, target): config.set('colors.' + target, colors['bg'][colortype])
    def setToFG(colortype, target): config.set('colors.' + target, colors['fg'][colortype])
    def colorSync(colortype, setting):
        if setting.endswith('.fg'): setToFG(colortype, setting)
        elif setting.endswith('.bg'): setToBG(colortype, setting)
        elif setting.endswith('.top') or setting.endswith('.bottom'): setToFG(colortype, setting)
        else:
            setToFG(colortype, setting + '.fg')
            setToBG(colortype, setting + '.bg')

    targets = {
        'normal': ['tabs.even', 'tabs.odd', 'hints', 'downloads.bar.bg',],
        'active': [
            'statusbar.normal', 'statusbar.command', 'tabs.selected.even',
            'tabs.selected.odd', 'statusbar.insert', 'downloads.stop',
            'prompts', 'messages.warning', 'messages.error',
            'statusbar.url.success.http.fg', 'statusbar.url.success.https.fg',
            'completion.item.selected', 'completion.category',
        ],
        'inactive': [
            'tabs.even', 'tabs.odd', 'completion.scrollbar', 'downloads.start',
            'messages.info', 'completion.fg', 'completion.odd.bg', 'completion.even.bg',
            'completion.category.border.top', 'completion.category.border.bottom',
            'completion.item.selected.border.top', 'completion.item.selected.border.bottom',
        ],
        'match': ['completion.match.fg', 'hints.match.fg',]
    }
    for colortype in targets:
        for target in targets[colortype]: colorSync(colortype, target)
    setToFG('active', 'statusbar.progress.bg')
    config.set('hints.border', '1px solid ' + colors['fg']['normal'])

    # tabbar
    def makePadding(top, bottom, left, right):
        return {'top': top, 'bottom': bottom, 'left': left, 'right': right}

    surround = round((theme['panel']['height'] - 14) / 2)
    c.tabs.padding = makePadding(surround, surround, 4, 4)
    c.tabs.indicator.padding = makePadding(0, 0, 0, 0)

    # fonts
    c.fonts.default_family = theme['fonts']['main'].split(' ')
    c.fonts.completion.entry = theme['fonts']['status']
    c.fonts.completion.category = theme['fonts']['status']
    c.fonts.debug_console = theme['fonts']['main']
    c.fonts.downloads = theme['fonts']['main']
    c.fonts.hints = theme['fonts']['status']
    c.fonts.keyhint = theme['fonts']['main']
    c.fonts.messages.error = theme['fonts']['main']
    c.fonts.messages.info = theme['fonts']['main']
    c.fonts.messages.warning = theme['fonts']['main']
    c.fonts.prompts = theme['fonts']['main']
    c.fonts.statusbar = theme['fonts']['entry']

    tabFont = str(theme['fonts']['tab_size']) + 'pt ' + theme['fonts']['main']
    if theme['fonts']['tab_bold']:
        tabFont = 'bold ' + tabFont
    c.fonts.tabs.selected = tabFont
    c.fonts.tabs.unselected = tabFont
