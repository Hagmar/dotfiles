" UI
set number		        	" Line numbers
set wildmenu		        " Visual autocomplete for command window

" Movement
                            " Move vertically by visual line
nnoremap j gj
nnoremap k gk
                            " Move to beginning/end of line
nnoremap B ^
nnoremap E $
                            " Highlight last inserted text
nnoremap gV `[v`]

" Leader shortcuts
let mapleader=","           " Set leader to comma
                            " jk is escape
inoremap jk <esc>

" Indentation
set autoindent		        " Autoindent
set smartindent
set tabstop=4		        " Number of visual spaces per
set softtabstop=4	        " Number of spaces in tab when editing
set expandtab		        " Turn tabs inte spaces
filetype indent on	        " Load filetyp-specific indent files

" Searching
set incsearch		        " Search while typing
set hlsearch			    " Highlight all search matches
nnoremap <leader><space> :nohlsearch<CR>

" Folding
set foldenable              " Enable folding
set foldlevelstart=15       " Open most folds by default
set foldnestmax=10          " Max 10 nested folds
set foldmethod=syntax       " Fold based on syntax
                            " Space opens/closes folds
nnoremap <space> za

set showmatch		        " Show matching brackets
set lazyredraw		        " Only redraw when necessary
noremap <F2> :echo strftime('%c')<CR>
