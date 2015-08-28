#!/bin/sh
echo ${PWD%/*} 
gst-launch-1.0 -v alsasrc ! audioconvert ! queue ! audio/x-raw,rate=44100,channels=2 ! lamemp3enc target=bitrate bitrate=128 ! queue ! filesink location=${PWD%/*}/output/a.mp3
