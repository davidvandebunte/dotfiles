#!/usr/bin/env bash
echo "Sourcing .bash_aliases"

# See:
# https://docs.google.com/document/d/1vQPrNDdwNSWZHHZF7cDg7bwpjtAAzxykyp5-TM6UrSI/edit
alias nmk="nice -n 2 make -k -j20"
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" nmk

# https://unix.stackexchange.com/a/84155/233125
alias info='info --vi-keys'

# You found the ninja completion script here:
# https://github.com/ninja-build/ninja/blob/master/misc/bash-completion
#
# You found where it was installed on your local machine with:
# dpkg-query -L ninja-build
NINJA_BASH_COMPLETION="/usr/share/bash-completion/completions/ninja"
if [ -f $NINJA_BASH_COMPLETION ]; then
    source $NINJA_BASH_COMPLETION
    alias nj="nice -n 4 ninja -k100 -l16 -j20"
    alias njd="ionice -c 3 nice -n 4 ninja -k100 -l14 -j20"
    complete -F _ninja_target nj
    complete -F _ninja_target njd
fi

alias vi=nvim

# For kubectl auto completion:
# https://kubernetes.io/docs/reference/kubectl/cheatsheet/
if type kubectl > /dev/null 2>&1; then
    source <(kubectl completion bash)
    alias k=kubectl
    complete -F __start_kubectl k
fi

# Argo autocompletion
if type argo > /dev/null 2>&1; then
    source <(argo completion bash)
fi

# Turn off ^S and ^Q which you don't feel you need in any contexts:
# https://stackoverflow.com/a/14737844/622049
if [ -t 0 ]; then
    stty sane
    stty stop ''
    stty start ''
    stty werase ''
fi

# Timebox everything you do.
function nt { \
    date
    faketime -f +"$1" date
    # TODO: Print how long you actually worked by catching the Ctrl-C signal (SIGINT?). Also how
    # much time you have left, in case you're just taking a break or you want to see how much time
    # you saved. Perhaps convert this all to Python.
    sleep "$1"
    local WARNING_TEXT
    WARNING_TEXT="$2"
    if [ -z "$WARNING_TEXT" ]; then
        WARNING_TEXT="Out of time!"
    fi
    zenity --warning --title="New timebox!" --text="$WARNING_TEXT" &
    watch paplay /usr/share/sounds/ubuntu/stereo/message.ogg
}

# Similar to the "config" alias suggested in this article:
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias dotf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Quickly switch to the root of the current git repository:
# https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command/23442470#23442470
#
# You took the name gcd from this comment:
# https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command/23442470#comment26303681_957928
alias gcd='cd $(git rev-parse --show-toplevel)'

# https://askubuntu.com/questions/391082/how-to-see-time-stamps-in-bash-history/391087#comment1723728_391087
HISTTIMEFORMAT="%F %T "

if [ -f ~/.bash_personal_aliases ]; then
    source ~/.bash_personal_aliases
fi

dfr() {
    # Example of mapping PWD to PWD:
    # https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only
    docker run \
        --rm \
        --interactive --tty \
        --env "TERM=xterm-256color" \
        --env DISPLAY \
        --volume $HOME/.viminfo:/home/internal/.viminfo \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume "$PWD":"$PWD" \
        --workdir "$PWD" "$@"
}

# TODO: This and dfr should really move to the vim-environment repository.
dvim() {
    dfr vim-env
}

# The following line is part of tmuxinator setup:
# https://github.com/tmuxinator/tmuxinator
source ~/.tmuxinator.bash
