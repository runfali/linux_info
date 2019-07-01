#!/bin/bash
# 安装常用组件
sleep 5
rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
yum install -y https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-7.rpm
curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker.repo
yum install -y lrzsz vim systemd bash-completion gcc cmake bzip2-devel curl-devel db4-devel libjpeg-devel libpng-devel freetype-devel libXpm-devel gmp-devel libc-client-devel openldap-devel unixODBC-devel postgresql-devel sqlite-devel aspell-devel net-snmp libxslt-devel libxml2-devel pcre-devel mysql-devel libmemcached libmemcached-devel zlib-devel tree htop net-tools openssl-devel.x86_64 gcc-c++.x86_64 iftop iotop lsof zabbix-agent nmap dos2unix telnet screen wget ntp rsync iptables-services docker-ce.x86_64 cifs-utils autossh openssh-clients openssh-server openssh

# 关闭 SElinux
echo "关闭 SElinux！"
sleep 5
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

# 关闭 firewalld 和 iptables
echo "关闭 firewalld 和 iptables！"
sleep 5
systemctl stop firewalld && systemctl disable firewalld && systemctl stop iptables && systemctl disable iptables


# 优化 ssh 连接
echo "优化 ssh 连接！"
sleep 5
sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config && sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config

# 修改最大文件打开数和最大进程数
echo "修改最大文件打开数和最大进程数！"
sleep 5
echo "* - nofile 65535" >> /etc/security/limits.conf
echo "* - nproc 65536" >> /etc/security/limits.conf
sed -i 's#4096#65536#g' /etc/security/limits.d/20-nproc.conf

# 修正系统时间
echo "修正系统时间并写入定时任务！"
sleep 5
(crontab -l;echo '*/10 * * * * /usr/sbin/ntpdate ntp1.aliyun.com && /usr/sbin/hwclock -w') | crontab
echo '*/10 * * * * root /usr/sbin/ntpdate ntp1.aliyun.com && /usr/sbin/hwclock -w' >> /etc/crontab


# 内核参数调优
echo "内核参数调优！"
sleep 5
cat >> /etc/sysctl.conf <<EOF
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.ip_local_port_range = 4000 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384
net.ipv4.tcp_max_orphans = 16384
net.netfilter.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_tcp_timeout_established = 180
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
EOF
sysctl -p >/dev/null 2>&1

# vim 编辑器优化
echo "vim 编辑器优化！"
sleep 5
cat > ~/.vimrc << EOF
" 显示行号
set number
" 高亮光标所在行
set cursorline
" 打开语法显示
syntax on
" 关闭备份
set nobackup
" 没有保存或文件只读时弹出确认
set confirm
" tab缩进
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
" 默认缩进4个空格大小 
set shiftwidth=4 
" 文件自动检测外部更改
set autoread
" 高亮查找匹配
set hlsearch
" 显示匹配
set showmatch
" 背景色设置为黑色
set background=dark
" 浅色高亮显示当前行
autocmd InsertLeave * se nocul
" 显示输入的命令
set showcmd
" 字符编码
set encoding=utf-8
" 开启终端256色显示
set t_Co=256
" 增量式搜索 
set incsearch
" 设置默认进行大小写不敏感查找
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase
" 不产生swap文件
set noswapfile
" 关闭提示音
set noerrorbells
" 历史记录
set history=10000
" 显示行尾空格
set listchars=tab:»■,trail:■
" 显示非可见字符
set list
" 检测文件类型
set paste
" 解决粘贴时会带有#号
filetype on
EOF

# 更新一下系统
echo "更新系统！"
sleep 5
yum update -y

# 重启系统
echo "重启系统！"
sleep 5
init 6