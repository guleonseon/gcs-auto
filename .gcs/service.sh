#!/bin/bash

###########################################################
###		This is a services script		###
###########################################################

LOCAL=$HOME/.gcs

if [[ ! -d $LOCAL/log ]]
then
  mkdir $LOCAL/log
fi

#frpc service
frpClient() {
LOG=$LOCAL/log/frpc.log
rm $LOG
PID=`pidof "frpc"`
if [[ $PID != ""  ]]
then
	kill -9 $PID > /dev/null 2>&1
	sleep 1
fi
nohup $LOCAL/bin/frpc -c $LOCAL/etc/frp/frpc.ini > $LOG 2>&1 &
}

#v2ray server service
v2rayServer() {
LOG=$LOCAL/log/v2ray-server.log
rm $LOG
PID=`ps aux |grep "v2ray-server"| awk '{print $2}'`
if [[ $PID != ""  ]]
then
	 kill -9 $PID > /dev/null 2>&1
	sleep 1
fi
nohup  $LOCAL/bin/v2ray/v2ray -config $LOCAL/etc/v2ray/v2ray-server.json > $LOG 2>&1 & 
}

#v2ray client service
v2rayClient() {
LOG=$LOCAL/log/v2ray-client.log
rm $LOG
PID=`ps aux |grep "v2ray-client"| awk '{print $2}'`
if [[ $PID != ""  ]]
then
	 kill -9 $PID > /dev/null 2>&1
	sleep 1
fi
nohup  $LOCAL/bin/v2ray/v2ray -config $LOCAL/etc/v2ray/v2ray-client.json > $LOG 2>&1 & 
}

frpClient && v2rayServer
