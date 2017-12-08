#!/bin/bash

## Before running script, please manually add all child nodes IPs
## into CHILD_IP_POOL. After that, generate SSH public key at each
## child node and APPEND the public key to the authorized_keys file
## in the host's ~/.ssh/ folder.

# host node information
HOST_USER_NAME='zijian'
HOST_IP='192.168.0.172'
HOST_EXE_PATH='/home/'$HOST_USER_NAME'/recording'
HOST_DATA_PATH=$HOST_EXE_PATH/data

# remotely execute scripts on child nodes
CHILD_USER_NAME='pi'
CHILD_IP_POOL=("192.168.0.171")
CHILD_EXE_PATH='/home/'$CHILD_USER_NAME'/recording'
CHILD_DATA_PATH=$CHILD_EXE_PATH/data

if [[ "$@" == "help" ]]
then
	echo "Options:"
	echo "  start: start scripts on all child nodes."
	echo "  stop: stop scripts on all child nodes."
	echo "  clear: delete all existing audio data in data folders on all nodes."
	echo "  help: show this help menu."
elif [[ "$@" == "start" ]]
then
	echo "Starting!"
	echo 'Please set the recording time interval:'
	read t
	echo 'Please set the sychronization interval (in times of t):'
	read s

	if [[ ! $t =~ [0-9] ]] || [[ ! $s =~ [0-9] ]]; then
		echo -e 'Wrong setting, exiting!'
		exit
	fi

	for CHILD_IP in "${CHILD_IP_POOL[@]}"
	do
		mkdir -p $HOST_DATA_PATH/$CHILD_IP
		echo "Starting on "$CHILD_IP" node."

		# pass t and s as parameters to the script
		nohup ssh $CHILD_USER_NAME@$CHILD_IP 'bash -s' < recording.sh $t $s > logs.txt 2>&1 &
	done
elif [[ "$@" == "stop" ]]
then
	echo "Stopping!"
	for CHILD_IP in "${CHILD_IP_POOL[@]}"
	do
		echo "Stopping on "$CHILD_IP" node."
		nohup ssh $CHILD_USER_NAME@$CHILD_IP "ps -ef | grep "bash -s"|grep -v "grep"|awk '{print \$2}'| xargs kill -9" > logs.txt 2>&1 &
	done
elif [[ "$@" == "clear" ]]
then
	echo "Clearing!"
	echo "Clearing data on the host."
	rm -rf $HOST_DATA_PATH/*
	for CHILD_IP in "${CHILD_IP_POOL[@]}"
	do
		echo "Clearing on "$CHILD_IP" node."
		nohup ssh $CHILD_USER_NAME@$CHILD_IP "rm -rf $CHILD_DATA_PATH/*" > logs.txt 2>&1 &
	done
else
	echo "Wrong option, exiting!"
	exit
fi
