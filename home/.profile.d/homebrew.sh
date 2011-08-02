export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# source all files in /usr/local/etc/bash_completion.d (sorted alphabetically, no . files)
# these are homebrew's bash completion files
for FILE in /usr/local/etc/bash_completion.d/*; do
  source $FILE
done
