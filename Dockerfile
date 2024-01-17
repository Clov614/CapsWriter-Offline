# 第一阶段：构建阶段
FROM python:3.8 as builder

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 升级 pip
RUN pip install --no-cache-dir --upgrade pip

# 安装项目所需的依赖
RUN pip install --no-cache-dir -r requirements-server.txt -i https://mirror.sjtu.edu.cn/pypi/web/simple

# 安装 pyinstaller
RUN pip install --no-cache-dir pyinstaller

# 运行 pyinstaller 构建可执行文件
RUN pyinstaller build.spec

# 移动可执行文件和 models 文件夹到目标目录
RUN mv /app/dist/start_server /app/start_server
RUN mv /app/models /app/models

## 第二阶段：最小化的运行阶段
FROM alpine:3.14

# 设置工作目录
WORKDIR /app

# 从构建阶段复制应用程序
COPY --from=builder /app/start_server /app/start_server
COPY --from=builder /app/run.sh /app/run.sh
COPY --from=builder /app/models /app/models

# 启动容器时执行 run_docker.sh
CMD ["./start_server"]
