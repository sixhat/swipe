if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# Aulas 2022
alias ddc='cd /Volumes/Jazz/Aulas/Esad-IPLEIRIA/2223/1S/DDC'
alias cf='cd /Volumes/Jazz/Aulas/Esad-IPLEIRIA/2223/1S/CF'

alias log='vim ~/Dropbox/Notas/$(date +"%Y").md'
alias ls='ls -G'
alias ll='ls -ltrh'
# alias ls='ls -lh'
alias ..='cd ..'
alias ipy='jupyter notebook'
alias _serve='php -S 0.0.0.0:8000'
alias _s74='php74 -S 0.0.0.0:8000'
alias cd2='pushd +2'
alias cd3='pushd +3'
alias cd4='pushd +4'

alias pd='popd'
alias ?='dirs -v'
alias grep='grep --color=auto'
alias ssh-x='ssh -c arcfour,blowfish-cbc -XC'
alias fix_brew='sudo chown -R $(whoami) /usr/local'
alias md5sum='md5 -r'
alias pmd="$HOME/pmd-bin-6.4.0/bin/run.sh pmd"
alias lw='ls -m'

alias gitee='git log --graph --oneline --decorate'
alias gst='git status -sb'
alias
# Set paths:
export PATH=$PATH:/Users/david/bin

# for GO

export TERM=xterm-256color

#### C C++ Compilers
### CLang
#export CC=clang
#export CXX=clang++
#export CPP=clang++
#export CFLAGS=-Qunused-arguments
#export CPPFLAGS=-Qunused-arguments

### GCC
#export CPP='llvm-gcc-4.2'
#export CC='llvm-gcc-4.2'
#export CXX='llvm-g++'

##
# Your previous /Users/david/.profile file was backed up as /Users/david/.profile.macports-saved_2012-10-28_at_20:36:33
##

# MacPorts Installer addition on 2012-10-28_at_20:36:33: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

## PATH Extend for Homebrew
export PATH=/usr/local/bin:$PATH

## For textmate
#export EDITOR="/usr/local/bin/mate -w"
export EDITOR="/usr/bin/vim"
#export EDITOR="/usr/local/bin/mate -w"

# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Ruby via Homebrew
PATH="/usr/local/opt/ruby/bin:${PATH}"
export PATH

# TikzIt
PATH=/usr/texbin:$PATH
export PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Usage: compresspdf [input file] [output file] [screen*|ebook|printer|prepress]
compresspdf() {
	gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"screen"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

# David functions
function mkobsidianvault {
	cp -rf ~/Dropbox/Notas/.obsidian .
}

function notas {
	cd ~/Dropbox/Notas
	vim .
}

function cd {
	test -r .exit.sh && . .exit.sh
	builtin pushd "$1"
	test -r .enter.sh && . .enter.sh
}

function c {
	dir="$1"
	# Delete dots. Surround every letter with "/" and "*".
	# Add a final "/." to be sure this only matches a directory:
	dirpat="$(echo $dir | sed 's/\([^.]*\)\./\/\1*/g')/."
	# In case $dirpat is empty, set dummy "x" then shift it away:
	set x $dirpat
	shift
	# Do the cd if we got one match, else print error:
	if [ "$1" = "$dirpat" ]; then
		# pattern didn't match (shell didn't expand it)
		echo "c: no match for $dirpat" 1>&2
	elif [ $# = 1 ]; then
		echo "$1"
		cd "$1"
	else
		echo "c: too many matches for $dir:" 1>&2
		ls -d "$@"
	fi
	unset dir dirpat
}

function rsync-ssh {
	rsync -avzhe ssh --progress "$@"
}

function marpall {
	marp --pdf --html --allow-local-files "$@" &
	marp --html --allow-local-files "$@" &
}

function md2pdf {
	echo Converting $1
	out="$(basename "$1" .md)".pdf
	echo /opt/local/bin/pandoc -f markdown -o "$(basename "$1" .md)".pdf $1
	/opt/local/bin/pandoc -f markdown -o "$out" $1
	say "PDF created"
	echo -- Done converting $out
}

function mdtoc2html {
	gawk 'BEGIN {c = -1;}/---/ {c+=1; }/^# /{$1 = "";print "<a href=\"#"c"\">"$0"</a>";}' $1
}

function md2watch {
	while sleep 1; do
		watch -gn 1 stat $1
		md2pdf $1
	done
}

function encrypt() {
	openssl aes-256-cbc -salt -pbkdf2 -in "$1" -out "$1".enc
}
function decrypt() {
	out=${1%.enc}
	openssl aes-256-cbc -d -salt -pbkdf2 -in "$1" -out $out
}

function _read() {
	links -dump "$1" | less
}

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

. "$HOME/.cargo/env"

export JULIA="/Applications/Julia-1.7.app/Contents/Resources/julia/bin/julia"
export PATH="$PATH:/Applications/Julia-1.7.app/Contents/Resources/julia/bin/"
export PATH="$PATH:/Users/david/go/bin/"
