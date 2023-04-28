#!/bin/bash
#author: rangapv@yahoo.com 28-04-23
#USUAGE: ./pvgen.sh gen (will generate the Skeletal YAML pvr.yaml and pvv.yaml a human readable file to fill values)
#USUAGE: ./pvgen.sh (SAME as above ....will generate the Skeletal YAML pvr.yaml and pvvv.yaml a human readable file to fill values)
#USUAGE: ./pvgen.sh fill (The program takes the FILLED v.yaml file generated ealier from above step and popluates the Skeletal pvr.yaml with pv values)

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1

sortit() {
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"
done | sort -n)
}


pvgen() {
nsfile="pvr.yaml"
nsfile1=`> "$nsfile"`
chknsln="7"
pcount=0
for a in "${sorted[@]}"
do 
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
done

}



pvfilyl() {
echo "gi"
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
