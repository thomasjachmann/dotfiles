# TODO: Check of fzf-cd-widget can be activated somehow.

# source all zshrc files in ~/.config/zsh (sorted alphabetically, no . files)
for file in ~/.config/zsh/*.zshrc; do
  source $file
done

# eval all eval files in ~/.config/zsh (sorted alphabetically, no . files)
for file in ~/.config/zsh/*.eval; do
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
