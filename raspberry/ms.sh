#!/bin/bash

ffmpeg -i queue/v.mp4 -i queue/a.mp3 -acodec copy -vcodec copy queue/av.mp4
rm queue/a.mp3
rm queue/v.mp4

sshpass -p789456 scp -o StrictHostKeyChecking=no queue/av.mp4 rossi@192.168.219.254:/home/rossi/hon/rgw/av/av.mp4
rm queue/av.mp4
