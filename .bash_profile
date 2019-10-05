# ~/.bash_profile: executed by the command interpreter for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

echo "Sourcing .bash_profile"

# All three of these sources recommend limiting .bash_profile to two
# lines and effectively using .profile instead:
# https://superuser.com/a/789465/293032
# https://superuser.com/a/183980/293032 (second to last paragraph)
# https://serverfault.com/a/261807/465399
#
# This approach also allows you to move zsh or another shell eventually.
#
# By default, tmux starts up as a login shell. Because of this, you end up
# running .profile twice when you ssh into your machine and then start tmux
# (leading to a PATH that has been doubly modified). See comments here:
# https://unix.stackexchange.com/a/61788/233125
#
# Reasoning behind the login shell default here:
# https://superuser.com/a/970847/293032
if [ -z "$TMUX" ]; then
    if [ -r ~/.profile ]; then
        # shellcheck source=/home/vandebun/.profile
        source ~/.profile
    fi
fi

# You include .bashrc after the PATH is completely set up so you can set
# aliases and define functions using the binaries from the modified PATH (e.g.
# kubectl autocompletion).
#
# Aliases are not propagated between shells like environment variables, so
# they need to stay in .bashrc:
# https://serverfault.com/a/261807/465399
#
# The logic in this file (such as checking the BASH_VERSION) makes me think
# you got it from a .profile file originally (not a .bash_profile file).
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        # shellcheck source=/home/vandebun/.bashrc
	    . "$HOME/.bashrc"
    fi
fi
