# Thomas Jachmann's Dotfiles

This is a repository containing my dotfiles. And everything that would resemble
them. In fact, I included my dotfiles, macOS application settings organized in
packages. And there's a `dotfiles` utility to manage (install/uninstall) these
packages.

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
dotfiles remove java
```

## Caveats

Currently, this is macOS based. You most likely can use most of the dotfiles on
Linux as well, but of course not the macOS app settings. The `dotfiles` utility
should work as long as you've got a `brew` command available.

All configuration is also zsh based so you should be willing to use this
shell.

It is assumed that Homebrew is installed into the standard location
`/usr/local`. Calling `brew --prefix <package>` just takes too long to be
included in the dotfiles. This would slow down shell initialization
dramatically. So we're using the hard coded path for now.

## Background

This uses:

* [Homebrew](https://brew.sh/) for installing command line and GUI tools
* [GNU Stow](https://www.gnu.org/software/stow/) for intelligently symlinking
  files into the home directory

Packages are represented by a directory in the root of this repository. This
contains (in the order of them being applied to the system when installing a
package):

1. `Brewfile` which is used to define which software to install for this
   package using Homebrew
1. any number of files to be symlinked into the home directory exactly as they
   appear here (`Brewfile`, `install` and `support` excluded)
1. `install` a shell script being executed in order to do some more complex
   setup
1. `support` a file/directory that can contain stuff you eg need for your
   `install` script but which should not be symlinked to the home directory

All of these are optional.

## Copyright

Copyright © 2019 Thomas Jachmann. See LICENSE for details.
