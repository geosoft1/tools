#!/bin/bash
#
# Golang programming environment installer
# NOTE:
# this project is third party. for support see http://golang.org and http://code.google.com/p/golangide/
# author       : geosoft1@gmail.com
# license      : GPLv3
# goal         : get last versions of Go compiler and LiteIde,install them, make a nice launcher and a more useful ide layout
# compatibible : Ubuntu 12.04+ (Unity)
# version      : 1.0.0.1
#
# 07.08.2014   - start project, skeleton, tests
#
# TODO:
# uninstall
#
clear

#get go compiler last version (e.g. go1.3)
#p=`wget -qO- golang.org`
#v=`echo $p |  awk '{ if (match($0,/go[1-9]+.[0-9]+./)) print substr($0,RSTART,RLENGTH) }'`
v=`echo $(wget -qO- golang.org) | awk '{ if (match($0,/go[1-9]+.[0-9]+./)) print substr($0,RSTART,RLENGTH) }'`
#get host computer arch (e.g. i386,amd64)
a=$(uname -i)
if [ $a == "i386" ]; then a=${a:1}; else a=$p; fi
cname=${v}linux-${a}.tar.gz
echo "Downloading compiler $cname..."
#http://golang.org/dl/go1.3.linux-386.tar.gz
wget -Nq -P $HOME/Downloads http://golang.org/dl/$cname --progress=bar:force 2>&1 | tail -f -n +8

#get liteide last version (e.g. X23.2)
v=`echo $(wget -qO- http://sourceforge.net/projects/liteide/files/) | awk '{ if(match($0,/X[0-9]+.[0-9]+/)) print substr($0,RSTART,RLENGTH) }'`
#get host computer LONG_BIT (e.g 32,64)
a=$(getconf LONG_BIT)
idename=liteidex${v:1}.linux-${a}.tar.bz2
echo "Downloading liteide $idename..."
#http://sourceforge.net/projects/liteide/files/X23.2/liteidex23.2.linux-32.tar.bz2
wget -Nq -P $HOME/Downloads http://sourceforge.net/projects/liteide/files/${v}/liteidex${v:1}.linux-${a}.tar.bz2

echo "Getting Monaco font..."
wget -Nq -P $HOME/.fonts http://usystem.googlecode.com/files/MONACO.TTF
echo "Unpacking all..."
#for f in $HOME/Downloads/*;do tar -xf $f -C $HOME;done
tar -xf $HOME/Downloads/$cname -C $HOME
tar -xf $HOME/Downloads/$idename -C $HOME
echo "Creating \$GOPATH"
mkdir -p $HOME/go-programs/src
mkdir -p $HOME/.config/liteide

echo "Creating more eficient layout for ide (ini.mini)"
echo "
[liteenv]
currentenv=linux32

[liteide]
gopath="$HOME"/go-programs

[liteapp]
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

[golangdoc]
goroot="$HOME"/go

[FileBrowser]
root="$HOME"/go-programs/src
synceditor=false

[FileManager]
initpath="$HOME"

[%General]
Language=en_US
WelcomePageVisible=false

[editor]
family=Monaco
fontsize=11" > $HOME/.config/liteide/liteide.ini.mini

echo "
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=LiteIDE
Comment=LiteIDE is a simple, open source, cross-platform Go IDE. 
Exec=sh -c 'cp .config/liteide/liteide.ini.mini .config/liteide/liteide.ini; "$HOME"/liteide/bin/liteide'
Icon="$HOME"/go/doc/gopher/gophercolor.png
Type=Application
Categories=Network;

Actions=golang;http server;gopath;

[Desktop Action golang]
Name=golang.org
Exec=firefox golang.org/pkg %U
OnlyShowIn=Unity;

[Desktop Action http server]
Name=HTTP server (localhost:8080)
Exec=firefox localhost:8080
OnlyShowIn=Unity;

[Desktop Action gopath]
Name=\$GOPATH
Exec=nautilus go-programs/src %U
OnlyShowIn=Unity;" > $HOME/.local/share/applications/liteide.desktop

echo "Creating nice launcher"
b=$(gsettings get com.canonical.Unity.Launcher favorites)
if ! [[ $b =~ "liteide.desktop" ]]; then
b=${b/]/, \'liteide.desktop\']}
gsettings set com.canonical.Unity.Launcher favorites "$b"
fi
echo "Creating HelloWorld program"
mkdir -p $HOME/go-programs/src/HelloWorld
echo "package main

import (
	\"fmt\"
)

func main() {
	fmt.Println(\"Hello World!\")
}" > $HOME/go-programs/src/HelloWorld/main.go

echo "Done."
