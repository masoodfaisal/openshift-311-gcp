# This script will create
# statis addresses
# health checks
# target pools



# create static addresses
gcloud compute addresses create "master-external" --region "australia-southeast1" 

gcloud compute addresses create "infranode-external" --region "australia-southeast1" 

#gcloud compute addresses create "ose-bastion" --region "australia-southeast1" 
wait

# create health checks
gcloud compute health-checks create https master-health-check --port 8443 --request-path /healthz
gcloud compute health-checks create http router-health-check --port 80 --request-path /


# create target pools
gcloud compute target-pools create master-pool --region australia-southeast1 
gcloud compute target-pools create infranode-pool --region australia-southeast1 
wait

gcloud compute target-pools add-instances master-pool --instances master1 --instances-zone australia-southeast1-a &
gcloud compute target-pools add-instances master-pool --instances master2 --instances-zone australia-southeast1-b &
gcloud compute target-pools add-instances master-pool --instances master3 --instances-zone australia-southeast1-c &
gcloud compute target-pools add-instances infranode-pool --instances infranode1 --instances-zone australia-southeast1-a &
gcloud compute target-pools add-instances infranode-pool --instances infranode2 --instances-zone australia-southeast1-b &
gcloud compute target-pools add-instances infranode-pool --instances infranode3 --instances-zone australia-southeast1-c &
wait


gcloud compute instance-groups unmanaged create master1 --zone australia-southeast1-a 
gcloud compute instance-groups unmanaged create master2 --zone australia-southeast1-b 
gcloud compute instance-groups unmanaged create master3 --zone australia-southeast1-c 

gcloud compute instance-groups unmanaged add-instances master1 --instances master1 --zone australia-southeast1-a 
gcloud compute instance-groups unmanaged add-instances master2 --instances master2 --zone australia-southeast1-b 
gcloud compute instance-groups unmanaged add-instances master3 --instances master3 --zone australia-southeast1-c 

gcloud beta compute backend-services create master-internal --load-balancing-scheme internal --region australia-southeast1 --protocol tcp --health-checks master-health-check
gcloud beta compute backend-services add-backend master-internal --instance-group master1 --instance-group-zone australia-southeast1-a --region australia-southeast1
gcloud beta compute backend-services add-backend master-internal --instance-group master2 --instance-group-zone australia-southeast1-b --region australia-southeast1
gcloud beta compute backend-services add-backend master-internal --instance-group master3 --instance-group-zone australia-southeast1-c --region australia-southeast1



gcloud compute forwarding-rules create master-external --region australia-southeast1 --ports 8443 --address `gcloud compute addresses list | grep master-external | awk '{print $3}'` --target-pool master-pool 
gcloud compute forwarding-rules create infranode-external-443 --region australia-southeast1 --ports 443 --address `gcloud compute addresses list | grep infranode-external | awk '{print $3}'` --target-pool infranode-pool 
gcloud compute forwarding-rules create infranode-external-80 --region australia-southeast1 --ports 80 --address `gcloud compute addresses list | grep infranode-external | awk '{print $3}'`  --target-pool infranode-pool 
gcloud beta compute forwarding-rules create master-internal --load-balancing-scheme internal --ports 8443 --region australia-southeast1 --backend-service master-internal 


gcloud compute firewall-rules create "oc-master" --allow tcp:8443 --network "default" --source-ranges "0.0.0.0/0" --target-tags "master"
gcloud compute firewall-rules create "oc-infranode" --allow tcp:80,tcp:443 --network "default" --source-ranges "0.0.0.0/0" --target-tags "infranode"


export GCLOUD_PROJECT=ocp-3-11-223704
export DNS_DOMAIN=rhtlabs.com
if [ `gcloud dns managed-zones list | grep $DNS_DOMAIN | wc -l` -ne 1  ]; then
gcloud dns managed-zones create --dns-name="$DNS_DOMAIN" --description="A zone" "$GCLOUD_PROJECT"
fi

# add records to dns zone
gcloud dns record-sets transaction start -z="$GCLOUD_PROJECT"
gcloud dns record-sets transaction add -z="$GCLOUD_PROJECT" --name="master.$DNS_DOMAIN" --type=A --ttl=300 `gcloud compute addresses list | grep master-external | awk '{print $3}'`
gcloud dns record-sets transaction add -z="$GCLOUD_PROJECT" --name="*.apps.$DNS_DOMAIN" --type=A --ttl=300 `gcloud compute addresses list | grep infranode-external | awk '{print $3}'`
gcloud dns record-sets transaction add -z="$GCLOUD_PROJECT" --name="master-internal.$DNS_DOMAIN" --type=A --ttl=300 `gcloud compute forwarding-rules list master-internal | awk 'NR>1 {print $3}'`
gcloud dns record-sets transaction add -z="$GCLOUD_PROJECT" --name="mi.$DNS_DOMAIN" --type=A --ttl=300 `gcloud compute forwarding-rules list master-internal | awk 'NR>1 {print $3}'`
gcloud dns record-sets transaction execute -z="$GCLOUD_PROJECT"