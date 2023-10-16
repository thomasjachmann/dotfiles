#!/usr/bin/env zsh

rtx plugins update
rtx list
if read -qs "CHOICE?Should I run \`rtx install\` now? (y/N) "; then
  echo
  rtx install
else
  echo
fi
