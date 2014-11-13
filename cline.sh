clear;
echo '================================================================';
echo ' [LTMP/AMH4.2] iiAMH - AMH Web Service';
echo ' Tengine & Mariadb & PHP & AMH4.2 by homeii';
echo ' http://Amysql.com http://homeii.info';
echo '================================================================';
echo 'Command line installer - no interactive';
echo 'Please wait while installer is loading files...';
echo '================================================================';
sleep 1;
sh pipe.sh "$1" "$2" "$3" "$4" | sh amh.sh
