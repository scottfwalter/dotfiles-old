
#################################
# Determine Platform
#################################
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
fi

#################################
# Source system shell
#################################

#https://superuser.com/questions/544989/does-tmux-sort-the-path-variable/583502#583502
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

[[ -r ~/.bashrc ]] && . ~/.bashrc

#################################
# Basic Bash Settings
#################################
# Fix typos
shopt -s cdspell

#Enable vi editing command on the command line
set -o vi

#################################
# History Settings
#################################

# Store 10,000 history entries
export HISTSIZE=10000

# Don't put duplicates in the history
export HISTCONTROL=erasedups

# Don't clobber the history when closing multiple shells
shopt -s histappend

#################################
# Default Editors
#################################
export EDITOR=vim
export VISUAL=vim

#################################
# Path  Settings
#################################
[ -r "$HOME/bin" ] && export PATH=$HOME/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH

#################################
# Command Settings
#################################

# Set default block size for ls, df, du
export BLOCK_SIZE=K
export BLOCKSIZE=K

# Default grep options
export GREP_OPTIONS='--color=auto --exclude-dir=.svn --exclude-dir=target'

export FZF_DEFAULT_COMMAND='rg --files --follow'


#################################
# Node JS
#################################
#Use system version of Node
nvm use 10.16.0

#################################
# Mac Specific
#################################

if [ "$platform" = "mac" ];
then
    #Export directory to iCloud Drive
    export CLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

    #integrate with iTerm
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

    #show apple banner
    archey -c -o

    if ls --color -d . >/dev/null 2>&1; then
        alias ls="ls --color"
    else
        alias ls="ls -G"
    fi
else
    alias ls="ls --color"
fi

#################################
# Source Additional Files
#################################
for file in ~/{.bash_colors,.bash_prompt,.bash_aliases,.bash_functions,.bash_dayjob}; do
    [ -r "$file" ] && source "$file"
done
unset file

export BREW_PREFIX=$(brew --prefix)

