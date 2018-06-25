# See:
# https://docs.google.com/document/d/1vQPrNDdwNSWZHHZF7cDg7bwpjtAAzxykyp5-TM6UrSI/edit
alias nmk="nice -n 2 make -k -j20"
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" nmk

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
