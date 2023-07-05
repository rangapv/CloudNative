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
chknsflg=(apiVersion kind name)
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

rnsgen() {
nsfile="nsr.yaml"
#nsfile1=`> "$nsfile"`
int1=0
ind="$1"
argr1="$2"
num1=$(echo "$ind" |sed  's/[^0-9]//g')
num2=${#num1}
num3=$((num2-=1))

      if [[ (($num3 -eq 0)) ]]
      then
               echo "$argr1"  >>"$nsfile"
       elif [[ (($num3 -eq 1)) ]]
       then
               echo "  $argr1" >>"$nsfile"
       elif [[ (($num3 -gt 1 )) ]]
       then
	for ((i=1; i <= $num3; i++));
        do 
	 echo -n "  " >>"$nsfile"
        done
        echo "$argr1" >>"$nsfile"
       else
	       echo "  "
       fi
}


nchkspec() {
nmaskflag=0
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

nchkspec "${spec[$a]:0:-1}"

    if [[ (( "$pcount" < "$nslen" )) ]]
    then
        ((pcount+=1))
	if [[ (( "$nmaskflag" -eq "1" )) ]]
	then
        echo "${value[$a]}:" >>"$nsvfile"
	fi
    fi
done
}

chksub() {
sub1="$1"
chksubflg=0
for t in "${chknsflg[@]}"
do
	if [[ "$t" == "$sub1" ]]
	then
		chksubflg=1
	fi
done
}

nfill () {

ffln="nsv.yaml"
fln="nsr.yaml"
gfln=`> "$fln"`
pcount=0
nlen="${#chkns[@]}"
#echo "nlen is $nlen"
for f in "${sorted[@]}"
do
rflag=0
if [[  (( "$pcount" < "4" )) ]]
then
for f1 in "${chkns[@]}"
do
   if [[ "${spec[$f]}" == "${f1}:" ]]
   then
   
   chksub "$f1"
   if [[ (( "$chksubflg" -eq "1" )) ]]
   then
	   #echo "inside equal ${spec[$f]} anf f1 is $f1 and f is $f"
   while read -r line; do
   donef=0
   line1=$(echo "$line" | awk '{split($0,f1,":"); print f1[1]}')
   line10=$(echo "$line1" | awk '{$1=$1;print}') 
     if [[ ("${value[$f]}" == "$line10") && ("${spec[$f]}" != "args:") ]]
     then
	     v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
	     v11=$(echo $v1 | awk '{$1=$1;print}') 
	     v2="${spec[$f]}"
	     v3="${v2} ${v11}"
		     rnsgen "$f" "$v3"
		     ((pcount+=1))
                     ((nlen-=1))
                     break
      fi
     done <$ffln
    fi
   if [[ (("$chksubflg" -eq "0" )) ]] 
   then
	   v2="${spec[$f]}"
           v3="${v2}"
#           echo "pcount is $pcount"
#           echo "else spec is ${spec[$f]} and f is $f and 2 is $v3"
	   rnsgen "$f" "$v3"
	   ((pcount+=1))
           ((nlen-=1))
  	   break
   fi
   fi
done
#echo "nlen1 is $nlen"
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
nsgen
if [[ ! -z "$nsfile" ]]
then
 #    echo "todo"
      nsfilyl
fi
else
        if [[ "$1" == "fill" ]]
        then
                nfill
        fi
fi

