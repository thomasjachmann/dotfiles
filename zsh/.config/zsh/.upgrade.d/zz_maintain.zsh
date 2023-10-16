#!/usr/bin/env zsh

if read -qs "CHOICE?Should I run \`maintain\` now? (y/N) "; then
  echo
  maintain
else
  echo
fi
