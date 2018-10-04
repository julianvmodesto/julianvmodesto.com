FROM alpine

RUN apk add --no-cache \
  --virtual install \
  curl && \
  curl "https://caddyserver.com/download/linux/amd64?license=personal&plugins=http.cache" | \
  tar --no-same-owner -C /usr/bin/ -xz caddy && \
  apk del install && \
  caddy -version

EXPOSE 8080
WORKDIR /srv

COPY static /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
