#!/usr/bin/env bash
#e-mail:rangapv@yahoo.com 15-08-23
#x.com:@rangapv

check_crd(){

iscrd=`kubectl get crd | grep "gatewayclasses.gateway.networking.k8s.io"`
iscrds="$?"


if [[ ( "$iscrds" != 0 ) ]]
then
	echo "Gateway CRD for ISTIO is not installed instaling now"
        ins_crd 

else
	echo "Gateway CRD is installed..proceeding to other checks"

fi

}

ins_crd() {

crd1=`kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v0.6.2" | kubectl apply -f -; }`

crd1s="$?"

if [[ ( "$crd1s" != 0 ) ]]
then
	echo "Install of CRD Gateway class failed exiting"
	exit
else
	echo "Install of CRD Passed"
fi

}

check_isctl() {

isctl=`which istioctl`
isctls="$?"

if [[ ( -z "$isctl" ) ]]
then

	echo "istioctl binary is not installed ..proceeding to install"
        ins_isctl
else
	echo "istioctl binary is installed and in the path"
        isver=`istioctl version`
	echo "$isver"
fi


}



ins_isctl() {


ctl2=`ls -l | grep -o "istio-.*[0-9.*]$"`
ctl2s="$?"
if [[ ( "$ctl2s" != 0 ) || ( -z "$ctl2" ) ]]
then
	echo "istio not found in the current directory..downloading and later installing"
	ctl1=`curl -L https://istio.io/downloadIstio | sh -`
	ctl1s="$?"
	if  [[ ( "$ctl1s" != 0 ) ]]
	then
		echo "istio binary downlaod error..exiting"
		exit
	fi
fi

ctl2=`ls -l | grep -o "istio-.*[0-9.*]$"`
ctl2s="$?"
ctl3=`export PATH=$PWD/bin:PATH`
ctl31=`echo "export PATH=$PWD/${ctl2}/bin:$PATH" >>~/.profile`
sc1=`source $HOME/.profile`
sc2=`which istioctl`
sc2s="$?"
echo "sc2s is $sc2s and sc2 is $sc2"
check_isctl
ins_istio
}


ins_istio() {


echo "All pre-requisties satisfied ..proceeding with the istio \"minimal\" install since it is the GatewayAPI"
istio1=`istioctl install -y --set profile=minimal`
istio1s="$?"

if [[ ( "$istio1s" != 0 ) ]]
then
	echo "istio minimal install failed"
	exit
else
	echo "istion minimal install succeeded"
	echo "istio SUCCESSFULLY installed"
fi


}


check_crd
check_isctl
