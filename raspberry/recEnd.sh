#!/bin/bash

function kproc(){
  #echo "argv: $1 $2"
  while read pid
  do
    #echo $pid
    kill -2 ${pid}
  done < $1
  return
}

kproc audio.pid
kproc video.pid

mv output/a.mp3 queue
mv output/v.mp4 queue

echo 0
