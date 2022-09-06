from subprocess import call
from time import sleep

worker = input('Worker name: ')

while True:
    call(['ethminer', '-P', f'stratum1+tcp://0x8AF5dDC83bc5a7D68Ed7c48647EF8b28E8bC190E.{worker}@eu1.ethermine.org:4444', '-U', '-R'])
    sleep(30)
