#!/bin/bash
set -e

# TODO - fix for 3.11 rpms.

# Prepare Cluster 
ansible nodes -vvv -b -i hosts -m shell -a "yum install -y subscription-manager && subscription-manager clean"
ansible nodes -vvv -b -i hosts -m shell -a "subscription-manager register --username=$RHN_USERNAME --password=$RHN_PASSWORD && subscription-manager auto-attach && subscription-manager refresh"
#ansible nodes -b -i hosts -m shell -a "subscription-manager repos --disable='*' && subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-optional-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-ose-3.7-rpms --enable=rhel-7-fast-datapath-rpms"
ansible nodes -vvv -b -i hosts -m shell -a "subscription-manager repos --disable='*' && subscription-manager repos --disable=rhel-7-server-htb-rpms && subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-optional-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-ose-3.11-rpms --enable=rhel-7-fast-datapath-rpms --enable=rhel-7-server-ansible-2.6-rpms"
ansible nodes -vvv -b -i hosts -m shell -a "yum update -y && yum install -y docker wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct"

# check how do we do this in OCP 3.11
ansible masters -i hosts -vvv -b -m copy -a "src=./misc/advanced-audit/advanced-audit-policy.yaml dest=/etc/advanced-audit-policy.yaml"
ansible nodes -vvv -i hosts -b -m copy -a "src=docker-storage-setup dest=/etc/sysconfig/docker-storage-setup"

#this is non-idempotent - move it to last ?
ansible nodes -vvv -i hosts -b -m shell -a "yum install -y docker && docker-storage-setup"
ansible nodes -b -i hosts -vvv -m service -a "name=docker enabled=true state=started"
ansible nodes -b -i hosts -vvv -m shell -a "reboot"