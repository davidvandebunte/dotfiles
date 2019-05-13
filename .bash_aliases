# See:
# https://docs.google.com/document/d/1vQPrNDdwNSWZHHZF7cDg7bwpjtAAzxykyp5-TM6UrSI/edit
alias nmk="nice -n 2 make -k -j20"
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" nmk

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

# See the suggested NINJA_STATUS here:
# https://ninja-build.org/manual.html#_environment_variables
export NINJA_STATUS="[%u/%r/%f] "

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
    sleep "$1" && \
    notify-send --urgency critical "Next task!" && \
    watch paplay /usr/share/sounds/ubuntu/stereo/message.ogg; \
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

# The idea to use tmuxinator (to restore tmux layouts) came from here:
# https://blog.bugsnag.com/benefits-of-using-tmux/
#
# You are installing tmux locally using this approach:
# https://stackoverflow.com/a/18294746/622049
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if [ -f ~/.bash_personal ]; then
    . ~/.bash_personal
fi

dfr() {
    # Example of mapping PWD to PWD:
    # https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only
    docker run \
        --rm \
        --interactive --tty \
        --env "TERM=xterm-256color" \
        --env DISPLAY \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume "$PWD":"$PWD" \
        --workdir "$PWD" "$@"
}

# As suggested here:
# https://confluence.in.here.com/display/RCPDS/Running+Feature+Consolidation+Filter+Locally
export RWO_JNI_BUILD_DIR=/home/vandebun/sdb/rwoj/RelWithDebInfo

# The following lines are part of tmuxinator setup:
# https://github.com/tmuxinator/tmuxinator
export EDITOR='vim'
source ~/.tmuxinator.bash
