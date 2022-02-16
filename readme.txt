Dotvim
======

Personal vim configuration files.


Installation & Dependencies
===========================

$ git clone --recursive git@git.n1t0r.com:n1t0r/dotvim.git ~/.config/nvim

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

$ git submodule add plugins-repo bundle/plugin-name

Removing plugins
================

$ git submodule deinit bundle/plugin
$ git rm bundle/plugin
$ rm -rf .git/modules/bundle/plugin

Updating plugins
================

$ git submodule update --recursive --remote --merge
