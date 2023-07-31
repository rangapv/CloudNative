#!/bin/bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="pvc.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="pvcv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; 
myindx="1,2,3(type annotations),5(capacity nfs csi)"

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
       source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: pvc-generator.sh gen/fill"

fi

