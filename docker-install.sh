#!/bin/bash

# 注：
#     1、不建议以root用户来安装docker，应以拥有sudo权限的普通用户来安装；
#     2、本脚本适用于CentOS 7，其他操作系统供参考；
#     3、本脚本参考自：https://zhuanlan.zhihu.com/p/35705290，感谢原作者。

# 作者：笨笨阿林
# 日期：20210912
# 版本：1.0.0

# step 1：移除旧版本的docker
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine \
                docker-ce
sudo rm -rf /etc/systemd/system/docker.service.d
# 如果原先在宿主机上安装、使用过Docker，需删除之前的docker镜像、容器、卷或自定义配置文件等，则可加上下面这两句
# 注意：如果你不知道这意味着什么，请慎用！
#sudo rm -rf /var/lib/docker
#sudo rm -rf /var/run/docker

# step 2：安装相关必备组件和配置yum源为国内源以加快下载速度
sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# step 3：缓存安装包
sudo yum makecache fast

# step 4：执行安装
# 注：默认安装docker最新stable版，如需要特定版本，请自行指定，如：sudo yum install -y docker-ce-18.06.0.ce-3.el7
sudo yum install -y docker-ce

# step 5：配置docker镜像源为国内源以加快下载速度
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://hub-mirror.c.163.com"]
}
EOF
sudo systemctl daemon-reload

# step 6：启动docker并设置为开机启动
sudo systemctl start docker
sudo systemctl enable docker

# step 7：设置当前用户的docker命令执行权限
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl restart docker

# step 8：安装docker-compose
sudo yum install -y https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y docker-compose
sudo ln -s /usr/bin/docker-compose /usr/local/bin/docker-compose
