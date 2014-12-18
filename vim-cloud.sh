#!/bin/sh

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
if [[ "$(ls ~/.vim)" != ''  ]]
then
    echo "A customized version of vim has already been found."
    ! confirm "Do you want to continue? [y/N]" && exit
    echo "OK, but I don't trust you. Backing up..."
fi

# backup anyway
mkdir -p ~/.vim.old
cp -r ~/.vim ~/.vimrc ~/.vim.old/ 2>/dev/null
rm -rf ~/.vim ~/.vimrc

# dependencies
echo "Installing dependencies..." 

## check operating systems
platform="$(uname -s)"
if   [[ "$platform" == 'Linux'  ]]
then
    ### Linux-specific dependencies
    sudo apt-get install ack
elif [[ "$platform" == 'Darwin' ]]
then
    ### OS X-specific dependencies
    brew install ack
else
    echo "Platform $platform not supported"
fi

## common dependencies
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/Code/vim-cloud/.vimrc ~/.vimrc
#ln -s .vimrc ~/.vimrc

# plugins initialization
echo "Installing plugin with Vundle"
vim +PluginInstall +qall

echo "Done! Goodbye"
