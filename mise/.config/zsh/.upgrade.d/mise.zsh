#!/usr/bin/env zsh

mise plugins update
mise list
if read -qs "CHOICE?Should I run \`mise install\` now? (y/N) "; then
  echo
  mise install
else
  echo
fi
