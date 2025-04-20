FROM caddy:2-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/caddy-dns/cloudflare



FROM --platform=$BUILDPLATFORM lucaslorentz/caddy-docker-proxy:2-alpine
COPY --from=builder /usr/bin/caddy /bin/caddy


LABEL keepimg=true
