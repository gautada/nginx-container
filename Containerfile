ARG ALPINE_VERSION=3.15.4
FROM docker.io/gautada/alpine:$ALPINE_VERSION

LABEL source="https://github.com/gautada/nginx-container.git"
LABEL maintainer="Adam Gautier <adam@gautier.org>"
LABEL description="An nginx container"

USER root
WORKDIR /

EXPOSE 80/tcp

ARG NGINX_VERSION=1.20.2
ARG NGINX_PACKAGE="$NGINX_VERSION"-r1
RUN /sbin/apk add --no-cache nginx=$NGINX_PACKAGE

ARG USER=nginx
VOLUME /opt/%USER
RUN /bin/mkdir -p /opt/$USER \
 && /usr/sbin/addgroup $USER \
 && /usr/sbin/adduser -D -s /bin/ash -G $USER $USER \
 && /usr/sbin/usermod -aG wheel $USER \
 && /bin/echo "$USER:$USER" | chpasswd \
 && /bin/chown $USER:$USER -R /opt/$USER
 
USER $USER
WORKDIR /home/$USER

