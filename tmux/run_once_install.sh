#!/bin/bash

brew bundle --file=/dev/stdin <<EOB
brew "tmux"
brew "reattach-to-user-namespace"
EOB
