#!/bin/sh
line=$(ifconfig | grep inet | grep Bcast | grep Mask)
#echo $line 		#inet addr:192.168.219.124 Bcast:192.168.219.255 Mask:255.255.255.0

line=${line% B*}
#echo $line		#inet addr:192.168.219.124

line=${line##*:}
echo $line		#192.168.219.124
