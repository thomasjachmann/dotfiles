#!/bin/bash

brew bundle --file=/dev/stdin <<EOB
brew "nvm"
EOB

mkdir -p ~/.nvm
