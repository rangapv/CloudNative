#!/bin/bash
#author: rangapv@yahoo.com 07-05-23
#USUAGE: ./ngen.sh gen (will generate the Skeletal YAML nsr.yaml and nsv.yaml a human readable file to fill values)
#USUAGE: ./ngen.sh (SAME as above ....will generate the Skeletal YAML nsr.yaml and nsv.yaml a human readable file to fill values)
#USUAGE: ./ngen.sh fill (The program takes the FILLED nsv.yaml file generated ealier from above step and popluates the Skeletal nsr.yaml with namespace values)

set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >>/dev/null 2>&1
#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh) >>/dev/null 2>&1

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(namespace labels annotations)
#array values that needs to be skipped fromt eh database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
skippv=( )


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


findp1() {

chind="$@"
skip1=0
#echo "chind is $chind"
p13=$(echo "$chind" |sed 's/[^0-9]//g')
p1=${#p13}
p2=`echo "scale=${p1}; $chind" | bc -l`
#echo "p13 is $p13 p1 is $p1 and p2 is $p2"
newarray=(${skippm[@]} + ${skippv[@]})
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
        findp1 "$chid"
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
          chkspec1 "${spec[$a]:0:-1}" "$a" "${skarray[@]}"
          if [[ (( $maskflag -eq 0 )) ]]
          then
		  if [[ (( "${tag[$a]}" == "0" )) ]]
		  then
			  #indent "$a"
			  rgenylg "$a" "${spec[$a]}" "$pvrfile"
		  else
                  pvcallagain "${spec[$a]:0:-1}" "$a" "$pvrfile"
                  #pvcallagain "${spec[$a]:0:-1}" "$a" "$pvrfile" "${skippv2[@]}"
		  #"$func1" "$a" "$pvfile"
		  fi
          fi
	fi
done
}

pvcallagain() {
item1="$1"
shift
item3="$1"
shift
fileo="$1"
#shift
#item2="$@"
rflag=0
#for g in ${item2[@]};
#do
#if [[ (( "$rflag" -eq "0" )) ]]
#then
#if [[ "$item1" == "$g" ]]
#then
#      rgenylg "$item3" "${spec[$item3]}" "$fileo"
#      rflag=1 
  #    	echo "${spec[$a]}" >> "$fileo"
#else
f="$item3"
while read -r line; do
 
   line1=$(echo "$line" | awk '{split($0,f1,":"); print f1[1]}')
   line10=$(echo "$line1" | awk '{$1=$1;print}')
   linec2=$(echo "$line" | grep ",")
   #echo "line2c is $line2c"
   if [[ ("${value[$f]}" == "$line10") && ( ! -z "$linec2") ]]
   then
       lined=$(echo "$line" | awk '{split($0,f1,":"); print f1[2]}')
       lined1=($(echo "$lined" | awk '{ld=split($0,fd1,","); for (i=1;i<=ld;i++) {print fd1[i]} }'))
       count1=0
         if [[ ( ! -z "$lined1" ) ]]
         then
         rgenylg "$f" "${spec[$f]} " "$fileo"
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
             rgenylg "$num143" "$lined2" "$fileo"
             ((fcount+=1))
             done
            rflag=1
         fi
   fi
   if [[ ("${value[$f]}" == "$line10") && ( -z "$linec2") ]]
   then
     v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
     v11=$(echo $v1 | awk '{$1=$1;print}')
     v2="${spec[$f]}"
     v3="${v2} ${v11}"
#            sudo sed -i "s/${v2}/${v2} ${v11}/" $line
     rgenylg "$f" "$v3" "$fileo"
     rflag=1
     ((fcount+=1))
   fi
#for while read
done <$pvfln
#for f loop
#if [[ (( $rflag -eq 0 )) ]]
#then
 #    rgenylg "$f" "${spec[$f]}"
#fi
#fi
#fi
#done
}

pvfill() {

pvfln="$1"
pvrfln="$2"
gfln=`> "$pvrfln"`
#genylg
chklen="8"
fcount=0

if [[ (-z $pvfln) ]]
then
    echo "File $pvfln not there or EMPTY"
    exit
fi
marraylen="${#skippm[@]}"
chknsln=`echo "$chknsln-$marraylen" | bc -l`

for f in "${sorted[@]}"
do
rflag=0
val=`echo "$f<3.9" | bc -l`
     #echo "val is $val"
if [[ (( "$val" > "0" )) ]]
then
chkspec1 "${spec[$f]:0:-1}" "$f" "${skippm[@]}"
if [[ (( "$maskflag" -eq "0" )) ]]
then

if [[ (( "$fcount" < "$chklen" )) ]]
then
while read -r line; do
   donef=0
   line1=$(echo "$line" | awk '{split($0,f1,":"); print f1[1]}')
   line10=$(echo "$line1" | awk '{$1=$1;print}')
   linec2=$(echo "$line" | grep ",")
   #echo "line2c is $line2c"
   if [[ ("${value[$f]}" == "$line10") && ( ! -z "$linec2") ]]
   then
   #echo "in the while line10 is $line10 and line2c is $line2c" 
       lined=$(echo "$line" | awk '{split($0,f1,":"); print f1[2]}')
       lined1=($(echo "$lined" | awk '{ld=split($0,fd1,","); for (i=1;i<=ld;i++) {print fd1[i]} }'))
       count1=0
         if [[ ( ! -z "$lined1" ) ]]
	 then
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
             rgenylg "$num143" "$lined2" "$pvrfln"
             ((fcount+=1))
             done
	 fi
             rflag=1
   fi
   if [[ ("${value[$f]}" == "$line10") && ( -z "$linec2") ]]
   then
     v1=$(echo "$line" | awk '{l=index($0,":"); print substr($0,l+1)}')
     v11=$(echo $v1 | awk '{$1=$1;print}')
     v2="${spec[$f]}"
     v3="${v2} ${v11}"
#            sudo sed -i "s/${v2}/${v2} ${v11}/" $line
     rgenylg "$f" "$v3" "$pvrfln"
     rflag=1
     ((fcount+=1))
   fi
#for while read
done <$pvfln
#for f loop
   if [[ (( $rflag -eq 0 )) ]]
   then
     rgenylg "$f" "${spec[$f]}" "$pvrfln"
     ((fcount+=1))
   fi
fi
fi
fi
done

ind1="5"
#pvspec1 "$ind1" "funecho" "$pvfln" "$pvrfln" "${skippv[@]}"

}


sortit
pvfill "nsv.yaml" "nsr.yaml"
