#!/bin/bash

ip=$(./ip.sh)
echo "myip" $ip

afile=$(find queue -name *_a.mp3)
echo $afile     #queue/1_a.mp3
afile=${afile:6}
aorg=$afile
echo $afile     #1_a.mp3

afile=`echo $afile | cut -d'.' -f1`
echo $afile

afile=${afile}_${ip}.mp3
echo $afile

token=$afile
token=`echo $token | cut -d'_' -f1`
echo "token:"$token
echo "TOK:"${token}>queue/${token}

vfile=$(find queue -name *_v.mp4)
echo $vfile     #queue/1_v.mp4
vfile=${vfile:6}
vorg=$vfile
echo $vfile     #1_v.mp4

vfile=`echo $vfile | cut -d'.' -f1`
echo $vfile

vfile=${vfile}_${ip}.mp4
echo $vfile

echo "aorg="$aorg
echo "vorg="$vorg

mv queue/${aorg} queue/${afile}
mv queue/${vorg} queue/${vfile}

sshpass -p789456 scp -o StrictHostKeyChecking=no queue/${afile} rossi@192.168.219.254:/home/rossi/hon/rgw/av/${afile}
sshpass -p789456 scp -o StrictHostKeyChecking=no queue/${vfile} rossi@192.168.219.254:/home/rossi/hon/rgw/av/${vfile}
sshpass -p789456 scp -o StrictHostKeyChecking=no queue/${token} rossi@192.168.219.254:/home/rossi/hon/rgw/av/${token}_${ip}

rm queue/${afile}
rm queue/${vfile}
rm queue/${token}
