#!/bin/bash
PIDFILE=/tmp/ng-server.pid

if [ $SHLVL -ne 1 ]; then
	echo "WARNING: This script is supposed to be sourced, not executed." >&2
fi
if ! [ -f epic.rb ]; then
	echo "Run this script from the top level directory." >&2
	exit 1
fi
if [ -f "$PIDFILE" ]; then
	kill $(<"$PIDFILE")
	rm "$PIDFILE"
fi
export JRUBY_OPTS=$(
	echo -n $(
		for i in $JRUBY_OPTS; do
			echo $i;
		done | grep -v -- --ng
	)
)
