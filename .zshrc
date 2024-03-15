# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# GITSTATUS_LOG_LEVEL=DEBUG

#################################
# Basic options
#################################
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt GLOB_COMPLETE
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
# vi command line editing
#################################
bindkey -v
export KEYTIMEOUT=1

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

MODE_CURSOR_VICMD="green blinking bar"
MODE_CURSOR_VIINS="#red block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"

# #################################
# # Set Editor
# #################################
if [[ -x "/usr/local/bin/code" ]]; then
   export EDITOR="/usr/local/bin/code -W"
fi
export EDITOR="vim"

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

# #################################
# # Source Additional Files
# #################################
files=('.zshrc_alias_functions' '.zshrc_colors' '.zshrc_cxone' '.zshrc.local')
for f in $files; do
  . ~/$f
done

# #################################
# # Node JS
# #################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # T


if [ "`uname -m`"  = 'arm64' ]; then
    export BREW_PREFIX="/opt/homebrew"
else
    export BREW_PREFIX="/usr/local"
fi

#################################
# RUBY
#################################
export GEMS=$BREW_PREFIX/lib/ruby/gems/3.0.0/bin
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"
export LDFLAGS="-L/$BREW_PREFIX/opt/ruby/lib"
export CPPFLAGS="-I/$BREW_PREFIX/opt/ruby/include"
export PKG_CONFIG_PATH="/$BREW_PREFIX/opt/ruby/lib/pkgconfig"

#################################
# PATH
#################################
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"


#################################
# macOS
#################################
platform_zshrc=${ZDOTDIR:-$HOME}/.zshrc_$(uname)
if [[ -r $platform_zshrc ]]; then
    source $platform_zshrc
fi

#################################
# Starship
#################################
#export STARSHIP_CONFIG=~/.starship-config/starship.toml
eval "$(starship init zsh)"

#################################
# Java
#################################
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/scott/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(fnm env --use-on-cd)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# bun completions
[ -s "/Users/scott/.bun/_bun" ] && source "/Users/scott/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
