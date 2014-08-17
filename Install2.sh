#!/bin/bash
#
# golang programming environment installer
# NOTE:
# this project is third party. for support see http://golang.org and http://code.google.com/p/golangide/
# author       : geosoft1@gmail.com
# license      : GPLv3
# version      : 2.0.0.1
#
# 07.08.2014   - start project, skeleton, tests (1.0.0.1).
# 08.08.2014   - added $DESKTOP_SESSION,kernel name and 64bit support (1.0.0.2),eye candy (1.0.0.3).
# 10.08.2014   - better integration with unity launcher bar. compact generated files (1.0.0.4).
# 17.08.2014   - code optimization and experimental git support (2.0.0.1).
#
# TODO:
# +some Unity2d improvements
# +shortcut for other desktop environments
# -adding zenity for more interactivity with the user
# wget http://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz 2>&1 | sed -u 's/.* \([0-9]%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading go1.3.1.linux-amd64.tar.gz" --auto-close --width="400" 
# +adding git support (install,config user,generate ssh keys,add $GOPATH/github.com/user/)
# +liteide git support ($HOME/liteide/share/liteide/litebuild/command/go.api)
#

clear

#get last version of go compiler (e.g. go1.3)
v=`echo $(wget -qO- golang.org) | awk '{ if (match($0,/go[1-9]+.[0-9]+./)) print substr($0,RSTART,RLENGTH) }'`

#get host computer arch (e.g. i386|amd64)
if [[ $(uname -i) == "i386" ]]; then a="386"; else a="amd64"; fi

#get kernel name (e.g. linux|freebsd)
k=$(uname -s | tr '[:upper:]' '[:lower:]')

#build compiler name (e.g. go1.3.linux-386.tar.gz)
name=${v}${k}-${a}.tar.gz

echo "Download last compiler $name..."
wget -Nq -P $HOME/Downloads http://golang.org/dl/$name --progress=bar:force 2>&1 | tail -f -n +8
echo "Unpack..."
tar -xf $HOME/Downloads/$name -C $HOME

#get last version of ide (e.g. X23.2)
v=`echo $(wget -qO- http://sourceforge.net/projects/liteide/files/) | awk '{ if(match($0,/X[0-9]+.[0-9]+/)) print substr($0,RSTART,RLENGTH) }'`

#get host computer LONG_BIT (e.g 32|64)
a=$(getconf LONG_BIT)

#build ide name (e.g. liteidex23.2.linux-32.tar.bz2)
name=liteidex${v:1}.${k}-${a}.tar.bz2

echo "Download last ide $name..."
wget -Nq -P $HOME/Downloads http://sourceforge.net/projects/liteide/files/${v}/$name
echo "Unpack..."
tar -xf $HOME/Downloads/$name -C $HOME

echo "Get Monaco font..."
wget -Nq -P $HOME/.fonts http://usystem.googlecode.com/files/MONACO.TTF

echo "Create \$GOPATH"
GOPATH=$HOME/go-programs
mkdir -p $GOPATH/src

echo "Install git..."
sudo apt-get install git -y > /dev/null
echo "Setup github"
echo -n "Git user  ";read GITUSER
echo -n "Git email ";read EMAIL
echo -n "Git server [ENTER for github.com]"; read GITSERVER
if [ $GITSERVER=="" ]; then GITSERVER="github.com"; fi

#create git configuration
echo -e "[user]
	name = $GITUSER
	email = $EMAIL" > $HOME/.gitconfig

KEY="rsa"
#if [ ! -f $HOME/.ssh/id_$KEY ];
#then
ssh-keygen -qt $KEY -C "$EMAIL"
# -f $HOME/.ssh/id_$KEY
echo "Copy next key to $GITSERVER/settings/ssh and press any key"
echo
cat $HOME/.ssh/id_$KEY.pub
read
#bug workaround https://help.github.com/articles/error-permission-denied-publickey
eval `ssh-agent -s` > /dev/null
#ssh-add ~/.ssh/id_rsa
echo "Checking the key..."
ssh -o "StrictHostKeyChecking no" -T git@$GITSERVER
#create $GITSERVER in $GOPATH
mkdir -p $GOPATH/src/$GITSERVER/$GITUSER


echo "Add git support to liteide..."
echo -e "git clone git@$GITSERVER:$GITUSER/PROJECT.git $GOPATH/src/$GITSERVER/$GITUSER/PROJECT
git commit -m \"-\" -a
git push" >$HOME/liteide/share/liteide/litebuild/command/go.api

#create GOROOT
GOROOT=$HOME/go

echo "Create liteide.ini.mini"
#create directory for liteide.ini.mini
mkdir -p $HOME/.config/liteide
echo -e "[liteenv]
currentenv=linux$a
\n[liteide]
gopath=$GOPATH
\n[liteapp]
geometry=\"@ByteArray(\x1\xd9\xd0\xcb\0\x1\0\0\0\0\0\x41\0\0\0\x18\0\0\x5U\0\0\x2\xff\0\0\0\0\0\0\0,\0\0\x3\x17\0\0\x2\xd3\0\0\0\0\x2\0)\"
state=@ByteArray(\0\0\0\xff\0\0\0\0\xfd\0\0\0\x4\0\0\0\0\0\0\x1&\0\0\x2\x8d\xfc\x2\0\0\0\x2\xfb\0\0\0\f\0\x64\0o\0\x63\0k\0_\0\x31\0\0\0\0\0\xff\xff\xff\xff\0\0\0 \0\xff\xff\xff\xfb\0\0\0\x18\0\x64\0o\0\x63\0k\0_\0\x31\0_\0s\0p\0l\0i\0t\x1\0\0\0\x39\0\0\x2\x8d\0\0\0\xab\0\xff\xff\xff\0\0\0\x1\0\0\x1\x1d\0\0\x2\x8d\xfc\x2\0\0\0\x2\xfb\0\0\0\f\0\x64\0o\0\x63\0k\0_\0\x32\0\0\0\0\x39\0\0\x2\x8d\0\0\0 \0\xff\xff\xff\xfb\0\0\0\x18\0\x64\0o\0\x63\0k\0_\0\x32\0_\0s\0p\0l\0i\0t\0\0\0\0\0\xff\xff\xff\xff\0\0\0 \0\xff\xff\xff\0\0\0\x2\0\0\0\0\0\0\0\0\xfc\x1\0\0\0\x2\xfb\0\0\0\f\0\x64\0o\0\x63\0k\0_\0\x34\0\0\0\0\0\xff\xff\xff\xff\0\0\0^\0\xff\xff\xff\xfb\0\0\0\x18\0\x64\0o\0\x63\0k\0_\0\x34\0_\0s\0p\0l\0i\0t\0\0\0\0\0\xff\xff\xff\xff\0\0\0^\0\xff\xff\xff\0\0\0\x3\0\0\x4\xdb\0\0\0@\xfc\x1\0\0\0\x2\xfb\0\0\0\f\0\x64\0o\0\x63\0k\0_\0\x38\0\0\0\0\x1d\0\0\x4\xdb\0\0\0^\0\xff\xff\xff\xfb\0\0\0\x18\0\x64\0o\0\x63\0k\0_\0\x38\0_\0s\0p\0l\0i\0t\0\0\0\0\0\xff\xff\xff\xff\0\0\0^\0\xff\xff\xff\0\0\x3\xe9\0\0\x2\x8d\0\0\0\x4\0\0\0\x4\0\0\0\b\0\0\0\b\xfc\0\0\0\x3\0\0\0\0\0\0\0\x1\0\0\0\f\0t\0o\0o\0l\0_\0\x31\x2\0\0\0\0\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\x1\0\0\0\f\0t\0o\0o\0l\0_\0\x32\x2\0\0\0\0\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\x2\0\0\0\x4\0\0\0\f\0t\0o\0o\0l\0_\0\x34\0\0\0\0\0\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\x16\0t\0o\0o\0l\0\x62\0\x61\0r\0/\0s\0t\0\x64\0\0\0\0\0\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\x16\0t\0o\0o\0l\0\x62\0\x61\0r\0/\0\x65\0n\0v\0\0\0\0\0\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\x18\0t\0o\0o\0l\0\x62\0\x61\0r\0/\0t\0\x61\0\x62\0s\x1\0\0\0\0\xff\xff\xff\xff\0\0\0\0\0\0\0\0)
toolState=@ByteArray(\0\0\xff\xe0\0\0\0\0\0\0\0\xe\0\x66\0o\0l\0\x64\0\x65\0r\0s\0\0\0\x1\0\0\0\0\0\x10\0\x65\0v\0\x65\0n\0t\0l\0o\0g\0\0\0\b\x1\0\0\0\0\x18\0s\0\x65\0\x61\0r\0\x63\0h\0r\0\x65\0s\0u\0l\0t\0\0\0\b\x1\0\0\0\0\x16\0\x62\0u\0i\0l\0\x64\0o\0u\0t\0p\0u\0t\0\0\0\b\0\0\0\0\0\xe\0o\0u\0t\0l\0i\0n\0\x65\0\0\0\x2\0\0\0\0\0\x12\0\x63\0l\0\x61\0s\0s\0v\0i\0\x65\0w\0\0\0\x2\0\0\0\0\0\x1a\0W\0\x65\0\x62\0K\0i\0t\0\x42\0r\0o\0w\0s\0\x65\0r\0\0\0\b\0\0\0\0\0\x16\0H\0t\0m\0l\0P\0r\0\x65\0v\0i\0\x65\0w\0\0\0\x2\0\0\0\0\0\x16\0\x64\0\x65\0\x62\0u\0g\0o\0u\0t\0p\0u\0t\0\0\0\b\0\0\0\0\0\x1a\0g\0o\0p\0\x61\0\x63\0k\0\x62\0r\0o\0w\0s\0\x65\0r\0\0\0\x1\x1\0\0\0\0\x18\0g\0o\0\x64\0o\0\x63\0/\0s\0\x65\0\x61\0r\0\x63\0h\0\0\0\x1\x1\0\0\0\0\x12\0g\0o\0\x64\0o\0\x63\0/\0\x61\0p\0i\0\0\0\x1\x1\0\0\0\0\x14\0\x66\0i\0l\0\x65\0s\0y\0s\0t\0\x65\0m\0\0\0\x1\x1\x1)
ShowEditToolbar=false
FolderShowHidenFiles=false
MaxRecentFiles=16
AutoLoadLastSession=false
SplashVisible=false
EditTabsClosable=true
StartupReloadFiles=true
StartupReloadFolders=true
FileWatcherAutoReload=false
\n[golangdoc]
goroot=$GOROOT
\n[FileBrowser]
root=$GOPATH/src
synceditor=false
\n[FileManager]
initpath=$HOME
\n[%General]
Language=en_US
WelcomePageVisible=false
\n[editor]
family=Monaco
fontsize=12" > $HOME/.config/liteide/liteide.ini.mini

#create generic .desktop file on desktop
echo -e "[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=LiteIDE
Comment=LiteIDE is a simple, open source, cross-platform Go IDE. 
Exec=sh -c 'cp .config/liteide/liteide.ini.mini .config/liteide/liteide.ini; eval \`ssh-agent -s\`; $HOME/liteide/bin/liteide'
Icon=$GOROOT/doc/gopher/gophercolor.png
Type=Application
Categories=Network;" > $HOME/Desktop/liteide.desktop

echo "Create smart launcher"
case $DESKTOP_SESSION in
ubuntu*)
   #create directory for liteide.desktop
   mkdir -p $HOME/.local/share/applications/

   #extend .desktop file with nice options
   echo -e "\nActions=golang;http server;gopath;github;
\n[Desktop Action golang]
Name=golang.org
Exec=firefox golang.org/pkg %U
OnlyShowIn=Unity;
\n[Desktop Action http server]
Name=HTTP server (localhost:8080)
Exec=firefox localhost:8080
OnlyShowIn=Unity;
\n[Desktop Action gopath]
Name=\$GOPATH
Exec=nautilus go-programs/src %U
OnlyShowIn=Unity;
\n[Desktop Action github]
Name=github.com/$GITUSER
Exec=firefox github.com/$GITUSER %U
OnlyShowIn=Unity;" >> $HOME/Desktop/liteide.desktop
   #add .desktop file to dash and integrate with unity
   mv $HOME/Desktop/liteide.desktop $HOME/.local/share/applications
   #get the current launcher favorites list
   b=$(gsettings get com.canonical.Unity.Launcher favorites)
   #skip update if liteide launcher already exists
   if ! [[ $b =~ "liteide.desktop" ]]; then
      #eye candy if is put after firefox or nautilus :)
      if [[ $b =~ "firefox.desktop" ]]; then
         #check if firefox has a launcher and insert liteide after
         b=${b/\'firefox.desktop\'/ \'firefox.desktop\', \'liteide.desktop\'}
      elif [[ $b =~ "nautilus-home.desktop" ]]; then
         #if someone does not use firefox, insert after home folder
         b=${b/\'nautilus-home.desktop\'/ \'nautilus-home.desktop\', \'liteide.desktop\'}
      else
         #otherwise, insert after all favorites
         b=${b/]/, \'liteide.desktop\']}
      fi
      #update the launcher favorites list. in unity changes are shwown immediately.
      gsettings set com.canonical.Unity.Launcher favorites "$b"
      #unity2d need restart to show last changes
      if [[ $DESKTOP_SESSION =~ "2d" ]]; then
         killall unity-2d-shell;
      fi
   fi
   ;;
#other desktop environments can be handled here
*)
   #generic desktop environment have only a desktop shortcut
   chmod +x $HOME/Desktop/liteide.desktop
   ;;
esac

echo "Create HelloWorld program"
mkdir -p $GOPATH/src/HelloWorld
echo -e "package main\n
func main() {
	println(\"Hello World!\")
}" > $GOPATH/src/HelloWorld/main.go

echo "Done."
