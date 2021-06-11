## Roswell Installation

### How does Roswell change my system?

See [[Policy on how Roswell affects or manipulates your system]].

### Why is Roswell core written in C?

See [[Why C?]]

### How do I customize the system-wide installation dir?

See [[Local installation]].

## Roswell Usage & Customization
### my .sbclrc are not loaded!!

for standardize command line behavior roswell's init script are `~/.roswell/init.lisp` only. The file 
are referred from all of common lisp implementation which are invoked from roswell.(if not inovoked with `+R`)

### Where should I put my local projects?

Roswell adds `~/.roswell/local-projects/` to ASDF's source registry during the initialization.
`~/common-lisp/` is also available, as it's the default local directory ASDF uses to look for systems.
See in the [ASDF manual](http://common-lisp.net/project/asdf/asdf/Configuring-ASDF.htm) for further information.

### Sure, but I don't want to change the dir I'm using now.

Create a symlink from  `~/.roswell/local-projects/` to whatever your favorite directory is. ASDF searches for system definitions recursively.

### My SLIME does not jump to the source code of implementation with `M-.`.

If you are using ``sbcl-bin`` with roswell, the installation doesn't include source code. You need to install the source via `ros install sbcl[/version] --without-install` which downloads the sbcl source code for sbcl-bin.

### How to Setup Slime with Roswell?

See [[Initial Recommended Setup]].

### Why is Roswell's Quicklisp dist old and older than mine in Slime ?

You probably didn't setup Slime with Roswell.

You probably have been using slime and quicklisp when you installed Roswell.
If you didn't touch the emacs settings, your slime is the old slime you have been using, and the quicklisp visible from your slime is the quicklisp that you installed.

However, Roswell installs and use a new quicklisp directory installed separately under `~/.roswell`, and your slime does not tell the underlying lisp to look up this directory on the startup.
The easiest way to achieve the best result is to follow the instruction for installing slime for roswell, which can be found here: 
 [[Initial Recommended Setup]].

## Writing & Launching Roswell Scripts

### How are roswell scripts evaluated?
#### Related: What's the default package when launching the script?
#### Related: In what environment is `main` executed?

In interpreter mode (without dump), the script is evaluated as a top-level form.
So, if you use `in-package` within the script, that same package will be effective when launching the `main` function.
The `main` function called by roswell should be in this last effective package.

Edit: now it acts the same in the dumped images. 2015/12/11

### How can I extend the dynamic space size? (sbcl-specific)

```lisp
$ ros dynamic-space-size=2000 -- ... 
```

### Roswell seems to disable the debugger.

On sbcl, try `#+sbcl (sb-ext:enable-debugger)`. You may use other impl-specific interfaces in other implementations.

### I gave a script a large (~100k) arglist, caused a memory exhaust

Consider letting the script read the data from the standard input.

### My roswell script uses a fixed random seed.

At the moment, you should obtain a fresh random state inside the script by `(setf *random-state* (make-random-state t))`.

### The script stops working when used as a CRON script

PATH is set differently under CRON. ~~Use the absolute path for the `ros` command in the script.~~ Instead of modifying the script, set up the ``PATH`` from the caller in `crontab`.

### Quick recipe for building a binary with my private subprojects

1. Place your subprojects under the main projects.

```
+ projects/
  + main.ros
  + src/
  + t/
  + subproj1/
  + subproj2/   ;; or
  + local-projects/
    + subproj1/
    + subproj2/
```

2. use `ros -e "(setf ql:*local-project-directories* '(#p\"$(PWD)/\"))" dump executable main.ros` or equivalent.
   If you build it with `make`, use `CURDIR` instead of `PWD`, since it is robust against `make -C ...`.

I (guicho2.71828) use the following makefile:
```makefile
submodules:
	git submodule update --init --recursive --remote

mwup: $(shell find -name "*.lisp") submodules
	ros -e "(setf ql:*local-project-directories* '(#p\"$(CURDIR)/\"))(ql:register-local-projects)" dump executable ./main.ros
```
