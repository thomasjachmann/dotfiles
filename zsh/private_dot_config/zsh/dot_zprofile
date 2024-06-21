# for login shells (before .zshrc)
#
# It is basically the same as .zlogin except that it's sourced before .zshrc
# whereas .zlogin is sourced after .zshrc.
#
# According to the zsh documentation, ".zprofile is meant as an alternative to
# .zlogin for ksh fans; the two are not intended to be used together, although
# this could certainly be done if desired."
#
# see https://unix.stackexchange.com/a/71258

for file in ~/.config/zsh/*.zprofile(N); do
  source $file
done
