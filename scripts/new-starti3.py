import i3
import os
import subprocess
from time import sleep

workspace = {1:  "", 2:  "", 3:  "", 4:  "", 5:  "",
             6:  "", 7:  "", 8:  "", 9:  "", 10: ""}
programs = []

def start_program(command, workspace, extra_commands=[]):
    if isinstance(command, str): command = [command]
    programs.append({'process':        subprocess.Popen(command),
                     'workspace':      workspace,
                     'extra_commands': extra_commands})
def pag(text, delay='-1'):
    subprocess.call(['python', 'Dotfiles/scripts/pagwrite.py', text, delay])

subprocess.call(['setxkbmap', '-option', 'caps:escape'])
subprocess.call(['setxkbmap', '-layout', 'us'])
# subprocess.call(['feh', '--bg-scale', '~/bg/bg.png'])

for i in range(4): start_program('alacritty', workspace[1])
start_program('alacritty', workspace[4], ['clear && cowsay -f tux -p "Dont be a dick." | lolcat'])
start_program('alacritty', workspace[4])
start_program('qutebrowser', workspace[2])
start_program('alacritty', workspace[3], ['emacs -nw'])
start_program('alacritty', workspace[5], ['r'])

if os.path.isfile('local_commands_before_startup.py'): subprocess.call(['python3', 'local_commands_before_startup.py'])

for program in programs:
    moved = False
    wids = []
    index = 0
    # print("moving " + str(program['process'].pid))
    while not moved:
        try:
            wids = subprocess.check_output(['xdotool', 'search', '--pid', str(program['process'].pid)]).decode('utf-8').split('\n')[:-1]
            index += 1
            if index == len(wids): index = 0
            try: subprocess.check_output(['i3-msg', f'[id={wids[index]}] move container to workspace {program["workspace"]}'])
            except: sleep(1)
            else: moved = True
        except: sleep(1)
    for command in program['extra_commands']:
        i3.workspace(str(program['workspace']))
        pag(command, '0')
        sleep(1)
        pag('enter')
        sleep(1)

i3.workspace(workspace[1])
i3.command('move down')
i3.command('focus up')
i3.command('move right')
i3.command('move right')
# subprocess.call(['i3-msg', 'move down'])
# subprocess.call(['i3-msg', 'focus up'])
# subprocess.call(['i3-msg', 'move right'])
# subprocess.call(['i3-msg', 'move right'])
i3.command('focus left')
i3.command('move up')
i3.command('move up')
i3.command('resize grow height 20px or 20ppt')

# pag.typewrite('archey3'); pag.press('enter')

# subprocess.call(['i3-msg', 'focus left'])
# subprocess.call(['i3-msg', 'move up'])
# subprocess.call(['i3-msg', 'move up'])
# subprocess.call(['i3-msg', 'resize grow height 20px or 20ppt'])

pag('glances --disable-plugin diskio'); pag('enter')

i3.workspace(workspace[4])
i3.command('resize shrink width 30px or 30ppt')
# subprocess.call(['i3-msg', 'resize shrink width 30px or 30ppt'])
i3.workspace(workspace[2])

if os.path.isfile('local_commands_after_startup.py'): subprocess.call(['python3', 'local_commands_after_startup.py'])

sleep(10)
programs.append(['discord'], 8)

for program in programs: program['process'].wait()
