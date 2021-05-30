export XDG_CONFIG_HOME="$HOME"/home/config
export XDG_DATA_HOME="$HOME"/home/local
export XDG_CACHE_HOME="$HOME"/.cache

export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose

export PATH="$HOME"/home/repos/dotfiles/scripts:"$HOME"/.local/bin:"$PATH"
export EDITOR=nvim

export GOPATH="$HOME"/home/junk/go

export GNUPGHOME="$XDG_DATA_HOME"/gpg

export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc

export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CONFIG_HOME"/less/history

unset SSH_ASKPASS

gpg-agent --daemon --enable-ssh-support 2>/dev/null 1>&2

export SSH_AGENT_PID=
export SSH_AUTH_SOCK="XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh

export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export _Z_DATA="$XDG_DATA_HOME"/z

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

export NVM_DIR="$HOME"/home/repos/nvm

export PICO_SDK_PATH="$HOME"/home/repos/PICO/pico_sdk
export PICO_EXAMPLES_PATH="$HOME"/home/repos/PICO/pico_examples
export PICO_PLAYGROUND_PATH="$HOME"/home/repos/PICO/pico_playground
export PICO_EXTRAS_PATH="$HOME"/home/repos/PICO/pico_extras

umask 027

export GPG_TTY=$(tty)

