#!/usr/bin/env bash

set -e

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOSTS="$ROOTDIR/hosts"
PLAYBOOK="$ROOTDIR/main.yaml"

ansible-playbook -i "$HOSTS" "$PLAYBOOK" --vault-id vault_pass.txt --ask-become-pass

exit 0
