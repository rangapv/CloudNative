#!/bin/bash

set -E

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(annotations )
#array values that needs to be skipped fromt eh database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
skippv=(resources)

pvfile="pvr.yaml"
pvvfile="pvv.yaml"
myindx="5"

if [[ "$1" == "gen" ]]
then
	source "../../gen.sh" "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	source "../../gen.sh" "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: pv-generator.sh gen/fill"

fi
