#!/usr/bin/env zsh

mise cache prune # Or do we need `mise cache clear`? This prevents warnings about not being able to update the python plugin.
mise plugins update
mise ls --outdated
if read -qs "CHOICE?Should I run \`mise upgrade\` now? (y/N) "; then
  echo
  mise upgrade
else
  echo
fi
