<div align=right>
<h3><i>"Simplicity is complicated"</i><br>
- Rob Pike
</div>

## Table of contents

- [Getting started with Gopei](#getting-started-with-gopei)
- [Working with Gopei](#working-with-gopei)
  - [Before install](#before-install)
  - [Install in beginer mode](#install-in-beginer-mode)
  - [Install in advanced mode](#install-in-advanced-mode)
  - Other options
    - [Install in server mode](#install-in-server-mode)
    - [Install in classroom mode](#install-in-classroom-mode)
    - [Install with no QT libs](#install-with-no-qt-libs)
    - [Uninstall](#unistall)
    - [Uninstall all](#uninstall-all)
    - [Help](#help)
    - [Version](#version)
  - [After install](#after-install)
  - [Tools](#tools)
    - [Github tool](#github-tool)
    - [Install tool](#install-tool)
    - [Cloud tool](#cloud-tool)
    - [Nightly build tool](#nightly-build-tool)
  - [Using git from LiteIDE](#using-git-from-liteide)
  - [Using go from Terminal](#using-go-from-terminal)
  - [Using toolbox from Terminal](#using-toolbox-from-terminal)
  - [Practical example to start a colaborative project](#practical-example-to-start-a-colaborative-project)
  - [Make talks and articles](#make-talks-and-articles)
  - [Install debugger](#install-debugger)
- [Troubleshooting](#troubleshooting)
  - [Sourceforge](#sourceforge)
  - [Qt](#qt)
  - [gocode](#gocode)
- [Known issues](#known-issues)
- [Platform Specific Information](#platform-specific-information)
- [Release Specific Information](#release-specific-information)
- [Faq](#faq)
  - [What exactly **is** Gopei shell?](#what-exactly-is-gopei)
  - [Gopei is a shell?](#gopei-is-a-shell)
  - [Who should use Gopei?](#who-should-use-gopei)
  - [Why Gopei goes multi-platform now?](#why-gopei-goes-multi-platform-now)
  - [But why Windows isn't on the list?](#but-why-windows-isnt-on-the-list)
  - [What code name mean?](#what-code-name-mean)
  - [Gopei don't install the last IDE. Why?](#gopei-dont-install-the-last-ide-why)
- [Articles](#articles)


## Getting started with Gopei

[Download](https://github.com/geosoft1/tools/archive/master.zip) anywhere and unarchive.

        curl -LO github.com/geosoft1/tools/archive/master.zip && unzip master.zip

From Terminal go to the `tools-master` folder and simply run:

        ./gopei

Use `` -h `` switch to see all options.

Run periodicaly or if compiler/ide versions change to update the system. Projects are never affected if you overinstall.

Note that your system must have `bash`,`curl` and `git` installed before. Also, some systems need additional packages described in the [Platform Specific Information](#platform-specific-information).

## Working with Gopei

#### Before install

Gopei create `GOPATH` in `$HOME` but if you keep this folder in other place don't forget to make a link to that location (e.g `ln -s ~/my/src`).

#### Install in beginer mode

        ./gopei

Gopei will install the last version of [golang](http://golang.org) compiler and a stable version of [LiteIDE](https://github.com/visualfc/liteide). Also will link go compiler with LiteIDE. No root rights are required.

#### Install in advanced mode

        ./gopei -g

This option activate full mode (clasic+git suport). You must have a Github account and `git` installed.
You will be asked for user and email and Gopei will generate a ssh key for use with git server.

Also you must provide a password. You also may set no password or for simplicity you can use the Github account password. You will be asked for this password at any push on server.

        Enter passphrase (empty for no passphrase): 
        Enter same passphrase again: 

Next you will be asked for Github account password. Do not confuse with previous password.

        Password:

Now the new key are deployed on Github. You will be asked again for phassphrase to check if the key work.

        Checking the keys...
        Enter passphrase for key '/home/george/.ssh/id_rsa': 
        Hi geosoft1! You've successfully authenticated, but GitHub does not provide shell access.

Note that if you reinstall with `` -g `` Gopei will look for existing ssh key and git profile to not override them.
If you uninstalled with `` -U `` then a new key will be generate on Github. Old keys can be deleted manualy from [Personal settings/SSH keys](https://github.com/settings/ssh).

Remember that sometime key deploy can be very slow during Github mentenance. Just be patience or reinstall later.

#### Install in server mode

        ./gopei -s
 
Install golang compiler only.


#### Install in classroom mode

        ./gopei -c

This option activate classroom mode. No settings are preserved after closing LiteIDE.

#### Install with no QT libs

        ./gopei -q

This option remove Qt libs to solve conflict problems on some systems.

#### Uninstall

        ./gopei -u

Uninstall all but not ssh keys and git profile.

#### Uninstall all

        ./gopei -U

Uninstall all and ssh keys (`.ssh` folder) and git profile (`.gitconfig` file). Be carefuly with this option if you have other keys in `.ssh` folder. Also keep safe `.ssh` folder and `.gitconfig` file to avoid keys regeneration at every update.

Note that `-U` don't delete the key from Github but local. You must authenticate on Github for.

The uninstall process don't delete go programs folder. `-U` option will delete local `liteide/goplay` folder.

#### Help

        ./gopei -h

Short help message.

#### Version

        ./gopei -v

Show Gopei shell version.

Note that some options can be combined (e.g `-cg`).

#### After install

If you update to new version of go compiler some programs dependencies like sql driver **must** be get and compiled again. Do `Build|Get` in LiteIDE if your program doesn't compile.

If you use Ubuntu Unity interface right click on Gopei launcher icon show some usefull options.

* golang.org
* HTTP server (localhost:8080)
* GOPATH
* github.com/username

If you use the new Ubuntu Gnome interface, search in dash LiteIDE and add to favorite.
 
Starting with Go 1.9 Mac users need to choose `darwin64-home` environment in LiteIDE otherwise the programs won't compile or run.

#### Tools

#### Github tool

Allow you to easy do some complicated tasks

        tools/github

Without parameters show a list of options.

        tools/github new

Create a new repo from your current project directory on `github.com`. At least one file from your project must be opened in LiteIDE before running this tool. If used from [Terminal](#using-from-terminal) change the current folder to project folder.

        tools/github clone githubuser/project

Clone existing project (e.g. `tools/github clone geosoft1/tools`)

#### Install tool

        tools/install

Install some useful tools like [delve](https://github.com/derekparker/delve) debugger or [presenter](https://godoc.org/golang.org/x/tools/present).

#### Cloud tool

        tools/cloud

Alow you to run and deploy remote projects. Without parameters show a list of options. Read more on the project [Wiki](https://github.com/geosoft1/tools/wiki/Cloud-tool) page.

#### Nightly build tool

Schedule build and deploy at given period of time.

        tools/nb

Without parameters show a list of options.

#### Add a schedule

        tools/nb add
        GOOS=linux
        nightly build ? [ENTER @midnight | m h dom mon dow] 

Posible options are `@midnight` (default) or a given date and time in `crontab` format (minute hour day_of_month month day_of_week). Use `*` if you want to skip a field. Example:

       nightly build ? [ENTER @midnight | m h dom mon dow] 00 14 * * *

**Note** that the tool detect architecture where the project will run and show it. Choose this architecture proper before starting this tool otherwise your project won't run remote. Do this from `LiteIDE:Current environment` or by setting proper `GOOS` environment variable.

**Important:** Do not let your working station in standby otherwise the tool won't work.

You can also queue more projects to deploy on various servers.

#### Remove schedule

        tools/nb remove

Remove a prior created schedule.

#### Using git from LiteIDE

`` ctrl+` `` will provide a list of git commands like

        git add filename                  add filename to repo
        git commit -m "-" -a              commit changes to repo
        git push                          push changes to Github
        git pull                          pull changes from Github

These commands are generally sufficient but it is possible to receive some suggestions from git server in certain situations. Use those commands when you will be asked.

#### Using go from Terminal

Is recomanded to work in LiteIDE but Gopei set environment for go in .bashrc so is posible to use Terminal.

         cd $GOPATH
         cd src/helloworld/
         go build
         go install
         helloworld

If the program have dependecies do go get command before go build

         go get github.com/user/repository

#### Using toolbox from Terminal

Run follow command after install

         find ~/go/bin/tools/* -exec ln -s "{}" go/bin/ ';'

#### Practical example to start a colaborative project

* Create a git acoount on Github.
* Open Terminal and run `./gopei -g`
* Enter user,email and password used with Github and wait setup to complete.
* Start LiteIDE and create new project Go1 Simple Project.
* At name write `github.com/githubuser/projectname`
* Open `main.go` from this project.
* Press `` ctrl+` ``
* Use `tools/github new`. You will be asked for password twice. Now your project will magicaly became a repo on Github.
* Use `git add filename` or simply `git add *` to add other files to your repo as you wish.
* Use `git commit -m "-" -a` and `git push` to push files to Github. Note that first time you will need to use `git push origin master` but not if you use `tools/github new` command.
* Use `tools/github clone githubuser/project` to clone projects.

Remember that you can't remove a repository from Gopei. You must authenticate on Github for.

#### Make talks and articles

Real gophers make [talks](https://talks.golang.org) and [articles](https://blog.golang.org) based on Google [present](http://godoc.org/golang.org/x/tools/present) package. LiteIDE know markdown format. You just need to add the presenter.

* Start LiteIDE press `` ctrl+` `` and execute `tools/install present` only once, first time.
* Create a new directory named `talks` in $GOPATH/src or in $GOPATH/src/github.com/gituser.
* Create new project Go Present Slide File. Use Location/Browse to put it in your talks directory.
* Open and edit your presentation (see [present](http://godoc.org/golang.org/x/tools/present) package for how to).
* Execute `present` to start presentation server.
* In your favorite browser open [http://127.0.0.1:3999](http://127.0.0.1:3999) and click on your `.slide` file.
* With the arrows keys navigate through the presentation.

#### Install debugger

Default gdb is not proper for debugging go programs. A good debugger is [delve](https://github.com/derekparker/delve). LiteIDE has support for. All you need to do is to install the debugger.

* Start LiteIDE press `` ctrl+` `` and execute once `tools/install delve`.
* Select `Debug|debugger/delve` from LiteIDE menu.
* Use `F5`, `F10` and `F11` to debug your code.

## Troubleshooting

### Sourceforge

        sourceforge.com website is temporarily in static offline mode.

        github.com website is temporarily in static offline mode.

        fatal: remote error: 
          GitHub is offline for maintenance. See http://status.github.com for more info.

Due to maintenance procedure those sites may be inaccessible. You must try later. Also check your internet connection and restrictions.

        bzip2: (stdin) is not a bzip2 file.
        tar: Child returned status 2
        tar: Error is not recoverable: exiting now

If you check the wrong archive you will see this

        We're sorry -- the Sourceforge site is currently in Disaster Recovery mode.  Please check back later.

Also try later, github mentenance :(

        Permission denied (publickey).

You enter a wrong password. Reinstall and check the password.

### Qt

Note that are sistems where Qt may conflict. Just remove Qt from LiteIDE if wont start or use `-q`.

        rm liteide/lib/liteide/libQt*.*

Also, check [Platform Specific Information](#platform-specific-information) for prequisites needed on some systems.

### gocode

If `gocode` from LiteIDE don't handle newest versions of Go compiler just update it.

       go get github.com/nsf/gocode
       mv bin/gocode liteide/bin/

## Known issues

* no support for localization on OS X yet
* `.fonts` folder is not used on some systems so a Monospace font must be manualy set in LiteIDE
* `delve` has a issue on OS X (could not launch process: could not fork/exec) and can't be used under LiteIDE.

## Platform Specific Information

Gopei is build around `bash` and `curl`. Also you may need to install `git`. See your package manager to find howto (a few examples below):

* Install `git` on OS X

        xcode-select --install

* Trisquel, Debian, Ubuntu 16.04.2+, Kubuntu and Mint need `curl` and `git`

        sudo apt-get install curl git

* Ubuntu 17+ need `libpng12` which miss from official repository

        wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb && sudo dpkg -i /tmp/libpng12.deb && rm /tmp/libpng12.deb

* Fedora and Centos need `libpng12` for LiteIDE

        sudo yum install libpng12 git

* OpenSUSE `libpng12` is named `libpng12-0`

        sudo zypper in libpng12-0 git

* Sabayon `libpng12` is named `libpng:1.2`

        sudo equo install libpng:1.2 --ask

* FreeBSD need `bash` installed. Also `bash` must be runed before working in golang.

        pkg install bash curl git
        bash

* Arch Linux need `libpng12` for LiteIDE

        yaourt -S libpng12

To compile a 32 bits application on the 64 bit Linux you must install some libs.

* On a Debian or Ubuntu Linux type

        sudo apt-get install gcc-multilib libc6-dev-i386
 
* On a Suse (SLES) / OpenSUSE Linux type

        zypper in glibc-devel-32bit

## Release Specific Information

**Gopei shell work with**

* OS X 10.11 El Capitan
* Ubuntu 12, 14, 16, 18, +Server, Lubuntu/Kubuntu 16+
* Debian 8
* Mint 17
* Trisquel 7
* OpenSUSE 42
* FreeBSD 10
* Fedora 24
* Sabayon 16
* Arch Linux
* Centos 7
* Raspbian (Raspberry Pi3)

## Faq

#### What exactly **is** Gopei?
Gopei is an installer for Go environment (compiler+LiteIDE) but also customize the IDE to bring easiest programming experience for you.

#### Gopei is a shell?
In a way, yes. Gopei bring a set of tools accessible from IDE to make your life better using git, debugger or other tools.

#### Who should use Gopei?
Basicaly Gopei was born from need to make Go language accesible to everyone with or without computer experience.

So, the first target is the beginers. Also, the classroom mode can be used in teaching.

Another destination is all those people who want to work simple and quickly. Golang is a simple language so tools used must be simplest too.

#### Why Gopei goes multi-platform now?
Next step is working in cloud. So, this was a natural step for.

Another reason is that the most golang programmers seems to use OS X so this was an important target.

Also, some users work on many servers so a server mode was an interesting idea.

#### But why Windows isn't on the list?
Due different architecture and especially because the missing tools, Windows need a totally different approach. No plans to porting but can work under [Windows Subsystem for Linux](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide) (untested). 

#### What code name mean?
Silly names are funny. From now Gopei code name will reflect the most interesting idea implemented in that version.

So, the first code name mean one script for many operating systems (The Convergence).

#### Gopei don't install the last IDE. Why?

It's not outdated. From compatibility reasons some versions of IDE work or not on some Linux distros. So, i prefer to have an error free tool instead an up to date one. Don't be afraid, are not so big differences between installed version and the last.

## Articles

- [http://www.webupd8.org/2014/09/easily-install-latest-golang-compiler.html](http://www.webupd8.org/2014/09/easily-install-latest-golang-compiler.html)
- [https://www.edivaldobrito.com.br/como-instalar-facilmente-o-compilador-e-varios-outros-itens-relacionados-a-linguagem-go/](https://www.edivaldobrito.com.br/como-instalar-facilmente-o-compilador-e-varios-outros-itens-relacionados-a-linguagem-go/)
- [http://sperse3.rssing.com/chan-3433311/all_p133.html](http://sperse3.rssing.com/chan-3433311/all_p133.html)
- [http://golangweekly.com/issues/77](http://golangweekly.com/issues/77)
- [https://www.despre-linux.eu/programeaza-in-go-sub-linux-cu-gopei/](https://www.despre-linux.eu/programeaza-in-go-sub-linux-cu-gopei/) (Romanian)
- [https://www.despre-linux.eu/gopei-shell-a-lansat-si-partea-de-cloud/](https://www.despre-linux.eu/gopei-shell-a-lansat-si-partea-de-cloud/) (Romanian)
