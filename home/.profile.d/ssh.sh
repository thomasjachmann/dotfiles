complete -W "$echo $(cat ~/.ssh/config | grep '^Host *[a-z]' | awk '{print $2}')" ssh
