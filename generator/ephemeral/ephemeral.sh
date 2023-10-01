#!/usr/bin/env bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="ec.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="ecv.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; this CANNOT be changed
myindx="1,2,3(labels),28(env envFrom volumeMounts volumeDevices resizePolicy securityContext seLinuxOptions windowsOptions)"

`>$pvfile`
`>$pvvfile`

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
        source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: service-generator.sh gen/fill"

fi

