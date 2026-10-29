FROM alpine:latest

# 安装必要工具并创建非特权用户
RUN apk add --no-cache wget tar && \
    adduser -D -h /app appuser

WORKDIR /app

# 下载并解压 sing-box 官方程序
RUN wget https://github.com/SagerNet/sing-box/releases/download/v1.10.1/sing-box-1.10.1-linux-amd64.tar.gz && \
    tar -zxvf sing-box-1.10.1-linux-amd64.tar.gz && \
    mv sing-box-1.10.1-linux-amd64/sing-box . && \
    rm -rf sing-box-1.10.1-linux-amd64*

# 复制配置文件并修改属主
COPY --chown=appuser:appuser config.json .

# 切换到非 root 用户
USER appuser

EXPOSE 8080
CMD ["./sing-box", "run", "-c", "config.json"]
