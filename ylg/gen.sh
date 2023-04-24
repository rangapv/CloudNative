#!/bin/bash
#author: rangapv@yahoo.com 15-04-23
#USUAGE: ./gen.sh gen (will generate the Skeletal YAML r.yaml and v.yaml a human readable file to fill values)
#USUAGE: ./gen.sh (SAME as above ....will generate the Skeletal YAML r.yaml and v.yaml a human readable file to fill values)
#USUAGE: ./gen.sh fill (The program takes the FILLED v.yaml file generated ealier from above step and popluates the Skeletal r.yaml with values) 

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1
chk=(spec metadata labels template containers ports volumes configMap volumeMounts)
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

rgenylg() {
int1=0
ind="$1"
argr1="$2"
cln="r.yaml"
#clnc=`> "$cln"`
t=" "
if [[ (( "$2" == " " )) ]]
then
	argr1=" "
fi
num1=$(echo "$ind" |sed  's/[^0-9]//g')
num2=${#num1}
num3=$((num2-=1))
       if [[ (($num3 -eq 0)) ]]
       then
               echo "$argr1"  >>"$cln"
       elif [[ (($num3 -eq 1)) ]]
       then

               echo "  $argr1" >>"$cln"
       elif [[ (($num3 -gt 1 )) ]]
       then
	for ((i=1; i <= $num3; i++));
        do 
	 echo -n "  " >>"$cln"
        done
        echo "$argr1" >>"$cln"
       else
	       echo "  "
       fi
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
fln="r.yaml"
gfln=`> "$fln"`
#genylg

if [[ (-z $ffln) ]]
then
    echo "File $ffln not there or EMPTY"
    exit
fi

for f in "${sorted[@]}"
do
rflag=0
while read -r line; do

   donef=0
   line1=$(echo "$line" | awk '{split($0,f1,":"); print f1[1]}')
   line10=$(echo "$line1" | awk '{$1=$1;print}') 
   if [[ ("${value[$f]}" == "$line10") && ("${spec[$f]}" == "args:") ]]
   then
	    #echo "line is $line and f is $f and spec is ${spec[$f]}"
	     rgenylg "$f" "${spec[$f]}" 
	     lined=$(echo "$line" | awk '{split($0,f1,":"); print f1[2]}')
	     lined1=($(echo "$lined" | awk '{ld=split($0,fd1,","); for (i=1;i<=ld;i++) {print fd1[i]} }'))
	     count1=0
             for i1 in "${lined1[@]}"
		do
   			#echo "array is $i1"
                        ((count1+=1))
	          
             lined2="- \"$i1\""
	     num11=$(echo "$f" |sed  's/[^0-9]//g')
             num12=${#num11}
             #echo "num12 is $num12"
	     num14="1"
	     for (( b=1; b <= $num12; b++))
	     do
		     num14=$((num14*10))
	     done
	     #echo "num14 is $num14"
	     num141="$num12"
	     #echo "num141 is $num141"
	     num5="$count1"
	     num142=`echo "scale=${num141}; $num5/$num14" | bc -l`
	     #echo "num142 is $num142"
	     num143=`echo "scale=${num141}; $num142+$f" | bc -l`
             # echo "count1 is $count1"
	     #echo "num143 is $num143"
             rgenylg "$num143" "$lined2"
		done
       	    donef=1
	    rflag=1
   fi
     if [[ ("${value[$f]}" == "$line10") && ("${spec[$f]}" != "args:") ]]
     then
	     v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
	     v11=$(echo $v1 | awk '{$1=$1;print}') 
	     v2="${spec[$f]}"
	     v3="${v2} ${v11}"
#	     sudo sed -i "s/${v2}/${v2} ${v11}/" $line
             rgenylg "$f" "$v3"
             rflag=1
     fi
done <$ffln
if [[ (( $rflag -eq 0 )) ]]
then
     rgenylg "$f" "${spec[$f]}" 
fi
done
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
