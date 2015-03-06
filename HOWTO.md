**Using Gopei Shell**  

To install in clasic mode run

        ./Install.sh

Gopei will install the last go compiler and the last ide and link them. Also will add GOPATH in LiteIDE.

        ./Install.sh -g

This option activate full mode (clasic+git suport). You must have a git server account.
Default is github.com. You will be asked for user and email and Gopei will generate a ssh
key for use with git server. Copy sugested public key to git server and you are ready
for colaborative work.

Note that if you reinstall with -g Gopei will look for existing ssh key and git profile to not to override them.

        ./Install.sh -u

Uninstall all but not ssh keys and git profile.

        ./Install.sh -ua

Uninstall all and ssh keys (.ssh folder) and git profile (.gitconfig file). Be carefuly with this option if you have other keys in .ssh folder.

**Important!**

If you update to new version of go compiler some programs dependencies like sql driver **must** be get and compiled again. Do Build|Get in LiteIDE if your program doesn't compile.

**Using git from LiteIDE**

    `` ctrl+` `` will provide a list of git commands like

        git add <filename>
        git commit -m "-" -a
        git push
	    git push origin master             (if is first push on repository)
        clone githubusername/projectname   (e.g. clone geosoft1/tools)

Remember to use commands only if a file from project is open in editor, otherwise will fail. Except aliases and scripts from this rule (e.g. clone command).

**Using go from Terminal**

         cd $GOPATH
         cd src/HelloWorld/
         go build
         go install
         ~/go-programs/bin/HelloWorld

If program have dependecies do go get command before go build

         go get github.com/user/repository
