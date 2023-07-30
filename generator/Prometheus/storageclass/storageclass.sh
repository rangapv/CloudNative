#!/bin/bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="scr.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="scv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; the spec is across 2 indexes hence comma seperated
myindx="1,2,3(labels annotations),8,9"

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: storageclass.sh gen/fill"

fi

