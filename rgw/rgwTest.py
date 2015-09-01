#create JSON-RPC client
import sys
sys.path.append('../rpc')

import jsonrpc
import time

server = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=("127.0.0.1", 7000)) )

#call a remote-procedure (with positional parameters)
print server.echo("hello")

server.add("127.0.0.1",7001)
#server.add("127.0.0.2",7001)
server.setup()
print server.child()
print server.port()

server.rstart("/home/pi/hon/rgw")

time.sleep(10)

server.rstop()