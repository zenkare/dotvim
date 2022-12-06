Personal vim configuration files.

Installation & Dependencies
===========================

$ git clone --recursive git@git.n1t0r.com:dotvim.git ~/.vim

Go:

$ sudo pacman -S go
$ go get -u golang.org/x/tools/...

Installing plugins
==================

$ git submodule add <repository> <path>

Removing plugins
================

$ git rm <path-to-submodule>

Git will keep the plugin to maintain the ability of checking commits that depend
on them. In order to remove those remnants:

$ rm -rf .git/modules/<path-to-submodule>
$ git config --remove-selection submodule.<path-to-submodule>

Updating plugins
================

$ git submodule update --recursive --remote 
