#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
brew "android-sdk"
EOB
