XX-Net
=================

翻墙工具套件，克隆自： [https://github.com/XX-net/XX-Net](https://github.com/XX-net/XX-Net)。这里添加 Docker 应用创建方法。关于 XX-Net 的使用细节请参考原作者提供的[中文文档](https://github.com/XX-net/XX-Net/wiki/%E4%B8%AD%E6%96%87%E6%96%87%E6%A1%A3).


## 使用

安装 [docker](https://docs.docker.com/engine/installation/)，然后进入项目目录，执行以下命令创建 docker 镜像：

> docker build -t huoty/xx-net .

`data`文件夹内保存了appid、ip、配置等信息，可以将 `data/gae_proxy/config.ini`  文件中的 `appid` 配置项改为自己的 appid 之后再创建镜像，这样就不用每次启动时都打开浏览器添加 appid.

镜像创建默认会将官方的源替换为阿里云的源，如果不需要可以将相应的内容注释掉。

容器中会添加开源项目 [tini](https://github.com/krallin/tini)。众所周知，docker容器没有 init 进程，这样在使用 docker 时可能就会存在一些问题，而 tini 则相当于是 init 进程，让所有启动的进程都成为它的子进程，进程停止后它再进程回收，避免出现僵尸进程。

镜像创建完成后，执行如下命令启动容器：

docker run -d -p 8085:8085 -p 8087:8087 huoty/xx-net

XX-Net 会开启两个端口，8085 用于管理 XX-Net 应用，8087 为代理端口，将这两个端口映射到本地，这样便可在本地访问。


## 管理 XX-Net

建议使用 supervisor 来管理 XX-Net 的容器应用。在 `gedit /etc/supervisor/conf.d/` 目录下创建 `docker-xx-net.conf` 文件，填入内容如下：

```
[program:xx-net]
;directory=/opt/XX-Net ; 程序的启动目录
command=docker run -d -p 8085:8085 -p 8087:8087 huoty/xx-net 
; 启动命令，可以看出与手动在命令行启动的命令是一样的
autostart=false    ; 在 supervisord 启动的时候也自动启动
startsecs=5        ; 启动 5 秒后没有异常退出，就当作已经正常启动了
autorestart=true   ; 程序异常退出后自动重启
startretries=5     ; 启动失败自动重试次数，默认是 3
;user=root          ; 用哪个用户启动
;redirect_stderr = true  ; 把 stderr 重定向到 stdout，默认 false

; 日志文件，需要注意当指定目录不存在时无法正常启动，所以需要手动创建目录（supervisord 会自动创建日志文件）
stdout_logfile=/home/huoty/.logs/xx-net.log
stdout_logfile_backups=10
stdout_logfile_maxbytes=10MB
stderr_logfile=/home/huoty/.logs/xx-net.log
stderr_logfile_maxbytes=10MB
stderr_logfile_backups=10
loglevel=info
 
; 可以通过 environment 来添加需要的环境变量，一种常见的用法是修改 PYTHONPATH
; environment=PYTHONPATH=$PYTHONPATH:/path/to/somewhere
```

这样便可以用 supervisor 来管理 xx-net 容器应用。


## 帮助 XX-Net 项目

[https://github.com/XX-net/XX-Net/wiki/How-to-contribute](https://github.com/XX-net/XX-Net/wiki/How-to-contribute)

