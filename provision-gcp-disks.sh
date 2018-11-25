#!/bin/bash



##########
# This script will provision GCP disks
# 3 disks for master nodes
# 2 disk for infra and app nodes each
# 3 disks for gluster
##########
set -e
gcloud config set project OCP-3-11

#create docker disks 3 master nodes
gcloud compute disks create "masternode1-docker" --size "50" --zone "asia-southeast1-a" --type "pd-standard" &
gcloud compute disks create "masternode2-docker" --size "50" --zone "asia-southeast1-b" --type "pd-standard" &
gcloud compute disks create "masternode3-docker" --size "50" --zone "asia-southeast1-c" --type "pd-standard" &

#create docker disks 3 infra nodes
gcloud compute disks create "infranode1-docker" --size "50" --zone "asia-southeast1-a" --type "pd-standard" &
gcloud compute disks create "infranode2-docker" --size "50" --zone "asia-southeast1-b" --type "pd-standard" &
gcloud compute disks create "infranode3-docker" --size "50" --zone "asia-southeast1-cc" --type "pd-standard" &

#create dockers disks for 2 app nodes
gcloud compute disks create "node1-docker" --size "50" --zone "asia-southeast1-a" --type "pd-standard" &
gcloud compute disks create "node2-docker" --size "50" --zone "asia-southeast1-b" --type "pd-standard" &

#wait for them to be provisioned
wait


#create gluster disks - we will start with 3 nodes gluster. 4 recommended.
gcloud compute disks create "infranode1-gluster" --size "50" --zone "asia-southeast1-a" --type "pd-standard" &
gcloud compute disks create "infranode2-gluster" --size "50" --zone "asia-southeast1-b" --type "pd-standard" &
gcloud compute disks create "infranode3-gluster" --size "50" --zone "asia-southeast1-c" --type "pd-standard" &

#wait for them to be provisioned
wait



