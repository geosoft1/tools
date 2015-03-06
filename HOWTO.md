###Gopei Shell User Manual
====
**Install in clasic mode**

        ./Install.sh

Gopei will install the last go compiler and the last ide and link them. Also will add GOPATH in LiteIDE.

**Install in full mode**

        ./Install.sh -g

This option activate full mode (clasic+git suport). You must have a git server account.
Default is github.com. You will be asked for user and email and Gopei will generate a ssh
key for use with git server. Copy sugested public key to git server and you are ready
for colaborative work.

Note that if you reinstall with -g Gopei will look for existing ssh key and git profile to not to override them.

**Uninstall**

        ./Install.sh -u

Uninstall all but not ssh keys and git profile.

**Uninstall all**

        ./Install.sh -ua

Uninstall all and ssh keys (.ssh folder) and git profile (.gitconfig file). Be carefuly with this option if you have other keys in .ssh folder.

**Important!** If you update to new version of go compiler some programs dependencies like sql driver **must** be get and compiled again. Do Build|Get in LiteIDE if your program doesn't compile.

**After install**

I used Ubuntu as main platform and best functionality is on Unity interface. Right click on Gopei launcher icon show some usefull options.

* golang.org
* HTTP server (localhost:8080)
* GOPATH

In full mode also you will see the new Gopei Shell icon :-)

**Using git from LiteIDE**

**CTRL+`** will provide a list of git commands like

        git add <filename>
        git commit -m "-" -a
        git push
        git pull
        git push origin master             (if is first push on repository)
        clone githubusername/projectname   (e.g. clone geosoft1/tools)

These commands are generally sufficient but it is possible to receive some suggestions from git server in certain situations (like git pull). Use those commands when you will be asked.

Remember to use commands only if a file from project is open in editor, otherwise will fail. Except aliases and scripts from this rule (e.g. clone command).

**Using go from Terminal**

Is strongly recomanded to work in LiteIDE but Gopei set environment for go in .bashrc so is posible to use Terminal.

         cd $GOPATH
         cd src/HelloWorld/
         go build
         go install
         ~/go-programs/bin/HelloWorld

If program have dependecies do go get command before go build

         go get github.com/user/repository

**Practical example to start a colaborative project**

* Create a git acoount on github
* Go to [Personal settings/SSH keys](https://github.com/settings/ssh) and Add SSH key
* Open Terminal and run

        ./Install.sh -g

* Copy suggested key into github page
* Create a new repository on github
* Start LiteIDE
* Clone existing project or create new
* Use `` git add <filename> `` to add files to your repository
* Use `` git commit -m "-" -a `` and `` git push `` to push files to github. Note that first time you will need to use `` git push origin master ``.
