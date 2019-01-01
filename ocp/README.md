# OCP on GCP
This repo provides scripts to install Red Hat Openshift on GCP from scratch.

It uses gcloud to provision infrastructure on GCP too.

# Customizations

WIP
- provision NFS on the ldap-server
- -- persistent volumes
install nfs server rhel 7
yum install nfs-utils rpcbind nfs4-acl-tools portmap nfs-utils-lib
mkdir /opt/nfs
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/5/html/Deployment_Guide/s1-nfs-server-config-exports.html
vi /etc/exports
/opt/nfs node1openshift.local(no_root_squash,rw,sync)
systemctl enable nfs-server
exportfs -avr
systemctl restart nfs-server

Each export must be:

/<example_fs> *(rw,all_squash)
Each export must be owned by nfsnobody:

chown -R nfsnobody:nfsnobody /<example_fs>
Each export must have the following permissions:

chmod 777 /<example_fs>

# setsebool -P virt_use_nfs 1

