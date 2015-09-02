#!/bin/sh
sudo modprobe bcm2835-v4l2 gst_v4l2src_is_broken=1
lsmod

v4l2-ctl --set-fmt-video=width=1920,height=1080,pixelformat=4
v4l2-ctl --set-parm=30
v4l2-ctl --set-ctrl video_bitrate=1000000
