#!/bin/bash
#author: rangapv@yahoo.com 24-04-23
#USUAGE: ./nsgen.sh gen (will generate the Skeletal YAML r.yaml and v.yaml a human readable file to fill values)
#USUAGE: ./nsgen.sh (SAME as above ....will generate the Skeletal YAML r.yaml and v.yaml a human readable file to fill values)
#USUAGE: ./nsgen.sh fill (The program takes the FILLED v.yaml file generated ealier from above step and popluates the Skeletal r.yaml with values)

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1

chkns=(apiVersion kind metadata name)
chknsflg=(apiVersion name)
maskflag=0

sortit() {
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"
done | sort -n)
}


nsgen() {
nsfile="nsr.yaml"
nsfile1=`> "$nsfile"`
chknsln="${#chkns[@]}"
pcount=0
for a in "${sorted[@]}"
do 
#echo "a si $a num3 is $num3" 
t=" "
for c in "${chkns[@]}" 
do
if [[ "${spec[$a]}" == "$c:" ]]
then
    if [[ (( "$pcount" < "$chknsln" )) ]]
    then
	((pcount+=1))
        num1=$(echo "$a" |sed  's/[^0-9]//g')
        num2=${#num1}
        num3=$((num2-=1))
       if [[ (($num3 -eq 0)) ]]
       then
               echo "${spec[$a]}"  >>"$nsfile"
       elif [[ (($num3 -eq 1)) ]]
       then
               echo "  ${spec[$a]}" >>"$nsfile"
       elif [[ (($num3 -gt 1 )) ]]
       then
	for ((i=1; i <= $num3; i++));
        do 
	 echo -n "  " >>"$nsfile"
        done
        echo "${spec[$a]}" >>"$nsfile"
       else
	       echo "  "
       fi
    fi
fi
done
done
}


nchkspec() {

nchspeck=("$@")
for nb in "${chknsflg[@]}"
do
 if [[ "$nb" == "$nchspeck" ]]
 then
       	nmaskflag=1
 fi
done
}



nsfilyl() {

nsvfile="nsv.yaml"
nsvfilec=`> "$nsvfile"`
nslen="${#chkns[@]}"
pcount=0
for a in "${sorted[@]}"
do
#echo "a si $a num3 is $num3"
t=" "

for c in "${chkns[@]}"
do

nchkspec "${spec[$a]:0:-1}"

if [[ "${spec[$a]}" == "$c:" ]]
then
    if [[ (( "$pcount" < "$nslen" )) ]]
    then
        ((pcount+=1))
	if [[ (( $nmaskflag -eq 1 )) ]]
	then
        echo "${value[$a]}:" >>"$nsvfile"
	nmaskflag=0
	fi
    fi
fi
done
done
}

sortit

if [[ "$#" -eq 0 ]]
then
        set -- "gen"
fi

if [[ "$1" == "gen" ]]
then
nsgen
if [[ ! -z "$nsfile" ]]
then
 #    echo "todo"
      nsfilyl
fi
else
        if [[ "$1" == "fill" ]]
        then
                fill
        fi
fi

