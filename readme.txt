Dotvim
======

Personal vim configuration files.


Installation & Dependencies
===========================

$ git clone --recursive git@git.n1t0r.com:dotvim.git ~/.vim

Python:

$ sudo pacman -S python python-pip yapf
$ pip install --user pylint

Go:

$ sudo pacman -S go
$ go get -u golang.org/x/tools/...

Rust:

$ sudo pacman -S rust
$ rustup toolchain install nightly
$ rustup default nightly
$ rustup component add rls rust-analysis rust-src


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
