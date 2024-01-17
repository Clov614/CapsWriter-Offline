# 第一阶段：构建阶段
FROM python:3.8 as builder

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 安装项目所需的依赖
RUN pip install --no-cache-dir -r requirements-server.txt -i https://mirror.sjtu.edu.cn/pypi/web/simple

# 第二阶段：最小化的运行阶段
FROM python:3.8-slim

# 设置工作目录
WORKDIR /app

# 从构建阶段复制应用程序
COPY --from=builder /app /app

# 启动容器时执行 run_docker.sh
CMD ["./run_docker.sh"]
