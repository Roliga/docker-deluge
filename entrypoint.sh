#!/bin/sh

# Kill the current process group on relevant signals, unbinding the TERM signal to prevent recursion
trap "trap - TERM && kill 0" INT EXIT TERM

# Start services in the background, and kill this process group if one of them exits
{ deluge-web -d -L info -c /etc/deluge/; kill 0; } &
{ deluged -d -L info -c /etc/deluge/; kill 0; } &

# Wait for all processes to exit, allowing traps to be handled
wait
