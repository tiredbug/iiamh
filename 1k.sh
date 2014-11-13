#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
NDomain="";
Domain=`ifconfig  | grep 'inet addr:'| egrep -v ":192.168|:172.1[6-9].|:172.2[0-9].|:172.3[0-2].|:10.|:127." | cut -d: -f2 | awk '{ print $1}'`;
MysqlPass='';
AMHPass='';

clear;
echo '================================================================';
echo ' [LTMP/AMH4.2] iiAMH - AMH Web Service';
echo ' OneKey Installer';
echo '================================================================';
function InputMirror()
{
	if [ "$NDomain" == '' ]; then
		echo 'Please choose mirror from the Mirror List：';
		echo '1. [CN] GITCAFE';
		echo '2. [CN] GIT@OSC';
		echo '3. [US] GITHUB';
		read -p '>' NDomain;
		[ "$NDomain" == '' ] && InputDomain;
	fi;
	if [ "$NDomain" == '1' ]; then
		Durl="https://gitcafe.com/homeii/iiamh/archiveball/master/zip";
		Dmirror="[CN] GITCAFE"
	elif [ "$NDomain" == '2' ]; then
		Durl="http://git.oschina.net/home/iiamh/repository/archive?ref=master";
		Dmirror="[CN] GIT@OSC"
	elif [ "$NDomain" == '3' ]; then
		Durl="https://github.com/homeii/iiamh/archive/master.zip";
		Dmirror="[US] GITHUB"
	else
		echo "Mirror Error!";
		NDomain="";
		InputMirror;
	fi;
	[ "$NDomain" != '' ] && echo [OK] IIAMH will download from ${Dmirror};
	read -p 'Press any key to start.' AnyKey;
}
function InputDomain()
{
	if [ "$Domain" == '' ]; then
		echo '[Error] empty server ip.';
		read -p '[Notice] Please input server ip:' Domain;
		[ "$Domain" == '' ] && InputDomain;
	fi;
	[ "$Domain" != '' ] && echo '[OK] Your server ip is:' && echo $Domain;
}


function InputMysqlPass()
{
	read -p '[Notice] Please input MySQL password:' MysqlPass;
	if [ "$MysqlPass" == '' ]; then
		echo '[Error] MySQL password is empty.';
		InputMysqlPass;
	else
		echo '[OK] Your MySQL password is:';
		echo $MysqlPass;
	fi;
}


function InputAMHPass()
{
	read -p '[Notice] Please input AMH password:' AMHPass;
	if [ "$AMHPass" == '' ]; then
		echo '[Error] AMH password empty.';
		InputAMHPass;
	else
		echo '[OK] Your AMH password is:';
		echo $AMHPass;
	fi;
}

function Downloadfile()
{
	randstr=$(date +%s);

	if [ -s $1 ]; then
		echo "[OK] $1 found.";
	else
		echo "[Notice] $1 not found, download now......";
		if ! wget -c --tries=3 ${2}?${randstr} -O ${randstr}.tmp  ; then
			echo "[Error] Download Failed : $1, please check $2 ";
			exit;
		else
			mv ${randstr}.tmp $1;
		fi;
	fi;
}
InputDomain;
InputMysqlPass
InputAMHPass
InputMirror;
rm -rf iiamh.zip
rm -rf iiamh
Downloadfile iiamh.zip $Durl;
unzip iiamh.zip 
cd iiamh 
sh cline.sh "1" "$MysqlPass" "$AMHPass" "$Domain" 2>&1 | tee iiamh.log
echo "success!"