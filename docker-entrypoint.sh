#!/bin/sh
set -e

# init
if [ ! -f /var/lib/clamav/main.cvd ]; then
  freshclam
fi

# start fresh daemon, check for update 6 times per day
freshclam -d -c 6

# start clamav daemon
clamd
