#!/bin/bash

set -E

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(namespace labels annotations)
#array values that needs to be skipped from the database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
skippv=( )

#The YAMl file name for this resource ; this can be changed
pvfile="nsr.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="nsv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ;
myindx="0"

if [[ "$1" == "gen" ]]
then
        # source /home/ubuntu/cn/generator/gen.sh "gen" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	#source /home/ubuntu/cn/generator/gen.sh "fill" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: ns-generator.sh gen/fill"

fi

