FROM debian:stretch-slim as build

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --yes curl

ARG URL=https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz
RUN curl -L $URL | tar xzvf - --strip-components=1
RUN X=1 ls -l

FROM scratch

COPY --from=build oauth2_proxy /
ENTRYPOINT ["/oauth2_proxy"]
