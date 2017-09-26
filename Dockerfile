FROM alpine

RUN apk add --no-cache openssh-client git \
  && apk add --no-cache --virtual install curl

RUN curl "https://caddyserver.com/download/linux/amd64?plugins=http.git,tls.dns.cloudflare&license=personal" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

RUN apk del install

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins | grep http.git

EXPOSE 80 443 2015
VOLUME /root/.caddy /srv
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
