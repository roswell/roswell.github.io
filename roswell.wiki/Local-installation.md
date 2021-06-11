In [[Installation]], we described how to install roswell from the source. However, it assumed the global installation.

**Local installation** is available by specifying `--prefix` option to `./configure`. The default location is `/usr/local`. Actual binary is installed in `$PREFIX/bin` and supporting files are installed into `$PREFIX/etc/roswell/`.

This is useful when using roswell as a backend of CI services (e.g. travis): When you specify a directory accessible without root permission, then you can switch to the new [container-based infrastructure](http://docs.travis-ci.com/user/workers/container-based-infrastructure/) for faster startup (of the tests). 
[We already provide such a script for Travis, CircleCI and Coverall](https://github.com/roswell/roswell/wiki/Roswell-as-a-Testing-Environment) using this feature. 

Another usage is for bundling roswell in a standalone project which does not alter the user environment at all.

Example:

    $ git clone -b release https://github.com/roswell/roswell.git
    $ cd roswell
    $ sh bootstrap
    $ ./configure --prefix=$HOME/.local/
    $ make && make install              ### in this case, no sudo is required!
    $ ~/.local/bin/ros

