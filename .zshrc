# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

setopt CHECK_JOBS
setopt HUP

export JAVA_6_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/
export JAVA_1_6_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/
export JAVA_8_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home
export JAVA_1_8_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home
export JAVA_11_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
export JAVA_HOME=$JAVA_11_HOME

export EDITOR=nvim
# Fix GPG signing, per https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

bindkey -v
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward
bindkey '^u' backward-kill-line
bindkey '^y' yank
bindkey '^t' delete-word
bindkey '^x' copy-prev-shell-word
bindkey '^z' vi-undo-change
bindkey '\e.' insert-last-word
bindkey '^[b' backward-word
bindkey '^[f' forward-word

alias o='open'
alias gw='./gradlew'
alias hd='hexdump -C'
alias p='python3'
alias json='python -mjson.tool'

alias gits='git status'
alias gitd='git diff'
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias opr='gh pr view --web'
alias cpr='gh pr create --web'
alias coder_gpg='ssh -v -N -R /run/user/1000/gnupg/S.gpg-agent:$HOME/.gnupg/S.gpg-agent.extra coder.nucleus'
alias tm='cd ~/nucleus && tmux new-session -n pnpm "pnpm dev:chat" \; new-window -n nvim \; new-window -n zsh'

alias vim='nvim'

newpy(){
    if [ $# -lt 1 ]; then
        echo "Error: provide file name!" >&2
    else
        filename="$1"
        if [ -e "$filename" ]; then
            echo "Error: file already exists!" >&2
        else
            echo > "$filename" """import argparse
import logging


def main():
    args = parse_args()



def parse_args():
    parser = argparse.ArgumentParser()

    return parser.parse_args()

if __name__ == '__main__':
    main()""" && vim +8 "$filename"
        fi
    fi
}

newjava(){
    if [ $# -lt 1 ]; then
        echo "Error: provide file name!" >&2
    else
        classname="$1"
        filename="$classname.java"
        if [ -e "$filename" ]; then
            echo "Error: file already exists!" >&2
        else
            echo > "$filename" """class $classname {
    public static void main(String[] args) {

    }
}""" && vim +3 "$filename"
        fi
    fi
}

makegif(){
    GIF_ARGS=''
    SCALE_PALETTE=''
    SCALE_GEN=''
    if [ "$1" = "-ss" -o "$1" = "-t" ]; then
        GIF_ARGS="$GIF_ARGS $1 $2"
        shift 2
    fi
    if [ "$1" = "-ss" -o "$1" = "-t" ]; then
        GIF_ARGS="$GIF_ARGS $1 $2"
        shift 2
    fi
    if [ $# -lt 2 ]; then
        echo "Usage: makegif [-ss N] [-t N] [width-scale] <input> <output>" >&2
        return
    elif [ $# -gt 2 ]; then
        SCALE_PALETTE="scale=$1:-1:flags=lanczos,"
        SCALE_GEN="scale=$1:-1:flags=lanczos,"
        shift
    fi
    if [ ! -f "$1" ]; then
        echo "Error: $1 does not exist" >&2
        return;
    fi
    echo ffmpeg -v warning $GIF_ARGS -i "$1" -vf fps=30,${SCALE_PALETTE}palettegen -y /tmp/palette.png
    ffmpeg -v warning $GIF_ARGS -i "$1" -vf fps=30,${SCALE_PALETTE}palettegen -y /tmp/palette.png
    echo ffmpeg -v warning -i "$1" -i /tmp/palette.png -lavfi "fps=30,${SCALE_GEN}paletteuse" -y $2
    ffmpeg -v warning -i "$1" -i /tmp/palette.png -lavfi "fps=30,${SCALE_GEN}paletteuse" -y $2
}

makegif2(){
    if [ $# -lt 1 ]; then
        echo "Error: provide file name!" >&2
    elif [ $# -lt 2 ]; then
        ffmpeg -i "$1" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3
    else
        ffmpeg -i "$1" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "$2"
    fi
}
