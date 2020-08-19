#!/bin/bash

# Check if you CPU supports KVM virtualization
retval=`egrep -c '(vmx|svm)' /proc/cpuinfo`

if [ $retval -eq 0 ];
    then
        printf "\n*** We sorry about that! But your CPU does NOT support KVM virtualization. ***\n\n"
    else
        sudo apt update
        sudo apt install cpu-checker
        sudo kvm-ok
        sudo apt install -y qemu-kvm \
            libvirt-daemon \
            libvirt-clients \
            bridge-utils \
            virt-manager
        sudo systemctl enable --now libvirtd
        sudo systemctl status libvirtd
        lsmod | grep -i kvm    
fi
