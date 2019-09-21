#!/bin/sh
set -e

# start fresh daemon, check for update 6 times per day
freshclam -d -c 6

# start clamav daemon
clamd &

# recognize PIDs
pidlist=$(jobs -p)

# initialize latest result var
latest_exit=0

# define shutdown helper
function shutdown() {
  trap "" SIGINT

  for single in $pidlist; do
    if ! kill -0 $single 2>/dev/null; then
      wait $single
      latest_exit=$?
    fi
  done

  kill $pidlist 2>/dev/null
}

# run shutdown
trap shutdown SIGINT
wait -n

# return received result
exit $latest_exit
