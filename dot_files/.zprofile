# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

DDEV='/Users/david/Desktop/dev'
DBIN='/Users/david/bin'
DCODE='/Users/david/Dropbox/_Code'

path+=('/Users/david/bin')
path+=('/Users/david/bin/zig')
path+=('/opt/homebrew/bin/')
# path+=('/Users/david/Library/Python/3.9/bin')
path+=('/Applications/Julia-1.9.app/Contents/Resources/julia/bin/')

alias ls='ls --color=auto'
alias ll='ls -l'
alias lal='ls -al'
alias python='/opt/homebrew/bin/python3.11'
alias aulas='cd /Users/david/Documents/2324'
alias cdf='cd `dirname $(fzf)`'
alias dev='cd ~/Desktop/dev'
alias tmp='cd /tmp/'
alias bin='cd /Users/david/bin'
alias vim='nvim'
alias gca='git commit -a'
alias du1='du --si -d 1 | sort -h'
alias notas='cd ~/Dropbox/Notas'

marp_index() {
        cat "$@" | awk '/^#/'
}
marpall() {
	marp --pdf --html --allow-local-files "$@" &
	marp --html --allow-local-files "$@" &
}
marpallmd() {
	marpall -w *.md
}

md2pdf() {
	theme="tango"
	while getopts ":t:" opt; do
		case ${opt} in
			t) theme=$OPTARG
				echo "-- Using $theme for syntax highlight"
			;;
			\?) echo "-- Option -t theme=pygments|tango|espresso|zenburn|kate|monochrome|breezedark|haddock"; return
			;;
		esac
	done

	INF=${@:$OPTIND:1}
	OUT=$(basename "$INF" .md).pdf

	pandoc --pdf-engine=lualatex -s --citeproc -V papersize=a4 -V colorlinks -V urlcolor=blue -f markdown+hard_line_breaks --highlight-style "$theme" "$INF" -o "$OUT"
	open "$OUT"
}

mdIndex() {
  awk '/^- / {$1="";print "\n---\n\n##"$0 } / +- /{$1="";print "\n---\n\n###"$0}' "$1"
}

move2tmp() {
	mv "$1" /tmp
	cd /tmp
}

move2dev() {
	mv "$1" "$DDEV"
	cd "$DDEV"
}

move2bin() {
	mv "$1" "$DBIN"
	cd "$DBIN"
}

export LANG=en_GB.UTF-8 LC_CTYPE=en_GB.UTF-8
export EDITOR=nvim

