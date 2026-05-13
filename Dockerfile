ARG BASE_IMAGE=ricwang/docker-wechat:base
FROM ${BASE_IMAGE}

ARG TARGETARCH
ARG WECHAT_DOWNLOAD_PAGE="https://linux.weixin.qq.com/"

COPY scripts/resolve-wechat-download.sh /usr/local/bin/resolve-wechat-download
RUN chmod +x /usr/local/bin/resolve-wechat-download

# 从微信 Linux 官网解析当前架构的 deb 链接并安装；腾讯下载源偶尔会断连，curl 需要显式重试。
RUN set -eux; \
    WECHAT_DEB_URL="$(resolve-wechat-download "${TARGETARCH:-}" "$WECHAT_DOWNLOAD_PAGE")"; \
    curl --fail --location --retry 5 --retry-delay 10 --retry-all-errors --connect-timeout 30 \
    --output /tmp/WeChatLinux.deb "$WECHAT_DEB_URL"; \
    APP_VERSION="$(dpkg-deb -f /tmp/WeChatLinux.deb Version)"; \
    dpkg -i /tmp/WeChatLinux.deb; \
    rm /tmp/WeChatLinux.deb; \
    set-cont-env APP_VERSION "$APP_VERSION"; \
    chmod -x /etc/cont-env.d/APP_VERSION

RUN echo '#!/bin/sh' > /startapp.sh && \
    echo 'exec /usr/bin/wechat' >> /startapp.sh && \
    chmod +x /startapp.sh

# 恢复 jlesage 基础镜像原有的符号链接（运行时 s6 init 需要通过这些
# 符号链接管理用户数据库，构建阶段临时替换为真实文件以支持 dpkg）
RUN rm -f /etc/passwd /etc/group /etc/shadow \
    && ln -s /tmp/.passwd /etc/passwd \
    && ln -s /tmp/.group /etc/group \
    && ln -s /tmp/.shadow /etc/shadow

VOLUME /root/.xwechat
VOLUME /root/xwechat_files
VOLUME /root/downloads
