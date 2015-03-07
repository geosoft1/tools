###tools
====
**Install.sh** - [golang](http://golang.org) compiler and [liteide](https://github.com/visualfc/liteide) simple installer for Ubuntu.

This project is third party. For support see http://golang.org and https://github.com/visualfc/liteide

![screenshot from 2014-09-07 18 16 40](https://cloud.githubusercontent.com/assets/6298396/4178685/4460829c-36a2-11e4-9674-236082f70d03.png)

[![last-version-blue](https://cloud.githubusercontent.com/assets/6298396/5602522/8967405e-935b-11e4-8777-de3623ed6ad7.png)](https://github.com/geosoft1/tools/archive/master.zip)
[![last-release-green](https://cloud.githubusercontent.com/assets/6298396/5602520/83eb3f72-935b-11e4-9fc0-296506ca5c9a.png)](https://github.com/geosoft1/tools/releases/latest)

* **Features**
    * Get and install last versions of go compiler and ide.
    * Create a simple layout for ide (liteide.ini.mini)
    * Lot of gophers use Monaco font so add in ide
    * Also create a GOPATH to the go-programs directory and add a HelloWorld project
    * Add git support (1.0.4.0+)
    * Add launcher to Unity with some useful functions on right-click. Other DE users have a shortcut on desktop
    * Add git support in ide on `` ctrl+` ``. Be sure you have configured [git] (https://help.github.com/articles/set-up-git) before with proper [ssh keys](https://help.github.com/articles/generating-ssh-keys) or use -g switch for.
    * Extend project templates with **Go1 Simple Project** and **Go1 GPL Project**
    
    See [CHANGES](https://github.com/geosoft1/tools/blob/master/CHANGES) for new features and bug corrections or use -h option to get help.

	Read [User Manual](https://github.com/geosoft1/tools/blob/master/HOWTO.md) for more details.
	
* **Use**

    Download anywhere and run from your file browser with double click. If you prefer Terminal go to the directory with the script and run

        ./Install.sh -h

    To see all options.

    Run periodicaly or if compiler/ide versions change to update the sistem.
    Projects are not affected if you overinstall.
    Tested on Ubuntu 12.04,14.04,14.10.
	
    **Note:** Ubuntu 14.04+ need script execute activation so run from Terminal
	
	For Nautilus use:
	
        gsettings set org.gnome.nautilus.preferences executable-text-activation launch

	For Nemo use:
	
        gsettings set org.nemo.preferences executable-text-activation ask
