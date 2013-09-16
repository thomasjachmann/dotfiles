alias svn-diff="svn diff | mate"
alias svn-addall="svn status | grep '^\?' | awk '{print \$2}' | xargs svn add"
