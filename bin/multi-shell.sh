#!/bin/sh

SOCKDIR=$(mktemp -d)
SOCKF=${SOCKDIR}/usock
shell=

NICECAP=$(date +"Connection Established:\n>%h %d - %I%M%p")
WHEN=$(date +"Captured-%h%d-%I%M%p")


# Create Screen Session
screen -d -m -S $WHEN socat UNIX-LISTEN:${SOCKF},umask=0077 STDIO
/opt/bin/discord.sh

# Wait for socket
while test ! -e ${SOCKF} ; do sleep 1 ; done

# Use socat to ship data between the unix socket and STDIO.
exec socat STDIO UNIX-CONNECT:${SOCKF}
