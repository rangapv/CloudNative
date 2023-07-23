#!/bin/bash

set -E

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(type annotations)
#array values that needs to be skipped from the database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
skippv=(capacity nfs csi)

#The YAMl file name for this resource ; this can be changed
pvfile="pvc.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="pvcv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; 
myindx="5"

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
       source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: pvc-generator.sh gen/fill"

fi

