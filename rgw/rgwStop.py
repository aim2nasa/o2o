#create JSON-RPC client
import sys
sys.path.append('../rpc')

import jsonrpc
import time

server = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=("127.0.0.1", 7000)) )

#call a remote-procedure (with positional parameters)
server.rstop()
