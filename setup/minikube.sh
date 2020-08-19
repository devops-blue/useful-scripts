#!/bin/bash

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

minikube start --driver=docker
minikube status

kubectl get nodes
kubectl get all --all-namespaces

minikube stop
minikube delete

printf "\n*** Minikube was installed, cluster was started, tested with kukbectl, stopped, and the cluster was deleted. If you didn't see any ERROR, to start your minikube cluster again utilize \"minikube start --driver=docker --memory=2048\" Amount of memory in Megabytes e.g. 2048 = 2 Gigabytes of memory utilization from the host machine. ***\n\n"

printf "\n*** If you saw any ERRORS, please visit: https://kubernetes.io/docs/tasks/tools/install-minikube and search help on-line. ***\n\n"
