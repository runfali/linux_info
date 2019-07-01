在 /etc/profile 中加入以下脚本
#history
USER_IP=`who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`  
HISTDIR=/var/log/.history
if [ -z $USER_IP ];then
    USER_IP=`hostname`
fi
if [ ! -d $HISTDIR ];then
    mkdir -p $HISTDIR
    chmod 777 $HISTDIR
fi
if [ ! -d $HISTDIR/${LOGNAME} ];then
    mkdir -p $HISTDIR/${LOGNAME}
    chmod 300 $HISTDIR/${LOGNAME}
fi
export HISTSIZE=4000
DT=`date +%Y%m%d_%H%M%S`
export HISTFILE="$HISTDIR/${LOGNAME}/${USER_IP}.history.$DT"
export HISTTIMEFORMAT="[%Y.%m.%d %H:%M:%S]"
chmod 600 $HISTDIR/${LOGNAME}/*.history* 2>/dev/null

在 /etc/bashrc 中加入几个环境变量,用于 history 命令显示用户 ip 等内容
#history
USER_IP=`who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`
HISTFILESIZE=4000
HISTSIZE=4000
HISTTIMEFORMAT="%F %T ${USER_IP} `whoami` "
export HISTTIMEFORMAT