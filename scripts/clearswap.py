from subprocess import call
from time import sleep

while True:
    call(['swapoff', '-a'])
    call(['swapon', '-a'])
    sleep(400)
