FROM paritytech/tools:latest
RUN apk add markdown
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
