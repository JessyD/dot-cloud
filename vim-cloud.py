import argparse

def install_vimrc():
    print("i")

def update_vimrc():
    print("u")

def clean_vimrc():
    print("c")

def switch(mode):
    return {
        'i': install_vimrc,
        'u': update_vimrc,
        'c': clean_vimrc,
    }[mode]

def main():
    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-m", "--mode",
                        help="Execution mode: (i)nstall, (u)pdate, (c)lean",
                        type=str, action="store",
                        choices=["i", "u", "c"], default="i")
    args = parser.parse_args()

    # execute the function corresponding to the chosen mode
    switch(args.mode)()

if __name__ == "__main__":
    main()
