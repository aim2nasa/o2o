#!/bin/sh
gst-launch-1.0 -e v4l2src device=/dev/video0 ! video/x-h264,width=1920,height=1080,framerate=30/1 ! h264parse ! queue ! mp4mux ! filesink location=${PWD%/*}/output/v.mp4
