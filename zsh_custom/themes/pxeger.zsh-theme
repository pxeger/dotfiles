# vim: filetype=zsh

# left-hand-side prompt
PROMPT=''
# set initial colour
PROMPT+='%F{12}'
# home directory, with `~/home` at the start replaced by just `~`, so that the prompt acts like `$HOME` is `$HOME/home`
PROMPT+='${$(print -P %~)/#\~\/home/~}'
# background jobs info
PROMPT+='%1(j. %f[%F{1}%j%f].) '
# colour of $ prompt: orange in case of error, otherwise grey
PROMPT+='%(?.%F{7}.%(130?.%F{7}.%F{3}))'
# $ prompt
PROMPT+='%(!.#.$)'
# reset formatting and add padding space
PROMPT+='%f '

# right-hand-side prompt
RPROMPT=''
# exit code of last command, in case of failure
RPROMPT=' %(?..%(130?..$F%?))'
