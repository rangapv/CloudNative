#!/bin/bash

set -E

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(labels )
#array values that needs to be skipped fromt eh database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
skippv=( )

#The YAMl file name for this resource ; this can be changed
pvfile="scr.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="scv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; this CANNOT be changed;the spec is across 2 indexes hence comma seperated
myindx="8,9"

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: storageclass.sh gen/fill"

fi

