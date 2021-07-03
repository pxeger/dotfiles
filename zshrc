# oh-my-zsh
export ZSH="$HOME"/home/repos/ohmyzsh
ZSH_THEME="pxeger"
ZSH_CUSTOM="$HOME"/home/repos/dotfiles/zsh_custom
source "$ZSH"/oh-my-zsh.sh

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/pxeger/home/local/google-cloud-sdk/path.zsh.inc' ]; then . '/home/pxeger/home/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/pxeger/home/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/pxeger/home/local/google-cloud-sdk/completion.zsh.inc'; fi

setopt extendedglob
setopt correct
unsetopt banghist

source ~/.profile

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

a() {
    [[ $# -eq 0 ]] && set -- -u
    git add $@
}

gp push() {
    waitgroup=()
    for i in $(git remote); do
        git push $i $@ &
        waitgroup+=$!
    done
    wait $waitgroup
}

# subshell to avoid setopt leaking
p() (
    setopt extendedglob
    setopt caseglob
    # do we need sudo? no if:
    #  -h --help
    #  -V --version
    #  -Q --query
    #  -F --files
    #  -T --deptest
    #  -Ss --sync --search
    #  -Si --sync --info
    if
        [[ $1 = (|-*[QVFTh]*|--help|--version|--query|--files|--deptest) ]] || 
        ( [[ $1 = (-*S*|--sync) ]] && [[ "$*" = (|*" ")(-[^ ][si][^ ]|--(info|sync)(|" "*)) ]] )
    then
        pacman $@
    else
        sudo pacman $@
    fi
)

reload() {
    exec zsh
}

alias -g ~="$HOME/home"

alias step=step-cli
alias to='tee >/dev/null'
alias g=git
alias c='git commit'
alias l='ls -lA'
alias v=nvim
alias e=sudoedit
alias f='run firefox-developer-edition'
alias a-p='ansible-playbook'
alias a-g='ansible-galaxy'
alias a-v='ansible-vault'
alias pw='tr</*/ur* -dc a-z|head -c32'
alias .='builtin source'

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
    if [[ $# != 1 ]]
    then
        command dir
    else
        mkdir "$1"
        cd "$1"
    fi
}

source() {
    if [[ $# = 0 ]]
    then
        cd source
    else
        builtin source $@
    fi
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
hash -d s=$HOME/home/sshfs
hash -d t=$HOME/home/temp
hash -d v=$HOME/home/videos
hash -d y=$HOME/home/y_books
hash -d z=$HOME/home/z_documents

watchtests() {
    ag -l . | entr -s 'clear; poetry run pytest -rP'
}

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

# use in complex pipelines
# foo | debug | bar
# now you will see the output of foo
alias debug='tee >(cat)'

# ... for cd ../..
# .... for cd ../../..
# etc
for i ({1..10}) {
    s=""
    repeat $i s+="."
    function ..$s {
        while [[ $0 = ...* ]] {
            cd ..
            0=${0:1}
        }
        cd ..
    }
}
unset s i

BW() bwrap --ro-bind /usr /usr --ro-bind /etc /etc --ro-bind /var /var --symlink /usr/lib /lib --symlink /usr/bin /bin --symlink /usr/lib /lib64 --tmpfs /tmp --proc /proc --dev /dev $@
