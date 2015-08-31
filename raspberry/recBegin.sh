#!/bin/sh

count=$(ps -eal | grep gst-launch-1.0 | wc -l)
if [ "$count" -gt 0 ];then
	echo 1
	exit
fi

./av.sh

loop='1 2 3 4 5 6 7 8 9 10'
for i in $loop;do
	count=$(ps -eal | grep gst-launch-1.0 | wc -l)
	if [ "$count" -eq 2 ];then
		#echo "loop="$i "eq 2"
		echo 0
		exit
	fi
	#echo "loop="$i
	sleep 1
done

echo 2 #error
