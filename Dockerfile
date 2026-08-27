FROM sipeed/picoclaw:latest

ENV GODEBUG=madvdontneed=1
ENV GOMEMLIMIT=380MiB
