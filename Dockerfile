FROM alpine:latest

RUN apk add --no-cache curl

COPY notify.sh /usr/bin/notify

