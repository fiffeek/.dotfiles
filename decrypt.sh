#!/bin/bash

fd . --extension .vault | xargs ansible-vault decrypt --vault-id vault_pass.txt
