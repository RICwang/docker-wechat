# docker-wechat
在docker里运行wechat，可以通过web或者VNC访问wechat

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
