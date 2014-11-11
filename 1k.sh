#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

clear;
echo '================================================================';
echo ' [LTMP/AMH4.2] iiAMH - AMH Web Service';
echo ' OneKey Installer';
echo '================================================================';
function InputDomain()
{
	if [ "$Domain" == '' ]; then
		echo 'Mirror List';
		echo '1. [China] GIT@OSC';
		echo '2. [US] GITHUB';
		read -p '[Notice] Please input mirror id:' Domain;
		[ "$Domain" == '' ] && InputDomain;
	fi;
	[ "$Domain" != '' ] && echo '[OK] IIAMH will download from mirror:' && echo $Domain;
}