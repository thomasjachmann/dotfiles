# source all files in ~/.config/zsh (sorted alphabetically, no . files)
for file in ~/.config/zsh/*; do
  source $file
done

# see http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

# correction never was useful for me - it usually just annoyed me
# (eg on git aliases)
unsetopt correct_all

# I rarely used extended globbing, but it hindered me in using stuff like
# git reset HEAD^
unsetopt extendedglob

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
