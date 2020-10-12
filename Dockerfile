FROM alpine:latest
RUN apk add markdown curl jq
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
