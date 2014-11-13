#!/bin/sh
Domain=`ifconfig  | grep 'inet addr:'| egrep -v ":192.168|:172.1[6-9].|:172.2[0-9].|:172.3[0-2].|:10.|:127." | cut -d: -f2 | awk '{ print $1}'`;
echo $1
if [ "$Domain" == '' ]; then
	echo $4
fi;
echo $2
echo $3
