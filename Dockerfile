FROM sipeed/picoclaw:latest

ENV GODEBUG=madvdontneed=1
ENV GOMEMLIMIT=50MiB
ENV PICOCLAW_GATEWAY_PORT=8080
ENV PICOCLAW_GATEWAY_HOST=0.0.0.0

COPY rules /rules

RUN mkdir -p /root/.picoclaw/workspace \
    && find /rules -maxdepth 1 -name '*.md' -print0 | \
    sort -z | \
    while IFS= read -r -d '' f; do \
        echo "# $(basename "$f")"; \
        cat "$f"; \
    done > /root/.picoclaw/workspace/SOUL.md

COPY config.json /root/.picoclaw/config.json
COPY USER.md /root/.picoclaw/workspace/USER.md
