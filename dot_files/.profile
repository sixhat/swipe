alias _serve="php -S 127.0.0.1:8000"
alias ...="awk '{fflush(); printf \".\"}' && echo \"\""
alias ls="ls -Gcko"
alias ll="ls -lh"
alias lsd="ls -d -l */"
alias gst="git status"
alias gco="git commit"
alias gp="git push"

calc(){ awk "BEGIN{ print $* }" ;}


EDITOR=vim

function parse_git_branch {

        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

}
function get_ip {
	ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
}


function proml {

PS1='\n\[\e[31;1m\j:\! \e[0m\]\u@$(get_ip):\[\e[36;1m\]\w\[\e[0;36m\]$(parse_git_branch)\[\e[32;1m\]\n\A\[\e[0m\]\$ '
}
proml

export PYTHONIOENCODING=UTF-8


# David 4 Novembro 2013

alias ipy="ipython notebook"

# David 22 Abril 2014

export PATH=/Library/TeX/texbin:/Applications/MAMP/bin/php/php5.5.3/bin:$PATH


##
# Your previous /Users/dr6845/.profile file was backed up as /Users/dr6845/.profile.macports-saved_2015-10-30_at_19:14:55
##

# MacPorts Installer addition on 2015-10-30_at_19:14:55: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# added by Anaconda 2.2.0 installer
export PATH="/Users/dr6845/anaconda/bin:$PATH"



export PATH="/Users/dr6845/bin:$PATH"

source ~/bin/git-completion.bash


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
