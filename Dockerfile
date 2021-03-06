FROM golang:1.10.3 AS builder

WORKDIR /go/src/github.com/dtan4/k8stail
COPY . /go/src/github.com/dtan4/k8stail

RUN make deps

RUN CGO_ENABLED=0 make

FROM alpine:3.8

RUN apk add --no-cache --update ca-certificates

COPY --from=builder /go/src/github.com/dtan4/k8stail/bin/k8stail /k8stail

ENTRYPOINT ["/k8stail"]
