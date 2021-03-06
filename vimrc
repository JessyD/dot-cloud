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
Plugin 'gmarik/Vundle.vim'                  " let Vundle manage Vundle

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
Plugin 'ntpeters/vim-better-whitespace' " highlight unwanted whitespaces
Plugin 'nanotech/jellybeans.vim'        " iolorscheme
Plugin 'sjl/badwolf'                    " colorscheme
Plugin 'jonathanfilip/vim-lucius'       " colorscheme
Plugin '29decibel/codeschool-vim-theme' " colorscheme
Plugin 'w0ng/vim-hybrid'                " colorscheme
Plugin 'scrooloose/nerdtree'            " file and folder structure
Plugin 'bling/vim-airline'              " status bar
Plugin 'dbakker/vim-projectroot'        " guess project root from file
Plugin 'RobertAudi/vis.vim'             " substitute visual blocks
Plugin 'clones/vim-cecutil'             " needed by vis
Plugin 'tpope/vim-commentary'           " easily comment lines out
Plugin 'tpope/vim-markdown'                 " markdown syntax highlighting
Plugin 'AlessandroA/vim-instant-markdown'   " realtime markdown browser preview
Plugin 'vim-scripts/applescript.vim'        " applescript syntax highlighting
Plugin 'Xuyuanp/nerdtree-git-plugin'        " git status in NERDTree
Plugin 'nvie/vim-flake8'                " add PEP8 checking
Plugin 'davidhalter/jedi-vim'           " python autocompletion
Plugin 'vim-scripts/indentpython'       " indentation according to PEP8
""" required
call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" easymotion
nmap <Space> <Plug>(easymotion-bd-w)
let g:EasyMotion_smartcase = 1                          " smart case as in vim
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'    " kb-layout-friendly

""" supertab - prevent unwanted tabs
let g:SuperTabNoCompleteAfter = [
    \ '^', ',', '\s', ';', "\'", '"', '>', ')', ':', '/', '%', '#'
\ ]

""" ctrlp - basic configuration
let g:ctrlp_map = '<C-p>'                           " mapped to ctrl-P
let g:ctrlp_cmd = 'CtrlP'                           " default command

""" ctrlp - customization
let g_ctrlp_switch_buffer = 'E'                     " re-open existing buffers
let g:ctrlp_tabpage_position = 'ac'                 " new tab after current
let g:ctrlp_show_hidden = 1                         " always show hidden files
let g:ctrlp_max_files=10000                         " may slow down a bit

""" ctrlp - working directory using version control or current/custom directory
let g:ctrlp_working_path_mode = 'ra'                " current + version control
nnoremap <C-l> :CtrlP ~/Code/<CR>

""" NERDTree - auto-start
augroup nerd_tree_open
    au!
    au StdinReadPre * let s:std_in=1
    """ NERDTree is started only if nothing prevents it
    """  g:NERDTreePreventOpen is set in this file
    """  since VimEnter is executed after vimrc and after all -c commands, the
    """  variable can be used here to prevent the future execution of NERDTree
    au VimEnter * if !exists('g:NERDTreePreventOpen') | NERDTree | endif
    if !(argc() == 0 && !exists("s:std_in"))
        au VimEnter * wincmd p
    endif
augroup END

""" NERDTree - close all if only NERDTree left
function! NERDTreeCloseAll()
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        q
    endif
endfunction
augroup nerd_tree_close
    au!
    au bufenter * call NERDTreeCloseAll()
augroup END

""" vim-commentary - custom file types
augroup vim_commentary_custom
    au!
    au FileType matlab set commentstring=%\ %s
augroup END

""" vim-instant-markdown - general settings
let g:instant_markdown_script = "~/.vim/vim-instant-markdown_chrome.applescript"

""" vim-better-whitespace
autocmd VimEnter * DisableWhitespace
autocmd VimEnter * EnableWhitespace
let g:strip_whitespace_on_save = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" syntax highlighting
syntax on

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
    colorscheme jellybeans              " colorscheme
catch /^Vim\%((\a\+)\)\=:E185/          " fallback
    colorscheme slate                   " just happens at first installation
endtry

""" tabs
set shiftwidth=4                        " shift width
set tabstop=4                           " tab width
set softtabstop=4                       " tab width in insert mode
set expandtab                           " tabs are spaces

""" automatic text-wide word wrapping
set textwidth=80                        " text width
set formatoptions+=t                    " wrap word
set colorcolumn=81                      " color text after textwidth
set autoindent                          " allow automatic indentation

""" folding
set foldmethod=indent                   " fold based on indentation
set foldenable                          " enable folding
set foldlevelstart=10                   " small snippets are unfolded

""" search
set incsearch                           " incremental search
set hlsearch                            " highlight matches
set smartcase                           " case smartly-insensitive search

""" parenthesis matching highlighting
set showmatch                           " highlight matching {[()]}

""" share clipboard with system (may show unwanted behavior)
""" FIXME allow clipboard sharing over X11 sessions (ssh)
set clipboard=unnamed                   " system wide clipboard

""" show special characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

""" linearly increment a list of numbers in visual mode with Ctrl-a
function! IncrementListLinearly()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call IncrementListLinearly()<CR>

""" always highlight keywords as TODO and FIXME
augroup HiglightKeywords
    au!
    au bufenter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
augroup END

""" auto-detect file changes (not if in command line window)
set autoread
function! CheckFileChanges()
    if getcmdtype() == ""
        checktime
    endif
endfunction
augroup file_changed
    au!
    au CursorMoved * call CheckFileChanges()
augroup END

""" mouse interaction (may show unwanted behavior)
set mouse=a                             " mouse can interact

""" project-specific settings (may override default)
function! ProjectSpecificSettings()
    let l:path = expand('%:p')
    let l:root = projectroot#guess(l:path)
    let l:vim_custom = l:root . "/.custom.vim"
    if filereadable(l:vim_custom)
        exec "so " . l:vim_custom
    endif
endfunction
augroup project_specific_settings
    au!
    au BufReadPost,BufNewFile * call ProjectSpecificSettings()
augroup END

""" custom highlighting for jellybeans
let g:jellybeans_overrides = {
\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
\              'attr': 'bold' },
\}

let python_highlight_all=1

" "python with virtualenv support
" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"     project_base_dir = os.environ['VIRTUAL_ENV']
"     activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"     execfile(activate_this, dict(__file__=activate_this))
" EOF

syntax on

" ignore .pyc files on NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"keeps current visual block selection after indentation
vmap > >gv
vmap < <gv

"remaps quick alternation between splitted windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set encoding=utf-8
