FROM klakegg/hugo:0.74.3-alpine AS hugo

COPY blog /src

RUN hugo

FROM caddy:2-alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY static /site
COPY --from=hugo /src/public /site/blog
