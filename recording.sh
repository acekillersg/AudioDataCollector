#!/bin/bash

# host node information
HOST_USER_NAME='zijian'
HOST_IP='192.168.0.172'
HOST_EXE_PATH='/home/'$HOST_USER_NAME'/recording'
HOST_DATA_PATH=$HOST_EXE_PATH/data

# child nodes  information
CHILD_USER_NAME='pi'
CHILD_IP=$(/sbin/ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)
CHILD_EXE_PATH='/home/'$CHILD_USER_NAME'/recording'
CHILD_DATA_PATH=$CHILD_EXE_PATH/data/

cd $CHILD_DATA_PATH

# file name should not be empty; time and synchronization intervals should be integers
count=0
while :
  do
      NOW=$(date +"%Y%m%d%H%M%S")
      arecord -D "plughw:1,0" -d $1 $NOW'.wav'
      # only transfer non-existing audio files to remote host
      if [[ $count -lt $2 ]]; then
	  count=$((count+1))
      else
          rsync -raz --ignore-existing $CHILD_DATA_PATH $HOST_USER_NAME@$HOST_IP:$HOST_DATA_PATH/$CHILD_IP
          count=0
      fi
  done
