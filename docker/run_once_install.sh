#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOB
# runtime, comes with lima nerdctl ...
brew "colima"

# docker CLI tools
brew "docker"
brew "docker-credential-helper"
brew "docker-compose"

# k8s CLI tools
brew "k3d"
brew "kubernetes-cli"

# used for ~/bin/rancher-*
# TODO: replace with pure kubectl
brew "rancher-cli"

# tap "ykursadkaya/openlens"
# cask "openlens"

brew "k9s"
EOB
