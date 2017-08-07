FROM alpine:3.6
MAINTAINER Frederic Leger <frederic@webofmars.com>

# install need packages
RUN apk upgrade --no-cache && \
    apk add --no-cache openssh-server openssh-client

# create the ssh users
ENV SSHUSERS="jump"
RUN for i in $SSHUSERS; do \
        adduser -g "" -s /bin/ash -D $i && \
        sed -e "s/$i:.:/$i:*:/" -iback /etc/shadow; \
    done

# add s6
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && rm /tmp/s6-overlay-amd64.tar.gz

# configuration
COPY etc/ /etc/
COPY ssh.template /ssh

ENTRYPOINT ["/init"]
CMD ["/usr/sbin/sshd", "-u0", "-De", "-f", "/etc/ssh/sshd_config"]

VOLUME /etc/ssh
EXPOSE 22
