#!/bin/bash
#author: rangapv@yahoo.com 17-04-23
#This SCRIPT should be run to update Key values INDEX incrementing it by 1(m varaible) and then commit the ylgdb.sh to REPO
set -E

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

#Just to run UNIT tests this Function exist
test() {
m=1
m1=1.1
mm2=$(echo "$m1 + $m" | bc)
mm2=$(((m+m1)| bc))
echo "m2 is $mm2" 
}

fix1
