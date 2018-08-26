## Cloud4 tool (Quantum Teleporter)

Cloud tool can easy used typing

        tools/cloud4

Cloud tool need a `.config` file in every project folder. First line of this file has the following structure

- `REMOTE_ADDR`,`REMOTE_PORT` address and port of the ssh server
- `REMOTE_USER` user on remote server (can be different from local user)
- `DELAY` short delay for programs working for example with `mysql` and start to quick as against the server at startup (default 1)
- `LOG` log file (default ~/log)
- `ENV` environment passed to your program, can contain more variables separated by space
- `ARGS` arguments passed to your program (flags)

e.g.

        REMOTE_ADDR=192.168.88.143
        REMOTE_PORT=22
        REMOTE_USER=george
        DELAY=3
        LOG=~/log
        ENV="A=1 B=2"
        ARGS="-conf=conf/home.json -debug=true"

Note that if this file missing you will be ask to create.

`cloud4` use the same commands like old cloud tool but without backup option.
