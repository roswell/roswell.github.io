After installation, don't miss the recommended setup. It is necessary to link Slime with Roswell so that installing packages with Slime does this in the context of Roswell.

Note: **This may be your first experience with Lisp and you might have tried other methods/tutorials that you found on the internet (none of which worked for you). Or, you could have managed to make it work but without confidence, only later you found roswell. Our advice is that you are better off removing whatever you did previously, or you end up having two duplicate copies of lisp implementations / quicklisp / asdf, which complicates the matter.**

## Dependencies

+ libcurl (both v3 and v4 should work) : used for downloading the lisp implementation binaries, etc.
+ automake (required when building from source)
+ developmental headers of libcurl (required when building from source)
  + on Ubuntu, libcurl4-openssl-dev works but libcurl4-nss-dev may not work

## Mac OS X + Homebrew

    $ brew install roswell

## Linux

On [Arch](https://www.archlinux.org/), Roswell is available in AUR:

    $ yay -S roswell

On [Void](https://voidlinux.org/), Roswell is available in xbps:

 <pre><code>$ sudo xbps-install -S roswell</code></pre>

on [Gentoo](https://www.gentoo.org/), Roswell is available in [portage](https://packages.gentoo.org/packages/dev-lisp/roswell):

    $ emerge --ask dev-lisp/roswell

(Please note that you cannot install Roswell and `dev-libs/librouteros` simultaneously due to [binary file collision](https://bugs.gentoo.org/691754).)

Support for other distributions/packaging systems (e.g. debian-based, redhat-based) is future work. However, building from source is fairly straightforward and somewhat stable. See the last section.

Or, you can use [Homebrew](https://brew.sh/).
It's same way.

    $ brew install roswell

On Ubuntu/Debian, there seems to be someone who managed to install from the release tarball or the deb file in https://github.com/roswell/roswell/releases, for example:

```
$ curl -L https://github.com/roswell/roswell/releases/download/v19.08.10.101/roswell_19.08.10.101-1_amd64.deb --output roswell.deb
$ sudo dpkg -i roswell.deb
```

If you want to get a latest debian package, you can do that with;

```
curl -sOL `curl -s https://api.github.com/repos/roswell/roswell/releases/latest | jq -r '.assets | .[] | select(.name|test("\\\.deb$")) | .browser_download_url'`
```

(you need [jq](https://stedolan.github.io/jq/) superior to 1.4)

## FreeBSD

Roswell is available in the [FreeBSD ports tree](https://www.freebsd.org/ports/). To install it system-wide

    $ cd /usr/ports/devel/roswell 
    $ sudo make install

To avoid system-wide installation, simply define a `PREFIX` (must be an absolute path)

    $ cd /usr/ports/devel/roswell
    $ sudo make PREFIX=/usr/home/<username>/.local install 

## Windows

Using [Scoop](http://scoop.sh/).

    $ scoop install roswell

Or, if you want to do it manually, just follow the link corresponding to your environment at the latest release page.

* [Latest release](https://github.com/roswell/roswell/releases)
  * `roswell_<version>_amd64.zip` for 64bit
  * `roswell_<version>_i686.zip` for 32bit

## Building from Source

Instructions for a system-wide installation follows. The `./configure` script has several useful options, see `./configure --help` for details. Note this instruction is for Debian based Linux (Debian, Ubuntu, Mint, etc.).

On Debian/Ubuntu, in a nutshell:

    sudo apt-get -y install git build-essential automake libcurl4-openssl-dev
    git clone -b release https://github.com/roswell/roswell.git
    cd roswell
    sh bootstrap
    ./configure
    make
    sudo make install
    ros setup

On some versions, `sudo apt-get install zlib1g-dev` [may also be necessary](https://github.com/roswell/roswell/issues/152).

To avoid system-wide installation,

    git clone -b release https://github.com/roswell/roswell.git
    cd roswell
    sh bootstrap
    ./configure --prefix=$HOME/.local
    make
    make install
    echo 'PATH=$HOME/.local/bin:$PATH' >> ~/.profile
    PATH=$HOME/.local/bin:$PATH ros setup

(for more details see [[Local installation]])

On a Red Hat based Linux (Fedora, CentOS), replace the first line with 

* `sudo dnf install automake libcurl-devel` or
* `sudo yum install automake libcurl-devel` (git, make, etc. are installed by default on these Linux).
* On CentOS [`sudo yum install zlib-devel` may also be necessary](https://github.com/roswell/roswell/issues/152).

On [FreeBSD](https://www.freebsd.org/) replace the first line with `sudo pkg install git automake curl`.
You may also need to set the include and library search paths prior to running `configure`.

    LDFLAGS="-L/usr/local/lib/" CFLAGS="-I/usr/local/include/" ./configure

With nix ([NixOS](http://nixos.org/)'s package manager) you can compile with this command:
```sh
nix-shell -p autoconf automake curl --command 'sh -c "./bootstrap && ./configure && make"'
```