#!/bin/sh
v4l2-ctl --set-fmt-video=width=1920,height=1080,pixelformat=4
v4l2-ctl --set-parm=30
v4l2-ctl --set-ctrl video_bitrate=1000000
gst-launch-1.0 -e v4l2src device=/dev/video0 ! video/x-h264,width=1920,height=1080,framerate=30/1 ! h264parse ! queue ! mp4mux ! filesink location=v.mp4
