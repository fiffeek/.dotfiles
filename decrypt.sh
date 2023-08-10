#!/bin/bash

fd . --extension .vault | xargs -n1 echo ansible-vault decrypt --vault-id vault_pass.txt | bash
