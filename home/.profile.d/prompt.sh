export PROMPT_COMMAND='printf "\e[0;37m%*s\e[0;30m\r" "$COLUMNS" `rvm-prompt`'
export PS1='`title`\e[0;32m\u@\h:\e[1;34m\w\e[0;30m$(__git_ps1 " \e[0;37m(git %s)\e[0;30m")
$ '
export SUDO_PS1='\e[33;1;41m\u@\h\e[0m:\e[1;34m\w\e[0;30m
$ '
