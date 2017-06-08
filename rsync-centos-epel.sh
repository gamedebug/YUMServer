#!/bain/bash
##CentOS Rsync
YUM_SITE="rsync://mirrors.yun-idc.com/centos/"
LOCAL_PATH="/var/www/html/centos/"
#LOCAL_VER=''
LOCK_FILE="/var/log/yum_server.pid"
RSYNC_PATH=""

MY_PID=$$
if [ -f $LOCK_FILE ]; then
get_pid=`/bin/cat $LOCK_FILE`
get_system_pid=`/bin/ps -ef|grep -v grep|grep $get_pid|wc -l`
if [ $get_system_pid -eq 0 ] ; then
echo $MY_PID>$LOCK_FILE
else
echo "Have update yum server now!"
exit 1
fi
else
echo $MY_PID>$LOCK_FILE
fi
 
if [ -z $RSYNC_PATH ]; then
RSYNC_PATH=`/usr/bin/whereis rsync|awk ' ''{print $2}'`
if [ -z $RSYNC_PATH ]; then
echo 'Not find rsync tool.'
echo 'use comm: yum install -y rsync'
fi
fi
 
#for VER in $LOCAL_VER;
#do

#if [ ! -d "$LOCAL_PATH$VER" ] ; then
#echo "Create dir $LOCAL_PATH$VER"
#`/bin/mkdir -p $LOCAL_PATH$VER`
#fi

#echo "Start sync $LOCAL_PATH$VER"
$RSYNC_PATH -avrtH --delete --exclude "isos" --exclude-from './centos-exclude.txt' $YUM_SITE$VER $LOCAL_PATH
#done
 
`/bin/rm -f $LOCK_FILE`
 
echo "rsync end $(date +%Y-%m-%d_%k:%M:%S)" >> /var/www/html/centos/centos_rsync_is_end.txt
exit 1

##Epel Rsync
YUM_SITE1="rsync://mirrors.yun-idc.com/epel/"
LOCAL_PATH1="/var/www/html/epel/"
#LOCAL_VER1=''
LOCK_FILE1="/var/log/epel_rsync.pid"
RSYNC_PATH1=""

MY1_PID=$$
if [ -f $LOCK_FILE1 ]; then
get_pid=`/bin/cat $LOCK_FILE`
get_system_pid=`/bin/ps -ef|grep -v grep|grep $get_pid|wc -l`
if [ $get_system_pid -eq 0 ] ; then
echo $MY1_PID>$LOCK_FILE1
else
echo "Have update yum server now!"
exit 1
fi
else
echo $MY1_PID>$LOCK_FILE1
fi
 
if [ -z $RSYNC_PATH1 ]; then
RSYNC_PATH1=`/usr/bin/whereis rsync|awk ' ''{print $2}'`
if [ -z $RSYNC_PATH1 ]; then
echo 'Not find rsync tool.'
echo 'use comm: yum install -y rsync'
fi
fi
 
#for VER1 in $LOCAL_VER1;
#do

#if [ ! -d "$LOCAL_PATH1$VER1" ] ; then
#echo "Create dir $LOCAL_PATH1$VER1"
#`/bin/mkdir -p $LOCAL_PATH1$VER1`
#fi

#echo "Start sync $LOCAL_PATH1$VER1"
$RSYNC_PATH -avrtH --delete --exclude "isos" --exclude-from './epel-exclude.txt' $YUM_SITE1$VER1 $LOCAL_PATH1
#done
 
`/bin/rm -f $LOCK_FILE1`
 
echo "rsync end $(date +%Y-%m-%d_%k:%M:%S)" >> /var/www/html/epel/epel_rsync_is_end.txt
exit 1