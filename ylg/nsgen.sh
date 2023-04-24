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
nsfile1=`> $nsfile`
chknsln="#{chkns[@]}"

for a in "${sorted[@]}"
do 
#echo "a si $a num3 is $num3" 
t=" "
for (( i=1; i<="$chklnsln"; i++))
do
if [[ "$spec[$a]" == "$chkns[$i]:" ]]
then
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
done
done

}




nsfilyl() {

nsvfile="nsv.yaml"
nsvfilec="> $nsvfile"
nslen="${#chknsflg[@]}"

for a in "${sorted[@]}"
do
#echo "a si $a num3 is $num3"
t=" "
for (( i=1; i<="$nslen"; i++))
do
if [[ "$spec[$a]" == "$chknsflg[$i]:" ]]
then
        echo "$value[$a]" >>"$nsvfile"
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
if [[ ! -z "$cln" ]]
then
        nsfilyl
fi
else
        if [[ "$1" == "fill" ]]
        then
                fill
        fi
fi

