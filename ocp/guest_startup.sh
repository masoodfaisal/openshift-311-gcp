#! /bin/bash

DNSZONE=
DNS_NAME=

EXTERNAL_IP=$(gcloud compute instances list --filter="name:${HOSTNAME}" --format="value(networkInterfaces[0].accessConfigs[0].natIP)")
DNS_IP=$(gcloud dns record-sets list --zone=${DNSZONE} --filter="name:${DNS_NAME}" --format="value(rrdatas[0])")

gcloud dns record-sets transaction abort --zone=${DNSZONE}
gcloud dns record-sets transaction start --zone=${DNSZONE}

if [ -n "${DNS_IP}" ]; then
  echo "removing current dns entry ${DNS_NAME} with IP ${DNS_IP}" 
  gcloud dns record-sets transaction remove ${DNS_IP} --name=${DNS_NAME} --ttl=300 --type=A --zone=${DNSZONE} 
fi;

gcloud dns record-sets transaction add ${EXTERNAL_IP} --name=${DNS_NAME} --ttl=300 --type=A --zone=${DNSZONE}
gcloud dns record-sets transaction execute --zone=${DNSZONE}
sleep 1
