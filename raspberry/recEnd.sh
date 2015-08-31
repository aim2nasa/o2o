#!/bin/sh

nohup ./eos.sh > eosLog 2>&1 </dev/null&

count=$(ps -eal|grep gst-launch-1.0|wc -l)
while [ "$count" -ne 0 ];do
	sleep 1
	count=$(ps -eal|grep gst-launch-1.0|wc -l)
done

echo 0
