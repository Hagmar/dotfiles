execute pathogen#infect()

" UI
set number                  " Line numbers
syntax on
set ruler                   " Always display infobar at bottom
set laststatus=2            " Always display statusbar
set wildmenu                " Visual autocomplete for command window
set splitbelow              " Horizontal splits place new pane below current
set splitright              " Vertical splits place new pane right of current

" Movement
                            " Move vertically by visual line
nnoremap j gj
nnoremap k gk
                            " Move to beginning/end of line
nnoremap B ^
nnoremap E $
                            " Move up/down one buffer
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
set scrolloff=1             " Always show lines above/below cursor
                            " Highlight last inserted text
nnoremap gV `[v`]

" Editing
set backspace=2             " Delete all characters with backspace
set history=500             " Remember commands
set autoread                " Detect updates from outside vim and reload file
set nrformats-=octal        " Don't recognize octal numbers
set pastetoggle=<F2>        " Toggle paste mode with F2

" Leader shortcuts
let mapleader=","           " Set leader to comma
                            " jk is escape
inoremap jk <esc>
                            " Toggle gundo
nnoremap <leader>u :GundoToggle<CR>
                            " Open CtrlP
nnoremap <leader>o :CtrlP<CR>
                            " Open CtrlP in buffer mode
nnoremap <leader>b :CtrlPBuffer<CR>
                            " Set syntax to python
nnoremap <leader>sp :set syntax=python<CR>
                            " Set syntax to html
nnoremap <leader>sh :set syntax=html<CR>

" Indentation
set autoindent              " Autoindent
set smartindent
set tabstop=4               " Number of visual spaces per tab
set softtabstop=4           " Number of spaces in tab when editing
set expandtab               " Don't turn tabs into spaces
set shiftwidth=4            " Number of spaces to use for autoindent
filetype plugin indent on          " Load filetyp-specific indent files

" Searching
set incsearch               " Search while typing
set hlsearch                " Highlight all search matches
                            " Clear search highlights
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Gundo settings
let g:gundo_preview_bottom=1                    " Force preview window below current windows
let g:gundo_close_on_revert=1                   " Automatically close on revert

" CtrlP settings
let g:ctrlp_match_window='bottom,order:ttb'     " Order matches from top to bottom
let g:ctrlp_switch_buffer='Et'                  " Open selected files in a new buffer
let g:ctrlp_working_path_mode=0                 " Accept working directory changes
if executable("ag")
                                                " Search using Ag
    let g:ctrlp_user_command='ag %s --files-with-matches --nocolor --hidden -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
endif

" Syntastic settings
                            " Hide Syntastic output
nnoremap <silent> <leader>h :SyntasticReset<CR>
                            " Jump to next error
nnoremap <silent> <leader>n :lnext<CR>
                            " Jump to previous error
nnoremap <silent> <leader>p :lprev<CR>
                            " Jump to first error
nnoremap <silent> <leader>f :lfirst<CR>

" Recommended settings for now
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/bin/python3'


set showmatch               " Show matching brackets
set lazyredraw              " Only redraw when necessary

                            " Show time when pressing F3
noremap <F3> :echo strftime('%c')<CR>
