#!/bin/bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="pvr.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="pvv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ;
myindx="1,2,3(annotations),5(resources nfs)"

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: pv-generator.sh gen/fill"

fi

