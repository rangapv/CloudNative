#!/bin/bash
#author: rangapv@yahoo.com 12-05-23
#USUAGE: ./sergen.sh gen (will generate the Skeletal YAML svr.yaml and svv.yaml a human readable file to fill values)
#USUAGE: ./sergen.sh (SAME as above ....will generate the Skeletal YAML svr.yaml and svv.yaml a human readable file to fill values)
#USUAGE: ./sergen.sh fill (The program takes the FILLED svv.yaml file generated ealier from above step and popluates the Skeletal svr.yaml with svv values)


set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "../../../ylg/thv1.sh"
source "../../../ylg/ylgdb.sh"
#source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
#skippm=(labels )
#array values that needs to be skipped fromt eh database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
#skippv=( )

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
	checknum=$(echo "$ai" | grep "\.")
        #echo "ai  is $ai"
        #echo "checknum is $checknum"
if [[ ( -z $checknum ) ]]
then
        echo "${spec[$ai]}"  >>"$ifile"
fi
if [[ ( ! -z $checknum ) ]]
then
       IFS='.' read -r -a ary <<< "$ai"
       num3=${#ary[1]}
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
fi
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
#echo "chksln is $chknsln"
for a in "${sorted[@]}"
do 
    val=`echo "$a<3.9" | bc -l`
     #echo "val is $val"
    if [[ (( "$val" > "0" )) ]]
    then
        chkspec "${spec[$a]:0:-1}" "$a" "${skippm[@]}"
        if [[ (( "$maskflag" -eq "0" )) ]]
	then
	((pcount+=1))
	"$fun1" "$a" "$nsfile"
	fi
    fi
done
if [[ (("$indx" -gt "0")) ]]
then
#	echo "inside and inx is $indx"
#pvspec "$indx" "$fun1" "$nsfile" "${skar[@]}" 
a1=($(echo "$indx" | awk '{lg=split($0,fd2,","); for (i = 1; i <= lg; i++) print fd2[i];}'))
a1len="${#a1[@]}"
#echo "the lenth is ${#a1[@]}"
for ((c1=0;c1<"$a1len";c1++))
do
#echo "a1 is ${a1[$c1]}"
pvspec "${a1[$c1]}" "$fun1" "$nsfile" "${skar[@]}" 
done
fi
}


findp() {

chind="$@"
skip1=0
#echo "chind is $chind"
p13=$(echo "$chind" |sed 's/[^0-9]//g')
p1=${#p13}
p2=`echo "scale=${p1}; $chind" | bc -l`
#echo "p13 is $p13 p1 is $p1 and p2 is $p2"
newarr=(${skippm[@]} + ${skippv[@]})
for ((c=1;c<"$p1";c++))
do
ab="${p2:0:-1}"
#echo "inside ab is ${spec[$ab]} and ab is $ab"

#rightsift "$a2"
for p in ${newarr[@]}
#for p in ${skippv[@]}
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
        if [[ ( "$ch1" == "$b" ) ]]
	then

        #echo "in the for ch1 is $ch1 and b is $b "
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
                if [[ (( "${tag[$a]}" -eq "1" )) ]]
		then
		#chkspec "${spec[$a]:0:-1}" "$a" "${skippv2[@]}"
	#	if [[ (( $maskflag -eq 0 )) ]]
#		then
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
ind2="$1"

marraylen="${#skippm[@]}"
chknsln=`echo "$chknsln-$marraylen" | bc -l`

for a in "${sorted[@]}"
do
#	`echo "$a < "3.62" | bc -l`
    val=`echo "$a<3.9" | bc -l`
     #echo "val is $val"
    if [[ (( "$val" > "0" )) ]]
    then
    if [[ (( "$pcount" < "$chknsln" )) ]]
    then
	#chkspec "${spec[$a]:0:-1}" "$a" "${skippv1[@]}"
	maskflag=1
        chkspec "${spec[$a]:0:-1}" "$a" "${skippm[@]}"
	if [[ (( $maskflag -eq 0 )) ]]
	then
		if [[ ( "${tag[$a]}" == "1" ) ]]
		then
                ((pcount+=1))
	        echo "${value[$a]}:" >>"$fln"
		fi
       fi
    fi
    fi
done

ind1="$ind2"

if [[ (("$ind1" -gt "0")) ]]
then
#       echo "inside and inx is $indx"
#pvspec "$indx" "$fun1" "$nsfile" "${skar[@]}"
a1=($(echo "$ind1" | awk '{lg=split($0,fd2,","); for (i = 1; i <= lg; i++) print fd2[i];}'))
a1len="${#a1[@]}"
#echo "the lenth is ${#a1[@]}"
for ((c1=0;c1<"$a1len";c1++))
do
#echo "a1 is ${a1[$c1]}"
pvspec11 "${a1[$c1]}" "funecho" "$fln" "${skippv[@]}" 
done
fi

}


pvfill(){
	#source /home/ubuntu/cn/generator/fill.sh "$pvvfile" "$pvfile" "$spxind"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/fill.sh) "$pvvfile" "$pvfile" "$spxind"
}

#pvfile="svr.yaml"
#pvvfile="svv.yaml"

sortit

if [[ "$#" -eq 0 ]]
then
        echo "Command line arguments insufficient"
	exit
fi


if [[ "$#" -eq 4 ]]
then

pvfile="$2"
pvvfile="$3"
spxind="$4"

if [[ "$1" == "gen" ]]
then
 nsfile="$pvfile"
 chknsln="8"
 fun2call="indent"
 specind="$spxind"
 pvgen "$nsfile" "$chknsln" "$fun2call" "$specind" "${skippv[@]}"
  if [[ ! -z "$pvvfile" ]]
  then
#     echo "todo"
      pvfilyl "$specind"
  fi
else
  if [[ "$1" == "fill" ]]
  then
           pvfill
  fi
fi
fi
