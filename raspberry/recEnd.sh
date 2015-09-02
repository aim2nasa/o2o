#!/bin/sh
while read pid
do
  #echo $pid
  kill -2 ${pid}
done < audio.pid

while read pid
do
  #echo $pid
  kill -2 ${pid}
done < video.pid

echo 0
