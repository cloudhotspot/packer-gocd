#!/bin/bash
# Configure settings
echo "$(sed -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server)" > /etc/default/go-server

# Start Agent
exec /usr/share/go-server/server.sh