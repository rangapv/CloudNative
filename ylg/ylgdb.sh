#!/bin/bash
#author: rangapv@yahoo.com 15-04-23
#updated database by adding a field tag on 08-05-23

declare -A spec
declare -A value
declare -A tag

spec[1]="apiVersion:"
value[1]="Version"
tag[1]="1"
spec[2]="kind:"
value[2]="kind"
tag[2]="1"
spec[3]="metadata:"
value[3]="Metadata For this kind"
tag[3]="0"
spec[3.4]="name:"
value[3.4]="Name for this kind"
tag[3.4]="1"
spec[3.5]="namespace:"
value[3.5]="Namespaces that you want this kind to be deployed"
tag[3.5]="1"
spec[3.6]="labels:"
value[3.6]="labels for this type of kind"
tag[3.6]="0"
spec[3.61]="type:"
value[3.61]="type definitions"
tag[3.61]="1"
spec[3.62]="app:"
value[3.62]="app name to be referenced"
tag[3.62]="1"
spec[3.7]="annotations:"
value[3.7]="The list of annotations for this kind"
tag[3.7]="1"
spec[4]="spec:"
value[4]="spec for the kind Deployment"
tag[4]="0"
spec[4.1]="replicas:"
value[4.1]="Replicas"
tag[4.1]="1"
spec[4.3]="selector:"
value[4.3]="The selector details for the Pod if any"
tag[4.3]="0"
spec[4.31]="matchLabels:"
value[4.31]="The labels for the Pod to match"
tag[4.31]="0"
spec[4.311]="app:"
value[4.311]="The app name for the Pod to match"
tag[4.311]="1"
spec[4.5]="strategy:"
value[4.5]="The container deployment strategy for the Pod"
tag[4.5]="0"
spec[4.51]="rollingUpdate:"
value[4.51]="The update details for the Pod "
tag[4.51]="0"
spec[4.511]="maxSurge:"
value[4.511]="The max surge number for the Pod"
tag[4.511]="1"
spec[4.512]="maxUnavailable:"
value[4.512]="The max Unavailabe details for the Pod"
tag[4.512]="1"
spec[4.52]="type:"
value[4.52]="The strategy type for the Pod"
tag[4.52]="1"
spec[4.6]="template:"
value[4.6]="template"
tag[4.6]="0"
spec[4.61]="metadata:"
value[4.61]="metadata for the container"
tag[4.61]="0"
spec[4.611]="labels:"
value[4.611]="label"
tag[4.611]="0"
spec[4.6111]="app:"
value[4.6111]="app name for the container"
tag[4.6111]="1"
spec[4.71]="spec:"
value[4.71]="Spec for the container"
tag[4.71]="0"
spec[4.711]="initContainers:"
value[4.711]="The init container details for the Pod if any"
tag[4.711]="0"
spec[4.811]="- name:"
value[4.811]="The name for the init container"
tag[4.811]="1"
spec[4.8111]="image:"
value[4.8111]="The init container image"
tag[4.8111]="1"
spec[4.8112]="command:"
value[4.8112]="The command to be executed for the init container"
tag[4.8112]="1"
spec[4.8113]="volumeMounts:"
value[4.8113]="The volume mounts for the init container"
tag[4.8113]="0"
spec[4.8114]="- name:"
value[4.8114]="Name of the volume mount in init container in the format mountpoints;mountpath "
tag[4.8114]="1"
spec[4.81141]="mountPath:"
value[4.81141]="The mountpath for the volume mount of init container"
tag[4.81141]="0"
spec[4.911]="containers:"
value[4.911]="Containers details"
tag[4.911]="0"
spec[4.9111]="- name:"
value[4.9111]="Name of this Container"
tag[4.9111]="1"
spec[4.91112]="image:"
value[4.91112]="image tag"
tag[4.91112]="1"
spec[4.91113]="args:"
value[4.91113]="args that may be needed to for the container to start/run"
tag[4.91113]="1"
spec[4.91114]="ports:"
value[4.91114]="ports details"
tag[4.91114]="0"
spec[4.911141]="- containerPort:"
value[4.911141]="containerports"
tag[4.911141]="1"
spec[4.91115]="volumeMounts:"
value[4.91115]="Mentions the Volumes in a COMMA seperated for the container mount points"
tag[4.91115]="0"
spec[4.911151]="- name:"
value[4.911151]="Name of the container mount points;mountpath"
tag[4.911151]="1"
spec[4.9111511]="mountPath:"
value[4.9111511]="The container mount points"
tag[4.9111511]="0"
spec[4.912]="volumes:"
value[4.912]="Volume details"
tag[4.912]="0"
spec[4.9121]="- name:"
value[4.9121]="Name of the Volume(configMapName)"
tag[4.9121]="1"
spec[4.91211]="configMap:"
value[4.91211]="Configmap details"
tag[4.91211]="0"
spec[4.912111]="name:"
value[4.912111]="Name fo this Configmap;DefaultMode"
tag[4.912111]="1"
spec[4.912112]="defaultMode:"
value[4.912112]="Config Map permissions"
tag[4.912112]="0"
spec[4.9122]="- name:"
value[4.9122]="Name of the Volume(PersistentVolumeClaim)"
tag[4.9122]="1"
spec[4.91221]="persistentVolumeClaim:"
value[4.91221]="Header of the Volume(PersistentVolumeClaim)"
tag[4.91221]="0"
spec[4.912211]="claimName:"
value[4.912211]="The Claim name of PersistentVolumeClaim"
tag[4.912211]="1"
spec[5]="spec:"
value[5]="spec for the kind PV/PVC"
tag[5]="0"
spec[5.1]="storageClassName:"
value[5.1]="User defined Name for the Storage Class"
tag[5.1]="1"
spec[5.2]="capacity:"
value[5.2]="Capacity details"
tag[5.2]="0"
spec[5.21]="storage:"
value[5.21]="Mention the amount of Storage details"
tag[5.21]="1"
spec[5.3]="accessModes:"
value[5.3]="The Access Modes that needs to be mentioned Read/Write/ReadWrite etc"
tag[5.3]="0"
spec[5.31]="-"
value[5.31]="The Access Modes Value needs to be mentioned Read/Write/ReadWrite etc"
tag[5.31]="1"
spec[5.4]="nfs:"
value[5.4]="The NEtwrok File Storage Details"
tag[5.4]="0"
spec[5.41]="server:"
value[5.41]="The nfs server IP address"
tag[5.41]="1"
spec[5.42]="path:"
value[5.42]="The NEtwrok File Storage path"
tag[5.42]="1"
spec[5.5]="csi:"
value[5.5]="The csi details for the Storage"
tag[5.5]="0"
spec[5.51]="driver:"
value[5.51]="The Driver details for the Storage"
tag[5.51]="1"
spec[5.52]="volumeHandle:"
value[5.52]="The volume handle details for the Storage(mandatory)"
tag[5.52]="1"
spec[5.7]="resources:"
value[5.7]="The resource Details"
tag[5.7]="0"
spec[5.71]="requests:"
value[5.71]="The requests Details"
tag[5.71]="0"
spec[5.711]="storage:"
value[5.711]="The storage Details(Mb/Gb)"
tag[5.711]="1"
spec[6]="spec:"
value[6]="spec for the kind Service"
tag[6]="0"
spec[6.1]="selector:"
value[6.1]="selector details for the kind Service"
tag[6.1]="0"
spec[6.11]="app:"
value[6.11]="App name for the selector for the kind Service"
tag[6.11]="1"
spec[6.2]="type:"
value[6.2]="Type for the kind Service(ClusterIP/NodePort)"
tag[6.2]="1"
spec[6.3]="ports:"
value[6.3]="Port mapping details for the Service"
tag[6.3]="0"
spec[6.4]="- port:"
value[6.4]="Port mapping details for the Service"
tag[6.4]="1"
spec[6.41]="targetPort:"
value[6.41]="The traget Port Number for the Service"
tag[6.41]="1"
spec[6.42]="nodePort:"
value[6.42]="The NodePort number for the Service"
tag[6.42]="1"
spec[7]="data:"
value[7]="spec of configmap for Prometheus data"
tag[7]="0"
spec[7.1]="prometheus.yml: |"
value[7.1]="The definition file"
tag[7.1]="0"
spec[7.11]="global:"
value[7.11]="The config header"
tag[7.11]="0"
spec[7.111]="scrape_interval:"
value[7.111]="The interval in which you need the metric to be scrapped"
tag[7.111]="1"
spec[7.112]="evaluation_interval:"
value[7.112]="The nterval in which you need the evaluation"
tag[7.112]="1"
spec[7.12]="alerting:"
value[7.12]="The alerting header"
tag[7.12]="0"
spec[7.121]="alertmanagers:"
value[7.121]="The alertmanagers header"
tag[7.121]="1"
spec[7.122]="- static_configs:"
value[7.122]="The static config header"
tag[7.122]="1"
spec[7.1221]="- targets:"
value[7.1221]="The target value header"
tag[7.1221]="1"
spec[7.13]="rule_files:"
value[7.13]="The rules file value"
tag[7.13]="1"
spec[7.14]="scrape_configs:"
value[7.14]="The scrap config values"
tag[7.14]="0"
spec[7.141]="- job_name:"
value[7.141]="The name of the job"
tag[7.141]="1"
spec[7.1411]="static_configs:"
value[7.1411]="The static config details"
tag[7.1411]="0"
spec[7.1412]="- targets:"
value[7.1412]="The Host&Port detail"
tag[7.1412]="1"
spec[8]="provisioner:"
value[8]="spec of provisioner for aws/gcp/azure"
tag[8]="1"
spec[9]="parameters:"
value[9]="spec parameters of provisioner for aws/gcp/azure"
tag[9]="0"
spec[9.1]="type:"
value[9.1]="The storage type for aws/gcp/azure"
tag[9.1]="1"
spec[10]="stringData:"
value[10]="Spec to hold access/secret keys"
tag[10]="0"
spec[10.1]="key_id:"
value[10.1]="Enter the  access key"
tag[10.1]="1"
spec[10.2]="access_key:"
value[10.2]="Enter the  secret key"
tag[10.2]="1"
