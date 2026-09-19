FROM sipeed/picoclaw:latest

RUN apk add --no-cache github-cli git curl && \
    rm -rf /sbin/apk /etc/apk /lib/apk /var/cache/apk /var/lib/apk

ENV GODEBUG=madvdontneed=1
ENV GOMEMLIMIT=50MiB
ENV PICOCLAW_GATEWAY_PORT=8080
ENV PICOCLAW_GATEWAY_HOST=0.0.0.0

COPY config.json /root/.picoclaw/config.json
