FROM golang:1.13-alpine as build

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY cmd cmd
RUN go build -o bin/hello-world cmd/hello/main.go

FROM alpine:3.10
COPY --from=build /build/bin/hello-world /hello-world
RUN addgroup -S gogroup && \
    adduser -S gouser -G gogroup
USER gouser
CMD ["/hello-world"]