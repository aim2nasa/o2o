#create JSON-RPC client
import jsonrpc
import time

server = jsonrpc.ServerProxy(
		jsonrpc.JsonRpc20(),
		jsonrpc.TransportTcpIp(addr=("127.0.0.1", 7000)) )

#call a remote-procedure (with positional parameters)
print server.echo("hello world")
print server.ip()

print "recording start"
result = server.recbegin()
print result

time.sleep(10)

print "recording end"
print server.recend()
