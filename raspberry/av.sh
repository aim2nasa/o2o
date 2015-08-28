#!/bin/sh

count=$(ls | grep output | wc -l) 
if [ "$count" -eq 0 ];then
	mkdir output
fi

count=$(ls output | wc -l) 
if [ "$count" -gt 0 ];then
	rm output/*
fi

cd util
nohup ./a.sh > ${PWD%/*}/output/audioLog 2>${PWD%/*}/output/atmp& </dev/null &
nohup ./v.sh > ${PWD%/*}/output/videoLog 2>${PWD%/*}/output/vtmp& </dev/null &
cd ..
