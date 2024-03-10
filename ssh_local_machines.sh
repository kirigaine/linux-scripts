#!/bin/bash

# THIS SCRIPT DEPENDS ON MANUAL INPUTTING STATIC IPS IN LOCAL FILE
# NEED TO CREATE MACHINES.JSON WITH FOLLOW FORMAT TO YOUR CREDENTIALS
#{
#  "machine_name": {
#	"hostname": "192.168.1.109",
#	"username": "user"
#}


JSON_FILE="machines.json"
function ssh_local_machines(){
	local machine_name=$1
	local hostname=$(jq -r ".$machine_name.hostname" "$JSON_FILE")
	local username=$(jq -r ".$machine_name.username" "$JSON_FILE")
	ssh "$username"@"$hostname"
}

# Check if a machine name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <machine_name>"
    exit 1
fi

ssh_local_machines "$1"

# WILL MAKE ITERATABLE LIST USER CAN PROVIDE QUICK INPUT FOR WHICH ONE TO ACCESS
