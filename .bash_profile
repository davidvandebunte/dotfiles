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
if [ -r ~/.profile ]; then
    source ~/.profile
fi
