import pyautogui as pag
import sys
if sys.argv[1] == 'enter': pag.press('enter')
elif sys.argv[2] != '-1':  pag.typewrite(sys.argv[1], int(sys.argv[2]))
else:                      pag.typewrite(sys.argv[1])
