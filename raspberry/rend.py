#create JSON-RPC client
import jsonrpc

server = jsonrpc.ServerProxy(
		jsonrpc.JsonRpc20(),
		jsonrpc.TransportTcpIp(addr=("127.0.0.1", 7000)) )

#call a remote-procedure (with positional parameters)
print server.ip()
print "recording end"
print server.recend()
