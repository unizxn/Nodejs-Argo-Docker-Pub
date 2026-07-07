# 1. 切换为基于 Debian 的轻量级 Node 镜像，确保 .so 文件和原生二进制的 glibc 兼容
FROM node:20-slim

WORKDIR /tmp
COPY . .
EXPOSE 3000/tcp

# 2. 将原作者的 Alpine (apk) 安装命令替换为 Debian (apt-get)
# 移除了在 Debian 下不需要的 gcompat 兼容包
# 增加了 ca-certificates 确保网络连接和证书验证正常
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        openssl \
        curl \
        iproute2 \
        coreutils \
        bash \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x index.js && \
    npm install

CMD ["node", "index.js"]
