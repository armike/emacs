#!/usr/bin/bash
export echo=1
export GREP_COLOR=34

alias l='ls -l'
alias ll='ls -l'
alias la='ls -a'
alias latr='ls -latr'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias uuuu='cd ../../../..'
alias uuuuu='cd ../../../../..'
alias g='grep'
alias fpg='find "`pwd`" | grep \!*'

alias emacs='/cygdrive/c/Program\ Files/emacs/bin/runemacs.exe'
alias e='emacs'
alias emww='emacs -no_cedet'
alias sal='cp ~/.aliases ~/.tmp_aliases; dos2unix ~/.tmp_aliases > /dev/null; source ~/.tmp_aliases; rm ~/.tmp_aliases'
alias eal='emacs ~/.aliases -no_cedet'

