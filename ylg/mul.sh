#!/bin/bash
#author: rangapv@yahoo.com 17-04-23
#This is a multi utility script to make Database changes which is take care by the function fix2 to adda new filed "tag"
#This SCRIPT should be run to update Key values INDEX incrementing it by 1(m varaible) and then commit the ylgdb.sh to REPO taken care by function fix1
#THe dunction fix3 adds the tag value "0" to the labels fields mentioned in the array tago

set -E

source "./ylgdb.sh"

tago=(spec metadata labels capacity accessModes nfs resources requests selector annotations template containers ports volumeMounts volumes configMap persistentVolumeClaim volumes) 

tag1=(args )

fix1() {
file1="./ylgdb.sh"
file34="./tb.sh"
m=1
`> $file34`
while read -r line; do
  if [[ ("$line" =~ ^"spec") || ("$line" =~ ^"value") ]]
  then
	mstr1=`grep -o "[(0-9)(.)(0-9)]*" <<< $line`
        mstr2=$(echo "$mstr1 + $m" | bc)
        #echo "mstr1 is $mstr1 mstr2 is $mstr2" 
	lin1=$(echo "$line" | awk '{split($0,a,"[");print a[1]}')
	lin3=$(echo "$line" | awk '{split($0,a,"]");print a[2]}')
        #echo "$lin1[$mstr2]$lin3"
        `echo "$lin1[$mstr2]$lin3">>"$file34"`
  else
	`echo "$line">>"$file34"`
  fi
done <$file1 
`mv "$file34" "$file1"`
}

sortit() {
source "./ylgdb.sh"
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"
done | sort -n)
}

sortag() {
source "./ylgdb.sh"
readarray -t sortg < <(for l in "${!tag[@]}"
do
        echo "$l"
done | sort -n)
}


fix2() {
file1="./ylgdb.sh"
file34="./thb.sh"
`> $file34`
while read -r line; do
   if [[ ("$line" =~ ^"spec") ]]
   then
        `echo "$line">>"$file34"`
   fi
   if [[ ("$line" =~ ^"value") ]]
   then 
        `echo "$line">>"$file34"`
 	mstr1=`grep -o "[0-9.]*" <<< $line`
        #mstr2=$(echo "$mstr1 + $m" | bc)
        #echo "mstr1 is $mstr1 mstr2 is $mstr2"
       # lin1=$(echo "$line" | awk '{split($0,a,"[");print a[1]}')
        #lin3=$(echo "$line" | awk '{split($0,a,"]");print a[2]}')
        #echo "$lin1[$mstr2]$lin3"
	#echo "mstr1 is $mstr1"
        `echo "tag[$mstr1]=\"1\"">>"$file34"`
       	#echo "$lin1[$mstr2]$lin3">>"$file34"
  fi
done <$file1
#mv "$file34" "$file1"

}
#Just to run UNIT tests this Function exist
test() {
m=1
m1=1.1
mm2=$(echo "$m1 + $m" | bc)
mm2=$(((m+m1)| bc))
echo "m2 is $mm2" 
}


fix3() {

sortit
file1="./ylgdb.sh"

for a in "${sorted[@]}"
do
	for b in ${tago[@]}
	do
          if [[ "${spec[$a]}" == "$b:" ]]
	  then
	     rep=`echo "tag[$a]=\"0\""`  
	     # sed s//$rep/ line 
             #echo "spec is ${spec[$a]} and b is $b and tag is tag[$a] and rep is $rep"  
             tr=`grep "tag\[$a\]" $file1`
	     suc=`sudo sed -i "s|tag\[$a\].*|${rep}|g" "$file1"`
	  fi
	done

done
}


fix4() {

sortit
file1="./ylgdb.sh"

for a in "${sorted[@]}"
do
	for b in ${tag1[@]}
	do
          if [[ "${spec[$a]}" == "$b:" ]]
	  then
	     rep=`echo "tag[$a]=\"1\""`  
	     # sed s//$rep/ line 
             #echo "spec is ${spec[$a]} and b is $b and tag is tag[$a] and rep is $rep"  
             tr=`grep "tag\[$a\]" $file1`
	     suc=`sudo sed -i "s|tag\[$a\].*|${rep}|g" "$file1"`
	  fi
	done

done
}


fix5() {

sortag
file1="./ylgdb.sh"
file34="./thb.sh"
`> $file34`
count=0
insindex="3.62"
pnsindex="3.7"
specvalue="annotations"
valuevalue="The list of annotations for this kind"
tagvalue="1"

while read -r line; do

  if [[ ("$line" =~ ^"spec") ]]
  then   
       echo "$line">>"$file34"
  elif [[ ("$line" =~ ^"value") ]]
  then
       echo "$line">>"$file34"
   elif [[ ("$line" =~ ^"tag") ]]
   then
   #echo "line os $line and mstr1 is $mstr11 and a is $a"
   dig1=`echo "$line" | awk '{split($0,a,"="); print a[1]}'`
   #echo "dig1 is $dig1"
   mstr1=`grep -o "[(0-9)(.)(0-9)]*" <<< $dig1`
   #echo "mstr1 is $mstr1"
  # mstr1=`grep -o "[0-9.]*" <<< $line`
   num1=$(echo "$mstr1" | sed 's/[^0-9]//g') 
  # mstr11=${#num1}
   mstr2=${#num1}
   #echo "mstr2 is $mstr2 and num1 is $num1"
   #echo "hi mstr1 $mstr1 and mstr2 is $mstr2 line is $line"
  # echo "num1 is $num1"
   echo "$line">>"$file34"
   if [[ ("$insindex"  == "$mstr1") ]]
   then
        #`echo "$line">>"$file34"`
        ((count+=1))
	#echo "hi $count and line is $line"
        #echo "mstr1 is $mstr1"
	echo "spec[$pnsindex]=\"$specvalue\"">>"$file34"
	echo "value[$pnsindex]=\"$valuevalue\"">>"$file34"
	echo "tag[$pnsindex]=\"$tagvalue\"">>"$file34"
   fi
   #`echo "$line">>"$file34"`
   else
    echo "$line">>"$file34"
   fi

done <$file1

echo "count is $count"
}

#fix1
#fix2
#sortit
#fix3
#sortit
#fix4
fix5
