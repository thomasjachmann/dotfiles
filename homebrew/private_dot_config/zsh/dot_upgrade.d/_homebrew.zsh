#!/usr/bin/env zsh

brew update
brew outdated
if read -qs "CHOICE?Should I run \`brew upgrade\` now? (y/N) "; then
  echo
  brew upgrade
else
  echo
fi
