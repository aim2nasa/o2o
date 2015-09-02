#create JSON-RPC client
import sys
sys.path.append('../rpc')

import jsonrpc
import time

server = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=("192.168.219.254", 7000)) )

#call a remote-procedure (with positional parameters)
print server.echo("hello")

server.add("192.168.219.124",7001)
server.add("192.168.219.35",7001)
server.setup()
print server.child()
print server.port()
