## Cloud tool (Quantum Teleporter)

Cloud tool let you run and deploy your projects on servers or on other computers.

- [Getting started with cloud tool](#getting-started-with-cloud-tool)
- [Working with cloud tool](#working-with-cloud-tool)
  - [.servers file structure](#servers-file-structure)
  - [Commands](#commands)
    - [init](#init)
	- [push](#push), [run](#run), [detach](#detach), [teleport](#teleport), [kill](#kill)
	- [deploy](#deploy), [delete](#delete), [remove](#remove)
	- [backup](#backup)
	- [terminal](#terminal)
	- [version](#version)
  - [Using from Terminal](#using-from-terminal)
- [Faq](#faq)
  - [What exactly **is** Quantum Teleporter?](#what-exactly-is-quantum-teleporter)
  - [Who should use cloud tool?](#who-should-use-cloud-tool)
  - [What code name mean?](#what-code-name-mean)
  - [How do i delete all .servers files?](#how-do-i-delete-all-servers-files)
- [Troubleshooting](#troubleshooting)
- [Platform Specific Information](#platform-specific-information)
- [Disclaimer](#disclaimer)

## Getting started with cloud tool

Cloud tool can easy used from LiteIDE by pressing `` ctrl+` `` and chosing

        tools/cloud

with no arguments to see all options. Also can be used from [Terminal](#using-from-terminal).

## Working with cloud tool

Cloud tool use ssh/scp for connecting to remote machines. You must have a properly ssh server on remote machines and ssh/scp clients on local machines.

Following commands are executed in user space with remote user rights. No root rights are required.

Remember that before start with cloud tool you must have a ssh key with a pasphrase corectly generated on your local machine. If you use [Gopei shell](https://github.com/geosoft1/tools), [install in advanced mode](https://github.com/geosoft1/tools/wiki#install-in-advanced-mode), otherwise use [ssh-keygen](https://help.github.com/articles/generating-ssh-keys/) for.

Cloud tool is project oriented tool so at least one file from your project must be opened in LiteIDE before running this tool. If used from [Terminal](#using-from-terminal) change the current folder to project folder.

#### .servers file structure

Cloud tool need a `.servers` file in every project folder. First line of this file has the following structure

        REMOTE_IP REMOTE_PORT REMOTE_USER

e.g.

        192.168.88.161 2222 george

Note that if this file missing you will be ask to create.

#### Commands
#### `init`

        tools/cloud init

Initialize a connection with a remote machine. Run this command one time for one machine from your local project folder.

You will be asked for remote server address, user and password. The current public `ssh` key will be pushed on remote machine and you will be linked with for further commands.

        Remote server 192.168.88.161
        Remote user [ENTER for george] 
        -- push ssh key to george@192.168.88.161:22
        george@192.168.88.164's password: 1234
        Done.

If you get `lost connection` see [troubleshooting](#troubleshooting)

`.servers` file are also created in local project folder and will keep this informations but not the password. Further cloud commands will use this file.

Delete the `.servers` file and run `tools/cloud init` again to connect to other machines. Also you can modify the file to switch the server runtime.

Note that the `init` funtion is invoked automaticaly if no connection is found by the other commands.

#### `push`

        tools/cloud push

Push the entire current project folder content on remote machine. Sources and binaries. Also push command will follow current sources tree structure.

Before run this command the project must be compiled with remote machine architecture.
View LiteIDE environment bar for this.

#### `run`

        tools/cloud run

`run` remote pushed project or remote executable and view results localy. Before run this command the project must be compiled and pushed on the remote machine.

Note that, if you start remote a listening project like a web server and interrupt connection from LiteIDE or Terminal, the process will still run on remote machine. Running again will get an error and this is a normal situation. Use [kill](#kill) command to stop remote processes.

Also note that cloud tool allow you to work remotely. If you use in you program any kind of file paths remember to use completly path or obtain from your program current path otherwise your running program will not find those files.

        pwd, err := filepath.Abs(filepath.Dir(os.Args[0]))
        if err != nil {
                os.Exit(1)
        }

Worked in LiteIDE projects executables get the project folder name. If you have, from some reasons, other executables or scripts in this folder you can execute them remote with

        tools/cloud run filename

#### `detach`

        tools/cloud detach

`detach` run remote pushed project or remote executable and detach ssh session. Useful in some circumstances when the project stops after the connection close.

#### `teleport`

        tools/cloud teleport

`teleport` command is nothing else than `push` and `run`. Also reflect the main concept of the cloud tool.

#### `kill`

        tools/cloud kill
        tools/cloud kill filename

`kill` command stop remote started processes.

#### `deploy`

        tools/cloud deploy

Completly deploy the project on remote machine and also add the main executable to remote machine startup. The project will continue running even after remote machine restart.

Before run this command the project must be compiled with remote machine architecture.
#### `delete`

Stop and delete the project from remote machine. Doesn't affect the startup of the machine.

#### `remove`

        tools/cloud remove

`remove` command stop and delete the project from remote machine. Also, remove from remote machine startup.

#### `backup`

Completly save the GOPATH on remote machine. Backup can be mirrored or versioned (default).

Backup tool use a `.backup` config file with the same structure as `.servers` file. `.backup` config file is found in the `GOPATH/src` folder.

        tools/cloud backup

Versioned backup. On remote machine a folder named `backup-USERNAME@MACHINENAME-datetime` will be created eg.:

        backup-george@ao756-180220173221

mean backup from user and machine `george@ao756` at 18 Feb 2017, `3221` minutes,seconds for making unique the folder name.  

        tools/cloud backup init

Initialize or reinitialize the connection with a remote machine.

        tools/cloud backup list

List existing backup folders from the remote machine.

        tools/cloud backup remove

Delete existing backup folders from the remote machine. Without arguments no folder will be removed. Posible argument is backup folder mask eg.:

        tools/cloud backup remove backup                 # this will remove only the existing backup folder
        tools/cloud backup remove backup-*               # remove any existing folder starting with `backup-` 
        tools/cloud backup remove backup-george*         # remove any existing folder made by user `george`
        tools/cloud backup remove backup-george@ao765*   # remove any existing made from george's machine 

**Mirroring**

        tools/cloud backup mirror

Mirror backup are made. On the remote machine a forder named `backup` is made. This folder contain one-to-one mirror copy of local `GOPATH/src folder`.

Note that if you use backup tool from more than one machine on one backup server don't use mirror backup, instead use versioned backup. Remember that this is a quick backup tool not a very sofisticated backup software.

Backup tool don't use differences or compresion but [teleportation](#what-exactly-is-quantum-teleporter) mechanism.

#### `terminal`

        tools/cloud terminal

`term` start a ssh console on remote machine.

#### `version`

        tools/cloud version

Version of this tool.

## Using from Terminal

Change folder to your project, if you install with  [Gopei shell](https://github.com/geosoft1/tools) the cloud tool are found in `$GOROOT/bin/tools`.

        cd ~/src/helloworld
        $GOROOT/bin/tools/cloud version

## Faq

## What exactly **is** Quantum Teleporter?

It is a deploy by replacement tool not a versioning tool. Use only if you understand exactly the concept. May alter ireversible the existing project on the remote machine.

## Why `pull` command is missing?

Because is very risky. `pull` overwrite the local project and that may be bad. Cloud tool is a final deploy tool and transfer should be unidirectional.

## Who should use cloud tool?

All those people who want to automatize deploy on many servers, write web services, work on various architectures and don't know specific configuration files and commands.

Also can be used by peoples who work colaborative and exchange or present projects.

## How do i delete all .servers files?

        find -name .servers -type f -delete

Make sure that `-delete` is the last argument in your command otherwise it will delete **everything**.

## Why backup tool is part of cloud tool?

Simply because mostly the code is shared with cloud tool.

## Troubleshooting

If you don't get `Done.` message check

- your network conectivity
- your firewall allow ssh port
- if the remote server respond
- if you enter right the server address,user and password
- .servers file exist

If your deployed project stops after the ssh connection close do this:

        tools/cloud detach

## What code name mean?

Fancy names are funny. Teleportation concept mean one to one fully operational replication and that is exactly what doing this tool.

## Platform Specific Information

Cloud tool need ssh servers and clients. Should work on the platforms that [Gopei shell](https://github.com/geosoft1/tools/wiki#platform-specific-information) work.

## Disclaimer

The programs are provided as is without any guarantees or warranty.
Although the author has attempted to find and correct any bugs in the free software programs, the author is not responsible for any damage or losses of any kind caused by the use or misuse of the programs.
The author is under no obligation to provide support, service, corrections, or upgrades to the free software programs.
