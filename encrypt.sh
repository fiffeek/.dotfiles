#!/bin/bash

fd . --extension .vault | xargs -n1 echo ansible-vault encrypt --vault-id vault_pass.txt | bash
