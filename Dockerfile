FROM parity/tools:latest
COPY entrypoint.sh /
CMD chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
