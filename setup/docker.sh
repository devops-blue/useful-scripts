#!/bin/bash
sudo apt-get -y remove docker \
	docker-engine \
	docker.io \
	containerd \
	runc  

sudo apt-get update  

sudo apt-get -y install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common  

grep -rn /etc/apt -e "https://download.docker.com/linux/ubuntu"
retval=$?

if [ $retval -ne 0 ];
	then
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		sudo apt-key fingerprint 0EBFCD88
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) \
		stable"		
	else
		printf "\n*** Docker repository https://download.docker.com/linux/ubuntu already exists in /etc/apt ***\n\n"
fi

DOCKER_VERSION=`apt-cache madison docker-ce|awk {'print $3'}|grep "$(lsb_release -cs)"|head -n1`

sudo apt-get update
sudo apt-get install docker-ce=${DOCKER_VERSION} docker-ce-cli=${DOCKER_VERSION} containerd.io

sudo usermod -aG docker ${USER} && newgrp docker

sudo apt autoremove -y

sudo apt install -y net-tools

sudo sed -i 's+ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock+ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock -H tcp://127.0.0.1:2375+g' /lib/systemd/system/docker.service

sudo systemctl daemon-reload

sudo systemctl restart docker.service

sudo netstat -tapn|grep 2375

printf "\nBelow commands should run with your common user without need to utilize sudo or root user.\n\n"
docker run hello-world
printf "Listing images via CLI"
docker image ls
printf "\nListing images via API unix socket"
curl --unix-socket /var/run/docker.sock http:/v1.24/images/json
printf "\nListing images via API exposed on http"
curl http://127.0.0.1:2375/v1.24/images/json
