#!/bin/bash
#author: rangapv@yahoo.com 15-04-23

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1
chk=(spec metadata labels template args containers ports volumes)
maskflag=0

genylg() {
int1=0
#readarray -t MyArray < <(printf '%s\n' "${!spec[@]}" | sort)
for l in "${!spec[@]}"
do
        ((int1+=1))
done
echo "int1 is $int1"
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"	
done | sort -n)

#for a in "${sorted[@]}"; do echo "a is $a" ; done

cln="r.yaml"
clnc=`> "$cln"`
for a in "${sorted[@]}"
do 
#echo "a si $a num3 is $num3" 
t=" "
num1=$(echo "$a" |sed  's/[^0-9]//g')
num2=${#num1}
num3=$((num2-=1))
       if [[ (($num3 -eq 0)) ]]
       then
               echo "${spec[$a]}"  >>"$cln"
       elif [[ (($num3 -eq 1)) ]]
       then

               echo "  ${spec[$a]}" >>"$cln"
       elif [[ (($num3 -gt 1 )) ]]
       then
	for ((i=1; i <= $num3; i++));
        do 
	 echo -n "  " >>"$cln"
        done
        echo "${spec[$a]}" >>"$cln"
       else
	       echo "  "
       fi
done

}

chkspec() {

chspeck=("$@")
for b in "${chk[@]}"
do
 if [[ "$b" == "$chspeck" ]]
 then
       	maskflag=1
 fi
done
}

filyl() {

fln="v.yaml"
flnc=`> "$fln"`

for a in "${sorted[@]}"
do
	chkspec "${spec[$a]:0:-1}"
	if [[ (( $maskflag -eq 0 )) ]]
	then
	echo "${value[$a]}:" >>"$fln"
        fi
	maskflag=0
done
}

genylg
if [[ ! -z "$cln" ]]
then
	filyl
fi
