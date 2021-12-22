# install the config files for a component

#export COMPONENTS="vim tmux screen bash aws git sp3 gdb "
export COMPONENTS="vim tmux screen bash aws git gdb "
export THIS_DIR=`pwd`
export OS_TYPE=`uname -s`
export PLIST="vim tmux git gcc python"

create()
{
	echo "create $1"
	if [ $# -eq 0 ]; then
		echo "no <args>"
		exit -1
	fi

	if [ $1 = "all" ]; then
			for i in $COMPONENTS
			do
				create $i
			done
	fi

	if [ $1 = "vim" ]; then
		mkdir -p ~/.vim
		cp ${THIS_DIR}/vim/vimrc ~/.vimrc
	fi
	if [ $1 = "tmux" ]; then
			cp ${THIS_DIR}/tmux/tmux.conf ~/.tmux.conf
	fi
	if [ $1 = "screen" ]; then
			cp ${THIS_DIR}/screen/screenrc ~/.screenrc
	fi
	if [ $1 = "bash" ]; then
			if [ ! -f ~/.bash_profile ]; then
				cp ${THIS_DIR}/bash/bash_profile ~/.bash_profile
				echo "~/.xbash/xbashrc please add the following to ~/.bash_profile"
				echo ""
				echo "if [ -f ~/.xbash/xbashrc ]; then"
				echo "		. ~/.xbash/xbashrc"
				echo "fi"
			fi

			mkdir -p ~/.xbash
			cp ${THIS_DIR}/bash/xbash/xbashrc ~/.xbash/xbashrc
			cp ${THIS_DIR}/bash/xbash/*env ~/.xbash/
			cp ${THIS_DIR}/bash/xbash/aliases ~/.xbash/
	fi
	if [ $1 = "aws" ]; then
			mkdir -p ~/.aws
			cp ${THIS_DIR}/aws/config ~/.aws/config
			cp ${THIS_DIR}/aws/credentials ~/.aws/credentials
	fi
	if [ $1 = "git" ]; then
			cp ${THIS_DIR}/gitconfig/gitconfig ~/.gitconfig
	fi
	if [ $1 = "sp3" ]; then
			cp ${THIS_DIR}/sp3/sp3 ~/.sp3
	fi
	if [ $1 = "gdb" ]; then
			cp ${THIS_DIR}/gdb/gdbinit ~/.gdbinit
	fi
}

backup()
{
	echo "backup $1"
	if [ $# -eq 0 ]; then
		echo "no <args>"
		exit -1
	fi

	if [ ! -d ~/.backup ]; then 
			mkdir -p ~/.backup
	fi

	if [ $1 = "all" ]; then
			for i in $COMPONENTS
			do
				backup $i
			done
	fi

	if [ $1 = "vim" ]; then
		cp ~/.vimrc ~/.backup/.vimrc
	fi
	if [ $1 = "tmux" ]; then
			cp ~/.tmux.conf ~/.backup/.tmux.conf
	fi
	if [ $1 = "screen" ]; then
			cp ~/.screenrc ~/.backup/.screenrc
	fi
	if [ $1 = "bash" ]; then
			cp ~/.bash_profile ~/.backup
			cp -r ~/.xbash ~/.backup
	fi
	if [ $1 = "aws" ]; then
			cp -r ~/.aws ~/.backup
	fi
	if [ $1 = "git" ]; then
			cp ~/.gitconfig ~/.backup/.gitconfig
	fi
	if [ $1 = "sp3" ]; then
			cp ~/.sp3e ~/.backup/.sp3e
	fi
	if [ $1 = "gdb" ]; then
			cp ~/.gdbinit ~/.backup/.gdbinit
	fi


}

restore()
{
	echo "restore $1"
	if [ $# -eq 0 ]; then
		echo "no <args>"
		exit -1
	fi

	if [ ! -d ~/.backup ]; then 
		echo "~/.backup not found"
		exit -1
	fi

	if [ $1 = "all" ]; then
			for i in $COMPONENTS
			do
				restore $i
			done
			exit 0
	fi

	if [ $1 = "vim" ]; then
		cp ~/.backup/.vimrc ~/.vimrc
	fi
	if [ $1 = "tmux" ]; then
			cp ~/.backup/.tmux.conf ~/.tmux.conf
	fi
	if [ $1 = "screen" ]; then
			cp ~/.backup/.screenrc ~/.screenrc
	fi
	if [ $1 = "bash" ]; then
			cp ~/.backup/.bash_profile ~/
			cp -r ~/.backup/.xbash ~/
	fi
	if [ $1 = "aws" ]; then
			cp -r ~/.backup/.aws ~/
	fi
	if [ $1 = "git" ]; then
			cp ~/.backup/.gitconfig ~/.gitconfig
	fi
	if [ $1 = "sp3" ]; then
			cp ~/.backup/.sp3e ~/.sp3e
	fi
	if [ $1 = "gdb" ]; then
			cp ~/.backup/.gdbinit ~/.gdbinit
	fi


}

cleanup()
{
	echo "cleanup $1"
	if [ $# -eq 0 ]; then
		echo "no <args>"
		exit -1
	fi

	if [ $1 = "all" ]; then
			for i in $COMPONENTS
			do
				cleanup $i
			done
			exit 0
	fi

	if [ $1 = "vim" ]; then
		rm -f ~/.vimrc
	fi
	if [ $1 = "tmux" ]; then
		rm -f ~/.tmux.conf
	fi
	if [ $1 = "screen" ]; then
		rm -f ~/.screenrc
	fi
	if [ $1 = "bash" ]; then
		rm -f ~/.bash_profile
		rm -rf ~/.xbash
	fi
	if [ $1 = "aws" ]; then
			rm -rf ~/.aws
	fi
	if [ $1 = "git" ]; then
			rm -f ~/.gitconfig
	fi
	if [ $1 = "sp3" ]; then
			rm -f ~/.sp3e
	fi
	if [ $1 = "gdb" ]; then
			rm -f ~/.gdbinit
	fi

}

clobber()
{
	echo "clobber"

	if [ -d ~/.backup ]; then
			rm -rf ~/.backup
	fi
}

pkginstall()
{
	echo "Package Install"
	if [ $OS_TYPE == "MSYS_NT-10.0-21390" ]; then
		pacman --noconfirm -S $PLIST
	fi
}

usage() {
cat << EOF
$UTIL COMMAND

Commands are:
create  <args>	- install the files from here
backup  <args>	- backup the existing dotfiles
cleanup <args>	- cleanup the dotfiles 
restore <args>	- restore the dotfiles from previous backup
clobber <args>	- remove the backup files
packages <args> - installed the required base packages
-h, --help      - Show this help screen

EOF
echo "<args> : "
echo " all | $COMPONENTS"
}

UTIL=$(basename $0)

if [ $# -eq 0 ]; then
	usage
	exit 0
fi


case $1 in
    "create")
        shift
        create "$@"
        exit 0
        ;;
    "cleanup")
        shift
        cleanup "$@"
        exit 0
        ;;
    "restore")
        shift
        restore "$@"
        exit 0
        ;;
    "clobber")
		shift
		clobber "$@"
		exit 0
		;;
    "backup")
		shift
		backup "$@"
		exit 0
		;;
	"packages")
		shift
		pkginstall "@"
		exit 0
		;;
    -h | --help)
        usage
        exit 0
        ;;
    *)
        echo >&2 "$UTIL: unknown command \"$1\" (use --help for help)"
        exit 1
        ;;
esac
