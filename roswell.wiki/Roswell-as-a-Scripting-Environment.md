Although Roswell is a unified interface to Common Lisp implementations, it also encourages writing scripts with it. A "Roswell script" is an implementation-independent script which can be invoked from a shell command line, launched by Roswell and run under standard CL environment.

> *To relatively new users of common lisp*: Roswell scripts are just like shell scripts, but for lisp. Most tutorials you will find on the internet will be assuming a REPL (read-eval-print-loop), but you can do the same thing in a file.

> *To advanced users*: Compared to writing a normal lisp script (e.g. by `#!/usr/bin/sbcl -l`), Roswell scripts have the following advantages:
> * A roswell script can be *distributed using quicklisp's infrastructure* (if you are a library author), and *installed* with `ros install [system]`, i.e., those scripts are made available anywhere in your system.
> * Also, the script can be dumped into an executable binary for the distribution purpose or for reducing the startup time. Each subsection below describes each feature.

## Initialising a Roswell Script

To start, run `ros init` in your terminal:

```
$ ros init
Usage: ros init [template] name [options...]

$ ros init fact
Successfully generated: fact.ros
```

<!--
It adds a file extension `.ros`.

Perhaps it's hardly understandable if you have been using only Unix OSes for years like me. Actually, it works well even without `.ros` on Unix, so renaming it to the name which doesn't have `.ros` is a usual manner if the script doesn't have to run on Windows. However, it helps Roswell to differentiate it from shell scripts, and Roswell provides some additional features for it like [Making Executables](#making-executables).
-->

The content of the file looks like this:

```common-lisp
#!/bin/sh
#|-*- mode:lisp -*-|#
#|
exec ros -Q -- $0 "$@"
|#
(defun main (&rest argv)
  (declare (ignorable argv)))
```

This looks a little bit hacky. It actually is a shell script which `exec` Roswell immediately. Roswell runs the same script, skips multi-line comments, reads the rest of the file as a Common Lisp program, and finally invokes a function `main` with command-line arguments.

Here's an example program which takes the exact one argument and prints its factorial:

```common-lisp
#!/bin/sh
#|-*- mode:lisp -*-|#
#|
exec ros -Q -- $0 "$@"
|#

(defun fact (n)
  (if (zerop n)
      1
      (* n (fact (1- n)))))

(defun main (n &rest argv)
  (declare (ignore argv))
  (format t "~&Factorial ~D = ~D~%" n (fact (parse-integer n))))
```

```
$ fact.ros 3
Factorial 3 = 6

$ fact.ros 10
Factorial 10 = 3628800
```

Though it falls through CL debugger if there's no arguments or non-integer value, I assume it's okay for now as a simple example ;) For further details, see [this article](Advanced-scripting).

Another thing you may notice is the speed --- why it takes so long to just compute the factorial? It is due to the slow startup time, and you can easily reduce it. See [[Reducing Startup Time]].

## Distributing Scripts via Quicklisp (for advanced users)

When you write a script which would make other people happy, let's think about sharing it.
The easiest way to achieve this is to just send the `.ros` file to the others.
However, it is impractical when your script is more like a "library" containing multiple separated source files.

If you're the author of the library, then consider adding the ros file to the repository and automatically providing a roswell-installable command-line interface to it.
The `.ros` files should be located in `roswell/` subdirectory in the repository.
Once added, `ros install` recognizes the ros scripts in the repository.
When `ros install <library name>` is invoked, it downloads the specified library from Quicklisp
and then copies the script files to `~/.roswell/bin`.
<!-- and gives them an executable flag. -->
These scripts can be launched via `ros exec <script name>`.
Also, when the PATH to `~/.roswell/bin` is resolved, they are available from the command line.

```
$ ros install <library name>
```

For instance, try `ros install clack`:

```
$ ros install clack
found system clack.
Attempting install scripts...
/Users/nitro_idiot/.roswell/bin/clackup
$ ros exec clackup                                                ### launch the web server!
```

To avoid `ros exec`, add `bin/` to the PATH variable:

```
$ echo 'export PATH="$HOME/.roswell/bin:$PATH"' >> ~/.zshrc
$ clackup                                                         ### launch the web server!
```
