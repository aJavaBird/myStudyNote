+ docker version
+ docker info
+ docker 命令 --help
+ docker images   镜像命令
+ docker search   搜索镜像
+ docker pull     下载镜像
+ docker run [可选参数] image    创建容器并启动  
&ensp;&ensp;可选参数包括:  
&ensp;&ensp;--name="xx"  容器名字  
&ensp;&ensp;-d  后台方式运行  
&ensp;&ensp;-it 交互式运行（启动并进入），其中exit退出并停止，Ctrl+P+Q退出不停止  
&ensp;&ensp;-p 主机端口:容器端口  
&ensp;&ensp;举例： docker run -d --name zhcNginx01 -p 3344:80 nginx
+ docker ps       查看有哪些容器正在运行
+ docker ps -a    列出正在运行容器+历史运行容器
+ docker rmi      删除镜像
+ docker rm 容器id     删除指定容器
+ docker rm -f $(docker ps -aq)    删除所有容器
+ docker start 容器id     启动容器
+ docker stop 容器id      停容器
+ docker kill 容器id      强制停容器
+ docker restart 容器id   重启容器
+ docker run -d 镜像名    发现没有前台应用访问会自动停止
+ docker logs -tf [--tail number]     查看日志
+ docker top 容器id
+ docker inspect 容器id      查看容器元数据
+ docker exec -it 容器id /bin/bash      进入正在运行的容器（重新打开一个终端）
+ docker attach 容器id                  进入正在运行的容器（使用原终端，不会新建）
+ docker cp 容器id:容器内文件 本机目录
> 作业：使用docker安装tomcat、nginx、es

