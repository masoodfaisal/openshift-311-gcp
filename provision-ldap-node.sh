#!/bin/bash

##########
# This script will provision one GCP node for LDAP
# This ldap will be used to authenticate against OCP
# We will also use some custom groups and map them to 
# the OCP nodes.
##########

set -e
gcloud config set project ocp-3-11

# provision a non-HA ldap server
gcloud compute instances create "ldap-server" --zone "asia-southeast1-a" --machine-type "n1-standard-2" --subnet "default" --maintenance-policy "TERMINATE" --service-account default --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append","https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_write" --image-project "rhel-cloud" --image "rhel-7-v20181113" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "ldap-server" --tags "ldap-server" &

# TODO -  add ldap provisioning here.
# refer https://www.itzgeek.com/how-tos/linux/centos-how-tos/step-step-openldap-server-configuration-centos-7-rhel-7.html