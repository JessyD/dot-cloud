"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" required
set nocompatible
filetype off

""" set the runtime path to include Vundle and initialize it
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""" Vundle
Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle

""" General plugins
Plugin 'vim-scripts/Gundo'              " visualize vim undo tree
Plugin 'terryma/vim-multiple-cursors'   " multi-cursors
Plugin 'kien/ctrlp.vim'                 " fuzzy file search
Plugin 'tpope/vim-fugitive'             " git features from within vim
Plugin 'mileszs/ack.vim'                " ack in vim
Plugin 'Lokaltog/vim-easymotion'        " jump anywhere quickly
Plugin 'airblade/vim-gitgutter'         " git diff in sign column
Plugin 'scrooloose/syntastic'           " syntax checking
Plugin 'ervandew/supertab'              " tab auto-completion
Plugin 'scrooloose/nerdcommenter'       " comment lines out
Plugin 'ntpeters/vim-better-whitespace' " highlight unwanted whitespaces
Plugin 'sjl/badwolf'                    " colorscheme
Plugin 'scrooloose/nerdtree'            " file and folder structure
Plugin 'bling/vim-airline'              " status bar

""" required
call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" easymotion
nmap <unique> <Space> <Plug>(easymotion-bd-w)
let g:EasyMotion_smartcase = 1                          " smart case as in vim
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'    " layout-friendly

""" supertab - prevent unwanted tabs
let g:SuperTabNoCompleteAfter = [
    \ '^', ',', '\s', ';', "\'", '"', '>', ')', ':', '/'
\ ]

""" ctrlp - basic configuration
let g:ctrlp_map = '<C-p>'                               " main command
let g:ctrlp_cmd = 'CtrlP'

""" ctrlp - customization
let g_ctrlp_switch_buffer = 'E'                     " re-open existing buffers
let g:ctrlp_tabpage_position = 'ac'                 " new tab after current

""" ctrlp - working directory using version control or current/custom directory
let g:ctrlp_working_path_mode = 'ra'
nnoremap <unique> <C-l> :CtrlP ~/Code/<CR>

"let g:ctrlp_show_hidden = 1
"let g:ctrlp_custom_ignore = {
"    \ 'dir' : '\v[\/]\.(git|hg|svn)$',
"    \ 'file': '\v\.(exe|so|dll)$',
"    \ 'file': '^\.^[gitignore]',
"    \ 'link': 'some_bad_symbolic_links',
"    \ }

""" NERDTree - auto-start
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
if argc() == 0 && !exists("s:std_in")
else
    autocmd VimEnter * wincmd p
endif

""" NERDTree - close all if only NERDTree left
function NERDTreeCloseAll()
    if (winnr("$") == 1 && exists("b:NERDTreeType")
                      \ && b:NERDTreeType == "primary")
        q
    endif
endfunction
au bufenter * call NERDTreeCloseAll()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" syntax highlighting
syntax on                               " syntax highlighting

""" spell checking
"setlocal spell                          " spell checking

""" lines
set number                              " show line numbers
set cursorline                          " show current line

""" status bar
set laststatus=2                        " persistent status bar
set ruler                               " show column number

""" fix backspaces 'bug'
set backspace=indent,eol,start          " backspace for special cases

""" color scheme
set t_Co=256                            " 256 colors
try
    colorscheme badwolf                 " colorscheme
catch /^Vim\%((\a\+)\)\=:E185/          " fallback
    colorscheme elflord                 " just happens at first installation
endtry

""" tabs
set shiftwidth=4                        " shift width
set tabstop=4                           " tab width
set softtabstop=4                       " tab width in insert mode
set expandtab                           " tabs are spaces

""" automatic text-wide word wrapping
set textwidth=79                        " text width
set formatoptions+=t                    " wrap word
set colorcolumn=80                      " color text after textwidth

""" folding
set foldenable                          " enable folding
set foldmethod=indent                   " fold based on indentation
set foldlevelstart=10                   " small snippets are unfolded

""" search
set incsearch                           " incremental search
set hlsearch                            " highlight matches
set smartcase                           " case smartly-insensitive search

""" parenthesis matching highlighting
set showmatch                           " highlight matching {[()]}

""" share clipboard with system (may show unwanted behavior)
set clipboard=unnamed                   " system wide clipboard

""" auto-detect file changes (not if in command line window)
set autoread
function CheckFileChanges()
    if getcmdtype() == ""
        checktime
    endif
endfunction
au CursorMoved * call CheckFileChanges()

""" mouse interaction (may show unwanted behavior)
set mouse=a                             " mouse can interact

""" project-specific settings (may override default)
if filereadable(".vim.custom")
	so .vim.custom
endif
