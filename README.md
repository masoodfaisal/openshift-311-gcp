# OCP on GCP
This repo provides scripts to install Red Hat Openshift on GCP from scratch.

It uses gcloud to provision infrastructure on GCP too.

# Customizations

WIP

# Using BYO RHEL image

Follow instructions on [2.4. Creating a Red Hat Enterprise Linux Base Image](https://access.redhat.com/documentation/en-us/reference_architectures/2018/html/deploying_and_managing_openshift_3.9_on_google_cloud_platform/red_hat_openshift_container_platform_prerequisites#creating_a_red_hat_enterprise_linux_base_image).

**Note:** the `qcow2->raw` image conversion using qemu-img won't work if done on MacOS (HomeBrew). It's best to create a `n1-standard-1` CentOS 7 VM to create the MI. The processing of the images will take a while (10Gb per image).
