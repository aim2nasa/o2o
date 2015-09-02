#create JSON-RPC client
import sys
sys.path.append('../rpc')

import jsonrpc

server = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=("192.168.219.254", 7000)) )

#call a remote-procedure (with positional parameters)
server.rstart("/home/pi/hon/rgw")
print "record start"
