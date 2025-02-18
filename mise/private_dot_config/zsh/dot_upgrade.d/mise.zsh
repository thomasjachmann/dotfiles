#!/usr/bin/env zsh

mise plugins update
mise ls --outdated
if read -qs "CHOICE?Should I run \`mise upgrade\` now? (y/N) "; then
  echo
  mise upgrade
else
  echo
fi
