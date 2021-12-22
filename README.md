# dotfiles

dot files for commonly used software programs, OpenSource and used in daily 
life in all OS environments

dot files for components

- aws
- bash
- gdb
- gitconfig
- screen
- sp3
- tmux
- vim

OS Platforms

- Linux ( Ubuntu )

Standard Ubuntu 20.04 or 21.04. The environement can be a full distribution or a docker container.
Same set of dotfile can also be used within Alpine

Package management for Ubuntu is done using `apt` and for Alpine it is `apk`

Once the OS is available for use , please make sure the package lists are updated and
the packages upgraded to the latest

Ubuntu

```bash
    % sudo apt update
    % sudo apt upgrade 
```

Alpine

```bash
    % apk update
    % apk upgrade 
```

- Windows 10 Pro

Windows 10 Pro needs an installation of a Unix emulation later called [MSYS2](http://www.msys2.org)
package management for msys is done using `pacman`

After install of msys2, let's do the following

Update the package listing to the latest

```bash
    % pacman -Syyu
```

This will syncronize with the latest updates for the msys runtime.
Now let's install the `vim` editor

```bash
    % pacman -S vim 
```

Now let's make Windows HOME directory the default home directory

```bash
    % vim /etc/nsswitch.conf
```

In this file, please change `db_home: cygwin desc` to `db_home: windows`
and restart the msys runtime.

- Mac OSX  ( Big Sur )

Mac OS X comes with the Linux shell by default ( either bash or zsh )
For package management `brew` is a really good option. [Homebrew](http://brew.sh) needs to be
installed in Mac OS X

After the installation of brew, let's do the following

- Update the homebrew with the latest updates

```bash
    % brew update
```

If the installation needs upgrade, the following is a god way to do so

```bash
    % brew upgrade
```

Now let's make sure we have `vim`

```bash
    % brew install vim 
```
