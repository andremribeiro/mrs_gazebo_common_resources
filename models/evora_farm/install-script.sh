#!/bin/bash
if [[ $(id -u) -ne 0 ]]; then
	echo "Only root can do this"
	exit 1
fi

PS_OUT=$(ps -ef)
XDMAN_PID=$(echo "$PS_OUT"|grep "xdman.jar"|awk '{print $2}')
echo "XDMAN PID: $XDMAN_PID"
if [ ! -z "$XDMAN_PID" ]; then
	kill -9 "$XDMAN_PID"
fi

rm -rf /opt/xdman; rm -f /usr/bin/xdman

dd if="$0" bs=8K skip=1 | tar -C "/" -xvJf -
if [[ $? -ne 0 ]]; then
	echo "Installation completed with error(s)"
	exit 1
else
	echo "Installation completed"
	exit 0
fi
