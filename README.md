# **useful-scripts**  

## **setup**  
Contains useful and very simple scripts "Keep It Simple!" for setup written for Ubuntu 20.04 (focal), should work in 18.04 (beaver). Use at your own risk! If it does not run, do "chmod +x script.sh" in your shell.  
  
### code.sh  
Installs Visual Studio Code. Our preferred IDE.  
  
### docker.sh  
Installs Docker community edition, containerd and all needful. Also allows run docker with other users besides root and expose docker API via TCP for localhost on port 2375.  
### kvm.sh  
Installs KVM QEMU needed for Minikube, there are other virtualization options you can utilize. I recommend KVM because is fully open source! It also install everything to make you capable to create virtual machine if you want to play around. Just run "virt-manager" and you will have a gtk graphical interface easy to go to create your VM's.  
### minikube.sh  
Installs Minikube and run it for the first time with docker driver.  
  