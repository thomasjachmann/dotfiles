#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
cask "openscad@snapshot"

# The bin/openscad symlink is needed since https://github.com/Homebrew/homebrew-cask/pull/87720
EOB
