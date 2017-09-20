FROM alpine:3.6

RUN apk --no-cache add alpine-sdk coreutils cmake && \
  adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder && \
  echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  mkdir /packages && \
  chown builder:abuild /packages

COPY /files/build.sh /bin/
USER builder
WORKDIR /home/builder/package

ENV RSA_PRIVATE_KEY_NAME ssh.rsa
ENV PACKAGER_PRIVKEY /home/builder/.abuild/${RSA_PRIVATE_KEY_NAME}
ENV REPODEST /packages
ENV PACKAGER "msales (alpine@msales.com)"
VOLUME ["/home/builder/package"]

ENTRYPOINT ["build.sh"]
