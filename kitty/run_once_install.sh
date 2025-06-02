#!/bin/bash

brew bundle --file=/dev/stdin <<EOB
cask "kitty"

cask "font-hack-nerd-font"

brew "jq" # needed for bin/open-in-kitty
EOB
