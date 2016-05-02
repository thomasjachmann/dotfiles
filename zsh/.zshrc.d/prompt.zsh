# export PROMPT_COMMAND='printf "\e[0;37m%*s\e[0;30m\r" "$COLUMNS" `ruby-version`'
# export PS1='`title`\e[0;32m\u@\h:\e[1;34m\w\e[0;30m$(__git_ps1 " \e[0;37m(git %s)\e[0;30m")
# $ '
# export SUDO_PS1='\e[33;1;41m\u@\h\e[0m:\e[1;34m\w\e[0;30m
# $ '

# from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# function prompt_char {
#     git branch >/dev/null 2>/dev/null && echo '±' && return
#     echo '$'
#     # echo '○'
# }

#autoload -Uz vcs_info
autoload -U colors && colors
#autoload -U promptinit
#promptinit

setopt prompt_subst

# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:git*:*' get-revision true
# zstyle ':vcs_info:git*:*' check-for-changes true
#
# # hash changes branch misc
# zstyle ':vcs_info:git*' formats "(%s) %12.12i %c%u %b%m"
# zstyle ':vcs_info:git*' actionformats "(%s|%a) %12.12i %c%u %b%m"
#
# zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash
#
# # Show remote ref name and number of commits ahead-of or behind
# # See http://eseth.org/2010/git-in-zsh
# function +vi-git-st() {
#     local ahead behind remote
#     local -a gitstatus
#
#     # Are we on a remote-tracking branch?
#     remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
#         --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
#
#     if [[ -n ${remote} ]] ; then
#         # for git prior to 1.7
#         # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
#         ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
#         (( $ahead )) && gitstatus+=( "${c3}+${ahead}${c2}" )
#
#         # for git prior to 1.7
#         # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
#         behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
#         (( $behind )) && gitstatus+=( "${c4}-${behind}${c2}" )
#
#         hook_com[branch]="${hook_com[branch]} [${remote} ${(j:/:)gitstatus}]"
#     fi
# }
# # Show count of stashed changes
# function +vi-git-stash() {
#     local -a stashes
#
#     if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
#         stashes=$(git stash list 2>/dev/null | wc -l)
#         hook_com[misc]+=" (${stashes} stashed)"
#     fi
# }

# # Format for git_prompt_info()
# ZSH_THEME_GIT_PROMPT_PREFIX="${fg[red]}git("
# ZSH_THEME_GIT_PROMPT_SUFFIX="${fg[red]})$reset_color"
# # Format for parse_git_dirty()
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(*)"
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# # Format for git_prompt_ahead()
# ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"
# # Format for git_prompt_long_sha() and git_prompt_short_sha()
# ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
# ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"
# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{${fg[red]}%}unmerged%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED=" %{${fg[red]}%}deleted%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{${fg[yellow]}%}renamed%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{${fg[yellow]}%}modified%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED=" %{${fg[green]}%}added%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{${fg[white]}%}untracked%{$reset_color%}"

function git-prompt() {
  gitstatus=$(git status --short --branch 2> /dev/null) || return
  gitstatus=$(echo $gitstatus | head -n 1)
  echo "%{%F{$light}%}± git on ${gitstatus/\#\# /} at $(git_prompt_short_sha)$(git_prompt_status)
%{%b%f%k%}"
}

# see for colors:
# - http://www.calmar.ws/vim/color-output.png
# - http://www.commandlinefu.com/commands/view/5876/show-numerical-values-for-each-of-the-256-colors-in-zsh
#
# see for bolding and stuff:
# - http://www.nparikh.org/unix/prompt.php
#
# use in terminal for testing:
# function color { print -P -- "%{%F{$1}%}%{%K{$2}%} TEST %{$reset_color%}" }
# color 28 7

local blue=4
local light=7
local mid=8
local dark=8
local offwhite=7
local white=15
local green=2
local red=1

# appropriate unicode symbols
# ▙▚▚▚▚▜
# ⬒⬓⬒⬓⬒⬓
# ␥␥␥␥
# ►
# ⮀
# ↩
# ⚡
# 

function return-code() {
  echo "%(?.%{%K{$green}%}  .%{%F{$white}%K{$red}%} ⚡  %?  )%{%b%f%k%}"
}

function current-time() {
  echo "%{%F{$offwhite}%K{$mid}%} %* %{%b%f%k%}"
}

function current-user() {
  echo "%{%F{$mid}%K{$offwhite}%} %n@%m %{%b%f%k%}"
}

function current-path() {
  echo "%{%F{$blue}%B%} %~%u%{%b%f%k%}"
}

PROMPT='$(return-code)$(current-time)$(current-user)$(current-path)
$(git-prompt)$ '
