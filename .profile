# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

echo "Sourcing .profile"

# Keep all your PATH modifications in .profile so:
# 1. They all happen in one place; you can see in what order you're
#    adding to or modifying the path.
# 2. You don't add the same pieces to the PATH over and over if you create
#    a sub-shell. If you print the PATH and then run `bash` to create a
#    sub-shell, you should be able to print the same PATH.
# 3. You are less afraid of what will break when you restart your computer
#    and you see for the first time how new .bashrc modifications interact
#    with your existing .profile. Similarly, you don't get home and see
#    unexpected behavior when you login via ssh (also a login shell that
#    sources .profile).
#
# The downside is you need to restart before getting PATH modifications in new
# terminal sessions. In the meantime, you can always source .bash_profile
# manually. You could also add lines to .bashrc with a TODO.

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    # Append ~/.local/bin to the end of the path rather than the front. See:
    # https://github.com/conda/conda/issues/7173
    #
    # When you try to activate a conda environment, this being on the path
    # makes your terminal find --user python binaries before conda-installed
    # binaries.
    PATH="$PATH:$HOME/.local/bin"
fi

# set PATH so it includes OLP command line tool
if [ -d "$HOME/sdk-2.4.0.403/tools/OLP_CLI/" ] ; then
    PATH="$HOME/sdk-2.4.0.403/tools/OLP_CLI/:$PATH"
fi

# Add golang to PATH
export PATH=$PATH:/usr/local/go/bin

# The idea to use tmuxinator (to restore tmux layouts) came from here:
# https://blog.bugsnag.com/benefits-of-using-tmux/
#
# You are installing tmux locally using this approach:
# https://stackoverflow.com/a/18294746/622049
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Added as part of CUDA/NVidia set up with Nick
export PATH=/usr/local/cuda/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda

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
	. "$HOME/.bashrc"
    fi
fi

# The following logic comes from:
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
#
# This is primarily to solve the same problem being asked about in the SO
# question. From your home machine, you want to be able to log in to your
# work machine and only enter your password once.
#
# You changed just one line; you don't need it to run ssh-add at the
# same time it starts the agent (you'd rather be prompted the first time
# you try to fetch).
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
