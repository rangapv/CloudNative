#!/bin/bash
#author: rangapv@yahoo.com 15-04-23
#USUAGE: ./gen.sh gen (will generate the Skeletal YAML r.yaml and v.yaml a human readable file to fill values)
#USUAGE: ./gen.sh (SAME as above ....will generate the Skeletal YAML r.yaml and v.yaml a human readable file to fill values)
#USUAGE: ./gen.sh fill (The program takes the FILLED v.yaml file generated ealier from above step and popluates the Skeletal r.yaml with values) 

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
source "./ylgdb.sh"
#source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1
chk=(spec metadata labels template args containers ports volumes)
maskflag=0

sortit() {
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"	
done | sort -n)
}

genylg() {
int1=0
#readarray -t MyArray < <(printf '%s\n' "${!spec[@]}" | sort)
for l in "${!spec[@]}"
do
        ((int1+=1))
done
echo "int1 is $int1"

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


fill() {
ffln="v.yaml"
gln="r.yaml"
genylg
if [[ (-z $ffln) || (-z $gln) ]]
then
    echo "Files $ffln and $gln are not there or EMPTY"
    exit
fi

while read -r line; do
   #v1=(echo "$line" | awk '{split($0,f1,":") print(a[1])}')
   #v2=(echo "$line" | awk '{split($0,f1,":") print(a[2])}')
   #line1="${line:0:-1}"
   line1=$(echo "$line" | awk '{split($0,f1,":"); print f1[1]}')
   for f in "${sorted[@]}"
   do
     if [[ "${value[$f]}" == "$line1" ]]
     then
	     v1=$(echo "$line" | awk '{split($0,f1,":"); print f1[2]}')
	     v11=$(echo $v1 | awk '{$1=$1;print}') 
	     v2="${spec[$f]}"
	     sudo sed -i "s/${v2}/${v2} ${v11}/" $gln
     fi
   done

done <$ffln
}


sortit

if [[ "$#" -eq 0 ]]
then
	set -- "gen"
fi

if [[ "$1" == "gen" ]]
then
genylg
if [[ ! -z "$cln" ]]
then
	filyl
fi
else
	if [[ "$1" == "fill" ]]
	then
		fill
	fi
fi
