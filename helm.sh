#!/bin/bash
#Author rangapv@yahoo.com 13-04-23
set -E

chk_hlm() {

chktl=`which kubectl`
chktls="$?"

chk8s=`kubectl cluster-info`
chk8ss="$?"

chkhlm=`which helm`
chkhlms="$?"

if [[ (( "$chkhlms" -eq 0 )) ]]
then
	echo "Helm already installed the version is $(helm version)"
	exit
fi


if [[ (( $chktls -ne 0 )) || (( $chk8ss -ne 0 )) ]]
then
     echo "Pre-requiste to Isntall Helm is not satisfied"
     exit
fi

}


hlmstatus () {

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
	echo "Helm Install succeeded"
else
	echo "Helm install failed..retry"
fi

}

inst_helm() {

chk_hlm

hlm1=`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`
hlm1s="$?"
hlm2=`chmod 700 get_helm.sh`
hlm2s="$?"
hlm3=`./get_helm.sh`
hlm3s="$?"

hlmstatus $hlm1s $hlm2s $hlm3s

}

inst_helm
