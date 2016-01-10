#!/bin/bash
# Update Docker GID
if [ -n "$DOCKER_GID" ]; then sudo groupmod -g $DOCKER_GID docker; fi

# Set GoCD Server
GO_SERVER=${GO_SERVER:-go-server}
echo "$(sed 's/GO_SERVER=.*/GO_SERVER='$GO_SERVER'/' /etc/default/go-agent)" > /etc/default/go-agent
echo "$(sed 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent)" > /etc/default/go-agent

# Set Agent Config settings
mkdir -p /var/lib/go-agent/config
rm -f /var/lib/go-agent/config/autoregister.properties
AGENT_KEY="${AGENT_KEY:-123456789abcdef}"
echo "agent.auto.register.key=$AGENT_KEY" > /var/lib/go-agent/config/autoregister.properties
if [ -n "$AGENT_RESOURCES" ]; then echo "agent.auto.register.resources=$AGENT_RESOURCES" >> /var/lib/go-agent/config/autoregister.properties; fi
if [ -n "$AGENT_ENVIRONMENTS" ]; then echo "agent.auto.register.environments=$AGENT_ENVIRONMENTS" >> /var/lib/go-agent/config/autoregister.properties; fi

# Start Agent
exec /usr/share/go-agent/agent.sh