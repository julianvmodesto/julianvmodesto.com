FROM caddy:2-alpine

COPY static /site
COPY Caddyfile /etc/caddy/Caddyfile
