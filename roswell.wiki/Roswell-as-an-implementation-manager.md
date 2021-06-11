Largely TBP 
## Installing CL implementations

```
# Installing SBCL 1.2.14
$ ros install sbcl/1.2.14

# Installing the latest SBCL
$ ros install sbcl

# Installing Clozure CL
$ ros install ccl-bin
```

```
$ ros list installed
```

### Managing/Installing Several Lisp Installations

    $ ros install sbcl-bin      # default sbcl
    $ ros install sbcl          # The newest released version of sbcl
    $ ros install ccl-bin       # default prebuilt binary of ccl
    $ ros install sbcl/1.2.0    # A specific version of sbcl
    $ ros list installed sbcl   # Listing the installed implementations

The list is growing further!

#### Show installable Lisp implements.

    $ ros list versions
    candidates for ros list versions [impl] are:
    
    abcl-bin
    allegro
    ccl-bin
    clasp
    clisp
    cmu-bin
    ecl
    quicklisp
    sbcl-bin
    sbcl
    slime

#### Compile Options

You can see the compile options by

    $ ros help install sbcl

### Checking and Setting the default implementation used by ros

    $ ros run -- --version      # check which implementation is used
    SBCL 1.2.15
    $ ros use sbcl/1.2.3        # change the default implementation

## Specifying which implementation to use

    $ ros -L sbcl/1.2.3 my-script.lisp

## Using SBCL's dynamic-space-size

```
$ ros dynamic-space-size=400 run
```
