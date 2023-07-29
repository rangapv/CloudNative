#!/bin/bash
#author: rangapv@yahoo.com 12-05-23
#This file gets called in the sergen.sh script for filling the skeletal svr.yaml file with the filled svv.yaml file that the user populates.

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "../../../ylg/ylgdb.sh"
#source "../../../ylg/thv1.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1


sortit() {
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"
done | sort -n)
}

rgenylg() {
int1=0
ind="$1"
argr1="$2"
cln="$3"
#clnc=`> "$cln"`
t=" "
if [[ (( "$2" == " " )) ]]
then
        argr1=" "
fi
num1=$(echo "$ind" |sed  's/[^0-9]//g')
num2=${#num1}
num3=$((num2-=1))

checknum=$(echo "$ind" | grep "\.")

if [[ ( -z $checknum ) ]]
then
        echo "$argr1"  >>"$cln"
fi
if [[ ( ! -z $checknum ) ]]
then
      IFS='.' read -r -a ary <<< "$ind"
      num3=${#ary[1]}
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
fi
}


findp1() {

skip1=0

chind="$1"
shift
chspeck="$@"

#echo "chind is $chind"
p13=$(echo "$chind" |sed 's/[^0-9]//g')
p1=${#p13}
p2=`echo "scale=${p1}; $chind" | bc -l`
#echo "p13 is $p13 p1 is $p1 and p2 is $p2"
newarray="${chspeck[@]}"
#newarray=(${skippm[@]} + ${skippv[@]})
for ((c=1;c<"$p1";c++))
do
ab="${p2:0:-1}"
#echo "inside ab is ${spec[$ab]} and ab is $ab"

#rightsift "$a2"
for p in ${newarray[@]}
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


chkspec1() {
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
#	   echo "in the if ch1 is $ch1 and b is $b "
 	   maskflag=1
        fi
done
        findp1 "$chid" "${chspeck[@]}"
        if  [[ (( "$skip1" -eq "1" )) ]]
	then
		maskflag=1
	fi
}


pvspec1() {
ind1="$1"
shift
func1="$1"
shift
pvfile="$1"
shift
pvrfile="$1"
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
		#echo "before chkspec1 is $a"
          chkspec1 "${spec[$a]:0:-1}" "$a" "${skarray[@]}"
          if [[ (( $maskflag -eq 0 )) ]]
          then
		  if [[ (( "${tag[$a]}" == "0" )) ]]
		  then
			  #indent "$a"
                #          echo "calling rgenylg a is $a"
			  rgenylg "$a" "${spec[$a]}" "$pvrfile"
		  else
	#		  echo "calling fillcall a is $a" 
			  fillcall "$a" "$pvrfln" "$pvfile"
                  #pvcallagain "${spec[$a]:0:-1}" "$a" "$pvrfile"
                  #pvcallagain "${spec[$a]:0:-1}" "$a" "$pvrfile" "${skippv2[@]}"
		  #"$func1" "$a" "$pvfile"
		  fi
          fi
	fi
done
}


pvfill() {

pvfln="$1"
pvrfln="$2"
mdx1="$3"
gfln=`> "$pvrfln"`
#genylg
chklen="8"
fcount=0
rflag=0
if [[ (-z $pvfln) ]]
then
    echo "File $pvfln not there or EMPTY"
    exit
fi
marraylen="${#skippm[@]}"
chknsln=`echo "$chknsln-$marraylen" | bc -l`

IFS=',' read -r -a insa <<< "$mdx1"
a1len="${#insa[@]}"
for ((c1=0;c1<"$a1len";c1++))
do
a1="${insa[$c1]}"
fr1=`echo "$a1" | grep -E -o '^[0-9]+'`
g1=`echo $a1 | grep '('`
if [[ ( ! -z "$g1" ) ]]
then
        fr=`echo "$a1" | grep -o '([a-z].*'`
        fr2="${fr:1:-1}"
#fr=`echo "${a1[$c1]}" | cut -d'(' -f1-`
#echo "fg is ${fr2[@]} length of fg is ${#fr2[@]}"
skar="${fr2[@]}"
else
skar=""
fi
#echo "calling pvspec for $fr1 and skar is ${skar[@]}"

pvspec1 "$fr1" "funecho" "$pvfln" "$pvrfln" "${skar[@]}"
done

}


fillcall() {
fg="$1"
pvrfln="$2"
pvfln="$3"
while read -r line; do
   donef=0
  # rflag=0
   #line1=($(echo "$line" | awk '{ld=split($0,fd1,":"); for (i = 1; i <= ld; i++) print fd1[i];}'))
   line1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
   line10=$(echo "$line" | awk '{split($0,f1,":"); print f1[1]}')
   #echo "line30 is $line30"
   linec2=$(echo "$line1" | grep ",")
   #echo "line is $line and linec2 is $linec2"
    linec3=$(echo "$line1" | grep "\[") 
   #echo THIS IF is for values with comma and in one below the other
   if [[ ("${value[$fg]}" == "$line10") && ( ! -z "$linec2") && ( -z "$linec3" ) ]]
   then
   echo "in the while line10 is $line10 and line2c is $line2c" 
      # rgenylg "$num143" "$lined2" "$pvrfln"
      v15=$(echo "$line1" | grep ";")
      if [[ ( -z "$v15" ) && ( "${tag[$fg]}" == "1" ) ]]
      then
       rgenylg "$fg" "${spec[$fg]}" "$pvrfln"
      fi
       #lined1=($(echo "$line1" | awk '{ld=split($0,fd1,","); for (i = 1; i <= ld; i++) print fd1[i];}'))
       lined="$(cut -d ':' -f 2- <<< "$line")"
       #double braces is for store the value as associative array
       lined1=($(echo "$lined" | awk '{ld=split($0,fd1,","); for (i = 1; i <= ld; i++) print fd1[i];}'))
       count1=0
        
         if [[ ( ! -z "$lined1" ) ]]
	 then
          for i1 in "${lined1[@]}"
          do
		    v14=$(echo "$i1" | grep ";")
	    if [[ ( ! -z "$v14" ) ]] 
	    then
	    v13=($(echo "$i1" | awk '{ld=split($0,fd1,";"); for (i = 1; i <= ld; i++) print fd1[i]}'))
            v2="${spec[$fg]}"
            #echo "the length of v13 is ${#v13[@]}"
            lined22=$(echo "${v13[0]}" | awk '{$1=$1;print}')
            v3="${v2} $lined22"
            rgenylg "$fg" "$v3" "$pvrfln"
  	      for k in "${!sorted[@]}";
              do
              if [[ "${sorted[$k]}" = "${fg}" ]];
              then
              index=$k
              newindex="${sorted[$k+1]}"
#            echo "newindex is $newindex"
              fi
              done
              v2="${spec[$newindex]}"
              lined22=$(echo "${v13[1]}" | awk '{$1=$1;print}')
              v3="${v2} $lined22"
              rgenylg "$newindex" "$v3" "$pvrfln"
            else
            #rgenylg "$fg" "${spec[$fg]}" "$pvrfln"
                       echo "array is $i1"
                        ((count1+=1))
             lined23=$(echo "$i1" | awk '{$1=$1;print}')
             lined24=$(echo "$lined23" | grep ":")
	     if [[ ( -z "$lined24") ]]
	     then
	     lined2="- \"$lined23\""
             num11=$(echo "$fg" |sed  's/[^0-9]//g')
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
       	     rgenylg "$num143" "$lined2" "$pvrfln"
             else 
	    # if [[ ( ! -z "$lined24" ) ]]
	     #then
            #function to check for annotations 
             lined25=$(echo "$i1" | grep ":")
	     if [[ ( ! -z "$lined25" ) ]]
	     then
             v19=($(echo "$i1" | awk '{ld=split($0,fd1,":"); for (i = 1; i <= ld; i++) print fd1[i]}'))
	     v191=$(echo "${v19[0]}" | awk '{$1=$1;print}') 
             v192=$(echo "${v19[1]}" | awk '{$1=$1;print}')
	     lined2=" $v191: $v192"
            #  lined23="$lined24"
            #  lined2=" $lined23"
              num11=$(echo "$fg" |sed  's/[^0-9]//g')
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
	      rgenylg "$num143" "$lined2" "$pvrfln"
	     fi
	     fi
             ((fcount+=1))
	     fi
             done
	 fi
             rflag=1
             donef=1
   fi
   #echo THIS IF for value without comma basically just one value types like replicas either 1 or 10 types / apiversions 
   if [[ ("${value[$fg]}" == "$line10") && ( -z "$linec2") && ( -z "$linec3" ) ]]
   then
   #echo "line1 2 is $line1"
     #v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
     #v11=$(echo $v1 | awk '{$1=$1;print}')
     v11="$line1"
     v12=$(echo $v11 | grep ";")  
     if [[ ( ! -z "$v12" ) ]]
     then
       v13=($(echo "$v12" | awk '{ld=split($0,fd1,";"); for (i = 1; i <= ld; i++) print fd1[i];}'))
       v2="${spec[$fg]}"
#       echo "the length of v13 is ${#v13[@]}"
       lined22=$(echo "${v13[0]}" | awk '{$1=$1;print}')
       v3="${v2} $lined22"
       rgenylg "$fg" "$v3" "$pvrfln"
       for k in "${!sorted[@]}";
       do
       if [[ "${sorted[$k]}" = "${fg}" ]];
       then
        index=$k
        newindex="${sorted[$k+1]}"
#	echo "newindex is $newindex"
       fi
       done
       v2="${spec[$newindex]}"
       lined22=$(echo "${v13[1]}" | awk '{$1=$1;print}')
       v3="${v2} $lined22"
       rgenylg "$newindex" "$v3" "$pvrfln"
     else
     v2="${spec[$fg]}"
     lined22=$(echo "$v11" | awk '{$1=$1;print}')
     v3="${v2} $lined22"
#            sudo sed -i "s/${v2}/${v2} ${v11}/" $line
     rgenylg "$fg" "$v3" "$pvrfln"
     fi
     rflag=1
     donef=1 
     ((fcount+=1))
   fi
#ADDES
   #echo This IF is for command line args but has comma and still comes in one line and NOT below each other 
   if [[ ("${value[$fg]}" == "$line10") && ( ! -z "$linec2")  && ( ! -z "$linec3" ) ]]
   then
   #echo "line1 3 is $line1"
     # v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
     #v11=$(echo $v1 | awk '{$1=$1;print}')
     v11="$line1"
     #v12=$(echo $v11 | grep ";")
     #v121=$(echo $v11 | grep ",")
     if [[ ( ! -z "$v11" ) ]]
     then
       #rgenylg "$fg" "$v3" "$pvrfln"
       v2="${spec[$fg]}"
       lined22=$(echo "$v11" | awk '{$1=$1;print}')
       v3="${v2} $lined22"
       rgenylg "$fg" "$v3" "$pvrfln"
       rflag=1
       donef=1
     fi
  fi
#ADDED
  #For all other user cases
  if [[ ("${value[$fg]}" == "$line10") && (( $donef -eq 0 )) ]]
   then
   #echo "line1 3 is $line1"
     # v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
     #v11=$(echo $v1 | awk '{$1=$1;print}')
     v11="$line1"
     #v12=$(echo $v11 | grep ";")
     #v121=$(echo $v11 | grep ",")
     if [[ ( ! -z "$v11" ) ]]
     then
       #rgenylg "$fg" "$v3" "$pvrfln"
       v2="${spec[$fg]}"
       lined22=$(echo "$v11" | awk '{$1=$1;print}')
       v3="${v2} $lined22"
       rgenylg "$fg" "$v3" "$pvrfln"
       rflag=1
       donef=1
     fi
  fi
#for while read
done <$pvfln
#for f loop

}


sortit
pvvfile="$1"
pvfile="$2"
mdx="$3"
pvfill "$pvvfile" "$pvfile" "$mdx"
