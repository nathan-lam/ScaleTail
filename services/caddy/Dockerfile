FROM caddy:2-builder AS builder

# Build Caddy with the official Porkbun DNS module
RUN xcaddy build \
    --with github.com/caddy-dns/porkbun

FROM caddy:2

# Copy the custom compiled Caddy binary from the builder stage
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
