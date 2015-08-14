import urllib2

try:
  reponse = urllib2.urlopen("http://10.5.5.9:8080/gp/gpControl/command/shutter?p=1",timeout=10)
  message = reponse.read()
  #print message 

  if message=="{}\n":
    print 'ok'
  else:
    print 'error'
except urllib2.URLError as e:
  print "UrlError"
  print type(e)
except socket.timeout as e:
  print "Error, timeout 10sec"
  print type(e)

