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
    rm ~/.vimrc
fi

# dependencies
echo "Installing dependencies..."

## operating system-specific dependencies
platform="$(uname -s)"
if   [[ "$platform" == 'Linux'  ]]
then
    sudo apt-get install ack-grep
elif [[ "$platform" == 'Darwin' ]]
then
    brew install ack
else
    echo "Platform $platform not supported"
fi

## common dependencies
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# FIXME what happens if script executed from other folder?
ln -s $(pwd)/vimrc ~/.vimrc

# plugins initialization
echo "Installing plugins with Vundle..."
vim +PluginInstall +qall

echo "Done! Goodbye"
