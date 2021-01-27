# oh-my-zsh
export ZSH="$HOME"/home/repos/ohmyzsh
ZSH_THEME="pxeger"
ZSH_CUSTOM="$HOME"/home/repos/dotfiles/zsh_custom
source "$ZSH"/oh-my-zsh.sh

setopt extendedglob
unsetopt banghist

nvm_load() {
	[ -n "$NVM_DIR" ] && \. "$NVM_DIR"/nvm.sh || true
}

# nvm_load

# aliases

alias dk='sudo docker-compose'
alias d='sudo docker'

cd() {
        if [ $# -eq 0 ]; then builtin cd ~/home; else builtin cd $@; fi
}

git() {
        if [ $# -eq 0 ]; then command git status; else command git $@; fi
}

run() {
    setsid $@ &> /dev/null
}

cat() {
    [[ $# -eq 0 ]] && command cat
    for file in $@
    do
        if [[ $file = - ]]
        then
            command cat
        # cat = ls for directories
        elif [[ -d $file ]]
        then
            ls -lA "$file"
        else
            command cat "$file"
        fi
    done
}

::addhack() {
    [[ $# -eq 0 ]] && set -- -u
    git add $@
}

::pushhack() {
    waitgroup=()
    for i in $(git remote); do
        git push $i $@ &
        waitgroup+=$!
    done
    wait $waitgroup
}

alias g=git
alias c='git commit'
alias push='::pushhack'
alias a='::addhack'
alias l='ls -lA'
alias v=nvim
alias e=sudoedit
alias p='sudo pacman'
alias f='run firefox-developer-edition'
alias a-p='ansible-playbook'
alias a-g='ansible-galaxy'
alias a-v='ansible-vault'
alias pw='tr</*/ur* -dc a-z|head -c32'
alias .=source

alias copy='xclip -selection clipboard'

alias cv='nvim ~/home/repos/dotfiles/init.vim'
alias cz='nvim ~/home/repos/dotfiles/zshrc'
alias ct='nvim ~/home/repos/dotfiles/tmux.conf'

alias yarn='npx yarn'

dis() {
    echo "$1" | python3.9 -m dis
}

export GPG_TTY=$(tty)

dir() {
    mkdir "$1"
    cd "$1"
}

# now I can use ~b to refer to ~/home/bin etc.
hash -d b=$HOME/home/bin
hash -d c=$HOME/home/config
hash -d d=$HOME/home/downloads
hash -d h=$HOME/home/haxx
hash -d i=$HOME/home/important
hash -d j=$HOME/home/junk
hash -d l=$HOME/home/local
hash -d m=$HOME/home/music
hash -d n=$HOME/home/notes
hash -d p=$HOME/home/pictures
hash -d q=$HOME/home/qemu
hash -d r=$HOME/home/repos
hash -d t=$HOME/home/temp
hash -d v=$HOME/home/videos
hash -d y=$HOME/home/y_books
hash -d z=$HOME/home/z_documents

# modified from zshexpn(1) § Filename Generation § Dynamic named directories
# now I can use ~[foo] to refer to ~/home/repos/foo
zsh_directory_name() {
    local -a match mbegin mend
    case $1 in
        d)  # turn the directory into a name
            if [[ $2 = (#b)($HOME/home/repos/)([^/]##)* ]]; then
                typeset -ga reply
                reply=($match[2] $(( ${#match[1]} + ${#match[2]} )) )
            else
                return 1
            fi
            ;;
        n)  # turn the name into a directory
            typeset -ga reply
            reply=($HOME/home/repos/$2)
            ;;
        c)  # complete names
            local expl
            local -a dirs
            # :t gets the basename of the directories
            dirs=($HOME/home/repos/*(/:t))
            _wanted dynamic-dirs expl 'dynamic directory' compadd -S\] -a dirs
            return
            ;;
        *)  # invalid
            return 1
            ;;
    esac
    return 0
}
