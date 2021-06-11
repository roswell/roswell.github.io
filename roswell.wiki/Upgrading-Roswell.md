
# Installed from source
1. Uninstall the old version<sup>[1](#footnote1)</sup>
2. Upgrade the source
3. build & install again

The commands are as follows.

    [step 1]$ sudo make uninstall   # uninstall it before upgrading the source code, then run
    [step 2]$ git pull              # or whatever needed to upgrade the source code of roswell
    [step 3]$ make                  # compile C-based part of roswell (`ros` binary)
    [step 4]$ sudo make install     # install C-based binary and lisp source code to /usr/.../roswell
    [step 5]$ ros setup             # build (compile&load&dump) the lisp-based part of roswell, using `ros` binary. Results are the dumped lisp image and are saved in ~/.roswell

In case of trouble, try `sudo rm -r /usr/local/etc/roswell/` and resume from step 4.

If it still doesn't help, try `rm -r ~/.roswell/` and resume from step 5


# Archlinux AUR

## yaourt

`yaourt -Sua roswell`

## Makepkg

* Download new PKGBUILD file
* in directory of PKGBUILD run `makepkg -i`

TBP


----

<a name="footnote1">1</a>: If you pull before uninstalling, `ros setup` might fail. It is because some old incompatible lisp file remains in `lispdir` (`lispdir` is /usr/local/etc/roswell/ in the recent version of roswell. You can check it by `ros version`). In this case, remove all files in `lispdir` and try `sudo make install` again.