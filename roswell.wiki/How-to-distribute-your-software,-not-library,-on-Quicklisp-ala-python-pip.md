written by: Masataro Asai

## Introduction

Most libraries in Quicklisp are created for lispers' sake, i.e. they are meant for lisp programmers who write lisp softwares. In comparison, many libraries in Python's `pip` also come with command-line interfaces. For example:

```
$ pip3 install --user cfncluster
Requirement already satisfied:   ....
$ cfncluster 
usage: cfncluster [-h] [--config CONFIG_FILE] [--region REGION] [--nowait]
                  {create,update,delete,start,stop,status,list,instances,configure,version}
                  ...
cfncluster: error: too few arguments
```

Ruby gems also have similar functionality.

This feature is crucial when you want your **software** to be used by non-lisp users.
Here, I distinguish **libraries** and **software**, **software** meaning being stand-alone. They are useful tools for their own specific tasks. The `cfncluster` above is a tool for managing AWS cluster as a supercomputer. 
In contrast, **libraries** are for writing software. In order to use them you have to know how to write software in the target programming language. Sadly, most people don't understand Lisp but we cannot change this fact (or [we don't want to](http://paulgraham.com/avg.html)). But you **DO** want people to use your **software** for your career, money or your personal satisfaction.

Software need to be black-boxes. Users usually do not care whether it is written in C or python or Lisp. They are happy as long as they are usable, useful, fast and flexible. They do not want to know lisp-specific issues. They do not want to learn how to build a lisp executable. They do not want to know where Quicklisp stores its downloaded archives and unpacks them into. They want software and not lisp.

There are many ways to distribute lisp **software**, but they are usually cumbersome, fail to hide the internals, or have some other drawbacks. We first review these approaches and then show how Roswell solves this.

## Distributing the executable binary directly from the website

This may seem the most straightforward way. Despite its simplicity, it has numerous drawbacks:

* There is no concept of *installing* or *uninstalling*. Users have to manage the downloaded binaries by themselves. They have to set up the central location for the downloaded lisp binaries by themselves. There is no central location from where to download the binaries, either.
* There is no concept of *updating* or *versions* whatsoever. Each binary may have `--version` option, but this is hardly coherent across different software. You can include the version number in the file name of the binary, but then you end up specifying the name each time from the command line (e.g. `$ cfncluster-1.1.1`), or you build another system for managing them (or use Roswell!)

## Distributing the binary from Packaging System

This solves the above problems, but it has other issues.

* Packaging systems e.g. rpm, apt, brew, chocolatey (Dear Microsoft, you finally have your own package manager) are OS-specific.
* It is sometimes hard to make the software available in packaging system. The cost of managing the package is high and as a result, usually the software is less frequently updated without the support from the huge community and user base. It is not suitable for lean startups.

## Custom shell scripts, Makefile and lisp file for building

You can include several script files for building the executable in your git repo. However:

* Supporting many different types of environments requires a great deal of effort. (Roswell did that already)
* It takes a few more steps before one can use the software. Find the repo, checkout the repo, build it, put the binary somewhere and use it.
* It feels more or less like using alpha-quality software that is still in development. Even more so if it is not CI-tested or Quicklisp-included (which requires not to be broken). Using release tags may solve this, but users may fail to pull from the proper branch. It increases the number of steps too.
* What if the scripts are also included in the Quicklisp repository? Users still need to find where Quicklisp stores the repo.

## ASDF's build-system

This requires users to understand lisp and launch REPL. If you provide a script that calls ASDF:build-system, then it falls into the same problems as the previous section.

# Using Roswell

Roswell solves the above problems by leveraging Quicklisp's distribution and versioning system.

* Instead of writing a lisp script that contains the `main` function and builds an executable, write a [roswell script](https://github.com/roswell/roswell/wiki/Roswell-as-a-Scripting-Environment) with a `main` function. Neither you nor your users have to care about how to build it.
* Put the roswell script in the roswell/ subdirectory of the repository. It does not have to be in Quicklisp, since Roswell have github-installation facility. See man page for `ros-install(8)`.
* Done! Now your script is available from a single command line. Example:

```
# install from quicklisp
$ ros install prove

# or fetch from the latest github repository [accountname]/[repo]
$ ros install fukamachi/prove

# launch ~/.roswell/bin/run-prove
$ ros exec run-prove

# Alternatively:
$ PATH=~/.roswell/bin:$PATH
$ which run-prove
/home/guicho/.roswell/bin/run-prove
$ run-prove
```

## To make the scripts automatically compiled upon installation

Roswell can automatically compile the installed script so that the later invocations of the command become much faster.
In order to make it compilable, add `-m <name>` to the fourth line of the script.

+ **Note**: Compilation happens only when the script is located in `.roswell/bin`, i.e. when it was already `ros install`ed.
+ **Bug (or a feature)**: The implementation supporting this auto-dump feature is `-L sbcl-bin` only. 

<!-- Compilation may run again and again when the fourth line does not include the implementation specifier `-L sbcl-bin`. -->

```
#!/bin/sh
#|-*- mode:lisp -*-|#
#| A utility library for Common Lisp dependant on SBCL
exec ros -Q -L sbcl-bin -m speed -- $0 "$@"
|#

(defpackage #:ros.script.speed
  (:use #:cl))

(in-package :ros.script.speed)

(defun main (&rest argv)
  (declare (ignore argv))
  (print "Hello world"))

(main)

;;; vim: set ft=lisp lisp:
```


