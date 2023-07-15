#!/bin/bash

set -E

#array values that needs to be skipped in the top section befor spec no entries means no values to skipp all present
#it is being called at checkspec in the pvgen function
skippm=(type annotations )
#array values that needs to be skipped fromt eh database in the spec section
#it is being called at function findp, pvfilyl(pvspec11) , pvfill(pvgen)
#NOTE in the below skippv array I have included defaultMode even though the Deployment needs this value! since while parsing I am entering the user values as pairs seperated by";" in the ConfigMap name Itself (check the filled dgv.yaml values file sample in the folder), hence do not have to repeat it. This is One-off
skippv=(mountPath defaultMode )


#The YAMl file name for this resource ; this can be changed
pvfile="dgr.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="dgv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; this CANNOT be changed
myindx="4,20,25,26"

if [[ "$1" == "gen" ]]
then
        #source /home/ubuntu/cn/generator/gen.sh "gen" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	#source /home/ubuntu/cn/generator/gen.sh "fill" "$pvfile" "$pvvfile" "$myindx"
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: deployment-generator.sh gen/fill"

fi

