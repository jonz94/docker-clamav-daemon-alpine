FROM alpine:3.11.3

LABEL maintainer="jonz94 <jody16888@gmail.com>"

# add edge main repository
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories

# install clamav & clamav-libunrar (for scan rar files)
RUN apk add --no-cache clamav@edge clamav-libunrar@edge

# make clamav running directory
RUN mkdir -p /run/clamav && chown clamav:clamav /run/clamav

EXPOSE 3310/tcp

VOLUME ["/etc/clamav", "/var/lib/clamav"]

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

COPY conf/clamd.conf /etc/clamav
COPY conf/freshclam.conf /etc/clamav

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
