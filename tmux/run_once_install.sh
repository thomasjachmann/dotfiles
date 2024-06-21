#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
brew "tmux"
brew "reattach-to-user-namespace"
EOB
