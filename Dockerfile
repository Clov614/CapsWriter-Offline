# 使用 Ubuntu 作为基础镜像
FROM ubuntu:20.04

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 设置非交互式环境变量
ENV DEBIAN_FRONTEND=noninteractive

## 安装 tmux
#RUN apt-get update && \
#    apt-get install -y tmux && \
#    rm -rf /var/lib/apt/lists/*

# 安装项目所需的依赖
RUN apt-get update && \
    apt-get install -y python3.8 python3-pip && \
    pip3 install -r requirements-server.txt -i https://mirror.sjtu.edu.cn/pypi/web/simple && \
    apt-get install -y xclip && \
    rm -rf /var/lib/apt/lists/*

# 为 run.sh 添加执行权限
RUN chmod +x run_docker.sh

# 启动容器时执行 run.sh
CMD ["./run_docker.sh"]
