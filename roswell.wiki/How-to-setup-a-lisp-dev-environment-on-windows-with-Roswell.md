by SANO Masatoshi

**this tentative document is WIP and intend for brave who volunteers testing roswell windows. **

By my experience of visiting some lisp conferences,I notice that windows is not popular platform for common lispers at least most of open source developers use linux or osx for their daily use.
It is not healthy for lisp community that many library looks abandoned for windows users and beginners required to have unix experience to start common lisp.
I would like to change the situation by roswell but implementation of roswell windows is not well tested yet.
this memo is to help setup lisp dev environment with roswell.

# downloading roswell binary.
download release file [Roswell-i686.zip](https://ci.appveyor.com/api/projects/snmsts/roswell-en89n/artifacts/Roswell-i686.zip?branch=release&job=Environment%3A%20MSYS2_ARCH%3Di686,%20MSYS2_BITS%3D32,%20MSYSTEM%3DMINGW32,%20METHOD%3Dcross) and extract it somewhere.

Warning: Roswell has an internal issue which assumes its file location doesn't contain white spaces. Please put `roswell/` at a directory which doesn't have spaces in it's path (like `C:\\roswell`).

# setup msys2
lauch command prompt and execute ros.exe with parameter shell

```
ros shell
```

at first launch roswell install msys2 and launch bash of msys2.

# install emacs and setup slime.

```
pacman -S emacs
```

then launch

```
ros emacs &
```
