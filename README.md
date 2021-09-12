## docker一键安装脚本(docker-install-sh)


### 说明

1、不建议以root用户来安装docker，应以拥有sudo权限的普通用户来安装；

2、本脚本适用于CentOS 7，其他操作系统供参考；

3、本脚本参考自：https://zhuanlan.zhihu.com/p/35705290，感谢原作者。
   
   
### 执行脚本

执行本脚本时不要再加sudo(因为本脚本中的命令前已经加过sudo了)，直接按以下命令执行即可。

`sh install_docker.sh`

该过程可能需要几分钟到十几分钟不等，安装完成后关闭当前shell会话，然后再重新打开一个新会话重登系统即可。


### 验证是否安装成功

可运行Docker官方的hello-world镜像来验证是否正确安装：

`$ sudo docker run hello-world`

如果出现类似如下信息，说明Docker安装正确：

![image](https://user-images.githubusercontent.com/9190887/132998854-10bd021a-17ec-4fcb-9a76-86901726e43e.png)

