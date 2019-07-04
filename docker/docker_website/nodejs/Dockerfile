FROM centos:7
# 基于哪个镜像
MAINTAINER me info@chainedfinance.com
# 作者信息
ADD https://nodejs.org/dist/v8.10.0/node-v8.10.0-linux-x64.tar.xz .
# 使用 ADD 下载 nodejs 二进制包
RUN tar xvf node-v8.10.0-linux-x64.tar.xz && mv node-v8.10.0-linux-x64 /usr/local/node-v8.10.0
# 使用 RUN 安装解包 nodejs 二进制包并剪切到对应位置
RUN ln -sf /usr/local/node-v8.10.0/bin/node /usr/local/bin/ && ln -sf /usr/local/node-v8.10.0/bin/npm /usr/local/bin/ && npm install -g pm2 && ln -sf /usr/local/node-v8.10.0/bin/pm2 /usr/local/bin/
# 设置 nodejs 的软连接
# 使用 docker build -t nodejs_8.10 . 构建镜像