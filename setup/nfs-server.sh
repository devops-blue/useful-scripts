#!/bin/bash

# need to run as root user. Change to run with any user (ToDo). Only utilize this configuration in your local network if it is a safe and private network. This configuration is supposing your docker is running on 172.*, and your local network is 192.*.

# Install nfs-kernel-server and useful tools
apt-get update
apt-get install nfs-kernel-server nfs-common nfs4-acl-tools nfstrace nfstrace-doc

mkdir -p /localhost/data
mkdir -p /localhost/app
chmod 777 -R /localhost

echo "/localhost/data 172.0.0.0/8(rw,async,anonuid=999,anongid=999,no_subtree_check) 192.0.0.0/8(rw,async,no_subtree_check)" >> /etc/exports
echo "/localhost/app 172.0.0.0/8(rw,async,anonuid=0,anongid=0,no_subtree_check) 192.0.0.0/8(rw,async,no_subtree_check)" >> /etc/exports

sudo exportfs -a
sudo systemctl restart nfs-kernel-server

sudo ufw status
sudo ufw allow from 172.0.0.0/8 to any port nfs
sudo ufw allow from 192.0.0.0/8 to any port nfs

minikube ssh
sudo apt-get update && sudo apt-get install nfs-common
sudo mkdir /localhost
sudo chmod 777 -R /localhost

# Replace mount below with your local IP, can't be 127.0.0.1 because minikube VM also has a loopback IP.
sudo mount 192.168.15.56:/localhost /localhost
mount|grep localhost