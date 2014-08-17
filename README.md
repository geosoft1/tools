###tools
====
**Install.sh** - [golang](http://golang.org) compiler and [liteide](https://github.com/visualfc/liteide) simple installer for Ubuntu.

* **Features**
    * Get and install last versions of go compiler and ide
    * Create a more practical layout for ide (liteide.ini.mini)
    * Lot of gophers use Monaco font so add in ide
    * Also create a GOPATH to the go-programs directory and add a HelloWorld project
    * Add launcher to Unity with some useful functions on right-click. Other DE users have a shortcut on desktop
    * Add git support in ide on `` ctrl+` ``. Be sure you have configured [git](https://help.github.com/articles/set-up-git) before and proper [ssh keys](https://help.github.com/articles/generating-ssh-keys)
* **Using**

    Download anywhere, make it executable and run. If you want to watch the installation process run it in Terminal.

        chmod +x Install.sh
        ./Install.sh

    Run periodicaly or if compiler/ide versions change to update the sistem.
    Projects are not affected if you overinstall.

* **Using git from liteide**

    `` ctrl+` `` will provide a list of git commands

        git add
        git commit -m "-" -a
        git push

    Remember to use commands only if a file from project is open in editor, otherwise will fail.

====
**Install2.sh** - more advanced installer (experimental)

* **Features**
    * Install git
    * Configure git user and email
    * Generate ssh keys pair and connect to Github
    * a workaround prevent `[Permission denied (publickey)]`(https://help.github.com/articles/error-permission-denied-publickey)
      so, you shoud not get this error
    * Add git server and user to $GOPATH
    * Extend liteide git support with **git clone** command
    * Extend smart launcher with Github option

* **Using**

   Your installation shoud be like that

        Download last compiler go1.3.linux-386.tar.gz...
        Unpack...
        Download last ide liteidex23.2.linux-32.tar.bz2...
        Unpack...
        Get Monaco font...
        Create $GOPATH
        Install git...
        [sudo] password for user: [here put your sudo password]
        Setup github
        Git user  [here put your gihub user]
        Git email [here put your email]
        Git server [ENTER for github.com]
        Enter file in which to save the key (/home/george/.ssh/id_rsa): 
        **here you must see**
        Enter passphrase (empty for no passphrase): [here write a password for git access]
        Enter same passphrase again: 
        **or if you already generate keys**
        /home/george/.ssh/id_rsa already exists.
        Overwrite (y/n)? n      #just press n to skip this step
        
        Copy next key to github.com/settings/ssh and press any key   #if already do, just press ENTER
        
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQAB...
        Adb3OAeIrMqix7n3Yj189 ...@gmail.com
        
        Checking the key...
        Enter passphrase for key '/home/george/.ssh/id_rsa':    # enter the git access password
        Hi user! You've successfully authenticated, but GitHub does not provide shell access.
        Add git support to liteide...
        Create liteide.ini.mini
        Create smart launcher
        Create HelloWorld program
        Done.

* **Using git from liteide**

    `` ctrl+` `` extend list of git commands

        git clone git@github.com:gituser/PROJECT.git /home/user/go-programs/src/github.com/gituser/PROJECT

    Replace PROJECT with your project name from Github to clone.


