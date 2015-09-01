#create a JSON-RPC server
import sys
sys.path.append('../rpc')

import jsonrpc
import subprocess

children={}

server = jsonrpc.Server(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=("127.0.0.1",7000),
                logfunc=jsonrpc.log_file("log")) )

#define procedures
def echo(s):
	return s

def add(ip,port):
	rasp  = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=(ip,port)) )

	children[ip]=rasp;
	print "add ip:",ip,",port:",port

def child():
	return children.keys() 

def setup():
	print "setup..."
	i=1
	for k,v in children.items():
		print i,"-echo testing system of ip:",k
		try:
			rep=children[k].echo("hello")
			if rep=="hello":
				print " >ip:",k,"echo ok"
			else:
				print " >ip:",k,"echo failed"
		except Exception,err:
			print " >exception:",err
			print "setup failed"
			return
		i+=1

	print "setup ok"

#register procedures so they can be called via RPC
server.register_function(echo)
server.register_function(add)
server.register_function(child)
server.register_function(setup)

#start server
server.serve()
