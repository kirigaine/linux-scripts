#!/bin/bash

echo "***** EASY UFW --- by: kirigaine *****"
echo "At any time leave prompts blank to exit program, or CRTL-C"
if command -v ufw &> /dev/null; then

	echo "- Default denying incoming traffic"
	#ufw default deny incoming
	echo "- Default allowing outgoing traffing"
	#ufw default allow outgoing
	echo "- Only allowing SSH on local IPs"
	#ufw allow from 192.168.1.0/24 to any port 22

	port_regex="^[0-9]{1,5}$"
	protocol_regex="^(tcp|udp){1}$"
	ufw_port=25565
	ufw_protocol='t'	

	# Continue loop while input isn't empty
	while ! [ -z $ufw_port ] && ! [ -z $ufw_protocol ]; do
		read -p "Input desired port to allow: " ufw_port && read -p "TCP or UDP? (tcp/udp): " ufw_protocol
		# Convert protocol to lowercase for regex
		ufw_protocol="${ufw_protocol,,}"
		# Check range of port and regex matches
		if [[ $ufw_port =~ $port_regex ]] && [ $ufw_port -lt 65536 ] && [ $ufw_port -ge 0 ] && [[ $ufw_protocol =~ $protocol_regex ]]; then
			ufw allow $ufw_port/$ufw_protocol
		elif [ -z $ufw_port ] && [ -z $ufw_protocol ]; then
			echo "- Thank you for using EASY UFW."
			ufw status
		else
			echo "- Invalid input. Please keep ports in range 0-65535 and ensure you supply tcp or udp for protocol."
		fi
	done
else
	echo "ufw could not be found on this system. Try 'apt-get install ufw' or respective command for your distro"
fi
