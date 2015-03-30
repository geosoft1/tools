###Gopei Shell User Manual
====
**Install in beginer mode (sempai mode)**

        ./Install.sh

Gopei will install last versions of [golang](http://golang.org) compiler and [LiteIDE](https://github.com/visualfc/liteide). Also will link go compiler with  LiteIDE. No root rights are required.

**Install in advanced mode (sensei mode)**

        ./Install.sh -g

This option activate full mode (clasic+git suport). You must have a github account.
You will be asked for sudo password. Don't worry about, is only for installing git.
Next you will be asked for user and email and Gopei will generate a ssh key for use with git server.

Also you must provide a password. You will be asked for this password at any push on server. You may set no password but is unsecure.

        Enter passphrase (empty for no passphrase): 
        Enter same passphrase again: 

Next you will be asked for Github account password. Do not confuse with previous password.

        Password:

Now the new key are deployed on github. You will be asked again for phassphrase to check if the key work.

Note that if you reinstall with -g Gopei will look for existing ssh key and git profile to not override them.
If you uninstall with --all new key will be generate on github. Old keys can be delete manualy from github * [Personal settings/SSH keys](https://github.com/settings/ssh).

Remember that sometime key deploy can be very slow during github mentenance. Just be patience or reinstall later.

**Classroom mode**

        ./Install.sh -c

This option activate classroom mode. Can be combined with `` -g ``. No settings are preserved after closing LiteIDE.

**Uninstall**

        ./Install.sh -u

Uninstall all but not ssh keys and git profile.

**Uninstall all**

        ./Install.sh -u --all

Uninstall all and ssh keys (.ssh folder) and git profile (.gitconfig file). Be carefuly with this option if you have other keys in .ssh folder.

The uninstall process don't delete go-programs folder.

Note that, starting with 1.0.4.1 some options can be combined (e.g -cg).

**Important!** If you update to new version of go compiler some programs dependencies like sql driver **must** be get and compiled again. Do Build|Get in LiteIDE if your program doesn't compile.

**After install**

If you use Ubuntu Unity interface right click on Gopei launcher icon show some usefull options.

* golang.org
* HTTP server (localhost:8080)
* GOPATH

In full mode also you will see the new Gopei Shell icon :-)

Note that are sistems where Qt may conflict. Just remove Qt from LiteIDE if wont start.

        rm liteide/lib/liteide/libQt*.*

**Using git from LiteIDE**

**CTRL+`** will provide a list of git commands like

        git add filename                   add filename to repo
        git commit -m "-" -a               commit changes to repo
        git push                           push changes to github
        git pull                           pull changes from github
        git push origin master             push changes first time
        clone githubusername/projectname   (e.g. clone geosoft1/tools)
        repo                               create repo from your current project directory

These commands are generally sufficient but it is possible to receive some suggestions from git server in certain situations. Use those commands when you will be asked.

Remember to use commands only if a file from project is open in editor, otherwise will fail. Except from this rule clone command.

**Troubleshooting**

        fatal: remote error: 
          GitHub is offline for maintenance. See http://status.github.com for more info.

Github is under maintenance. Open github.com and you will see

        No server is currently available to service your request.
        Sorry about that. Please try refreshing and contact us if the problem persists.

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

* Create a git acoount on github.
* Open Terminal and run `` ./Install.sh -g ``
* Enter user,email and password used with github and wait setup to complete.
* Start LiteIDE and create new project Go1 Simple Project.
* At Name write `` github.com/githubuser/projectname ``
* Open `` main.go `` from this project.
* Use `` repo ``. You will be asked for password twice. Now your project will became a repo on github.
* Use `` git add filename `` to add other files to your repo as you wish.
* Use `` git commit -m "-" -a `` and `` git push `` to push files to github. Note that first time you will need to use `` git push origin master `` but not if you use `` repo `` command.
* Use `` clone github.com/projectname `` to clone projects.
