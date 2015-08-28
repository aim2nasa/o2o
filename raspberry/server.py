#create a JSON-RPC server
import jsonrpc
import subprocess

server = jsonrpc.Server(
		jsonrpc.JsonRpc20(),
		jsonrpc.TransportTcpIp(addr=("127.0.0.1",7000),
		logfunc=jsonrpc.log_file("log")) )

#define procedures
def echo(s):
    return 'ans='+s

def ip():
	return subprocess.check_output('./ip.sh',shell=True)	

#register procedures so they can be called via RPC
server.register_function(echo)
server.register_function(ip)

#start server
server.serve()
