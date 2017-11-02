FROM golang as build

RUN go get -d github.com/bitly/oauth2_proxy
WORKDIR /go/src/github.com/bitly/oauth2_proxy

COPY token.patch ./
RUN git apply token.patch
RUN CGO_ENABLED=0 go install

FROM scratch

COPY --from=build /go/bin/oauth2_proxy /
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/oauth2_proxy"]
