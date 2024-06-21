# for login shells (after .zshrc)
#
# It is sourced on the start of a login shell but after .zshrc, if the shell is
# also interactive. This file is often used to start X using startx. Some
# systems start X on boot, so this file is not always very useful.
#
# see https://unix.stackexchange.com/a/71258

for file in ~/.config/zsh/*.zlogin(N); do
  source $file
done
