#!/bin/bash

set -E

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(labels )
#array values that needs to be skipped fromt eh database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
skippv=( )


pvfile="scr.yaml"
pvvfile="scv.yaml"
myindx="8,9"

if [[ "$1" == "gen" ]]
then
	source "../../gen.sh" "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	source "../../gen.sh" "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: service-generator.sh gen/fill"

fi
