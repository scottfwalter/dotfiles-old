# GITSTATUS_LOG_LEVEL=DEBUG

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################################
# Basic options
#################################
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt GLOB_COMPLETE
#setopt shwordsplit
unsetopt correct_all

#################################
# History file options
#################################
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

#################################
# Core
#################################
alias zshreload="source ~/.zshrc"
alias cwd="pwd | pbcopy"

#################################
# vi command line editing
#################################
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
#bindkey -M vicmd '^e' edit-command-line
bindkey -M vicmd v edit-command-line

MODE_CURSOR_VICMD="green blinking bar"
MODE_CURSOR_VIINS="#red block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
source ~/bin/zsh/zsh-vim-mode.plugin.zsh

# #################################
# # Auto Complete
# #################################
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# #################################
# # GREP
# #################################
export GREP_OPTIONS='--color=auto --exclude-dir=.svn --exclude-dir=target'

# #################################
# # GIT
# #################################
alias gpush="echo pushing to `git rev-parse --abbrev-ref HEAD` && sleep 3 && git push origin `git rev-parse --abbrev-ref HEAD`"
alias gpm="git fetch origin master && git merge origin/master"
alias module-version="npm list --depth=0 | grep "


# #################################
# # Set platform variable
# #################################
case $(uname) in
    Darwin)
    # macOS specific code goes here
    export platform="mac"
    ;;

    Linux)
    export platform="linux"
    alias ls="ls --color"
    ;;

    *)
    export platform="other"
    # Other platforms code goes here
esac

platform_zshrc=${ZDOTDIR:-$HOME}/.zshrc_$(uname)
if [[ -r $platform_zshrc ]]; then
    source $platform_zshrc
fi

# #################################
# # Set Editor
# #################################
if [[ -x "/usr/local/bin/code" ]]; then
   export EDITOR="/usr/local/bin/code -W"
fi
export EDITOR="vim"

# #################################
# # Source Additional Files
# #################################
# files=('.zshrc_prompt' '.zshrc_functions' '.zshrc_colors')
files=('.zshrc_functions' '.zshrc_colors')
for f in $files; do
  . ~/$f
done

# #################################
# # Node JS
# #################################
# #Use system version of Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # T

# nvm use 10.16.0

# ##
# alias lsn="ls . | tr '\n' '\0' | xargs -0 -n 1 basename"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

#################################
# PATH
#################################
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias ibash="/usr/local/bin/bash"

