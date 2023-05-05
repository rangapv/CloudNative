#!/bin/bash
#author: rangapv@yahoo.com 28-04-23
#USUAGE: ./pvgen.sh gen (will generate the Skeletal YAML pvr.yaml and pvv.yaml a human readable file to fill values)
#USUAGE: ./pvgen.sh (SAME as above ....will generate the Skeletal YAML pvr.yaml and pvvv.yaml a human readable file to fill values)
#USUAGE: ./pvgen.sh fill (The program takes the FILLED pvv.yaml file generated ealier from above step and popluates the Skeletal pvr.yaml with pv values)

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present 
skippm=( )
#array values that needs to be skipped fromt eh database in the spec section 
skippv=(resources)
#entries that dont need USer values this is referenced by the values file in the function pvfilyl
skippv1=(metadata labels spec capacity accessModes nfs resources)
#entries that need be present in the YAML but no value needed like kind of heading
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
    #echo "in the indent fun and writing ${spec[$ai]}"
}


funecho() {
input1="$1"
fileo="$2"


echo "${value[$input1]}:" >>"$fileo"
#echo "${value[$a]}:" >>"$fln"

}



pvgen() {
nsfile="$1"
shift
nsfile1=`> "$nsfile"`
chknsln="$1"
shift
fun1="$1"
shift
indx="$1"
shift
pcount=0
skar="$@"
marraylen="${#skippm[@]}"
chknsln=`echo "$chknsln-$marraylen" | bc -l`
#echo "chknsln is $chknsln and marraylen is $marraylen"
for a in "${sorted[@]}"
do 
    if [[ (( "$pcount" < "$chknsln" )) ]]
    then
	chkspec "${spec[$a]:0:-1}" "$a" "${skippm[@]}"
        if [[ (( "$maskflag" -eq "0" )) ]]
        then
	    ((pcount+=1))
        "$fun1" "$a" "$nsfile"
	fi
    fi
done
pvspec "$indx" "$fun1" "$nsfile" "${skar[@]}" 
}


findp() {

chind="$@"
skip1=0
#echo "chind is $chind"
p13=$(echo "$chind" |sed 's/[^0-9]//g')
p1=${#p13}
p2=`echo "scale=${p1}; $chind" | bc -l`
#echo "p13 is $p13 p1 is $p1 and p2 is $p2"
for ((c=1;c<"$p1";c++))
do
ab="${p2:0:-1}"
#echo "inside ab is ${spec[$ab]} and ab is $ab"

#rightsift "$a2"
for p in ${skippv[@]}
do
#	echo "inside for p is $p and spec is ${spec[$ab]} and ab is $ab"
if [[ "${spec[$ab]}" == "$p:" ]]
then
	skip1=1
	#echo "inside skipp"
	break
fi
done
ab13=$(echo "$ab" |sed 's/[^0-9]//g')
ab1=${#ab13}
ab2=`echo "scale=${ab1}; $ab" | bc -l`
#echo "ab13 is $ab13 ab1 is $ab1 and ab2 is $ab2 and ab is $ab"
p2="$ab2"
#p13=$(echo "$p2" |sed 's/[^0-9]//g')
#p1=${#p13}
#p2=`echo "scale=${p1}; $ab" | bc -l`
#echo "p13 is $p13 p1 is $p1 and p2 is $p2"
done
}

chkspec() {
ch1="$1"
shift
chid="$1"
shift
chspeck="$@"
maskflag=0
for b in ${chspeck[@]};
do
        #echo "in the for ch1 is $ch1 and b is $b "
	if [[ "$ch1" == "$b" ]]
	then
	   #echo "in the if ch1 is $ch1 and b is $b "
 	   maskflag=1
	   break
        fi
done
        findp "$chid"
        if  [[ (( "$skip1" -eq "1" )) ]]
	then
		maskflag=1
	fi
}

pvspec() {
ind1="$1"
shift
func1="$1"
shift
pvfile="$1"
shift
skarray="$@"
ul=`echo "$ind1+1" | bc -l`

for a in "${sorted[@]}";
do
	a11=$(echo "$a" |sed 's/[^0-9]//g')
        a1=${#a11}
	a2=`echo "scale=${a1}; $a" | bc -l`
	#echo "a ia $a2 ind1 is $ind1 ul is $ul"
	if ( (( $(echo "$a2 >= $ind1" | bc -l) )) && (( $(echo "$a2 < $ul" | bc -l) )) )
	then
          chkspec "${spec[$a]:0:-1}" "$a" "${skarray[@]}"
          if [[ (( $maskflag -eq 0 )) ]]
          then
		  "$func1" "$a" "$pvfile"
          fi
          maskflag=1
	fi
done
}

pvspec11() {
ind1="$1"
shift
func1="$1"
shift
pvfile="$1"
shift
skarray="$@"
ul=`echo "$ind1+1" | bc -l`

for a in "${sorted[@]}";
do
        a11=$(echo "$a" |sed 's/[^0-9]//g')
        a1=${#a11}
        a2=`echo "scale=${a1}; $a" | bc -l`
        #echo "a ia $a2 ind1 is $ind1 ul is $ul"
        if ( (( $(echo "$a2 >= $ind1" | bc -l) )) && (( $(echo "$a2 < $ul" | bc -l) )) )
        then
          chkspec "${spec[$a]:0:-1}" "$a" "${skarray[@]}"
          if [[ (( $maskflag -eq 0 )) ]]
          then
                chkspec "${spec[$a]:0:-1}" "$a" "${skippv2[@]}"
                if [[ (( $maskflag -eq 0 )) ]]
                then
                  "$func1" "$a" "$pvfile"
                fi
          fi
          maskflag=1
        fi
done
}



pvfilyl() {

fln="$pvvfile"
flnc=`> "$fln"`
chknsln="8"
pcount=0

marraylen="${#skippm[@]}"
chknsln=`echo "$chknsln-$marraylen" | bc -l`

for a in "${sorted[@]}"
do
    if [[ (( "$a" < "4" )) ]]
    then
    if [[ (( "$pcount" < "$chknsln" )) ]]
    then
	maskflag=1
	chkspec "${spec[$a]:0:-1}" "$a" "${skippv1[@]}"
	if [[ (( $maskflag -eq 0 )) ]]
	then
        ((pcount+=1))
	echo "${value[$a]}:" >>"$fln"
        fi
    fi
    fi
done

ind1="5"
pvspec11 "$ind1" "funecho" "$fln" "${skippv[@]}" 

}


pvfill(){
source "./pvfill.sh"
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
 nsfile="$pvfile"
 chknsln="8"
 fun2call="indent"
 specind="5"
 pvgen "$nsfile" "$chknsln" "$fun2call" "$specind" "${skippv[@]}" 
if [[ ! -z "$pvvfile" ]]
then
#     echo "todo"
      pvfilyl
fi
else
        if [[ "$1" == "fill" ]]
        then
                pvfill
        fi
fi
