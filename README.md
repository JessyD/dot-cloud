vim-cloud
=========

My vim, everywhere.

# Installation

The installation script is only needed once.

Use it with care. It has not been used with exotic configurations. The `.vimrc`
file and the `.vim` folder are supposed to be in the home folder `~/`.

The script tries to be conservative and keep the present custom vim, if any. No
merge is done: If installation goes on, the version in the repository is
fully copied, backing up and removing the old one.

```bash
git clone git@github.com:AlessandroA/vim-cloud.git
cd vim-cloud
chmod +x vim-cloud.sh
./vim-cloud.sh
```

A symbolic link is created in the home folder that points to the `.vimrc` file
of this repository, so that pushed/pulled changes are automatically applied.
