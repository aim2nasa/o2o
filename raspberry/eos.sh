#!/bin/sh

count=$(ps -eal|grep gst-launch-1.0|wc -l)
echo "start,process:$count"

if [ "$count" -gt 0 ];then
	ps -eal|grep gst-launch-1.0 > plist

	while read F S UID PID ETC
	do
		echo "${PID}"
		kill -2 ${PID}
	done < plist
fi

while [ "$count" -ne 0 ];do
	sleep 1
	count=$(ps -eal|grep gst-launch-1.0|wc -l)
	echo "inspecting...,process:$count"
done

count=$(ps -eal|grep gst-launch-1.0|wc -l)
echo "end,process:$count"

rm av.mp4 
ffmpeg -i v.mp4 -i a.mp3 -acodec copy -vcodec copy av.mp4
