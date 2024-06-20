#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
brew "git"
brew "git-lfs"
brew "git-absorb"
brew "git-delta"
brew "git-extras"
brew "tig"
brew "hub"
EOB
