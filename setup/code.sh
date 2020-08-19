#!/bin/bash

grep -rn /etc/apt -e "https://packages.microsoft.com/repos/vscode stable main"
retval=$?

if [ $retval -ne 0 ];
	then
                curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
                sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'	
	else
		printf "\n*** Visual Studio Code repository https://packages.microsoft.com/repos/vscode stable main already exists in /etc/apt ***\n\n"
fi

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code
