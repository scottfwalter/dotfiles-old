#!/bin/bash
ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
BASE_DIR="$HOME/Dropbox"

mkdir -p $HOME/.ssh

create_dir_link() {
    source=$1
    symlink=$2
    dir="false"

    if [[ -d $symlink ]]; then
        dir="true"

        if [[ -L "$symlink" ]]; then
            dir="false"
        fi
    fi

    if [ "$dir" = "true" ]; then
        echo "Skipping $symlink.  It is a real directory.  rm -rf $symlink && ln -s $source $symlink"
    else
        echo "Creating symlink from $source to $symlink"
        rm -f "$symlink" && ln -s "$source" "$symlink"
    fi
}

create_file_link() {
    source=$1
    symlink=$2

    echo "Creating symlink from $source to $symlink"
    rm -f "$symlink" && ln -s "$source" "$symlink"
}

#create_dir_link "$BASE_DIR/MyDocuments" "$HOME/Documents"
#create_dir_link "$BASE_DIR/MyDesktop" "$HOME/Desktop"
create_dir_link "$ICLOUD_DIR/Downloads" "$HOME/Downloads"
#create_dir_link "$BASE_DIR/Projects" "$HOME/Projects"
#create_dir_link "$BASE_DIR/Sandbox" "$HOME/Sandbox"
create_dir_link "$BASE_DIR/bin" "$HOME/bin"
create_dir_link "$BASE_DIR/dotfiles/.git-templates" "$HOME/.git-templates"
create_dir_link "$BASE_DIR/dotfiles/.tmux" "$HOME/.tmux"
create_dir_link "$BASE_DIR/dotfiles/.vim" "$HOME/.vim"
#create_dir_link "$BASE_DIR/dotfiles/.config" "$HOME/.config"

create_file_link "$BASE_DIR/dotfiles/.bash_aliases" "$HOME/.bash_aliases"
create_file_link "$BASE_DIR/dotfiles/.bash_colors" "$HOME/.bash_colors"
create_file_link "$BASE_DIR/dotfiles/.bash_functions" "$HOME/.bash_functions"
create_file_link "$BASE_DIR/dotfiles/.bash_profile" "$HOME/.bash_profile"
create_file_link "$BASE_DIR/dotfiles/.bash_prompt" "$HOME/.bash_prompt"
create_file_link "$BASE_DIR/dotfiles/.bash_dayjob" "$HOME/.bash_dayjob"
create_file_link "$BASE_DIR/dotfiles/.bashrc" "$HOME/.bashrc"
create_file_link "$BASE_DIR/dotfiles/.gitconfig" "$HOME/.gitconfig"
create_file_link "$BASE_DIR/dotfiles/.gitignore_global" "$HOME/.gitignore"
create_file_link "$BASE_DIR/dotfiles/.git-hooks" "$HOME/.git-hooks"
create_file_link "$BASE_DIR/dotfiles/.jslintrc" "$HOME/.jslintrc"
create_file_link "$BASE_DIR/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
create_file_link "$BASE_DIR/dotfiles/.tmux-mac.conf" "$HOME/.tmux-mac.conf"
create_file_link "$BASE_DIR/dotfiles/.vimrc" "$HOME/.vimrc"
create_file_link "$BASE_DIR/dotfiles/.git-prompt.sh" "$HOME/.git-prompt.sh"
create_file_link "$BASE_DIR/dotfiles/ssh-config" "$HOME/.ssh/config"
create_file_link "$BASE_DIR/dotfiles/.zshrc" "$HOME/.zshrc"
create_file_link "$BASE_DIR/dotfiles/.zshrc_Darwin" "$HOME/.zshrc_Darwin"
create_file_link "$BASE_DIR/dotfiles/.zshrc_functions" "$HOME/.zshrc_functions"
create_file_link "$BASE_DIR/dotfiles/.zshrc_prompt" "$HOME/.zshrc_prompt"
create_file_link "$BASE_DIR/dotfiles/.zshrc_colors" "$HOME/.zshrc_colors"


echo "To enable sudo with touchid.  Add the following line to /etc/pam.d/sudo"
echo "auth	   sufficient     pam_tid.so"
