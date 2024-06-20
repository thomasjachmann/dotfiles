#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
cask "ngrok"
EOB
