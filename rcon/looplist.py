import time
import os
import sys

i=0
while True:
  print i
  i+=1

  print "view list"
  execfile("list.py")
  print "sleep 30 sec"
  time.sleep(30)

  os.system('iwlist wlan0 scan | grep wonderboy-hero4')
