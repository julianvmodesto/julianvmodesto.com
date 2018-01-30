FROM alpine

RUN apk add --no-cache --virtual install curl

RUN curl "https://caddyserver.com/download/linux/amd64?license=personal" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

RUN apk del install

# validate install
RUN /usr/bin/caddy -version

EXPOSE 8080
WORKDIR /srv

COPY static /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
