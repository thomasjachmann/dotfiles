#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
brew "task"
brew "tasksh"
brew "taskwarrior-tui"
EOB
