gcloud auth login
gcloud config set project OCP-3-11

bastion station ssh-keys copy

ssh-keygean -t rsa

gcloud compute project-info add-metadata --metadata-from-file sshKeys=./Users/faisalmasood/.ssh/id_rsa_gcp.pub