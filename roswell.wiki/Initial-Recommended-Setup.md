# Setting up SLIME

This section is not mandatory to use Roswell, but we strongly recommend following the instructions below.

## for Emacs

* Run the following command on the command line:
  * `ros install slime`
     <!-- (from release 16.12.8.72) -- this is pretty old, so removed -->
* Add the following lines to init.el, as suggested by the message
  * `(load (expand-file-name "~/.roswell/helper.el"))`
* Also add the following lines to init.el.

```elisp
(setq inferior-lisp-program "ros -Q run")
```

The actual implementation launched by roswell depends on the current configuration.
Initially, the implementation is set to SBCL. You can later check it with `ros config` and change it with `ros use`.

## for vim

For Vim, an equivalent of SLIME called [slimv](https://www.vim.org/scripts/script.php?script_id=2531) is available.
There is a [tutorial](https://kovisoft.bitbucket.io/tutorial.html) for installing it.
After the installation, add the following commands to `.vimrc`:

```.vimrc
let g:slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'sbcl'
```

## for Atom editor

If you are an Atom user, the [slima](https://atom.io/packages/slima) package is available.
Follow the tutorial on the website, and specify the Roswell executable `ros` as the lisp implementation.

If you are running it on Windows, you may have to create an ASDF config file 
`C:\Users\your-name\AppData\Local\config\common-lisp\source-registry.conf` as follows:

```lisp
(:source-registry
  (:tree "/Users/your-name/.roswell/lisp/quicklisp/dists/quicklisp/software/")
  :INHERIT-CONFIGURATION)
```

# Complete!

*To new lisp users*: Setting up a lisp environment with Roswell is complete with this step. Launch SLIME and enjoy the REPL, write a script following the tutorial ([[Roswell as a Scripting Environment]]), or proceed to [[Basic Usage]] if you want to learn more about Roswell.

# Advanced users section

Slime also has another (and historically newer) interface for switching between multiple lisps through a variable `slime-lisp-implementations`. Expert lispers may already have this variable customized and if you are a bit conservative you might want to add roswell as just one of them. The following sample code does not override the existing setting:
```elisp
(setf slime-lisp-implementations
      `((sbcl    ("sbcl" "--dynamic-space-size" "2000"))
        (roswell ("ros" "-Q" "run"))))
(setf slime-default-lisp 'roswell)
```

* In order to launch SBCL with `.sbclrc`, try the following instead:
```elisp
(setq inferior-lisp-program "ros -L sbcl -Q -l ~/.sbclrc run")
```

* When you need to jump to the implementation source code with M-. , run `ros install sbcl` which compiles the new sbcl from the source code.

* `ros emacs` also launches emacs with slime setup.

* To have `.roswell` in somewhere other than your home directory, set the environment variable `ROSWELL_HOME`:

```shell
export ROSWELL_HOME=/tmp
ros setup # will create /tmp/.roswell and install files there instead of ~/.roswell
```