FROM golang:latest AS builder

ARG HUGO_VERSION=v0.92.2

WORKDIR /build

COPY . .

RUN go install github.com/gohugoio/hugo@${HUGO_VERSION} && \
	hugo

FROM nginx:latest

RUN rm -rf /usr/share/nginx/html

COPY --from=builder /build/public/ /usr/share/nginx/html
