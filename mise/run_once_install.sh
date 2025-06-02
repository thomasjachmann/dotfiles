#!/bin/bash

brew bundle --file=/dev/stdin <<EOB
brew "mise"
EOB

mise plugin add yarn
mise plugin add pnpm
mise plugin add rust

mise install
