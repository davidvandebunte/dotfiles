# See:
# https://docs.google.com/document/d/1vQPrNDdwNSWZHHZF7cDg7bwpjtAAzxykyp5-TM6UrSI/edit
alias nmk="nice -n 2 make -k -j20"
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" nmk

# The alias suggested in this article:
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
