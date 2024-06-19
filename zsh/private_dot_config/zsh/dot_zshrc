# for interactive shells
#
# You set options for the interactive shell there with the setopt and unsetopt
# commands. You can also load shell modules, set your history options, change
# your prompt, set up zle and completion, et cetera. You also set any variables
# that are only used in the interactive shell (e.g. $LS_COLORS).
#
# see https://unix.stackexchange.com/a/71258

# TODO: Check of fzf-cd-widget can be activated somehow.

# source all zshrc files in ~/.config/zsh (sorted alphabetically, no . files)
for file in ~/.config/zsh/*.zshrc(N); do
  source $file
done

# eval all eval files in ~/.config/zsh (sorted alphabetically, no . files)
for file in ~/.config/zsh/*.eval(N); do
  # eval cannot handle commented lines - there must be a better way...
  eval $(cat $file | grep -v '^#')
done

# see http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

# correction never was useful for me - it usually just annoyed me
# (eg on git aliases)
unsetopt correct_all

# I rarely used extended globbing, but it hindered me in using stuff like
# git reset HEAD^
unsetopt extendedglob
