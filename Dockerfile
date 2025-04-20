FROM caddy:2.9.1-builder-alpine AS builder

RUN rm -rf /usr/local/go
RUN wget -O/tmp/go1.24.2.linux-amd64.tar.gz "https://go.dev/dl/go1.24.2.linux-amd64.tar.gz"
RUN tar -C /usr/local -xzf /tmp/go1.24.2.linux-amd64.tar.gz


RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/caddyserver/certmagic@b9399eadfbe7ac3092f4e65d45284b3aabe514f8 \
    --with github.com/caddyserver/caddy@9becf61a9f5bafb88a15823ce80c1325d3a30a4f



FROM --platform=$BUILDPLATFORM lucaslorentz/caddy-docker-proxy:2.9.1-alpine
COPY --from=builder /usr/bin/caddy /bin/caddy


LABEL keepimg=true
