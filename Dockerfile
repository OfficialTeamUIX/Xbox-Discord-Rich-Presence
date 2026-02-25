ARG GO_VERSION=1.24
FROM golang:${GO_VERSION}-alpine AS builder

WORKDIR /src
RUN apk add --no-cache git ca-certificates

COPY xbdStats-go/go.mod xbdStats-go/go.sum ./xbdStats-go/
WORKDIR /src/xbdStats-go
RUN go mod download

WORKDIR /src
COPY . .

WORKDIR /src/xbdStats-go

ARG TARGETOS
ARG TARGETARCH

RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH:-amd64} \
    go build -trimpath -ldflags="-s -w" -o /out/xbdStats .

FROM alpine:3.20
RUN apk add --no-cache ca-certificates && update-ca-certificates

WORKDIR /app
COPY --from=builder /out/xbdStats /app/xbdStats

EXPOSE 1101
EXPOSE 1102
EXPOSE 1103

RUN adduser -D -H -s /sbin/nologin appuser && chown -R appuser:appuser /app
USER appuser

ENTRYPOINT ["/app/xbdStats"]