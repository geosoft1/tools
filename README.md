###tools
====
**Install.sh** - [golang](http://golang.org) compiler and [liteide](https://github.com/visualfc/liteide) simple installer for Ubuntu.

This project is third party. For support see http://golang.org and http://code.google.com/p/golangide/

[![latest_release](https://cloud.githubusercontent.com/assets/6298396/4099028/fc8391ec-3045-11e4-8b67-9e27a15fe91d.png)](https://github.com/geosoft1/tools/releases/latest)

* **Features**
    * Get and install last versions of go compiler and ide
    * Create a simple layout for ide (liteide.ini.mini)
    * Lot of gophers use Monaco font so add in ide
    * Also create a GOPATH to the go-programs directory and add a HelloWorld project
    * Add launcher to Unity with some useful functions on right-click. Other DE users have a shortcut on desktop
    * Add git support in ide on `` ctrl+` ``. Be sure you have configured [git](https://help.github.com/articles/set-up-git) before and proper [ssh keys](https://help.github.com/articles/generating-ssh-keys)
    * Extend project templates
* **Using**

    Download anywhere, from your graphical interface make it executable and run. If you prefer Terminal run next commands.

        chmod +x Install.sh
        ./Install.sh

    Run periodicaly or if compiler/ide versions change to update the sistem.
    Projects are not affected if you overinstall.
    Tested on Ubuntu 12.04 and 14.04.
	
    **Note:** Ubuntu 14.04 need script execute activation so run from Terminal
	
        gsettings set org.gnome.nautilus.preferences executable-text-activation launch

* **Using git from liteide**

    `` ctrl+` `` will provide a list of git commands

        git add
        git commit -m "-" -a
        git push

    Remember to use commands only if a file from project is open in editor, otherwise will fail.

====
