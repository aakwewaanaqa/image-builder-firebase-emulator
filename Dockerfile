# 使用官方 Ubuntu 22.04 镜像
FROM ubuntu:22.04

# 设置非交互模式
ENV DEBIAN_FRONTEND=noninteractive

# 安装基础工具
RUN apt-get update && \
    apt-get install -y curl tar git && \
    rm -rf /var/lib/apt/lists/*

# 动态选择 JDK 架构 (构建时通过 --build-arg 指定)
ARG TARGETPLATFORM
ARG JDK_ARCH
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then  \
    export JDK_ARCH=linux-x64;  \
    else export JDK_ARCH=linux-aarch64;  \
    fi

RUN curl -L -o jdk.tar.gz \
    "https://download.oracle.com/java/24/latest/jdk-24_${JDK_ARCH}_bin.tar.gz" && \
    tar -xf jdk.tar.gz && \
    mv jdk-24* /jdk && \
    rm jdk.tar.gz
ENV PATH="/jdk/bin:${PATH}"

# 安装 Node.js 环境
RUN apt-get update && \
    apt-get install -y nodejs npm && \
    npm install -g firebase-tools n && \
    n lts

# 设置工作目录
WORKDIR /workspace

# 暴露 Firestore 模拟器端口
EXPOSE 1337 4000

# 初始化脚本
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
