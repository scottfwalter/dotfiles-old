export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for jiractl package
# uninstall by removing these lines or running `tabtab uninstall jiractl`
[ -f /Users/scottwalter/.nvm/versions/node/v8.12.0/lib/node_modules/@godaddy/jiractl/node_modules/tabtab/.completions/jiractl.bash ] && . /Users/scottwalter/.nvm/versions/node/v8.12.0/lib/node_modules/@godaddy/jiractl/node_modules/tabtab/.completions/jiractl.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

