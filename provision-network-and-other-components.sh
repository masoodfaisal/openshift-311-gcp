# This script will create
# statis addresses
# health checks
# target pools



# create static addresses
gcloud compute addresses create "master-external" --region "asia-southeast1" &

gcloud compute addresses create "infranode-external" --region "asia-southeast1" &

gcloud compute addresses create "ose-bastion" --region "asia-southeast1" &
wait

# create health checks
gcloud compute health-checks create https master-health-check --port 8443 --request-path /healthz
#gcloud compute health-checks create http router-health-check --port 80 --request-path /


# create target pools
gcloud compute target-pools create master-pool --region asia-southeast1 &
gcloud compute target-pools create infranode-pool --region asia-southeast1 &
wait

gcloud compute target-pools add-instances master-pool --instances master1 --instances-zone asia-southeast1-a &
gcloud compute target-pools add-instances master-pool --instances master2 --instances-zone asia-southeast1-b &
gcloud compute target-pools add-instances master-pool --instances master3 --instances-zone asia-southeast1-c &
gcloud compute target-pools add-instances infranode-pool --instances infranode1 --instances-zone asia-southeast1-a &
gcloud compute target-pools add-instances infranode-pool --instances infranode2 --instances-zone asia-southeast1-b &
gcloud compute target-pools add-instances infranode-pool --instances infranode3 --instances-zone asia-southeast1-c &
wait
