vim-cloud
=========

My vim, everywhere.

# Installation

The script tries to be conservative and keep the present custom vim, if any. No
merge is done: If installation goes on, the version in the repository is
installed, backing up and removing the old one.

```bash
git clone git@github.com:AlessandroA/vim-cloud.git
cd vim-cloud
chmod +x vim-cloud.sh
./vim-cloud.sh
```

A symbolic link is created in the home folder that points to the `.vimrc` file
of this repository, so that pushed/pulled changes are automatically applied.
