#create a JSON-RPC server
import sys
sys.path.append('../rpc')

import jsonrpc
import subprocess
import datetime
import subprocess

children={}
ports={}
tok=0

ip=subprocess.check_output('../raspberry/ip.sh',shell=True)
print "local ip:",ip

server = jsonrpc.Server(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=(ip,7000),
                logfunc=jsonrpc.log_file("log")) )

#define procedures
def echo(s):
	return s

def log(str):
        print datetime.datetime.now(),str

def add(ip,port):
	rasp  = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=(ip,port)) )

	children[ip]=rasp;
	ports[ip]=port
	str="add ip:",ip,",port:",port
	log(str)

def child():
	return children.keys() 

def port():
	return ports 

def setup():
	log("setup...")
	i=1
	for k,v in children.items():
		str=i,"-echo testing system of ip:",k,",port:",ports[k]
		log(str)
		try:
			rep=children[k].echo("hello")
			if rep=="hello":
				str=" >ip:",k,",port:",ports[k],",echo ok"
				log(str)
			else:
				str=" >ip:",k,",port:",ports[k],",echo unexpected message"
				log(str)
		except Exception,err:
			str=" >exception:",err
			log(str)
			log("setup failed")
			return
		i+=1

	log("setup ok")

def rstart(path):
	global tok
	log("record...")
	i=1
	for k,v in children.items():
		str= i,"-activate recording(ip:",k,",port:",ports[k],")"
		log(str)
		try:
			rep=children[k].recbegin()
			str="resonse(from ip:",k,",port:",ports[k],"):",rep[0]
			log(str)
			if rep[0]=='0':
				log(" >recording started")
			else:
				str=" >failed to start recording(",rep[0],")"
				log(str)
				return "ERROR:"+rep[0]
		except Exception,err:
			str=" >failed to start recording,exception:",err
			log(str)
			return "EXCEPT:"+err
		i+=1

	log("record ok")
	tok+=1
	resTok = "TOK:{0}".format(tok) 
	f=open("../raspberry/output/TOK{0}".format(tok),'w')
	f.write(resTok)
	f.close()
	return resTok

def rstop():
	log("stop...")
	i=1
	for k,v in children.items():
		str=i,"-stopping(ip:",k,",port:",ports[k],")"
		log(str)
		try:
			rep=children[k].recend()
			str="resonse(from ip:",k,",port:",ports[k],"):",rep[0]
			log(str)
			if rep[0]=='0':
				log(" >recording stopped")
			else:
				str=" >failed to stop recording(",rep[0],")"
				log(str)
				return
		except Exception,err:
			str=" >failed to stopt recording,exception:",err
			log(str)
			return
		i+=1
	log("stop ok")

#register procedures so they can be called via RPC
server.register_function(echo)
server.register_function(add)
server.register_function(child)
server.register_function(port)
server.register_function(setup)
server.register_function(rstart)
server.register_function(rstop)

#start server
server.serve()
