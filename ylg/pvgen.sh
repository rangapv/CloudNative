#!/bin/bash
#author: rangapv@yahoo.com 28-04-23
#USUAGE: ./pvgen.sh gen (will generate the Skeletal YAML pvr.yaml and pvv.yaml a human readable file to fill values)
#USUAGE: ./pvgen.sh (SAME as above ....will generate the Skeletal YAML pvr.yaml and pvvv.yaml a human readable file to fill values)
#USUAGE: ./pvgen.sh fill (The program takes the FILLED pvv.yaml file generated ealier from above step and popluates the Skeletal pvr.yaml with pv values)

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1

skippv1=(metadata labels)
skippv2=(spec capacity accessModes nfs)

sortit() {
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"
done | sort -n)
}

indent() {

ai="$1"
ifile="$2"
#echo "inside indent $ai"
        num1=$(echo "$ai" |sed  's/[^0-9]//g')
        num2=${#num1}
        num3=$((num2-=1))
       if [[ (($num3 -eq 0)) ]]
       then
               echo "${spec[$ai]}"  >>"$ifile"
       elif [[ (($num3 -eq 1)) ]]
       then
               echo "  ${spec[$ai]}" >>"$ifile"
       elif [[ (($num3 -gt 1 )) ]]
       then
        for ((i=1; i <= $num3; i++));
        do
         echo -n "  " >>"$ifile"
        done
        echo "${spec[$ai]}" >>"$ifile"
       else
               echo "  "
       fi

}


pvgen() {
nsfile="$pvfile"
nsfile1=`> "$nsfile"`
chknsln="8"
pcount=0
for a in "${sorted[@]}"
do 
    if [[ (( "$pcount" < "$chknsln" )) ]]
    then
	((pcount+=1))
        indent "$a" "$nsfile"
    fi
done
pvspec "5"
}


pvspec() {
ind1="$@"
pvfile="$pvfile"
ul=`echo "$ind1+1" | bc -l`
for a in "${sorted[@]}"
do
	a11=$(echo "$a" |sed 's/[^0-9]//g')
        a1=${#a11}
	a2=`echo "scale=${a1}; $a" | bc -l`
	#echo "a ia $a2 ind1 is $ind1 ul is $ul"
	if ( (( $(echo "$a2 >= $ind1" | bc -l) )) && (( $(echo "$a2 < $ul" | bc -l) )) )
	then
          indent "$a" "$pvfile"
	fi
done
}


chkspec() {

chspeck="$1"
skip="$2"
for b in "${skip[@]}"
do
 if [[ "$b" == "$chspeck" ]]
 then
       	maskflag=1
 fi
done
}

pvfilyl() {

fln="$pvvfile"
flnc=`> "$fln"`
chknsln="8"
pcount=0

for a in "${sorted[@]}"
do
    if [[ (( "$pcount" < "$chknsln" )) ]]
    then
        ((pcount+=1))
	chkspec "${spec[$a]:0:-1}" "$skippv1"
	if [[ (( $maskflag -eq 0 )) ]]
	then
	echo "${value[$a]}:" >>"$fln"
        fi
	maskflag=0
    fi
done

ind1="5"
pvfile="$fln"
ul=`echo "$ind1+1" | bc -l`
for a in "${sorted[@]}"
do
        a11=$(echo "$a" |sed 's/[^0-9]//g')
        a1=${#a11}
        a2=`echo "scale=${a1}; $a" | bc -l`
        #echo "a ia $a2 ind1 is $ind1 ul is $ul"
        if ( (( $(echo "$a2 >= $ind1" | bc -l) )) && (( $(echo "$a2 < $ul" | bc -l) )) )
        then
        chkspec "${spec[$a]:0:-1}" "$skippv2"
        if [[ (( $maskflag -eq 0 )) ]]
        then
        echo "${value[$a]}:" >>"$fln"
        fi
        maskflag=0
        fi
done

}


pvfill(){
echo "gi"
}

pvfile="pvr.yaml"
pvvfile="pvv.yaml"

sortit

if [[ "$#" -eq 0 ]]
then
        set -- "gen"
fi

if [[ "$1" == "gen" ]]
then
pvgen
if [[ ! -z "$pvvfile" ]]
then
 #    echo "todo"
      pvfilyl
fi
else
        if [[ "$1" == "fill" ]]
        then
                pvfill
        fi
fi
