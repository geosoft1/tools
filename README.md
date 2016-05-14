###Gopei (Go Programming Environment Installer)
====
Simple [Go](http://golang.org) compiler and [LiteIDE](https://github.com/visualfc/liteide) installer for Ubuntu.

This project is third party. For support see http://golang.org and https://github.com/visualfc/liteide.

[![version](https://img.shields.io/badge/version-1.0.5.1-blue.svg)](https://github.com/geosoft1/tools/archive/master.zip)
[![license](https://img.shields.io/badge/license-GPL-blue.svg)](https://github.com/geosoft1/tools/blob/master/LICENSE)
[![go1.5 passed](https://img.shields.io/badge/go1.5-passed-brightgreen.svg)](https://blog.golang.org/go1.5)
[![go1.6 passed](https://img.shields.io/badge/go1.6-passed-brightgreen.svg)](https://blog.golang.org/go1.6)

[![ubuntu16.04 compatible](https://img.shields.io/badge/ubuntu16.04-compatible-orange.svg)]
(http://www.ubuntu.com/)

<img src="https://cloud.githubusercontent.com/assets/6298396/10415856/62b936b0-7005-11e5-90f5-0a8644e632d7.png" width=600px>

**Features**
* Get and install last versions of go compiler and ide.
* Create a simple layout for ide (liteide.ini.mini).
* Lot of gophers use Monaco font so add into ide.
* Also create a GOPATH to the go-programs directory and add a HelloWorld project.
* Add launcher to Unity with some useful functions on right-click. Other DE users have a shortcut on desktop.
* Add git support in ide on `` ctrl+` ``. Be sure you have configured [git] (https://help.github.com/articles/set-up-git) before with proper [ssh keys](https://help.github.com/articles/generating-ssh-keys) or use `` -g `` switch for.
* Extend project templates with **Go1 Simple Project** and **Go1 GPL Project**.
* Add some nice color schemes.
* Real gophers make slides and articles so add presenter to ide on `` ctrl+` ``.
* Add [delve](https://github.com/derekparker/delve) debugger install command on `` ctrl+` ``.

Read the [User Manual](https://github.com/geosoft1/tools/blob/master/HOWTO.md) for more details.

See [CHANGES](https://github.com/geosoft1/tools/blob/master/CHANGES) for new features and bug corrections.

**How to use**

Download anywhere and run from your file browser with double click. If you prefer Terminal go to the directory with the script and run:

    ./Install.sh

Use `` -h `` switch to see all options.

Run periodicaly or if compiler/ide versions change to update the system. Projects are not affected if you overinstall.
	
Ubuntu 14.04+ need script execute activation so run from Terminal
	
For Nautilus use:

     gsettings set org.gnome.nautilus.preferences executable-text-activation launch

For Nemo use:

     gsettings set org.nemo.preferences executable-text-activation ask

Note that on 14.04+ is better to install with `` -s `` to have proper Qt interface.
