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
    alias nj="nice -n 2 ninja -k 100 -j20"
    complete -F _ninja_target nj
fi

# Turn off ^S and ^Q which you don't feel you need in any contexts:
# https://stackoverflow.com/a/14737844/622049
if [ -t 0 ]; then
    stty sane
    stty stop ''
    stty start ''
    stty werase ''
fi

# The alias suggested in this article:
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# The idea to use tmuxinator (to restore tmux layouts) came from here:
# https://blog.bugsnag.com/benefits-of-using-tmux/
#
# You are installing tmux locally using this approach:
# https://stackoverflow.com/a/18294746/622049
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# The following lines are part of tmuxinator setup:
# https://github.com/tmuxinator/tmuxinator
export EDITOR='vim'
source ~/.tmuxinator.bash
