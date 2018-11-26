gcloud auth login
gcloud config set project OCP-3-11

bastion station ssh-keys copy

ssh-keygean -t rsa

gcloud compute project-info add-metadata --metadata-from-file sshKeys=/Users/faisalmasood/.ssh/id_rsa_gcp.pub
gcloud compute --project "ocp-3-11" ssh --zone "asia-southeast1-a" "ose-bastion"

gcloud compute images list

https://cloud.google.com/compute/docs/internal-dns

===
yum -y install openldap compat-openldap openldap-clients openldap-servers openldap-servers-sql openldap-devel

{SSHA}fgSCgjMIRV/dXTmZ3GW66JYgWf0UCqJH

use no-address for disable ephemeral external IP. https://cloud.google.com/sdk/gcloud/reference/compute/instances/create#--address


https://docs.openshift.com/container-platform/3.11/install/example_inventories.html

https://github.com/openshift/openshift-ansible/blob/master/inventory/hosts.example

https://access.redhat.com/articles/3560571


https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys



