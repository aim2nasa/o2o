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
	echo "Token:" $Token 	#av/1_192.168.219.35:TOK:1 av/1_192.168.219.39:TOK:1
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
	echo "Token:" $Token	#av/1_192.168.219.35 

	Token=`echo $Token | cut -d'/' -f2`
	echo "Token:" $Token	#1_192.168.219.35

	Token=`echo $Token | cut -d'_' -f1`
	echo "Final Token:" $Token	#1

	audios=$(ls ${source} | grep mp3 | grep ${Token}_a_ | wc -l)
	echo "mp3 files:" $audios 
	for files in `ls ${source} | grep mp3 | grep ${Token}_a_`; do
		echo "mp3: " $files
	done

	if [ $audios != $nrpi ]; then
		echo "mp3 files not match:" $audios ",expected:" $nrpi
		sleep 1
		continue
	fi

	videos=$(ls ${source} | grep mp4 | grep ${Token}_v_ | wc -l)
	echo "mp4 files:" $videos
	for files in `ls ${source} | grep mp4 | grep ${Token}_v_`; do
		echo "mp4: " $files
	done

	if [ $videos != $nrpi ]; then
		echo "mp4 files not match:" $videos ",expected:" $nrpi
		sleep 1
		continue
	fi

	for files in `ls ${source} | grep mp3 | grep ${Token}`; do
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
		rm ${source}/${Token}_${IP}
	done
	sleep 1
done
