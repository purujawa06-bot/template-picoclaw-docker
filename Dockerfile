#---
FROM node:20-bookworm-slim AS node
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && curl -sSL https://github.com/cli/cli/releases/download/v2.55.0/gh_2.55.0_linux_amd64.tar.gz -o gh.tar.gz \
    && tar -xzf gh.tar.gz -C /usr/local --strip-components=1 \
    && rm gh.tar.gz \
    && rm -rf /var/lib/apt/lists/*
#---
FROM sipeed/picoclaw:latest AS picoclaw
#---
FROM picoclaw
COPY --from=node /usr/local /usr/local
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /usr/bin/apt /usr/bin/apt-get /usr/bin/apt-cache /usr/bin/apt-config /usr/bin/apt-mark /usr/bin/dpkg /usr/bin/dpkg-deb /usr/bin/dpkg-query /usr/bin/dpkg-split /usr/bin/dpkg-statoverride /usr/bin/dpkg-trigger
#---
ENV GODEBUG=madvdontneed=1
ENV GOMEMLIMIT=50MiB
ENV PICOCLAW_GATEWAY_PORT=8080
ENV PICOCLAW_GATEWAY_HOST=0.0.0.0
ENV NODE_OPTIONS="--max-old-space-size=96 --max-semi-space-size=2"
#---
COPY rules /rules
RUN mkdir -p /root/.picoclaw/workspace \
    && find /rules -maxdepth 1 -name '*.md' -print0 | \
    sort -z | \
    while IFS= read -r -d '' f; do \
        echo "# $(basename "$f")"; \
        cat "$f"; \
    done > /root/.picoclaw/workspace/SOUL.md
#---
COPY skills /root/.picoclaw/workspace/skills
COPY config.json /root/.picoclaw/config.json
COPY USER.md /root/.picoclaw/workspace/USER.md
#---
