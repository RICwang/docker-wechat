# docker-wechat
在docker里运行wechat，可以通过web或者VNC访问wechat

# 环境变量
| 环境变量       | 描述                                  | 默认值 |
|----------------|----------------------------------------------|---------|
|`LANG`| 设置[区域设置](https://en.wikipedia.org/wiki/Locale_(computer_software))，用于定义应用程序的语言（**如果支持**）。区域设置的格式为`语言[_地区][.编码集]`，其中语言是[ISO 639语言代码](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)，地区是[ISO 3166国家代码](https://en.wikipedia.org/wiki/ISO_3166-1#Current_codes)，编码集是字符集，如`UTF-8`。例如，使用UTF-8编码的澳大利亚英语表示为`en_AU.UTF-8`。 | `en_US.UTF-8` |
|`TZ`| 容器使用的[时区](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)。时区也可以通过映射主机和容器之间的`/etc/localtime`来设置。 | `Asia/Shanghai` |
|`KEEP_APP_RUNNING`| 当设置为`1`时，如果应用程序崩溃或终止，将自动重启。 | `0` |
|`APP_NICENESS`| 应用程序运行的优先级。nice值-20是最高优先级，19是最低优先级。默认nice值为0。**注意**：负nice值（提高优先级）需要额外权限。在这种情况下，容器应使用docker选项`--cap-add=SYS_NICE`运行。 | `0` |
|`CONTAINER_DEBUG`| 设置为`1`启用调试日志。 | `0` |
|`DISPLAY_WIDTH`| 应用程序窗口的宽度（像素）。 | `1920` |
|`DISPLAY_HEIGHT`| 应用程序窗口的高度（像素）。 | `1080` |
|`DARK_MODE`| 当设置为`1`时，为应用程序启用深色模式。 | `0` |
|`WEB_AUDIO`| 当设置为`1`时，启用音频支持，意味着应用程序产生的任何音频都通过浏览器播放。注意VNC客户端不支持音频。 | `0` |
|`WEB_AUTHENTICATION`| 当设置为`1`时，通过网络浏览器访问应用程序GUI时需要通过登录页面进行保护。只有提供有效凭据才允许访问。**注意**：此功能需要启用安全连接（`SECURE_CONNECTION`环境变量）。 | `0` |
|`WEB_AUTHENTICATION_USERNAME`| Web认证的可选用户名配置。这是为单个用户配置凭据的快速简便方法。要以更安全的方式配置凭据或添加更多用户，请参见[Web认证](#web-authentication)部分。 | （无值） |
|`WEB_AUTHENTICATION_PASSWORD`| Web认证的可选密码配置。这是为单个用户配置凭据的快速简便方法。要以更安全的方式配置凭据或添加更多用户，请参见[Web认证](#web-authentication)部分。 | （无值） |
|`SECURE_CONNECTION`| 当设置为`1`时，使用加密连接访问应用程序的GUI（通过网络浏览器或VNC客户端）。更多详情请参见[安全](#security)部分。 | `0` |
|`SECURE_CONNECTION_VNC_METHOD`| 执行安全VNC连接的方法。可能的值为`SSL`或`TLS`。更多详情请参见[安全](#security)部分。 | `SSL` |
|`SECURE_CONNECTION_CERTS_CHECK_INTERVAL`| 系统验证Web或VNC证书是否已更改的间隔时间（秒）。当检测到更改时，受影响的服务会自动重启。值为`0`时禁用检查。 | `60` |
|`VNC_PASSWORD`| 连接到应用程序GUI所需的密码。更多详情请参见[VNC密码](#vnc-password)部分。 | （无值） |

# docker-compose.yml
```
services:
  wechat:
    image: ricwang/docker-wechat:latest
    container_name: wechat_container
    volumes:
      - <THE PATH>/.xwechat:/root/.xwechat
      - <THE PATH>/xwechat_files:/root/xwechat_files
      - <THE PATH>/downloads:/root/downloads
      - /dev/snd:/dev/snd
    ports:
      - "5800:5800"
      - "5900:5900"
    environment:
      - LANG=zh_CN.UTF-8
      - USER_ID=0
      - GROUP_ID=0
      - WEB_AUDIO=1
      - TZ=Asia/Shanghai
    privileged: true
```

# docker run
```
docker run -d \
 --name wechat_container_demo \
 -v <THE PATH>/.xwechat:/root/.xwechat \
 -v <THE PATH>/xwechat_files:/root/xwechat_files \
 -v <THE PATH>/downloads:/root/downloads \
 -v /dev/snd:/dev/snd \
 -p 5800:5800 \
 -p 5900:5900 \
 -e LANG=zh_CN.UTF-8 \
 -e USER_ID=0 \
 -e GROUP_ID=0 \
 -e WEB_AUDIO=1 \
 -e TZ=Asia/Shanghai \
 --privileged \
 ricwang/docker-wechat:latest
```

# 演示：
https://b23.tv/ihPZQaa  
https://youtu.be/1zqcNArcZBA

# Stars 🌟
<picture>
  <source
    media="(prefers-color-scheme: dark)"
    srcset="
      https://api.star-history.com/svg?repos=RICwang/docker-wechat&type=Date&theme=dark
    "
  />
  <img
    alt="Star History Chart"
    src="https://api.star-history.com/svg?repos=RICwang/docker-wechat&type=Date"
  />
</picture>
