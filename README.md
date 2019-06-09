## Gopei2 (Go Programming Environment Installer)

[![version](https://img.shields.io/badge/version-2.4.0-blue.svg)](https://github.com/geosoft1/tools/archive/master.zip)
[![license](https://img.shields.io/badge/license-gpl-blue.svg)](https://github.com/geosoft1/tools/blob/master/LICENSE)
![go](https://img.shields.io/badge/go-1.12.5-green.svg)
![liteide](https://img.shields.io/badge/liteide-36-orange.svg)

Gopei shell install [Go](http://golang.org) compiler, [LiteIDE](https://github.com/visualfc/liteide) and configure for you the entire environment, variables, paths, ide interface and even link the machine with your Github account in a few minutes with just one command.

You don't need to use complicated commands on Mac or Linux so you just have to write go programs. 

Also, add some high level commands wich help you easy make a repository, clone, push or get a project and more.

This project is third party. For support see [golang.org](http://golang.org) and [github.com/visualfc/liteide](https://github.com/visualfc/liteide).

Read the user manual on the [wiki page](https://github.com/geosoft1/tools/wiki). For cloud tool read [here](https://github.com/geosoft1/tools/wiki/Cloud-tool).

**Features**

- Install a stable version of Go compiler and LiteIDE on almost any Unix/Linux based desktops and servers.
- Create a simple and practical layout for ide (liteide.ini.mini).
- Also create `GOPATH` and add a hello world project.
- Add a nice launcher to dock or desktop.
- Extend snippets, project templates and themes.
- Add some useful cloud scripts for
   - working with github (be sure you have installed `git` before and a valid acount)
   - servers in cloud (see [Quantum Teleporter](https://github.com/geosoft1/tools/wiki/Cloud-tool)).
- Gopei shell is free as in free speech and free beer and always will be.

**How to use**

[Download](https://github.com/geosoft1/tools/archive/master.zip) anywhere and unarchive. From Terminal go to the `tools-master` folder and simply run:

    ./gopei

or if you have a github account

    .gopei -g

Use `` -h `` switch to see all options.

Note that your system must have `bash`,`curl` and `git` installed before. Also, some systems may need additional [packages](https://github.com/geosoft1/tools/wiki#platform-specific-information).
