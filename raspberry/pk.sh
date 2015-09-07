#!/bin/sh

count=$(ps -eal|grep gst-launch-1.0|wc -l)

while [ "$count" -ne 0 ];do
        ps -eal|grep gst-launch-1.0 > plist

        while read F S UID PID ETC
        do
                #echo "${PID}"
                kill -2 ${PID}
        done < plist

	sleep 1
	count=$(ps -eal|grep gst-launch-1.0|wc -l)
done
