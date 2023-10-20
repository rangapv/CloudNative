#!/usr/bin/env bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="cling.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="clingv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; this can have multiple indexes depending on your particular use case
myindx="1,2,3(labels type annotations),50(parameters)"


if [[ "$1" == "gen" ]]
then
`>$pvfile`
`>$pvvfile`
        #source /home/ubuntu/cn/generator/gen.sh "gen" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	#source /home/ubuntu/cn/generator/gen.sh "fill" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: cling.sh gen/fill"

fi
