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
Plugin 'ntpeters/vim-better-whitespace' " highlight unwanted whitespaces
Plugin 'sjl/badwolf'                    " colorscheme
Plugin 'scrooloose/nerdtree'            " file and folder structure
Plugin 'bling/vim-airline'              " status bar
Plugin 'dbakker/vim-projectroot'        " guess project root from file
Plugin 'RobertAudi/vis.vim'             " substitute visual blocks
Plugin 'clones/vim-cecutil'             " needed by vis
Plugin 'tpope/vim-commentary'           " easily comment lines out
Plugin 'neilagabriel/vim-geeknote'      " integrate geeknote in vim

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
    \ '^', ',', '\s', ';', "\'", '"', '>', ')', ':', '/', '%'
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
    if (winnr("$") == 1 && exists("b:NERDTreeType")
                      \ && b:NERDTreeType == "primary")
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

""" vim-geeknote - general settings
let g:GeeknoteFormat = "markdown"       " warning: it may cause lost content
augroup geeknote_startup
    au!
    """ prevent execution of NERDTree and close and existing instance
    au FileType geeknote let g:NERDTreePreventOpen = 1 | NERDTreeClose
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" syntax highlighting
syntax on                               " syntax highlighting

""" spell checking
""" FIXME add conditional spell check for verbose filetypes (md, latex)
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
    au WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
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

""" reload .vimrc in a running vim instance everytime it is changed
augroup reload_vimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
                \|if has('gui_running') | so $MYGVIMRC | endif
augroup END
