#!/bin/sh
echo "process count:"$(ps -eal | grep gst-launch-1.0 | wc -l)
