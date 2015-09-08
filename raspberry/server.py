#create a JSON-RPC server
import sys
sys.path.append('../rpc')

import jsonrpc
import subprocess

ip=subprocess.check_output('../raspberry/ip.sh',shell=True)
print "local ip:",ip

server = jsonrpc.Server(
		jsonrpc.JsonRpc20(),
		jsonrpc.TransportTcpIp(addr=(ip,7001),
		logfunc=jsonrpc.log_file("log")) )

#define procedures
def echo(s):
    subprocess.call('mkdir output',shell=True)
    return s

def ip():
	return subprocess.check_output('./ip.sh',shell=True)	

def recbegin():
	return subprocess.check_output('./recBegin.sh',shell=True)	

def recend():
	return subprocess.check_output('./recEnd.sh',shell=True)	

def token(tok):
	resTok = "TOK:{0}".format(tok)
        f=open("output/TOK{0}".format(tok),'w')
        f.write(resTok)
        f.close()
	print resTok

#register procedures so they can be called via RPC
server.register_function(echo)
server.register_function(ip)
server.register_function(recbegin)
server.register_function(recend)
server.register_function(token)

#start server
server.serve()
