#!/bin/bash

source=$1
echo "source folder:"$source

if [ ! -d "$source" ]; then
	echo "usage:./merge.sh <source> <target> <num of RPi>"
	echo "source folder does not exist, abort execution"
	exit
fi

target=$2
echo "target folder:"$target

if [ ! -d "$target" ]; then
	mkdir $target
fi

nrpi=$3
echo "number of RPi:" $nrpi

if [ ${#nrpi} -eq 0 ]; then
	echo "usage:./merge.sh <source> <target> <num of RPi>"
	echo "number of rpi(s) must be given, abort execution"
	exit
fi

while :
do
	grep -I TOK ${source}/*
	Token=$(grep -I TOK ${source}/*)
	echo "Token:" $Token 	#av/300:TOK:300
	if [ ${#Token} -eq 0 ]; then
		echo "Token is not found"
		sleep 1 
		continue
	fi

	rpis=$(grep -I TOK ${source}/* | wc -l)
	if [ $rpis != $nrpi ]; then
		echo "Token is insufficient:" $rpis ",expected:" $nrpi
		sleep 1 
		continue
	fi
	echo "Token(s) ready:" $rpis

	Token=`echo $Token | cut -d':' -f1`
	echo "Token:" $Token	#av/300 

	Token=`echo $Token | cut -d'/' -f2`
	echo "Token:" $Token	#300 

	for files in `ls ${source} | grep mp3 | grep $Token`; do
		echo "files=" $files	#300_a_192.168.219.39.mp3
		IP=`echo $files | cut -d'_' -f3`
		echo "IP=" $IP		#192.168.219.39.mp3
		IP=${IP%.*3}
		echo "IP=" $IP		#192.168.219.39

		ffmpeg 	-i ${source}/${Token}_v_${IP}.mp4 \
			-i ${source}/${Token}_a_${IP}.mp3 \
			-y \
			-acodec copy \
			-vcodec copy \
			${source}/${Token}_${IP}.mp4

		mv ${source}/${Token}_${IP}.mp4 ${target}
		rm ${source}/${Token}_v_${IP}.mp4
		rm ${source}/${Token}_a_${IP}.mp3
		rm ${source}/${Token}
	done
	sleep 1
done
