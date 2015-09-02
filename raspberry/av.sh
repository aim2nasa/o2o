#!/bin/sh

count=$(ls | grep queue | wc -l) 
if [ "$count" -eq 0 ];then
	mkdir queue 
fi

count=$(ls | grep output | wc -l) 
if [ "$count" -eq 0 ];then
	mkdir output
fi

count=$(ls output | wc -l) 
if [ "$count" -gt 0 ];then
	rm output/*
fi

rm *.pid
rm audio.log
rm video.log

cd util
nohup gst-launch-1.0 -v alsasrc ! audioconvert ! queue ! audio/x-raw,rate=44100,channels=2 ! lamemp3enc target=bitrate bitrate=128 ! queue ! filesink location=${PWD%/*}/output/a.mp3 > ../a.log 2>&1&
echo $! > ../audio.pid

nohup gst-launch-1.0 -e v4l2src device=/dev/video0 ! video/x-h264,width=1920,height=1080,framerate=30/1 ! h264parse ! queue ! mp4mux ! filesink location=${PWD%/*}/output/v.mp4 > ../v.log 2>&1&
echo $! > ../video.pid
cd ..
