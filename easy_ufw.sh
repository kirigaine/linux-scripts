#!/bin/bash

echo "***** EASY UFW --- by: kirigaine *****"
echo "NOTE: May need to run with sudo or as root user, use caution"
echo "NOTE: AT ANY TIME LEAVE PROMPTS BLANK TO EXIT PROGRAM, or CRTL-C"
if command -v ufw &> /dev/null; then

	# Setup generic defensive firewall rules with SSH access
	echo "- Default denying incoming traffic"
	ufw default deny incoming
	echo "- Default allowing outgoing traffing"
	ufw default allow outgoing
	echo "- Only allowing SSH on local IPs"
	ufw allow from 192.168.1.0/24 to any port 22

	# Only allow ports (0-65535 inclusive) and tcp or udp for protocol
	port_regex="^[0-9]{1,5}$"
	protocol_regex="^(tcp|udp){1}$"
	ufw_port=25565
	ufw_protocol='tcp'

	# Continue loop while input isn't empty
	while ! [ -z "$ufw_port" ] && ! [ -z "$ufw_protocol" ]; do
		read -p "Input desired port to allow: " ufw_port && read -p "TCP or UDP? (tcp/udp): " ufw_protocol
		# Trim port to first parameter for regex
		ufw_port="${ufw_port%% *}"
		# Convert protocol to lowercase and trim protocol to first parameter for regex
		ufw_protocol="${ufw_protocol,,}" && ufw_protocol="${ufw_protocol%% *}"
		# Check range of port and regex matches
		if [[ $ufw_port =~ $port_regex ]] && [ $ufw_port -lt 65536 ] && [ $ufw_port -ge 0 ] && [[ $ufw_protocol =~ $protocol_regex ]]; then
			ufw allow $ufw_port/$ufw_protocol
		# If input is empty, exit script
		elif [ -z "$ufw_port" ] && [ -z "$ufw_protocol" ]; then
			echo "- Thank you for using EASY UFW."
			ufw status
		else
			# Notify user of invalid input on failed regex(s)
			echo "- Invalid input. Please keep ports in range 0-65535 and ensure you supply tcp or udp for protocol."
		fi
	done
else
	# In case of command -v failing, leave to user discretion to install
	echo "- ufw could not be found on this system. Try 'apt-get install ufw' or respective command for your distro"
fi
