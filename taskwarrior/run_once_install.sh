#!/bin/bash

brew bundle --file=/dev/stdin <<EOB
brew "task"
brew "tasksh"
brew "taskwarrior-tui"
EOB
