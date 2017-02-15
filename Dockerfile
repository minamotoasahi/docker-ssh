# 使用的基础镜像
FROM ubuntu:14.04

# 添加作者信息
MAINTAINER jiulong chjiulong@126.com

# 安装SSH服务
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

# 取消pam登录限制
RUN sed -ri 's/session    required    pam_loginuid.so/#session    required    pam_loginuid.so/g' /etc/pam.d/sshd

# 添加认证文件和启动脚本
ADD authorized_keys /root/.ssh/authorized_keys
RUN echo "#!/bin/bash" > /root/run.sh
RUN echo "/usr/sbin/sshd -D" >> /root/run.sh
RUN chmod u+x /root/run.sh

# 导出端口
EXPOSE 22

# 设置默认的启动命令
CMD ["/root/run.sh"]
