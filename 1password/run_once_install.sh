#!/bin/bash

[ -d /Applications/1Password.app ] || \
brew bundle --no-lock --file=/dev/stdin <<EOB
cask "1password"
EOB

brew bundle --no-lock --file=/dev/stdin <<EOB
cask "1password-cli"
EOB
