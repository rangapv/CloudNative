#!/bin/bash
#author: rangapv@yahoo.com 15-04-23

declare -A spec 
declare -A value 

spec[1]="apiVersion:"
value[1]="Version"
spec[2]="kind:"
value[2]="kind"
spec[3]="metadata:"
value[3]="Metadata For this kind"
spec[3.4]="name:"
value[3.4]="Name for this kind"
spec[3.5]="namespace:"
value[3.5]="Namespaces that you want this kind to be deployed"
spec[3.6]="labels:"
value[3.6]="labels for this type of kind"
spec[3.61]="type:"
value[3.61]="type definitions"
spec[3.62]="app:"
value[3.62]="app name to be referenced"
spec[4]="spec:"
value[4]="spec for the kind"
spec[4.1]="replicas:"
value[4.1]="Replicas"
spec[4.21]="metadata:"
value[4.21]="metadata for the container"
spec[4.2]="template:"
value[4.2]="template"
spec[4.211]="labels:"
value[4.211]="label"
spec[4.2111]="app:"
value[4.2111]="app name for the container"
spec[4.31]="spec:"
value[4.31]="Spec for the container"
spec[4.311]="containers:"
value[4.311]="Containers details"
spec[4.3111]="- name:"
value[4.3111]="Name of this Container"
spec[4.31112]="image:"
value[4.31112]="image tag"
spec[4.31113]="args:"
value[4.31113]="args that may be needed to for the container to start/run"
spec[4.31114]="ports:"
value[4.31114]="ports details"
spec[4.311141]="- containerPorts:"
value[4.311141]="containerports"
spec[4.31115]="volumeMounts:"
value[4.31115]="Mentions the Volumes in a COMMA seperated for the container mount points"
spec[4.311151]="- name:"
value[4.311151]="Name of the container mount points"
spec[4.3111512]="mountPath:"
value[4.3111512]="The container mount points"
spec[4.312]="volumes:"
value[4.312]="Volume details"
spec[4.3121]="- name:"
value[4.3121]="Name of the Volume(configMapName)"
spec[4.31211]="configMap:"
value[4.31211]="Configmap details"
spec[4.312111]="name:"
value[4.312111]="Name fo this Configmap"
spec[4.312112]="defaultMode:"
value[4.312112]="Config Map permissions"
spec[5]="spec:"
value[5]="spec for the kind PV"
spec[5.1]="storageClassName:"
value[5.1]="User defiend Name for the Storage Claim"
spec[5.2]="capacity:"
value[5.2]="Capacity details"
spec[5.21]="storage:"
value[5.21]="Mention the amount of Storage details"
spec[5.3]="accessModes:"
value[5.3]="The Access Modes that needs to be mentioned Read/Write/ReadWrite etc"
spec[5.4]="nfs:"
value[5.4]="The NEtwrok File Storage Details"
spec[5.41]="server:"
value[5.41]="The nfs server IP address"
spec[5.42]="path:"
value[5.42]="The NEtwrok File Storage path"
spec[5.5]="resources:"
value[5.5]="The resource Details"
spec[5.51]="requests:"
value[5.51]="The requests Details"
spec[5.511]="storage:"
value[5.511]="The storage Details(Mb/Gb)"
spec[6]="spec:"
value[6]="spec for the kind Service"
spec[6.1]="selector:"
value[6.1]="selector details for the kind Service"
spec[6.11]="app:"
value[6.11]="App name for the selector for the kind Service"
spec[6.2]="type:"
value[6.2]="Type for the kind Service(ClusterIP,NodePort)"
spec[6.3]="ports:"
value[6.3]="Port mapping details for the Service"
spec[6.31]="- port:"
value[6.31]="Port mapping details for the Service"
spec[6.32]="targetPort:"
value[6.32]="The traget Port Number for the Service"
spec[6.33]="nodePort:"
value[6.33]="The NodePort number for the Service"
