#!/bin/bash
#author: rangapv@yahoo.com 14-04-23

yq_inst() {

wyq=`which yq`
wyqs="$?"

if [[ (( $wyqs -eq 0 )) ]]
then
	echo "yq is already installed and the version is $(yq -V)"
	exit
else
	yq1=`wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O ./yq`
        yq1s="$?"
	yq2=`chmod +x ./yq`
        yq2s="$?"
	yq3=`sudo mv ./yq /usr/bin/yq`
        yq3s="$?"
        yqstatus $yq1s $yq2s $yq3s
fi

}

yqstatus () {

stcot=0
arg1=("$@")
arg2="$#"

for i in "${arg1[@]}" 
do
if [[ (( $i -eq 0 )) ]]
then
	((stcot+=1))
fi
done

if [[ (( $stcot -eq $arg2 )) ]]
then
	echo "YQ Install succeeded"
	echo "$(yq -V)"
else
	echo "YQ install failed..retry"
fi

}

yq_inst
