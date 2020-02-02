#!/bin/sh
# 
# https://github.com/hosac | hosac@gmx.net
# 

# Start service
if [ -e /etc/init.d/snapclient ]
then
	/etc/init.d/snapclient enable
	/etc/init.d/snapclient start
	rm /etc/uci-defaults/set-snapclient-enabled.sh
fi