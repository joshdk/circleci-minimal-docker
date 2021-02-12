FROM alpine:3.8 as bundler

RUN apk add --no-cache \
      busybox=1.28.4-r0 \
      git=2.18.0-r0 \
      openssh-client=7.7_p1-r2

RUN wget --quiet https://download.docker.com/linux/static/stable/x86_64/docker-18.06.0-ce.tgz \
 && tar -xf docker-18.06.0-ce.tgz \
 && install docker/docker /usr/bin

COPY bundler /bin/

RUN bundler /bundle \
      /bin/sh \
      /usr/bin/docker \
      /usr/bin/git \
      /usr/bin/ssh

FROM scratch

COPY --from=bundler /bundle/ /

CMD ["/bin/sh"]
