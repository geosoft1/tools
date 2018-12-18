## Cloud tool (Quantum Teleporter)

Cloud tool let you run and deploy your projects on servers or on other computers.

- [Getting started with cloud tool](#getting-started-with-cloud-tool)
- [Working with cloud tool](#working-with-cloud-tool)
  - [.config file structure](#config-file-structure)
  - [Commands](#commands)
    - [init](#init)
    - [push](#push), [run](#run), [teleport](#teleport), [detach](#detach), [kill](#kill), [restart](#restart)
    - [deploy](#deploy), [delete](#delete), [remove](#remove)
    - [cli](#cli)
    - [version](#version)
  - [Using from Terminal](#using-from-terminal)
  - [Multiple configuration files](#multiple-configuration-files)
- [Faq](#faq)
  - [What exactly **is** Quantum Teleporter?](#what-exactly-is-quantum-teleporter)
  - [Who should use cloud tool?](#who-should-use-cloud-tool)
  - [What code name mean?](#what-code-name-mean)
  - [How do i delete all .config files?](#how-do-i-delete-all-config-files)
- [Troubleshooting](#troubleshooting)
- [Platform Specific Information](#platform-specific-information)
- [Disclaimer](#disclaimer)

## Getting started with cloud tool

Cloud tool can easy used from IDE by typing in local comand line:

        cloud

with no arguments to see all options. Also can be used from [Terminal](#using-from-terminal).

## Working with cloud tool

Cloud tool use ssh/scp for connecting to remote machines. You must have a properly ssh server on remote machines and ssh/scp clients on local machines.

Following commands are executed in user space with remote user rights. No root rights are required.

Remember that before start with cloud tool you must have a ssh key with a pasphrase corectly generated on your local machine. If you use [Gopei shell](https://github.com/geosoft1/tools), [install in advanced mode](https://github.com/geosoft1/tools/wiki#install-in-advanced-mode), otherwise use [ssh-keygen](https://help.github.com/articles/generating-ssh-keys/) for.

Cloud tool is project oriented tool so at least one file from your project must be opened in IDE before running this tool. If used from [Terminal](#using-from-terminal) change the current folder to project folder.

#### .config file structure

Cloud tool need a `.config` file in every project folder with the following structure

- `REMOTE_ADDR`,`REMOTE_PORT` address and port of the ssh server
- `REMOTE_USER` user on remote server (can be different from local user)
- `DELAY` short delay for programs working for example with `mysql` and start to quick as against the server at startup (default 1)
- `ENV` environment passed to your program, can contain more variables separated by space
- `ARGS` arguments passed to your program (flags)

e.g.

        REMOTE_ADDR=192.168.88.143
        REMOTE_PORT=22
        REMOTE_USER=george
        DELAY=3
        ENV="A=1 B=2"
        ARGS="-conf=conf/home.json -verbose"

Note that if this file missing you will be ask to create.

#### Commands

#### `init`

        cloud init

Initialize a connection with a remote machine. Run this command one time for one machine from your local project folder.

You will be asked for remote server address, user and password. The current public `ssh` key will be pushed on remote machine and you will be linked with for further commands.

        Remote server 192.168.88.161
        Remote user [ENTER for george] 
        -- push ssh key to george@192.168.88.161:22
        george@192.168.88.164's password: 1234
        Done.

If you get `lost connection` see [troubleshooting](#troubleshooting)

`.config` file are also created in local project folder and will keep this informations but not the password. Further cloud commands will use this file.

Delete the `.config` file and run `cloud init` again to connect to other machines. Also you can modify the file to switch the server runtime.

Note that the `init` funtion is invoked automaticaly if no connection is found by the other commands.

#### `push`

        cloud push

Push the entire current project folder content on remote machine. Sources and binaries. Also push command will follow current sources tree structure.

Before run this command the project must be compiled with remote machine architecture.
View IDE environment bar for this.

#### `run`

        cloud run

`run` remote pushed project or remote executable and view results localy. Before run this command the project must be compiled and pushed on the remote machine.

Note that, if you start remote a listening project like a web server and interrupt connection from IDE or Terminal, the process will still run on remote machine. Running again will get an error and this is a normal situation. Use [kill](#kill) command to stop remote processes.

Also note that cloud tool allow you to work remotely. If you use in you program any kind of file paths remember to use completly path or obtain from your program current path otherwise your running program will not find those files.

        pwd, err := filepath.Abs(filepath.Dir(os.Args[0]))
        if err != nil {
                os.Exit(1)
        }

Worked in IDE projects executables get the project folder name. If you have, from some reasons, other executables or scripts in this folder you can execute them remote with

        cloud run filename

#### `teleport`

        cloud teleport

`teleport` command is nothing else than `push` and `run`. Also reflect the main concept of the cloud tool.

#### `detach`

        cloud detach

`detach` run remote pushed project or remote executable and detach ssh session. Useful in some circumstances when the project stops after the connection close.

#### `kill`

        cloud kill
        cloud kill filename

`kill` command stop remote started processes.

#### `deploy`

        cloud deploy

Completly deploy the project on remote machine and also add the main executable to remote machine startup. The project will continue running even after remote machine restart.

Before run this command the project must be compiled with remote machine architecture.

#### `restart`

Kill and detach the project on remote machine.

#### `delete`

Stop and delete the project from remote machine. Doesn't affect the startup of the machine.

#### `remove`

        cloud remove

`remove` command stop and delete the project from remote machine. Also, remove from remote machine startup.

#### `cli`

        cloud cli

`term` start a ssh console on remote machine.

#### `version`

        cloud version

Version of this tool.

## Using from Terminal

Change folder to your project and run `cloud [options]`.

## Multiple configuration files

An explicit name can be given to the configuration file as second argument (eg:`.home`). 

		cloud init .home

This name will be concatenated with `.config` base resulting the final file name `.config.home`. If no name is given the default name `.config` will be used.

Useful when a project have multiple implementation and host multiple `.config` files.

## Faq

## What exactly **is** Quantum Teleporter?

It is a deploy by replacement tool not a versioning tool. Use only if you understand exactly the concept. May alter ireversible the existing project on the remote machine.

## Why `pull` command is missing?

Because is very risky. `pull` overwrite the local project and that may be bad. Cloud tool is a final deploy tool and transfer should be unidirectional.

## Who should use cloud tool?

All those people who want to automatize deploy on many servers, write web services, work on various architectures and don't know specific configuration files and commands.

Also can be used by peoples who work colaborative and exchange or present projects.

## How do i delete all .config files?

        find -name .config -type f -delete

Make sure that `-delete` is the last argument in your command otherwise it will delete **everything**.

## Troubleshooting

If you don't get `Done.` message check

- your network conectivity
- your firewall allow ssh port
- if the remote server respond
- if you enter right the server address,user and password
- .config file exist

If your deployed project stops after the ssh connection close do this:

        cloud detach

If you delete the `.ssh` folder on the remote machine don't foget to delete it from the source machine or run `cloud init`.

## What code name mean?

Fancy names are funny. Teleportation concept mean one to one fully operational replication and that is exactly what doing this tool.

## Platform Specific Information

Cloud tool need ssh servers and clients. Should work on the platforms that [Gopei shell](https://github.com/geosoft1/tools/wiki#platform-specific-information) work.

## Disclaimer

The programs are provided as is without any guarantees or warranty.
Although the author has attempted to find and correct any bugs in the free software programs, the author is not responsible for any damage or losses of any kind caused by the use or misuse of the programs.
The author is under no obligation to provide support, service, corrections, or upgrades to the free software programs.
