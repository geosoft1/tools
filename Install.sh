#!/bin/bash

# golang programming environment installer
# Copyright (C) 2014,2015  geosoft1@gmail.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

VERSION=1.0.4.6

#B0006
set -e

#if dumb terminal (file browser) run xterm
if [ $TERM == "dumb" ]; then
   xterm -hold -e $0
fi

clear
echo -e "Golang Programming Environment Installer\nCopyright (C) 2014,2015  geosoft1@gmail.com"
#-------------------------------------------------------------------------------
while getopts ":cghsu:v" OPTION; do
#avoid error if -u $OPTION=: and $OPTARG=u
if [ "$OPTION" == ":" ]; then OPTION=$OPTARG; fi
case $OPTION in
c|classroom)
   CLASSROOM=yes;;
g|github)
   GITSUPPORT=yes;;
h|help)
   echo "Usage: install [options]"
   echo
   echo "Options:"
   echo "-c, --classroom     enable classroom mode"
   echo "-g, --git           enable git suppport"
   echo "-h, --help          show this help message and exit"
   echo "-s, --system        install system only, no qt libs"
   echo "-u, --uninstall     uninstall"
   echo "--uninstall --all   include .gitconfig file and .ssh folder"
   echo "-v, --version       version"
   exit;;
s|system)
   QTLIBS=no;;
u|uninstall)
   rm -rf $HOME/liteide/
   rm -rf $HOME/go/
   rm -rf $HOME/.local/share/applications/liteide.desktop
   #B0020
   rm -f  $HOME/.local/share/data/liteide/*.*
   rm -rf $HOME/.config/liteide/
   rm -rf $HOME/.fonts/MONACO.TTF
   if [ "$OPTARG" == "--all" ]; then
      rm -rf $HOME/.local/share/data/liteide/
      rm -f $HOME/.gitconfig
      rm -rf $HOME/.ssh/
   fi
   #ugly! must rewrite sometime
   sed --in-place '/export GOROOT=$HOME\/go/d' $HOME/.bashrc
   sed --in-place '/export PATH=$PATH:$GOROOT\/bin/d' $HOME/.bashrc
   sed --in-place '/export GOPATH=$HOME\/go-programs/d' $HOME/.bashrc
   echo "Uninstalled."
   exit;;
v|-version)
   echo $VERSION
   exit;;
esac
done
#-------------------------------------------------------------------------------
#get host computer arch (e.g. i686|amd64)
#B0002,B0007
case $(uname -m) in
i686 ) a="386";;
   * ) a="amd64";;
esac

#get host computer LONG_BIT (e.g 32|64)
b=$(getconf LONG_BIT)

#get kernel name (e.g. linux|freebsd)
k=$(uname -s | tr '[:upper:]' '[:lower:]')

#get localized user directories
#B0005
test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
#-------------------------------------------------------------------------------
#get last version of go compiler (e.g. go1.3.3.)
#B0009
v=`echo $(wget -qO- golang.org) | 
awk '{
   if (match($0,/go([0-9]+.)+/)) 
      print substr($0,RSTART,RLENGTH)
}'`

#B0003 exit if no network connection otherwise the rest will fail 
if [ -z "$v" ]; then
   echo "No network connection"
   exit
fi

#build compiler name (e.g. go1.3.3.linux-386.tar.gz)
n=${v}${k}-${a}.tar.gz

echo "Download last compiler $n..."
#ERROR: certificate common name `*.googleusercontent.com' doesn't match requested host name `storage.googleapis.com'.
#To connect to storage.googleapis.com insecurely, use `--no-check-certificate'.
#WORKAROUND: expired sistems need --no-check-certificate to avoid this error
#B0004
wget --no-check-certificate -qNP ${XDG_DOWNLOAD_DIR} https://storage.googleapis.com/golang/$n
echo "Unpack..."
tar -xf ${XDG_DOWNLOAD_DIR}/$n -C $HOME
#-------------------------------------------------------------------------------
#determine last version of ide (e.g. X27.2.1) from github instead sourceforge
#B0009,B0011
#exit if github is offline otherwise the rest will fail 
v=`echo $(wget -qO- https://github.com/visualfc/liteide/blob/master/README.md) | 
awk '{ 
   if(match($0,/Version: X([0-9]+.)+/)) 
      print substr($0,RSTART+10,RLENGTH-10-1) 
}'`

if [ -z "$v" ]; then
   echo "github.com website is temporarily in static offline mode."
   exit
fi

#build ide name (e.g. liteidex23.2.linux-32.tar.bz2 | liteidex27.2.1.linux-32-qt4-system.tar.bz2)
#B0015,#B0018
n=`echo $(wget -qO- http://sourceforge.net/projects/liteide/files/X$v) | 
awk '{ 
   if(match($0, /liteidex([0-9 -]+\.)+'"$k"'-'"$b"'([-. a-z 0-9])+tar\.bz2\// )) { 
      print substr($0,RSTART,RLENGTH-1); 
      exit 0; 
   }
}'`

if [ -z "$n" ]; then
   echo "sourceforge.com website is temporarily in static offline mode."
   exit
fi

echo "Download last ide $n..."
wget -qNP ${XDG_DOWNLOAD_DIR} http://sourceforge.net/projects/liteide/files/X${v}/$n

#get last version name (experimental): liteidex27.2.1.linux-32-qt4-system.tar.bz2
#echo $(wget -qO- http://sourceforge.net/projects/liteide/files/) |  awk '{ 
#   if(match($0, /liteidex([0-9 -]+\.)+linux-[0-9][0-9]([-. a-z 0-9])+tar\.bz2/ )) { 
#      print substr($0,RSTART,RLENGTH);  
#   }
#}'
#get latest version file (experimental)
#wget -qNP ${XDG_DOWNLOAD_DIR} http://sourceforge.net/projects/liteide/files/latest/$n

echo "Unpack..."
tar -xf ${XDG_DOWNLOAD_DIR}/$n -C $HOME
#-------------------------------------------------------------------------------
if [ -n "$QTLIBS" ]; then
   rm $HOME/liteide/lib/liteide/libQt*.*
fi

echo "Get Monaco font..."
wget -nc -qP $HOME/.fonts http://usystem.googlecode.com/files/MONACO.TTF

echo "Create \$GOPATH"
GOPATH=$HOME/go-programs
mkdir -p $GOPATH/src

#create GOROOT
GOROOT=$HOME/go

echo "Add git support to liteide..."
#-------------------------------------------------------------------------------
if [ -n "$GITSUPPORT" ]; then
   GITSERVER="github.com"
   #install git and curl if not installed (#B0017)
   if ! which git > /dev/null; then
      echo "Install git..."
      sudo apt-get install git curl -y > /dev/null
   fi
   #create git configuration if not exist, otherwise use existent (~/.gitconfig)
   if [ -f $HOME/.gitconfig ]; then
      GITUSER=`awk 'NR==2 {print $3}' $HOME/.gitconfig`
      GITEMAIL=`awk 'NR==3 {print $3}' $HOME/.gitconfig`
   else
      echo "Setup git"
      echo -n "Git user ";read GITUSER
      echo -n "Git email [ENTER for $GITUSER@gmail.com] ";read GITEMAIL
      #try to guess git email
      if [ -z "$GITEMAIL" ]; then GITEMAIL="$GITUSER@gmail.com"; fi
      git config --global user.name "$GITUSER"
      git config --global user.email "$GITEMAIL"
   fi
   #generate ssh keys if not exist, otherwise use existent (https://help.github.com/articles/generating-ssh-keys/)
   KEYTYPE="rsa"
   if [ ! -f $HOME/.ssh/id_$KEYTYPE ]; then
      ssh-keygen -qt $KEYTYPE -C "$GITEMAIL" -f $HOME/.ssh/id_$KEYTYPE
      #add a new deploy key on github with api (https://developer.github.com/v3/)
      echo -n "Password:"; read -s GITPASSWORD
      echo 
      KEY=`cat $HOME/.ssh/id_$KEYTYPE.pub`
      err=`curl -s -u $GITUSER:$GITPASSWORD https://api.github.com/user/keys -d '{"title":"'$GITEMAIL'", "key":"'"${KEY}"'"}'| awk '/message/ { gsub(/^[\t ]+|[\",]/,"");print }'`
      if [ "$err" != "" ]; then
         echo -e $err
      fi
   fi
   #bug workaround https://help.github.com/articles/error-permission-denied-publickey
   eval `ssh-agent -s` > /dev/null
   echo "Checking the keys..."
   #workaround: if ssh result is false (Permission denied (publickey).) set -e will stop the script
   #prevent this by changing result code to true and let the script to continue
   ssh -o StrictHostKeyChecking=no -o LogLevel=error -T git@github.com || true
   #create github.com in $GOPATH
   mkdir -p $GOPATH/src/github.com/$GITUSER
   #show gopei shell mode :-)
   #wget -q https://raw.githubusercontent.com/geosoft1/tools/master/gopher/gopeicolor.png -O $GOROOT/doc/gopher/gophercolor.png

   #setup desktop action to launcher
   GITACTION="$GITSERVER;"
   GITDESKTOPACTION="[Desktop Action $GITSERVER]
Name=github.com/$GITUSER
Exec=xdg-open http://github.com/$GITUSER"
fi
#-------------------------------------------------------------------------------
#build essential git commands list
echo -e "git commit -m \"-\" -a
git push
git pull
git add *
clone
repo
go get golang.org/x/tools/cmd/present
go-programs/bin/present" >$HOME/liteide/share/liteide/litebuild/command/go.api

#add git clone repository command (external script)
wget -q https://raw.githubusercontent.com/geosoft1/tools/master/scripts/clone -O $HOME/liteide/bin/clone
chmod +x $HOME/liteide/bin/clone

#add git create repository command (external script)
wget -q https://raw.githubusercontent.com/geosoft1/tools/master/scripts/repo -O $HOME/liteide/bin/repo
chmod +x $HOME/liteide/bin/repo
#-------------------------------------------------------------------------------
#create system environment for ide
#B0012,#B0019
echo -e 'GOARCH='$a'\nGOROOT=$HOME/go\nPATH=$PATH:$GOROOT/bin' >> $HOME/liteide/share/liteide/liteenv/system.env

echo "Create liteide.ini.mini"
#create directory for liteide.ini.mini
mkdir -p $HOME/.config/liteide
#get liteide.ini.mini from github.com
wget -q https://raw.githubusercontent.com/geosoft1/tools/master/liteide.ini.mini -O $HOME/.config/liteide/liteide.ini
sed -i "s#\$a#$a#g; s#\$GOPATH#$GOPATH#g; s#\$GOROOT#$GOROOT#g; s#\$HOME#$HOME#g" $HOME/.config/liteide/liteide.ini
if [ "$CLASSROOM" == "yes" ]; then
   #B0016
   cp $HOME/.config/liteide/liteide.ini $HOME/.config/liteide/liteide.ini.mini
   #add customizer command
   CUSTOMIZER="cp $HOME/.config/liteide/liteide.ini.mini $HOME/.config/liteide/liteide.ini;"
fi

#create generic .desktop file on desktop
echo -e "[Desktop Entry]
Version=1.0
Name=LiteIDE
Comment=LiteIDE is a simple, open source, cross-platform Go IDE. 
Exec=sh -c 'eval \`ssh-agent -s\`;$CUSTOMIZER$HOME/liteide/bin/liteide'
Icon=$GOROOT/doc/gopher/gophercolor.png
Type=Application" > ${XDG_DESKTOP_DIR}/liteide.desktop

echo "Create smart launcher"
case $DESKTOP_SESSION in
ubuntu*)
   #create directory for liteide.desktop
   mkdir -p $HOME/.local/share/applications/
   #B0014
   #extend .desktop file with nice options
   echo -e "Actions=golang;http;gopath;$GITACTION
\n[Desktop Action golang]
Name=golang.org
Exec=xdg-open http://golang.org/pkg
\n[Desktop Action http]
Name=HTTP server (localhost:8080)
Exec=xdg-open http://localhost:8080
\n[Desktop Action gopath]
Name=GOPATH
Exec=xdg-open go-programs/src
\n$GITDESKTOPACTION" >> ${XDG_DESKTOP_DIR}/liteide.desktop

   #add .desktop file to dash and integrate with unity
   mv ${XDG_DESKTOP_DIR}/liteide.desktop $HOME/.local/share/applications
   #get the current launcher favorites list
   b=$(gsettings get com.canonical.Unity.Launcher favorites)
   #skip update if liteide launcher already exists
   if ! [[ $b =~ "liteide.desktop" ]]; then
      b=${b/]/, \'liteide.desktop\']}
      #B0001
      sleep 1
      #update the launcher favorites list. in unity changes are shwown immediately.
      gsettings set com.canonical.Unity.Launcher favorites "$b"
      #WORKAROUND: unity2d need restart to show last changes
      #if [[ $DESKTOP_SESSION =~ "2d" ]]; then
      #  killall unity-2d-shell;
      #fi
   fi;;
#other desktop environments can be handled here
*)
   #generic desktop environment have only a desktop shortcut
   #B0008
   chmod +x ${XDG_DESKTOP_DIR}/liteide.desktop;;
esac

echo "Create some useful templates"
TEMPL=$HOME/liteide/share/liteide/liteapp/template

#create simple template
sed -i '1i gosimple' $TEMPL/project.sub
mkdir -p $TEMPL/gosimple

echo -e "// \$ROOT\$ project
package main\n
func main() {
}" > $TEMPL/gosimple/main.go

echo -e "[SETUP]
NAME = \"Go1 Simple Project\"
AUTHOR = geosoft1
INFO = new go1 simple project
TYPE = gopath
FILES = main.go
OPEN = main.go
SCHEME=folder" > $TEMPL/gosimple/setup.inf

#create gpl template
sed -i '2i gogpl' $TEMPL/project.sub
mkdir -p $TEMPL/gogpl

year=`date +"%Y"`
author=$GITUSER
email=$GITEMAIL
if [ "$author" == "" ]; then
   author="<name of the author>"
fi
if [ "$email" == "" ]; then
   email="<email>"
fi
echo -e "// \$ROOT\$ project
// Copyright (C) $year  $author  $email
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
\npackage main\n
func main() {
}" > $TEMPL/gogpl/main.go

echo -e "[SETUP]
NAME = \"Go1 GPL Project\"
FILES = main.go LICENSE CONTRIBUTORS README.md
AUTHOR = geosoft1
INFO = new go1 gpl project
TYPE = gopath
OPEN = main.go
SCHEME=folder" > $TEMPL/gogpl/setup.inf

wget -Nq -O $TEMPL/gogpl/LICENSE http://www.gnu.org/licenses/gpl.txt
#touch $TEMPL/gogpl/CONTRIBUTORS
echo $GITEMAIL > $TEMPL/gogpl/CONTRIBUTORS
echo -e "\$ROOT\$\n====" > $TEMPL/gogpl/README.md

echo "Create HelloWorld program"
mkdir -p $GOPATH/src/HelloWorld
echo -e "package main\n
func main() {
\tprintln(\"Hello World!\")
}" > $GOPATH/src/HelloWorld/main.go

#B0013, add GOPATH,GOROOT to PATH but in $HOME/.bashrc to avoid root rights
#ugly! must rewrite sometime
grep -q 'export GOROOT=$HOME\/go' $HOME/.bashrc || sed -i '$ a\export GOROOT=$HOME\/go' $HOME/.bashrc
grep -q 'export PATH=$PATH:$GOROOT\/bin' $HOME/.bashrc || sed -i '$ a\export PATH=$PATH:$GOROOT\/bin' $HOME/.bashrc
grep -q 'export GOPATH=$HOME\/go-programs' $HOME/.bashrc || sed -i '$ a\export GOPATH=$HOME\/go-programs' $HOME/.bashrc

echo "Done."
