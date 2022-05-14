ARG ALPINE_VERSION=3.15.4
FROM gautada/alpine:$ALPINE_VERSION as final

LABEL source="https://github.com/gautada/nginx-container.git"
LABEL maintainer="Adam Gautier <adam@gautier.org>"
LABEL description="An nginx container"

USER root
WORKDIR /

EXPOSE 80/tcp
EXPOSE 443/tcp

ARG NGINX_VERSION=1.20.2
ARG NGINX_PACKAGE="$NGINX_VERSION"-r1
RUN /sbin/apk add --no-cache nginx=$NGINX_PACKAGE

RUN /bin/echo "%wheel         ALL = (ALL) NOPASSWD: /usr/sbin/nginx" >> /etc/sudoers

COPY 10-entrypoint.sh /etc/entrypoint.d/10-entrypoint.sh

ARG USER=nginx
VOLUME /opt/%USER
# nginix group & user is already created
# && /usr/sbin/addgroup $USER \
# && /usr/sbin/adduser -D -s /bin/ash -G $USER $USER \
RUN /bin/mkdir -p /opt/$USER \
 && /usr/sbin/usermod -aG wheel $USER \
 && /bin/echo "$USER:$USER" | chpasswd \
 && /bin/chown $USER:$USER -R /opt/$USER
 
USER $USER
WORKDIR /home/$USER

