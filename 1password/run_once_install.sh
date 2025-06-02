#!/bin/bash

[ -d /Applications/1Password.app ] || \
brew bundle --file=/dev/stdin <<EOB
cask "1password"
EOB

brew bundle --file=/dev/stdin <<EOB
cask "1password-cli"
EOB
