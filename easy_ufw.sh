#!/bin/bash

echo "***** EASY UFW --- by: kirigaine *****"
if command -v ufw &> /dev/null; then

	echo "- Default denying incoming traffic"
	#ufw default deny incoming
	echo "- Default allowing outgoing traffing"
	#ufw default allow outgoing
	echo "- Only allowing SSH on local IPs"
	#ufw allow from 192.168.1.0/24 to any port 22

	port_regex="^[0-9]{1,5}$"
	protocol_regex="^[t|u]{1}$"
	ufw_port=25565
	ufw_protocol='t'	

	# Ensure user input is numeric and within valid port ranges [0-65535]
	while ! [ -z $ufw_port ] && ! [ -z $ufw_protocol ]; do
		read -p "Input desired port to allow: " ufw_port && read -p "TCP or UDP? (t/u): " ufw_protocol
		[[ $ufw_port =~ $port_regex ]] && [ $ufw_port -lt 65536 ] && [ $ufw_port -ge 0 ] && [[ $ufw_protocol =~ $protocol_regex ]] && echo "Valid port and protocol. Implementing."
	done
else
	echo "ufw could not be found on this system. Try 'apt-get install ufw' or respective command for your distro"
fi
