
Roswell keeps its effect on the system to the minimum.

Installing roswell on linux causes the core C runtime (`ros` binary) in `/usr/local/bin/` and a few lisp files under `/usr/local/etc/roswell`. They are completely safe to remove once you decide to remove roswell.
You can optionally change this installation directory by `./configure --prefix=/path/`. See [Local installation](https://github.com/roswell/roswell/wiki/Local-installation).

Roswell *DOES NOT* use this directory for its runtime operation (subcommands like `ros install sbcl`).
Files downloaded/created/manipulated by Roswell are kept under `~/.roswell` directory. It is completely safe to remove this directory without affect the integrity of the system, nor roswell itself. Removing this directory means resetting Roswell to the blank state, just like removing `~/.mozilla` for firefox which removes all of your preferences/history/plugins.

Quicklisp, ASDF, or Quicklisp libraries installed by Roswell does not affect, nor is affected by, the Quicklisp, ASDF, or the libraries that you installed manually. Roswell downloads and keeps them separately under `~/.roswell`.

Implementations installed by Roswell does not affect, nor is affected by, the implementations already installed on the system. However, roswell is able to use those systems by `ros use <IMPL>/system` (e.g. `ros use sbcl/system`) or `ros -L <IMPL>/system ...` which uses the binary visible from PATH.

Roswell does not write to the system configuration files nor user configuration files outside roswell, such as `.profile`, `.bashrc`, `.emacs` or `.sbclrc`. Nor does Roswell magically alter the environment variables like PATH.
