#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
brew "heroku/brew/heroku"
EOB
