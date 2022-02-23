FROM golang:latest AS builder

ARG HUGO_VERSION=v0.92.2

WORKDIR /build

COPY . .

RUN go install github.com/gohugoio/hugo@${HUGO_VERSION} && \
	hugo

FROM nginx:latest

COPY --from=builder /build/public/* /var/lib/www/
