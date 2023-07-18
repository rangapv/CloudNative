#!/bin/bash
#author: rangapv@yahoo.com 17-04-23
#This is a multi utility script to make Database changes which is take care by the function fix2 to adda new filed "tag"
#This SCRIPT should be run to update Key values INDEX incrementing it by 1(m varaible) and then commit the ylgdb.sh to REPO taken care by function fix1
#THe dunction fix3 adds the tag value "0" to the labels fields mentioned in the array tago

set -E

#source "./ylgdb.sh"
source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/ylg/ylgdb.sh)

tago=(spec metadata labels capacity accessModes nfs resources requests selector annotations template containers ports volumeMounts volumes configMap persistentVolumeClaim volumes) 

tag1=(args )


#this function just increments a particlar index with the value in m
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

#file to move and copy ; this needs more work to be done
fix11() {
file1="./ylgdb.sh"
file34="./thb.sh"
file3="./ch.txt"
`> $file34`

while read -r line1; do

IFS=',' read -r -a insa <<< "$line1"
echo "${insa[0]}" "${insa[1]}"
t2="${insa[1]}"
while read -r line; do

	#echo "line is $line"
	#if [[ ("$line" =~ ^"tag") ]]
        sflag="0"	
	if [[ ("$line" =~ ^"spec") || ("$line" =~ ^"value") ]]
        then
	#echo "line is $line"
        mstr1=`grep -o "[(0-9)(.)(0-9)]*" <<< $line`
        #mstr2=$(echo "$mstr1 + $m" | bc)
        #echo "mstr1 is $mstr1 mstr2 is $mstr2"
        lin1=$(echo "$line" | awk '{split($0,a,"[");print a[1]}')
        lin3=$(echo "$line" | awk '{split($0,a,"]");print a[2]}')
        #echo "$lin1[$mstr2]$lin3"
	if [[ ("$mstr1" == "${insa[0]}") ]]
	then
         #echo "Inside match1 $mstr1 ${insa[0]} and line is $line" 
	`echo "$lin1[$t2]$lin3">>"$file34"`
        else
	`echo "$line">>"$file34"`
	fi
	sflag="1"
  else
	mstr4=`echo "$line" | grep -o ^"tag"`
        mstr4s="$?"
        if [[ ("$mstr4s" -eq "0") ]]
        then
        #echo "mstr4 is $mstr4"
        sflag="1"
	lin1=$(echo "$line" | awk '{split($0,a,"[");print a[1]}')
        lin3=$(echo "$line" | awk '{split($0,a,"]");print a[2]}')
        #echo "$lin1[${insa[1]}]$lin3"
         if [[ ("$mstr1" == "${insa[0]}") ]]
         then
         #echo "Inside match1 $mstr1 ${insa[0]} and line is $line"
         `echo "$lin1[$t2]$lin3">>"$file34"`
         else
         `echo "$line">>"$file34"`
         fi
        fi
	if [[ (("$sflag" -ne "1" )) ]]
	then
           `echo "$line">>"$file34"`
	fi
  fi
done <$file1
`cp "$file34" "$file1"`

done<$file3

}




#This takes an input file to-index 2 new-index on existing db values
fix13() {

file1="./ylgdb.sh"
file34="./thb.sh"
file3="./ch.txt"
`> $file34`

while read -r line1; do

IFS=',' read -r -a insa <<< "$line1"
echo "${insa[0]}" "${insa[1]}"
t2="${insa[1]}"

in1="${insa[0]}"
in2="${insa[1]}"
echo "in1 is $in1"
sudo sed -i "s|\[${in1}\]|\[${in2}\]|g" "$file1" 


#`cp "$file34" "$file1"`

done<$file3

}

#This takes an input file and sorts the array[] , just copy the top part of the Database 
fix14() {

file1="./ylgdb.sh"
file34="./thb.sh"
`> $file34`
sortit

for k in "${sorted[@]}"
do
	while read -r line;do 
         g1=`echo "$line" | grep "\[$k\]"`
         g1s="$?"
         #echo "g1 is $g1"
	 if [[ ("$g1s" -eq "0") ]]
	 then
		`echo "$line">>"$file34"`
	 fi
	done<$file1
done

}


#to print unique index number into a file , which can be used to do further manipulation such as changinf the new index etc

fix12() {
inp1="4.912"
inp2="4.912211"
newfile="./ch.txt"
`> $newfile`
sortit

for k in "${sorted[@]}"
do
	#echo "k is $k"
        if ( (( $(echo "$k >= $inp1" | bc -l) )) && (( $(echo "$k <= $inp2" | bc -l) )) )
        then
		`echo "$k">>"$newfile"`
	fi
done

}

#sort the database with respect to spec 
sortit() {
source "./ylgdb.sh"
readarray -t sorted < <(for l in "${!spec[@]}"
do
        echo "$l"
done | sort -n)
}

#sort the database with respect to tag
sortag() {
source "./ylgdb.sh"
readarray -t sortg < <(for l in "${!tag[@]}"
do
        echo "$l"
done | sort -n)
}


#this function again adds tag as a entry to the Database
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

#this function is to change the elements in the array tago() values of tag to "0" or can be used for vice-versa
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



#this function was added to insert tag as an element to all the entries in the Database which initally had only spec and value entries
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




#This function increment the index inside a particluar range so new features can be added
fix41() {
sortit
file1="./ylgdb.sh"
file2="./tgb.sh"
index1=4.711
index2=5
m1=0.2
`> ./$file2`
`cp $file1 $file2`
for a in "${sorted[@]}"
do
	#echo "a is $a"
        mm2=$(echo "$a" | bc)
	mm3=$(echo "$mm2 + $m1" | bc)
	#echo "mm3 is $mm3"
	#$mm21=$(((mm2+m1)| bc))
        #echo "m2 is $mm2 and mm21 is $mm3"
	if (( $(echo "$mm2 $index1" | awk '{print ($1 >= $2)}') )) && (( $(echo "$mm2 $index2" | awk '{print ($1 < $2)}') ))
	#	if (( $(echo "$result1 $result2" | awk '{print ($1 > $2)}') ))
	then
                mm2=$(echo "$a" | bc)
	        #=$(echo "$mm2 + $m1" | bc)
		#newindx=$(echo "$a + $m1" | bc)
		s1=`echo "spec\["$mm2"\]="`
		echo "s1 is $s1"
		s2=`echo "spec\["$mm3"\]="`
                suc=`sudo sed -i "s|$s1|$s2|g" "$file2"`
		s1=`echo "value\["$mm2"\]="`
		s2=`echo "value\["$mm3"\]="`
                suc=`sudo sed -i "s|$s1|$s2|g" "$file2"`
		s1=`echo "tag\["$mm2"\]="`
		s2=`echo "tag\["$mm3"\]="`
                suc=`sudo sed -i "s|$s1|$s2|g" "$file2"`

	fi
done
}




#this function is for serial value addition to the Database
callfix5() {

	fix5 "4.71" "4.711" "initContainers:" "The init container details for the Pod if any" "0"
	fix5 "4.711" "4.811" "- name:" "The name for the init container" "1"
	fix5 "4.811" "4.8111" "image:" "The init container image" "1"
	fix5 "4.8111" "4.8112" "command:" "The command to be executed for the init container" "1"
	fix5 "4.8112" "4.8113" "volumeMounts:" "The volume mounts for the init container" "0"
	fix5 "4.8113" "4.8114" "- name:" "The name for the volume mount in init container" "1"
	fix5 "4.8114" "4.81141" "mountPath:" "The mountpath for the volume mount of init container" "1"

	#fix5 "4.1" "4.3" "selector:" "The selector details for the Pod if any" "0"
	#fix5 "4.3" "4.31" "matchLabels:" "The labels for the Pod to match" "0"
	#fix5 "4.31" "4.311" "app:" "The app name for the Pod to match" "1"
	#fix5 "4.311" "4.5" "strategy:" "The container deployment strategy for the Pod" "0"
	#fix5 "4.5" "4.51" "rollingUpdate:" "The update details for the Pod " "0"
	#fix5 "4.51" "4.511" "maxSurge:" "The max surge number for the Pod" "1"
	#fix5 "4.511" "4.512" "maxUnavailable:" "The max Unavailabe details for the Pod" "1"
	#fix5 "4.512" "4.52" "type:" "The strategy type for the Pod" "1"
	#fix5 "4.712112" "4.7122" "- name:" "Name of the Volume(PersistentVolumeClaim)" "1"
	#fix5 "4.7122" "4.71221" "persistentVolumeClaim:" "Header of the Volume(PersistentVolumeClaim)" "0"
	#fix5 "4.71221" "4.712211" "claimName:" "The Claim name of PersistentVolumeClaim" "1"


}


#reads entries in file3 to add to database
fix51() {
file1="./ylgdb.sh"
file34="./thb.sh"
file3="data4.text"
`> $file34`
`cp $file1 $file34`
count=0

while read line; do
        echo "line ois $line"
        IFS=',' read -r -a insa <<< "$line"
        #echo "the length of array is ${#insa[@]}"
        #echo "${insa[0]}" "${insa[1]}" "${insa[2]}" "${insa[3]}" 
        echo "spec[${insa[0]}]=\"${insa[1]}\"">>"$file34"
        echo "value[${insa[0]}]=\"${insa[2]}\"">>"$file34"
        echo "tag[${insa[0]}]=\"${insa[3]}\"">>"$file34"
done <$file3


}

#this function is for inserting va new value into the Database
fix5() {

sortag
#file1="./tgb.sh"
file1="./ylgdb.sh"
file34="./thb.sh"
`> $file34`
count=0

insindex="$1"
pnsindex="$2"
specvalue="$3"
valuevalue="$4"
tagvalue="$5"



#insindex="4.1"
#pnsindex="4.3"
#specvalue="selector:"
#valuevalue="The selector details for the Pod if any"
#tagvalue="0"

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
`cp $file34 $file1`
}

#this particular function is to replace a particlar index with a new index
fix6() {
filename="./thv1.sh"
`> $filename`
c2=`cp ./ylgdb.sh ./thv1.sh`
nx1="4.3111512"
nx2="4.3111511"
str1="spec\[$nx1\]"
str2="spec\[$nx2\]"
str11="value\[$nx1\]"
str21="value\[$nx2\]"
str22="tag\[$nx1\]"
str23="tag\[$nx2\]"


sudo sed -i "s|${str1}|${str2}|" $filename
sudo sed -i "s|${str11}|${str21}|" $filename
sudo sed -i "s|${str22}|${str23}|" $filename

}

#this function reads the file in file3 and adds entries to the database(ylgdb.sh)
fix61() {
#file1="./ylgdb.sh"
#file2="./bkpylgdb"
file3="./data1.text"
#file3="./data.text"
#cp1=`cp ${file1 $file2`

while read line; do
        echo "line ois $line"
	#insa=($(line.split(",")))
	#insa=($(echo $line | tr "," "\n"))
	#insa=($(echo $line | awk '{len=split($0,a,",");for(i=1;i<=len;i++) print a[i];}'))
	#insa=($(echo $line | cut -d "," -f 1-5 --output-delimiter=' '))

	#insa=($(echo $line | awk '{len=split($0,a,"/");for(i=1;i<=len;i++) cut -d ',' -f 1-2print a[i];}'))
#	insa=($(echo $line | cut -f 1 -d ','))
        IFS=',' read -r -a insa <<< "$line"
	echo "the length of array is ${#insa[@]}"
	echo "${insa[0]}" "${insa[1]}" "${insa[2]}" "${insa[3]}" "${insa[4]}"
        fix5 "${insa[0]}" "${insa[1]}" "${insa[2]}" "${insa[3]}" "${insa[4]}"

done <$file3

}

#this function is for replacing a value into the Database
fix7() {

if [[ ("$#" -eq "") ]]
then
	echo "need a index-value and the value-defintion ( like 4.5 "Spec for gtf" etc) "
        exit
elif [[ ("$#" -eq "1") ]]
then
       echo "need a value-defintion ( like 4.5 "Spec for gtf" etc) "
       exit
else
       echo "executing "
fi

sortag
#file1="./tgb.sh"
file1="./ylgdb.sh"
file34="./thb.sh"
`> $file34`
count=0

insindex="$1"
str="$*"
dfr="$(cut -d ' ' -f 2- <<< $str)"
valuevalue="$dfr"

while read -r line; do

  if [[ ("$line" =~ ^"spec") ]]
  then
       echo "$line">>"$file34"
  elif [[ ("$line" =~ ^"value") ]]
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
   if [[ ("$insindex"  == "$mstr1") ]]
   then
        #`echo "$line">>"$file34"`
        ((count+=1))
        #echo "hi $count and line is $line"
        #echo "mstr1 is $mstr1"
        echo "value[$insindex]=\"$valuevalue\"">>"$file34"
   else
        echo "$line">>"$file34"
   fi
   #`echo "$line">>"$file34"`
  elif [[ ("$line" =~ ^"tag") ]]
  then
       echo "$line">>"$file34"
   else
    echo "$line">>"$file34"
   fi

done <$file1

echo "count is $count"
echo "The modified database is in the file $file34; kindly checkit once and rename it as ylgdb.sh and uplaod to the git repo"
#`cp ./thb.sh ./tgb.sh`
}



#This function is to display the Database starting index of various resource YAML
dbdetails() {
sortit
i1=0
oldgt=-1
for a in "${sorted[@]}"
do
	d0=`echo "$a" | grep "\."`
        gt=$(echo $a | awk '{split($0,b,".");print b[1]}')
        if [[ ("$oldgt" != "$gt") ]]
	then
               echo "${value[$a]}   Begins at index $gt"
               oldgt=$gt
	fi
       	#echo "gt is $gt"
	#echo "i1 is $i1 ${sorted[$i1]}"
	((i1+=1))

done
}


if [[ ("$#" -eq "") ]]
then
	echo "need a function name to execute"
	exit
else
	$@
fi



#fix1
#fix2
#sortit
#fix3
#sortit
#fix4
#fix5
#fix6
#fix41
#callfix5
