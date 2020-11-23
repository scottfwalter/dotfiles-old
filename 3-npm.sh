if [ ! -f "$HOME/.nvm/nvm.sh" ]; then
    echo "Installing nvm for you."
    mkdir $HOME/.nvm
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
fi

# Install commonly used clis
sudo npm i -g fkill-cli
sudo npm i -g http-server
# sudo npm install -g eslint
sudo npm i -g gist-backup

