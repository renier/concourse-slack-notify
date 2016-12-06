FROM alpine:latest

RUN apk add --no-cache bash curl jq

COPY notify.sh /usr/bin/notify
COPY check.sh /opt/resource/check
COPY in.sh /opt/resource/in
COPY out.sh /opt/resource/out
RUN chmod +x /opt/resource/out /opt/resource/in /opt/resource/check
