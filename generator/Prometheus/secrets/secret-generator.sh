#!/bin/bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="sr.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="sv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; 
myindx="1,2,3(labels annotations),10"

if [[ "$1" == "gen" ]]
then
	#source /home/ubuntu/cn/generator/gen.sh "gen" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then

	#source /home/ubuntu/cn/generator/gen.sh "fill" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: secret-generator.sh gen/fill"

fi

