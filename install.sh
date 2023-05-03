#!/usr/bin/env bash

set -e

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOSTS="$ROOTDIR/hosts"
PLAYBOOK="$ROOTDIR/main.yaml"

apt-get update && apt-get install -y ansible

ansible-playbook -i "$HOSTS" "$PLAYBOOK" --ask-become-pass

exit 0

