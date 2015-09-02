#create JSON-RPC client
import sys
sys.path.append('../rpc')

import jsonrpc
import time

server = jsonrpc.ServerProxy(
                jsonrpc.JsonRpc20(),
                jsonrpc.TransportTcpIp(addr=("192.168.219.254", 7000)) )

#call a remote-procedure (with positional parameters)
server.rstop()
