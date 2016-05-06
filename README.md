XX-Net
=================

翻墙工具套件，克隆自： [https://github.com/XX-net/XX-Net](https://github.com/XX-net/XX-Net)。这里添加 Docker 应用创建方法。

## 使用

安装 [docker](https://docs.docker.com/engine/installation/)，进入项目目录，执行以下命令：

> docker build -t huoty/xx-net .

`data`文件夹内保存了appid,ip,配置等信息，可以将 `data/gae_proxy/config.ini`  文件中的 `appid` 配置项改为自己的 appid 之后再创建镜像，这样就不用每次启动时都打开浏览器添加 appid.

镜像创建默认会将官方的源替换为阿里云的源，如果不需要可以将相应的内容注释掉。

容器中会添加开源项目 [tini](https://github.com/krallin/tini)。众所周知，docker容器没有 init 进程，这样在使用 docker 时可能就会存在一些问题，而 tini 则相当于是 init 进程，让所有启动的进程都成为它的子进程，进程停止后它再进程回收，避免出现僵尸进程。

关于 XX-Net 的更多使用细节请参考原作者提供的[中文文档](https://github.com/XX-net/XX-Net/wiki/%E4%B8%AD%E6%96%87%E6%96%87%E6%A1%A3).




## 帮助 XX-Net 项目

[https://github.com/XX-net/XX-Net/wiki/How-to-contribute](https://github.com/XX-net/XX-Net/wiki/How-to-contribute)

