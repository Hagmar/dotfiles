" ============= SETUP =============
" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

" Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdcommenter'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'

" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'peitalin/vim-jsx-typescript'

" Initialize plugin system
call plug#end()




" ============= GENERAL =============
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

let mapleader = ","           " Set leader to comma


" UI
set number                  " Line numbers
syntax on
set ruler                   " Always display infobar at bottom
set laststatus=2            " Always display statusbar
set wildmenu                " Visual autocomplete for command window
set splitbelow              " Horizontal splits place new pane below current
set splitright              " Vertical splits place new pane right of current
set showmatch               " Show matching brackets
set lazyredraw              " Only redraw when necessary
set scrolloff=5             " Always show lines above/below cursor
set mouse=                  " Disable mouse

" Syntax highlightings
au BufReadPost *.handlebars set syntax=handlebars
au BufNewFile,BufRead *.less set filetype=less
au BufReadPost *.tsx set syntax=typescript


" No more trailing white spaces
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" Indentation
set autoindent              " Autoindent
set smartindent
set tabstop=4               " Number of visual spaces per tab
set softtabstop=4           " Number of spaces in tab when editing
set expandtab               " Turn tabs into spaces
set shiftwidth=4            " Number of spaces to use for autoindent
filetype plugin indent on          " Load filetype-specific indent files

" Set indentation for typescript
autocmd FileType typescript,typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2


" Searching
set incsearch               " Search while typing
set hlsearch                " Highlight all search matches
                            " Clear search highlights
nnoremap <silent> <leader><space> :nohlsearch<CR>

" sane regexes
nnoremap / /\v
vnoremap / /\v

" keep search results centered
nnoremap <silent> n nzz
nnoremap <silent> N Nzz


" Movement
                            " jk is escape
inoremap jk <esc>
                            " Move vertically by visual line
nnoremap j gj
nnoremap k gk
                            " Move to beginning/end of line
nnoremap B ^
nnoremap E $
                            " Move up/down one buffer
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
                            " Switch tabs
nnoremap <C-h> gT
nnoremap <C-l> gt
                            " Highlight last inserted text
nnoremap gV `[v`]


" Editing
set backspace=2             " Delete all characters with backspace
set history=500             " Remember commands
set autoread                " Detect updates from outside vim and reload file
set nrformats-=octal        " Don't recognize octal numbers
set pastetoggle=<F2>        " Toggle paste mode with F2
vnoremap s :sort<CR>
                            " Close current buffer
nmap <leader>d :b#<bar>bd#<CR>
                            " Close all other buffers
command! BufOnly %bd|e#|bd#

                            " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

                            " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P






" ============= PLUGINS =============
" NERDTree
" Open NERDTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>
" Open NERDTree to current file
map <leader>m :NERDTreeFind<cr>

let g:NERDTreeGitStatusWithFlags = 1

" Ignore node_modules folder
let g:NERDTreeIgnore = ['^node_modules$']

" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


" FZF
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number --color=always -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': '--color hl:123,hl+:222 --delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': '--color hl:123,hl+:222 --delimiter : --nth 4..' }), 0)


nnoremap <leader>p :FZF<cr>
"nnoremap <leader>f :Files<cr>
nnoremap <leader>o :GFiles<cr>
nnoremap <C-p> :GFiles<cr>
nnoremap <leader>g :Rg <c-r><c-w><cr>
nnoremap <leader>rg :Rg<cr>
nnoremap <leader>b :Buffers<cr>
" nnoremap <leader>g :GGrep<cr>


" Rooter
" Define project root for Rooter
let g:rooter_patterns = ['.git/']


" Gundo
                            " Toggle gundo
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_preview_bottom=1                    " Force preview window below current windows
let g:gundo_close_on_revert=1                   " Automatically close on revert


" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_y = ''                    " Disable encoding section of status bar


" GitGutter
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_preview_win_floating = 1


" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile



" Coc
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

" From readme
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CocList:
" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
