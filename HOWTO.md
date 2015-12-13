###Gopei Shell User Manual
====
Aply to: GoPEI v1.0.4.0+, Revision: 6

**Before install**

Gopei create GOPATH in $HOME/go-programs but if you keep this folder in other place (e.g. $HOME/my/go-programs) don't forget to make a link to that location in $HOME (e.g. ln -s $HOME/my/go-programs).

**Install in beginer mode (sempai mode)**

        ./Install.sh

Gopei will install last versions of [golang](http://golang.org) compiler and [LiteIDE](https://github.com/visualfc/liteide). Also will link go compiler with  LiteIDE. No root rights are required.

**Classroom mode**

        ./Install.sh -c

This option activate classroom mode. Can be combined with `` -g ``. No settings are preserved after closing LiteIDE. Do not use with LiteIDE prior than 27.1 due a compatibility issue in `` system.env ``.

**Emergency mode** (1.0.4.7+)

This option let you install a previous specific version on LiteIDE if the last version in unavailable. The versions can be taked from [here](http://sourceforge.net/projects/liteide/files/) (e.g. X27.2.1).

        ./Install.sh -e X27.2.1

Remember that if you downgrade the ide version you must check and switch the current environment (see View:Environment Toolbar) to system. Otherwise your programs will not be compiled.

**Install in advanced mode (sensei mode)** (1.0.4.0+)

        ./Install.sh -g

This option activate full mode (clasic+git suport). You must have a Github account.
You will be asked for sudo password. Don't worry about, is only for installing git.
Next you will be asked for user and email and Gopei will generate a ssh key for use with git server.

Also you must provide a password. You will be asked for this password at any push on server. You may set no password but is unsecure. For simplicity you can use the Github account password.

        Enter passphrase (empty for no passphrase): 
        Enter same passphrase again: 

Next you will be asked for Github account password. Do not confuse with previous password.

        Password:

Now the new key are deployed on Github. You will be asked again for phassphrase to check if the key work.

        Checking the keys...
        Enter passphrase for key '/home/george/.ssh/id_rsa': 
        Hi geosoft1! You've successfully authenticated, but GitHub does not provide shell access.

Note that if you reinstall with `` -g `` Gopei will look for existing ssh key and git profile to not override them.
If you uninstall with `` --all `` new key will be generate on Github. Old keys can be delete manualy from  [Personal settings/SSH keys](https://github.com/settings/ssh).

Remember that sometime key deploy can be very slow during Github mentenance. Just be patience or reinstall later.

**System only** (1.0.4.5+)

        ./Install.sh -s

This option remove Qt libs to solve conflict problems on some systems. The author of LiteIDE also provide a separate version without Qt containing `` -system `` in name.

**Uninstall**

        ./Install.sh -u

Uninstall all but not ssh keys and git profile.

**Uninstall all**

        ./Install.sh -U

Uninstall all and ssh keys (.ssh folder) and git profile (.gitconfig file). Be carefuly with this option if you have other keys in .ssh folder. Also keep safe .ssh folder and .gitconfig file to avoid keys regeneration at every update.

The uninstall process don't delete go-programs folder. `` -U `` option will delete .local/share/data/liteide/goplay folder.

Note that, starting with 1.0.4.1 some options can be combined (e.g `` -cg ``).

**Important!** If you update to new version of go compiler some programs dependencies like sql driver **must** be get and compiled again. Do Build|Get in LiteIDE if your program doesn't compile.

**After install**

If you use Ubuntu Unity interface right click on Gopei launcher icon show some usefull options.

* golang.org
* HTTP server (localhost:8080)
* GOPATH
* github.com/username

Note that are sistems where Qt may conflict. Just remove Qt from LiteIDE if wont start or use `` -s ``.

        rm liteide/lib/liteide/libQt*.*

**Using git from LiteIDE**

`` ctrl+` `` will provide a list of git commands like

        git add filename                   add filename to repo
        git commit -m "-" -a               commit changes to repo
        git push                           push changes to Github
        git pull                           pull changes from Github
        git push origin master             push changes first time (default not included)
        clone githubusername/projectname   (e.g. clone geosoft1/tools)
        repo                               create repo from your current project directory

These commands are generally sufficient but it is possible to receive some suggestions from git server in certain situations. Use those commands when you will be asked.

Remember to use commands only if a file from project is open in editor, otherwise will fail. Except from this rule `` clone `` command.

**Troubleshooting**

        sourceforge.com website is temporarily in static offline mode.

        github.com website is temporarily in static offline mode.

        fatal: remote error: 
          GitHub is offline for maintenance. See http://status.github.com for more info.

Due to maintenance procedure this sites can be inaccessible. You must try later.

Note that if you receive this message repeatedly and sourceforge is not offline use `` -e `` switch to install emergency ide version because from some reason the last version of the ide is not available.

        Permission denied (publickey).

You enter a wrong password. Reinstall and check the password.

**Useful installation schemes**

Install curent go compiler, LiteIDE X27.1 with git, in classroom mode, without qt libs

        ./Install.sh -gcse X27.1

**Using go from Terminal**

Is strongly recomanded to work in LiteIDE but Gopei set environment for go in .bashrc so is posible to use Terminal.

         cd $GOPATH
         cd src/HelloWorld/
         go build
         go install
         ~/go-programs/bin/HelloWorld

If the program have dependecies do go get command before go build

         go get github.com/user/repository

**Practical example to start a colaborative project**

* Create a git acoount on Github.
* Open Terminal and run `` ./Install.sh -g ``
* Enter user,email and password used with Github and wait setup to complete.
* Start LiteIDE and create new project Go1 Simple Project.
* At Name write `` github.com/githubuser/projectname ``
* Open `` main.go `` from this project.
* Press `` ctrl+` ``
* Use `` repo ``. You will be asked for password twice. Now your project will became a repo on Github.
* Use `` git add filename `` to add other files to your repo as you wish.
* Use `` git commit -m "-" -a `` and `` git push `` to push files to Github. Note that first time you will need to use `` git push origin master `` but not if you use `` repo `` command.
* Use `` clone github.com/projectname `` to clone projects.

**Make presentations** (1.0.4.6+)

* Start LiteIDE press `` ctrl+` `` and execute `` go get golang.org/x/tools/cmd/present `` only once, first time.
* Create a new directory named `` talks `` in $GOPATH/src or in $GOPATH/src/github.com/gituser.
* Create new project Go Present Slide File. Use Location/Browse to put it in your talks directory.
* Open and edit your presentation (see http://godoc.org/golang.org/x/tools/present).
* Execute `` go-programs/bin/present `` to start presentation server.
* Go to View/WebKitBrowser menu or in your favorite browser open http://127.0.0.1:3999 and click on your .slide file.
* With the arrows keys navigate through the presentation.
