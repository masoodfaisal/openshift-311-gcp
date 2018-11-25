#!/bin/bash

#!/bin/bash

##########
# This script will provision GCP nodes
# 3 master nodes
# 3 infra and gluster nodes. Same nodes will be used for infra and gluster.
# 2 app nodes
##########

set -e
gcloud config set project OCP-3-11

# provision the master nodes
#Masters
gcloud compute instances create "master1" --zone "asia-southeast1-a" --machine-type "n1-standard-2" --subnet "default" --maintenance-policy "TERMINATE" --disk "name=masternode1-docker,device-name=docker-disk,mode=rw,boot=no" --service-account default --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append","https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_write" --image-project "rhel-cloud" --image "rhel-7-v20171129" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "master1" --tags "master" &
gcloud compute instances create "master2" --zone "asia-southeast1-b" --machine-type "n1-standard-2" --subnet "default" --maintenance-policy "TERMINATE" --disk "name=masternode2-docker,device-name=docker-disk,mode=rw,boot=no" --service-account default --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append","https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_write" --image-project "rhel-cloud" --image "rhel-7-v20171129" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "master2" --tags "master" &
gcloud compute instances create "master3" --zone "asia-southeast1-c" --machine-type "n1-standard-2" --subnet "default" --maintenance-policy "TERMINATE" --disk "name=masternode3-docker,device-name=docker-disk,mode=rw,boot=no" --service-account default --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append","https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_write" --image-project "rhel-cloud" --image "rhel-7-v20171129" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "master3" --tags "master" &
