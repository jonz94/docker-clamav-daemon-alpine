FROM alpine:3.10.2

LABEL maintainer="jonz94 <jody16888@gmail.com>"

# install clamav & clamav-libunrar (for scan rar files)
RUN apk add --no-cache clamav clamav-libunrar

# make clamav running directory
RUN mkdir -p /run/clamav && chown clamav:clamav /run/clamav

EXPOSE 3310/tcp

VOLUME ["/etc/clamav", "/var/lib/clamav"]

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
