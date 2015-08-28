#!/bin/sh

count=$(ps -eal|grep gst-launch-1.0|wc -l)
echo "start,process:$count"

if [ "$count" -gt 0 ];then
	ps -eal|grep gst-launch-1.0 > output/plist

	while read F S UID PID ETC
	do
		echo "${PID}"
		kill -2 ${PID}
	done < output/plist
fi

while [ "$count" -ne 0 ];do
	sleep 1
	count=$(ps -eal|grep gst-launch-1.0|wc -l)
	echo "inspecting...,process:$count"
done

count=$(ps -eal|grep gst-launch-1.0|wc -l)
echo "end,process:$count"

count=$(ls output| grep av.mp4 | wc -l)
if [ "$count" -gt 0 ];then
        rm output/av.mp4
fi

ffmpeg -i output/v.mp4 -i output/a.mp3 -acodec copy -vcodec copy output/av.mp4
