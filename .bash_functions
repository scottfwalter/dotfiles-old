#######################################
# SHELL CORE
#######################################
hist() {
    if [ $# = "0" ] ; then
        history
    else
        history | grep $1
    fi
}

function on_mac() {
	[[ $(uname -a | grep -c "Darwin") -eq 1 ]]
}

function on_wsl() {
	[[ $(uname -a | grep -c "Microsoft") -eq 1 ]]
}

#######################################
# SHELL UI
#######################################

function ohai() {
	local green='\033[0;32m'
	local reset='\033[0m'
	local msg="${1}"

	echo -e "${green}${msg}${reset}"
}

# Color-echo.
cecho() {
    echo -e "${1}${2}"

    #Reset text attributes to normal + without clearing screen
    tput sgr0
}

# Set shell title useful in multi-tab terminal apps
function title() {
    echo -n -e "\033]0;$1\007"
}

function set_term_bgcolor {
    local R=$1
    local G=$2
    local B=$3
    /usr/bin/osascript <<EOF
        tell application "iTerm"
            tell the current terminal
                tell the current session
                    set background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
                end tell
            end tell
        end tell
EOF
}

#######################################
# ITERM
#######################################
function title {
	    echo -ne "\033]0;"$*"\007"
}

function badge {
	printf "\e]1337;SetBadgeFormat=%s\a"   $(echo -n "$1" | base64)
}

#######################################
# PROCESS MANAGEMENT
#######################################
# Kills process by a grep syntax
killbygrep() {
   ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs kill -9
}

#find and list processes matching a case-insensitive partial-match string
fp() {
    ps Ao pid,comm|awk '{match($0,/[^\/]+$/); print substr($0,RSTART,RLENGTH)": "$1}'|grep -i $1|grep -v grep
}

#Kill Port
killbyport() {
    lsof -i :$1 | tail -n+2 | awk '{ print $2 }' | xargs kill
}

#######################################
# NETWORKING
#######################################
# What is using a particular port
usingport() {
	sudo lsof -iTCP:$1 -sTCP:LISTEN
}

# Check if a port is in use
portused() {
    #count=$(lsof -P | grep ":$1" | wc -l)
    count=$(netstat -an | grep $1 | wc -l)

    if [ $count -eq 0 ]
    then
        echo "Port not in use"
    else
        echo "Port in use"
    fi
}

#get the ip address of a host
hostip() {
  host $1|grep " has address "|cut -d" " -f4
}

#######################################
# FILE AND DIRECTORY RELATED
#######################################
# Get the absolute path
abspath() {
    pushd . > /dev/null;
    if [ -d "$1" ]; then
        cd "$1";
        dirs -l +0;
    else
        cd "`dirname \"$1\"`";
        cur_dir=`dirs -l +0`;

        if [ "$cur_dir" == "/" ]; then
            echo "$cur_dir`basename \"$1\"`";
        else
            echo "$cur_dir/`basename \"$1\"`";
        fi;
    fi;

    popd > /dev/null;
}

# Checks if a file or Volume is in use
inuse() {
  lsof | grep -i $1
}

# Create a new directory and enter it
function mkd() {
        mkdir -p "$@" && cd "$@"
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Determine size of a file or total size of a directory
 function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi

    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}

#Show the get info finder dialog
gi() {
    osascript - "$@" <<-END > /dev/null 2>&1
      on run args
      tell app "Finder"
    activate
        repeat with f in args
          open information window of (posix file (contents of f) as alias)
        end
      end
      end
END
}

#######################################
# Extract
#######################################
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#######################################
# Tagging
#######################################
# List files with specified Finder tags in current directory and subdirectories
lst() {
    local query
    # if the first argument is "all" (case insensitive),

    bool="OR"
    [[ $1 =~ "all" ]] && bool="AND" && shift

    # if there's no argument or the argument is "+"
    # list all files with any tags
    if [[ -z $1 || $1 == "+" ]]; then
        query="kMDItemUserTags == '*'"

    # if the first argument is "-"
    #	# list only files without tags
    elif [[ $1 == "-" ]]; then
        query="kMDItemUserTags != '*'"

    # Otherwise, build a Spotlight syntax query string
    else
        query="tag:$1"
        shift
        for tag in $@; do
            query="$query $bool tag:$tag"
        done
    fi

    while IFS= read -r -d $'\0' line; do
        echo ${line#`pwd`/}
    done < <(mdfind -onlyin . -0 "$query")
}

#######################################
# Apps
#######################################
chromed() {
    open -a 'Google Chrome' --args -allow-file-access-from-files -enable-precise-memory-info
}

#######################################
# HTTP Server
#######################################
function server() {
	local port="${1:-8000}"
	open "http://localhost:${port}/"

	# Set the default Content-Type to `text/plain` instead of `application/octet-stream
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

#######################################
# TMUX Stuff
#######################################
#kill a tmux session
tmux-kill() {
    tmux kill-session -t $1
}

#create a new tmux session
tmux-new() {
    tmux new -s $1
}

node_version()
{
  local br
  br=$(node -v)
  test -n "$br" && printf %s "$br" || :
}

#######################################
# Video
#######################################
youtube() {
    youtube-dl  --ffmpeg-location /usr/local/bin/ffmpeg --all-subs --embed-subs --embed-thumbnail --add-metadata --merge-output-format mp4 --format bestvideo[ext=mp4]+bestaudio[ext=m4a] "$1"
}

#######################################
# iTerm
#######################################
# See https://www.iterm2.com/3.3/documentation-scripting-fundamentals.html
function iterm2_print_user_vars() {
  iterm2_set_user_var phpVersion $(php -v | awk '/^PHP/ { print $2 }')
  iterm2_set_user_var rubyVersion $(ruby -v | awk '{ print $2 }')
  iterm2_set_user_var nodeVersion $(node -v)
}

