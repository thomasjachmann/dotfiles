# import scripts for rvm
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# activate bash completion
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
