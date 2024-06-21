#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
brew "nvm"
EOB

mkdir -p ~/.nvm
