#-----
FROM sipeed/picoclaw:latest

#-----
ENV GODEBUG=madvdontneed=1
ENV GOMEMLIMIT=50MiB
ENV PICOCLAW_GATEWAY_PORT=8080
ENV PICOCLAW_GATEWAY_HOST=0.0.0.0

#-----
WORKDIR /app
COPY config.json /app/.picoclaw/config.json

