#!/bin/bash
dbname='ma'
#数据库名
dbuser='root'
#对这个数据库有权限的用户
dbpassword='mo@#mysql2018'
#数据库用户的密码
backup_dir='/home/mysql_data/data'
#要备份到哪个目录
backup_log='/home/mysql_data/logs/mysql_backup_log.log'
#备份的信息输出到指定日志，如成功或者失败
ymtime=`date +%Y-%m`
#定义时间，这里是年月的格式
dtime=`date +%d`
#定义时间，这里是日

wlog(){
  echo -e "`date "+%F %T"` DBname: $1 State: $2\n" >> $backup_log
}
#定义输出什么内容到日志，date "+%F %T" 表示当前时间，$1 表示日志信息的第一个参数，$2 表示日志信息的第二个参数，这里可以把 wlog 理解为一个小的 shell 脚本

[ ! -d $backup_dir/$ymtime ] && mkdir -p $backup_dir/$ymtime
#判断以当前年月命名的目录是否存在，不存在则创建以当前年月命名的目录


cd $backup_dir/$ymtime && /usr/bin/innobackupex --user=$dbuser --password=$dbpassword --no-timestamp $dbname > /dev/null 2>&1
#开始备份，先进入以当前年月命名的目录下，然后使用 innobackupex 备份，--user 指定数据库用户名，--password 指定数据库密码，如果不加 --no-timestamp 的话会在备份目录下生成一个备份时间的目录，备份数据存在该目录下，因为我们这里是要自定义，所以不加

if [ $? -eq 0 ];then
#linux 可以使用 echo $? 来判断，之前执行的命令是否执行成功，执行成功则会输出 0，所以我们这就直接判断 $? 的输出是否为 0
  wlog $dbname 'Backup success.'
  #这里就引用了上面所定义的 wlog 了，其中 $dbname 代入到 $1 的位置，Backup success. 代入到 $2 的位置
  dbakfile=$dbname.$dtime.tar.gz
  #定义最终备份出来的包的名字
  tar zcf $dbakfile $dbname --remove-files
  #这里使用 tar 来把备份的文件打包，同时使用 --remove-files 参数实现一边打包一边删除源文件
  [ $? -eq 0 ] && wlog $dbakfile 'Packaging success.' || wlog $dbakfile 'Packaging failed.'
  #这里还再次利用 $0 的作用，判断是否打包成功，打包成功则输出打包成功的信息到日志，失败则输出失败信息
else
  wlog $dbname 'Backup failed.'
  #这里跟 if 是一对，假如上面 if 中判断 $? 不为 0，则直接输出错误信息到日志
fi
#最后写个循环，判断是否备份成功，并把信息追加到日志