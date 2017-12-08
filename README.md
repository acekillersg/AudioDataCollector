# AudioDataCollector
This is a set of scripts to collect audio data from field sites and transfer them to host periodically.

# Prerequirement:
Before running the main script, you should
1. Add all new nodes' IPs into CHILD_IP_POOL array in main.sh file;
2. Change the HOST_USER_NAME and HOST_IP to the corresponding values according to your own configurations;
3. On the host node, use "ssh-keygen -t rsa" command to generate the private and public keys (please do not set password when generating these keys), and APPEND the public key to the end of authorised_keys files located in the children nodes' ~/.ssh/ folder by "cat ~/.ssh/id_rsa.pub | ssh CHILD_USER_NAME@CHILD_IP 'cat >> ~/.ssh/authorized_keys'" command;
4. Similarly, log into each local node, use "ssh-keygen -t rsa" command to generate its public and private keys (please do not set password when genering these keys), and APPEND the public key to end of authorised_keys file located in the host's ~/.ssh/ folder by "cat ~/.ssh/id_rsa.pub | ssh HOST_USER_NAME@HOST_IP 'cat >> ~/.ssh/authorized_keys'" command.

Done!!!

# Usage
Change to the directory containing scripts and execute ./main.sh help to find all available functions. Available functions are as follows.
- ./main.sh start: start the audio data collection on all field sites.
- ./main.sh stop: stop the audio data collection on all field sites.
- ./main.sh clear: clear all audio data on both host and field nodes.
- ./main.sh help: show this help menu.
