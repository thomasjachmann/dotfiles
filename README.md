# Thomas Jachmann's Dotfiles

This is a repository containing my dotfiles. And everything that would resemble
them. In fact, I included my dotfiles, macOS application settings, etc. and
organized them in packages. And there's a `dotfiles` utility to manage
(install/uninstall) these packages.

## Installation

Quick and easy:

```bash
curl -fsSL https://raw.githubusercontent.com/thomasjachmann/dotfiles/main/install) | /bin/bash
```

If you don't like piping stuff into shells, clone this repository somewhere
into your system (recommended: `$XDG_DATA_HOME/dotfiles/vault` aka
`~/.local/share/dotfiles/vault`) and then call the `./install` script there.

## Usage

```bash
dotfiles install tmux vim ruby
dotfiles uninstall java
```

## Caveats

Currently, this is macOS based. You most likely can use most of the dotfiles on
Linux as well, but of course not the macOS app settings. The `dotfiles` utility
should work as long as you've got a `brew` command available.

All configuration is also zsh based so you should be willing to use this
shell.

It is assumed that Homebrew is installed into the standard location
`/opt/homebrew` or `/usr/local`. Calling `brew --prefix <package>` just takes
too long to be included in the dotfiles. This would slow down shell
initialization dramatically. So we're using the hard coded path for now.

## Background

This uses:

* [Homebrew](https://brew.sh/) for installing command line and GUI tools
* [chezmoi](https://www.chezmoi.io/) for intelligently symlinking/copying files
  into the home directory

Packages are represented by a directory in the root of this repository. This
contains everything you want `chezmoi` to do to install that package.

## Copyright

Copyright © 2019 Thomas Jachmann. See LICENSE for details.
