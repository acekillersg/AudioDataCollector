# AudioDataCollector
This is a set of scripts to collect audio data from field sites and transfer them to host periodically.

# Prerequirement:
Before running the main script, you should
1. Add all new nodes' IPs into CHILD_IP_POOL array in main.sh file;
2. Log into each local node, use "ssh-keygen -t rsa" command in terminal to generate its public and private keys (please do not set password when genering these keys), and APPEND the public key to end of authorised_keys file located in the host's ~/.ssh/ folder by "cat LOCAL_HOME/.ssh/id_rsa.pub >> HOST_HOME/.ssh/authorized_keys".
Done!!!

# Usage
Change to the directory containing scripts and execute ./main.sh help to find all available functions. Available functions are as follows.
- start: start the audio data collection on all field sites.
- stop: stop the audio data collection on all field sites.
- clear: clear all audio data on both host and field nodes.
- help: show this help menu.
