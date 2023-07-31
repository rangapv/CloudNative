#!/bin/bash

set -E

#The YAMl file name for this resource ; this can be changed
pvfile="configmap-grafa.yaml"
#The Values file name for this resource ; this can be changed
pvvfile="configmap-grafa-value.yaml"
#The starting Index in the database(ylgdb.sh) for this resource ; this CANNOT be changed
myindx="1,2,3(labels annotations),7(global alerting scrape_configs rule_files)"

if [[ "$1" == "gen" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "gen" "$pvfile" "$pvvfile" "$myindx"

elif [[ "$1" == "fill" ]]
then
	source <(curl -s https://raw.githubusercontent.com/rangapv/CloudNative/main/generator/gen.sh) "fill" "$pvfile" "$pvvfile" "$myindx"
else
	echo "usuage: cm-generator.sh gen/fill"

fi

