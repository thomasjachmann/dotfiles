# source all files in ~/.profile.d (sorted alphabetically, no . files)
for FILE in ~/.profile.d/*; do
  source $FILE
done
