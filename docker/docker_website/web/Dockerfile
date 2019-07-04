FROM nodejs_8.10
# 基于哪个镜像
MAINTAINER me info@chainedfinance.com
# 作者信息
RUN mkdir -p /data/website
# 创建 web 项目目录
CMD cd /data/website && npm install --production && pm2 kill && sleep 10 && pm2 start server.js && tail -f /etc/passwd
# 使用 docker build -t cf_web . 构建镜像