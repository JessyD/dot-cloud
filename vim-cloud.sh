#!/bin/bash

# function to ask for confirmation
confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-'Are you sure? [y/N]'} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# ask for confirmation
if [ -e ~/.vim -o -e ~/.vimrc ]
then
    echo "A customized version of vim has already been found."
    # exit by default
    ! confirm "Do you want to continue? [y/N]" && exit
    # back up otherwise
    echo "Backing up..."
    mkdir -p ~/.vim.old
    cp -r ~/.vim ~/.vimrc ~/.vim.old/ 2>/dev/null
    rm -rf ~/.vimrc ~/.vim
fi

# dependencies
echo "Installing dependencies..."

## operating system-specific dependencies
## FIXME different approach with dependencies: list missing, the user takes
##       care of them
platform="$(uname -s)"
if   [[ "$platform" == 'Linux'  ]]
then
    dpkg -s ack-grep 2>/dev/null >/dev/null || sudo apt-get -y install ack-grep
elif [[ "$platform" == 'Darwin' ]]
then
    for pkg in ack; do
    if ! brew list -1 | grep -q "^${pkg}\$"; then
        brew install ${pkg}
    fi
    done
else
    echo "Platform $platform not supported"
fi

## common dependencies
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# create symbolic link
script_path="`dirname \"$0\"`"                  # relative path of script
script_path="`( cd \"$script_path\" && pwd )`"  # absolute path
ln -s $script_path/vimrc ~/.vimrc

# create symbolic links for neovim as well
echo "Updating neovim as well..."
mkdir -p ~/.nvim
ln -sfn ~/.vim ~/.nvim
ln -sfn ~/.vimrc ~/.nvimrc

# copy additional files
mkdir -p ~/.vim/after/ftplugin
cp *.vim ~/.vim/after/ftplugin/
cp vim-instant-markdown_chrome.applescript ~/.vim/

# plugins initialization
echo "Installing plugins with Vundle..."
vim +PluginInstall +qall

echo "Done! Goodbye"
