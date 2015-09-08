#!/bin/bash

source=$1
echo "source folder:"$source

if [ ! -d "$source" ]; then
	echo "source folder does not exist, abort execution"
	exit
fi

target=$2
echo "target folder:"$target

if [ ! -d "$target" ]; then
	mkdir $target
fi

grep -I TOK ${source}/*
Token=$(grep -I TOK ${source}/*)
echo "Token:" $Token 	#av/300:TOK:300

Token=`echo $Token | cut -d':' -f1`
echo "Token:" $Token	#av/300 

Token=`echo $Token | cut -d'/' -f2`
echo "Token:" $Token	#300 

#ls ${source} | grep mp3 | grep $Token	#300_a_192.168.219.39.mp3
#ls ${source} | grep mp4 | grep $Token	#300_v_192.168.219.39.mp3

while :
do
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
