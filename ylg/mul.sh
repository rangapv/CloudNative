#!/bin/bash
#author: rangapv@yahoo.com 17-04-23
#This is a multi utility script to make Database changes which is take care by the function fix2 to adda new filed "tag"
#This SCRIPT should be run to update Key values INDEX incrementing it by 1(m varaible) and then commit the ylgdb.sh to REPO taken care by function fix1
#THe dunction fix3 adds the tag value "0" to the labels fields mentioned in the array tago

set -E

source "./ylgdb.sh"

tago=(spec metadata labels capacity accessModes nfs resources requests selector annotations template containers args ports volumeMounts volumes configMap persistentVolumeClaim volumes) 



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




#fix1
#fix2
sortit
fix3

