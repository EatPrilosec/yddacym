FROM caddy:2.9.1-builder-alpine AS builder

RUN rm -rf /usr/local/go
RUN wget -O/tmp/go1.24.2.linux-amd64.tar.gz "https://go.dev/dl/go1.24.2.linux-amd64.tar.gz"
RUN tar -C /usr/local -xzf /tmp/go1.24.2.linux-amd64.tar.gz


RUN xcaddy build master \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/caddyserver/caddy



FROM --platform=$BUILDPLATFORM lucaslorentz/caddy-docker-proxy:2.9.1-alpine
COPY --from=builder /usr/bin/caddy /bin/caddy


LABEL keepimg=true
