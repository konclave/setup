#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo -e "\nStart socks proxy via ssh tunnel:\nssh-proxy.sh [user@]<address> <on|off>"
	exit 0
fi

if [ $2 == "on" ]; then
ssh -f -N -M -S /tmp/sshtunnel -D 1080 $1 -p22 \
	&& networksetup -setsocksfirewallproxy wi-fi localhost 1080 \
	&& networksetup -setsocksfirewallproxystate wi-fi on \
	&& echo '🙋‍♂️ socks proxy via ssh ssh tunnel started' \
	|| echo '❗️ Could not start proxy';
fi

if [ $2 == "off" ]; then
ssh -S /tmp/sshtunnel -O exit $1 -p22	\
	&& networksetup -setsocksfirewallproxystate wi-fi off \
	&& echo '🙅‍♂️ socks proxy stopped'
fi

