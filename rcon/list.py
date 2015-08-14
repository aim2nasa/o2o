import re
import urllib2
import socket

try:
  response = urllib2.urlopen("http://10.5.5.9:8080/videos/DCIM/100GOPRO",timeout=10)
  #print response.getcode()
  html = response.read()
  #print html

  result = re.findall(r">(\w+[\w\.]*).MP4<",html)
  #print result

  final = list(set(result))
  #print final
  count=len(final) 

  if count==1:
    print 'ok'
    #print final[0]
    print final[0]+'.MP4'
  else:
    print "error, too may files({})".format(count)
except urllib2.URLError as e:
  print "UrlError"
  print type(e)
except socket.timeout as e:
  print "Error, timeout 10sec"
  print type(e)
