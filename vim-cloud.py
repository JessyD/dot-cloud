# modules
import argparse
import os
import sys
import shutil
import time

# current platform
from sys import platform as _platform

# supported platforms
supported_platforms = ["linux", "darwin"]

# default configuration
home_path = os.path.expanduser("~")
vimrc_file_path = home_path + "/.vimrc"
vim_dir_path = home_path + "/.vim"

# timestamp
time_stamp = "_" + time.strftime('%Y%m%d%H%M%S', time.localtime())

"""
    install_vimrc(args)
        it backs up a previous custom configuration of vim, if any, installs
        all missing dependencies and then installs the current vim; the user
        can also choose to install once, unlinking the .vimrc file from the
        cloned git repository
"""
def install_vimrc(args):
    if os.path.isdir(vim_dir_path):
        print("Back up: " + vim_dir_path)
        try:
            shutil.copytree(vim_dir_path, vim_dir_path + time_stamp)
        except RuntimeError:
            print("Error while backing up " + vim_dir_path)
    if os.path.isfile(vimrc_file_path):
        print("Back up: " + vimrc_file_path)
        try:
            shutil.copyfile(vimrc_file_path, vimrc_file_path + time_stamp)
        except RuntimeError:
            print("Error while backing up " + vimrc_file_path)
    print("Checking dependencies...")
    if args.once:
        print("Once")
    print("i")

def update_vimrc(args):
    print("u")

def clean_vimrc(args):
    print("c")

def switch(mode):
    return {
        'i': install_vimrc,
        'u': update_vimrc,
        'c': clean_vimrc,
    }[mode]

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-m", "--mode",
                        help="Execution mode: (i)nstall, (u)pdate, (c)lean",
                        type=str, action="store",
                        choices=["i", "u", "c"], default="i")
    parser.add_argument("-o", "--once",
                        help="Perform unlinked installation (static .vimrc)")
    args = parser.parse_args()

    if _platform not in supported_platforms:
        raise RuntimeError("This platform is currently unsupported")

    # execute the function corresponding to the chosen mode
    switch(args.mode)(args)

if __name__ == "__main__":
    main()
