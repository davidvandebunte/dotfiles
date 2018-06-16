# dotfiles
The dotfiles in this repository are designed to be cloned using the simple
approach advocated by this [Atlassian developer article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

It also helps to have remote tracking branches showing where your local
repository is relative to the remote, as explained in
[this answer](https://stackoverflow.com/a/36410649). That is, you should also run:
```
config config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
config fetch
```
