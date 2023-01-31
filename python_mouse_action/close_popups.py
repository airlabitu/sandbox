# dependencies: install pyautogui "pip install pyautogui"
#
# To setup auto run on system boot:
# 	Open autostart: sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
# 	Add the following line: @/usr/bin/python /home/pi/close_popups.py


import pyautogui, time

#pyautogui.displayMousePosition() # comment in to print mouse position on screen

time.sleep(20)
pyautogui.click(920, 140)
pyautogui.click(0, 1920)
