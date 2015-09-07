#!/bin/bash

./pk.sh

rm plist

FTOKEN=$(find output -name TOK*)
#echo $FTOKEN
TOK=${FTOKEN:10}
#echo "Token:"$TOK

mv output/a.mp3 queue/${TOK}_a.mp3
mv output/v.mp4 queue/${TOK}_v.mp4
rm output/TOK*

nohup ./ms.sh > ms.tmp 2>ms.log& </dev/null &
rm ms.tmp

echo 0
