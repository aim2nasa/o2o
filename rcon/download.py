import re
import urllib2
import socket

try:
  base = "http://10.5.5.9:8080/videos/DCIM/100GOPRO"
  response = urllib2.urlopen(base,timeout=10)
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

    file = final[0]+'.MP4'
    print file

    u = urllib2.urlopen(base+'/'+file)
    localFile = open(file,'w')
    localFile.write(u.read())
    localFile.close()
  else:
    print "error, too may files({})".format(count)
except urllib2.URLError as e:
  print "UrlError"
  print type(e)
except socket.timeout as e:
  print "Error, timeout 10sec"
  print type(e)
