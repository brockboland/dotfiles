export PATH=~/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/opt/llvm/bin:$PATH


export SVN_EDITOR='subl -w'
export GIT_EDITOR='subl -w'
export LESSEDIT='subl -l %lm %f'
export GOPATH=~/go_workspace

alias ll="ls -lh"
alias la="ls -lah"
alias flush="dscacheutil -flushcache"
alias topmem="top -n 20 -o vsize"
alias topcpu="top -n 20 -o cpu"

alias mysql=/Applications/MAMP/Library/bin/mysql
alias mysqldump=/Applications/MAMP/Library/bin/mysqldump

# Open current path in Finder
alias f='open -a Finder ./'

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


# Use hub for git operations
# alias git=hub

# Use git auto-completion
# TODO: do this without hard-coding versions
source /usr/local/Cellar/git/2.9.0/etc/bash_completion.d/git-completion.bash
source /usr/local/Cellar/git/2.9.0/etc/bash_completion.d/git-prompt.sh
source /usr/local/Cellar/hub/2.2.9/etc/bash_completion.d/hub.bash_completion.sh

function spidersite {
  if [ -z "$1" ]
  then
    # No parameter passed, show usage
    echo "Usage: spidersite [http://example.com]"
  else
    # Spider the site
    wget -q --mirror -p --html-extension -e robots=off --base=./ -k -P ./ $1
  fi
}

function cleanWhiteboard {
  convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2"
}

# Convert a movie file to a gif. Crappy quality, only good for short screen cap
# See https://gist.github.com/dergachev/4627207
function gifify {
  if [ -z "$1" ]
  then
    # No parameter passed, show usage
    echo "Usage: gifify filename.mov"
    echo "Resulting gif is stored as out.gif"
  else
    ffmpeg -i "$1" -s 320x480 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > out.gif
  fi
}


# Convert a movie file to a gif. Better quality!
# The output file is the original file with .gif tacked on
# See http://superuser.com/a/556031/1090
function goodgif {
  if [ -z "$1" ]
  then
    # No parameter passed, show usage
    echo "Usage: goodgif filename.mov"
    echo "Resulting gif is stored as out.gif"
  else
    mkdir framestmp
    ffmpeg -i "$1" -vf scale=320:-1 -r 10 framestmp/ffout%03d.png
    convert -delay 10 -loop 0 framestmp/ffout*.png out.gif
    mv out.gif "$1.gif"
    rm -rf framestmp
  fi
}


# Syntax highlighting
function syntax_highlight {
  qlmanage -p $1  -o .
}

# cd to the path of the front Finder window
function cdf() {
	target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
	if [ "$target" != "" ]; then
		cd "$target"; pwd
	else
		echo 'No Finder window found' >&2
	fi
}




#################################################
# Prompt cusomtization from:
# https://gist.github.com/pjf/1dfc0ff2da636cd6ad98

# Reset
Color_Off='\[\e[0m\]'      # Text Reset

# Regular Colors
Black='\[\e[0;30m\]'       # Black
Red='\[\e[0;31m\]'         # Red
Green='\[\e[0;32m\]'       # Green
Yellow='\[\e[0;33m\]'      # Yellow
Blue='\[\e[0;34m\]'        # Blue
Purple='\[\e[0;35m\]'      # Purple
Cyan='\[\e[0;36m\]'        # Cyan
White='\[\e[0;37m\]'       # White

# Bold
BBlack='\[\e[1;30m\]'      # Black
BRed='\[\e[1;31m\]'        # Red
BGreen='\[\e[1;32m\]'      # Green
BYellow='\[\e[1;33m\]'     # Yellow
BBlue='\[\e[1;34m\]'       # Blue
BPurple='\[\e[1;35m\]'     # Purple
BCyan='\[\e[1;36m\]'       # Cyan
BWhite='\[\e[1;37m\]'      # White

# Underline
UBlack='\[\e[4;30m\]'      # Black
URed='\[\e[4;31m\]'        # Red
UGreen='\[\e[4;32m\]'      # Green
UYellow='\[\e[4;33m\]'     # Yellow
UBlue='\[\e[4;34m\]'       # Blue
UPurple='\[\e[4;35m\]'     # Purple
UCyan='\[\e[4;36m\]'       # Cyan
UWhite='\[\e[4;37m\]'      # White

# Background
On_Black='\[\e[40m\]'      # Black
On_Red='\[\e[41m\]'        # Red
On_Green='\[\e[42m\]'      # Green
On_Yellow='\[\e[43m\]'     # Yellow
On_Blue='\[\e[44m\]'       # Blue
On_Purple='\[\e[45m\]'     # Purple
On_Cyan='\[\e[46m\]'       # Cyan
On_White='\[\e[47m\]'      # White

# High Intensity
IBlack='\[\e[0;90m\]'      # Black
IRed='\[\e[0;91m\]'        # Red
IGreen='\[\e[0;92m\]'      # Green
IYellow='\[\e[0;93m\]'     # Yellow
IBlue='\[\e[0;94m\]'       # Blue
IPurple='\[\e[0;95m\]'     # Purple
ICyan='\[\e[0;96m\]'       # Cyan
IWhite='\[\e[0;97m\]'      # White

# Bold High Intensity
BIBlack='\[\e[1;90m\]'     # Black
BIRed='\[\e[1;91m\]'       # Red
BIGreen='\[\e[1;92m\]'     # Green
BIYellow='\[\e[1;93m\]'    # Yellow
BIBlue='\[\e[1;94m\]'      # Blue
BIPurple='\[\e[1;95m\]'    # Purple
BICyan='\[\e[1;96m\]'      # Cyan
BIWhite='\[\e[1;97m\]'     # White

# High Intensity backgrounds
On_IBlack='\[\e[0;100m\]'  # Black
On_IRed='\[\e[0;101m\]'    # Red
On_IGreen='\[\e[0;102m\]'  # Green
On_IYellow='\[\e[0;103m\]' # Yellow
On_IBlue='\[\e[0;104m\]'   # Blue
On_IPurple='\[\e[0;105m\]' # Purple
On_ICyan='\[\e[0;106m\]'   # Cyan
On_IWhite='\[\e[0;107m\]'  # White

# Make our prompt awesome. :)

TICK="✓"
CROSS="✗"

PS1="\[\e]0;\u@\h: \w\a\]"'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain --untracked-files=no 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$BRed'$CROSS "; else echo "'$BGreen'$TICK "; fi; fi;)'"$Color_Off${debian_chroot:+($debian_chroot)}\w$BYellow\$(__git_ps1)\$ $Color_Off"
