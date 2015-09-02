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

echo 0
