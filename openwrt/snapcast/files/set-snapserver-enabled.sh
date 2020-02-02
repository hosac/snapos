#!/bin/sh
# 
# https://github.com/hosac | hosac@gmx.net
# 

# Start service
if [ -e /etc/init.d/snapserver ]
then
	/etc/init.d/snapserver enable
	/etc/init.d/snapserver start
	rm /etc/uci-defaults/set-snapserver-enabled.sh
fi