#!/bin/bash

fd . --extension .vault | xargs ansible-vault encrypt --vault-id vault_pass.txt
