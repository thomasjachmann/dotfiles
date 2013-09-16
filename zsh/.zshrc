# source all files in ~/.zshrc.d (sorted alphabetically, no . files)
for FILE in ~/.zshrc.d/*; do
  source $FILE
done

# see http://stackoverflow.com/questions/564648/zsh-tab-completion-for-cd
zstyle ':completion:*' special-dirs true

# correction never was useful for me - it usually just annoyed me
# (eg on git aliases)
unsetopt correct_all

# I rarely used extended globbing, but it hindered me in using stuff like
# git reset HEAD^
unsetopt extendedglob
