#!/usr/bin/env python
# coding=utf-8

import sys
sys.path.append('Dotfiles/qutebrowser')
from user_agents import user_agents, http_accepts
import random
from qutescript import userscript
from qutescript.cli import parser



parser.add_argument('-c',
                    action='store',
                    help='Command to execute.',
                    default='')

@userscript
def randomize_user_agent(request):
    args = parser.parse_args()
    request.send_command(f'set content.headers.user_agent \'{user_agents[random.randint(0, len(user_agents)-1)]}\'')
    request.send_command('set content.headers.custom "{\\"accept\\": \\"' +
                         http_accepts[random.randint(0, len(http_accepts)-1)] + '\\"}"')
    if args.c: request.send_command(args.c)

if __name__ == '__main__':
    randomize_user_agent()
