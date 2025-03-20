Personal vim configuration files.

Installation & Dependencies
===========================

$ git clone --recursive git@git.n1t0r.com:dotvim.git ~/.config/nvim

Go:

Install the language using the distribution's package manager and then install
the latest version of gopls:

$ go install golang.org/x/tools/gopls@latest

Installing plugins
==================

$ git submodule add <repository> <path>

Removing plugins
================

$ git rm <path-to-submodule>

Git will keep the plugin to maintain the ability of checking commits that depend
on it. In order to remove those remnants:

$ rm -rf .git/modules/<path-to-submodule>
$ git config --remove-selection submodule.<path-to-submodule>

Updating plugins
================

$ git submodule update --recursive --remote
