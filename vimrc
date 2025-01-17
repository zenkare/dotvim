syntax on
filetype plugin indent on

let mapleader=' '

" Netrw banner.
let g:netrw_banner = 0
" Disable netrw history from being created in ~/.vim/.netrwhist.
let g:netrw_dirhistmax = 0
" Thin flat listing.
let g:netrw_liststyle = 0
" Set width of 25% of current window width.
let g:netrw_winsize = 25
" Open files from netrw in a previous window, unless we're opening the current dir.
if argv(0) ==# '.'
    let g:netrw_browse_split = 0
else
    let g:netrw_browse_split = 4
endif
" Ignore case when sorting.
let g:netrw_sort_options = 'i'

" Use system clipboard.
set clipboard=unnamed,unnamedplus

" Use wayland clipboard.
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

" Line numbers
set number
set relativenumber

" Encodings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Mouse off
set mouse=

" Indentation
set autoindent
set nosmartindent
set smarttab
set expandtab

" Indentation lengths
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80

" Folding
set foldmethod=syntax
set foldnestmax=1
set foldclose=all

" Disable viminfo logging
set viminfo=

" Disable saves
set nobackup
set noswapfile
set nowritebackup

" Disable sign column, this removes diagnostic highlighting but if there's an
" error I will notice and jump to it.
set signcolumn=no

" Delay between switching modes
set ttimeoutlen=10
set ttyfast

" Text formatting
" Underline the current line with equal in normal mode
nnoremap <F5> yyp<c-v>$r=
nnoremap <F6> 80A-<ESC>0
nnoremap <F7> 80A=<ESC>0

" Insert current time
nnoremap <F4> "=strftime("%s")<CR>P

" Trim lines of white space.
autocmd BufWritePre * :%s/\s\+$//e

" Completion
set completeopt=menu,menuone,preview,noselect,noinsert

" Custom indentation settings
autocmd FileType make setlocal ts=8 sw=8 sts=0 noet
autocmd FileType PKGBUILD setlocal ts=2 sw=2 sts=2 et

" Auto indent pasted text
" nnoremap p p=`]<C-o>
" nnoremap P P=`]<C-o>

" Disable arrows in all modes
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" Set colorscheme
" colorscheme darkness
colorscheme gruvbox
set bg=dark
highlight Normal ctermbg=NONE

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" TextEdit might fail if hidden is not set.
set hidden

" PLUGIN CONFIGURATIONS
call plug#begin()
Plug 'dense-analysis/ale'
" Plug 'gergap/vim-ollama'
" Wait until graphics card upgrade.
call plug#end()

" Ale configuration.
set omnifunc=ale#completion#OmniFunc
set signcolumn=no
nnoremap K <cmd>ALEHover<CR>
nnoremap ]d <cmd>ALENext<CR>
nnoremap [d <cmd>ALEPrevious<CR>
nnoremap <leader>gd <cmd>ALEGoToDefinition<CR>
nnoremap <leader>gr <cmd>ALEFindReferences<CR>
nnoremap <leader>ca <cmd>ALECodeAction<CR>
nnoremap <leader>rn <cmd>ALERename<CR>
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'rust': ['rustfmt'],
\}
let g:ale_linters = {
\  'rust': ['analyzer'],
\}
" Extra rust flags.
let g:ale_rust_rustfmt_options = '--edition 2018'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_examples = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
set completeopt=menuone,noselect

" " Default chat model.
" let g:ollama_chat_model = 'qwen2.5-coder:3b'
" " qwen2.5-coder (0.5b, 1.5b, 3b, 7b, 14b, 32b)
" " smaller is faster, bigger is better"
" " https://ollama.com/library/qwen2.5-coder
" let g:ollama_model = 'qwen2.5-coder:1.5b'
" let g:ollama_fim_prefix = '<|fim_prefix|>'
" let g:ollama_fim_middle = '<|fim_middle|>'
" let g:ollama_fim_suffix = '<|fim_suffix|>'
