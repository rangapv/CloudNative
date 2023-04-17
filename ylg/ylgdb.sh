#!/bin/bash
#author: rangapv@yahoo.com 15-04-23

declare -A spec
declare -A value

spec[2]="apiVersion:"
value[2]="Version"
spec[3]="kind:"
value[3]="kind"
spec[4]=metadata:
value[4]="Metadata"
spec[4.4]=name:
value[4.4]="Name"
spec[4.5]=namespace:
value[4.5]="Namespaces"
spec[5.1]=replicas:
value[5.1]="Replicas"
spec[5]=spec:
value[5]="spec"
spec[5.21]=metadata:
value[5.21]="metadata"
spec[5.2]=template:
value[5.2]="template"
spec[5.211]=labels:
value[5.211]="label"
spec[5.2111]=app:
value[5.2111]="apps"
spec[5.31]=spec:
value[5.31]="Spec"
spec[5.311]=containers:
value[5.311]="COntainers"
spec[5.3111]="- name:"
value[5.3111]="Name"
spec[5.31112]=image:
value[5.31112]="image"
spec[5.31113]=args:
value[5.31113]="args"
spec[5.31114]=ports:
value[5.31114]="ports"
spec[5.311141]="- containerPorts:"
value[5.311141]="containerports"
