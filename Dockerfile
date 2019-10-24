FROM alpine:3.10.3

LABEL maintainer="jonz94 <jody16888@gmail.com>"

# install clamav & clamav-libunrar (for scan rar files)
RUN apk add --no-cache clamav clamav-libunrar

# make clamav running directory
RUN mkdir -p /run/clamav && chown clamav:clamav /run/clamav

EXPOSE 3310/tcp

VOLUME ["/etc/clamav", "/var/lib/clamav"]

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

COPY conf/clamd.conf /etc/clamav
COPY conf/freshclam.conf /etc/clamav

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
