"                         _
"   _ __   ___  _____   _(_)_ __ ___
"  | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
"  | | | |  __/ (_) \ V /| | | | | | |
"  |_| |_|\___|\___/ \_/ |_|_| |_| |_|
"

"===========================
" Load vim-plug for plugins
"===========================
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !pip3 install --user pynvim
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/bundle')

	"Plug '~/.zgen/junegunn/fzf-master'
	"Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'kien/ctrlp.vim'

	Plug 'dense-analysis/ale'
	Plug '~/.config/nvim/bundle/vim-trailing-whitespace'

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
	Plug 'Shougo/deoplete-clangx'
	Plug 'deoplete-plugins/deoplete-jedi'
	Plug 'deoplete-plugins/deoplete-zsh'
	Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
	Plug 'ervandew/supertab'

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'mattn/emmet-vim'

	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'

	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'jiangmiao/auto-pairs'

	Plug 'sheerun/vim-polyglot'

	Plug 'christoomey/vim-tmux-navigator'

call plug#end()

"=============
" Basic stuff
"=============
" Enable true color
"if exists('+termguicolors')
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"  set termguicolors
"endif
syntax on
filetype plugin indent on
set scrolloff=5
set pumheight=10
set autoindent
set smarttab
set number relativenumber
set clipboard=unnamedplus
set inccommand=nosplit
set tabstop=4
set shiftwidth=4
set ignorecase
set smartcase
set undofile
set background=dark
set mouse=a
set tabpagemax=15
set showtabline=1  " 1 to show tabline only when more than one tab is present
set splitright
set splitbelow
color term

" Restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Statusline
source $HOME/.config/nvim/statusline.vim

set laststatus=2
set noruler
set showcmd
set noshowmode

let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set laststatus=1
		set noruler
		set noshowcmd
		set showmode
	else
		let s:hidden_all = 0
		set laststatus=2
		set noruler
		set noshowcmd
		set noshowmode
	endif
endfunction

nnoremap <S-s> :call ToggleHiddenAll()<CR>

"================
" Plugin configs
"================
" ALE - Asynchronous Lint Engine
hi ALEWarning       ctermbg=NONE  ctermfg=3   cterm=underline
hi ALEError         ctermbg=NONE  ctermfg=1   cterm=underline
hi ALEWarningSign   ctermbg=NONE  ctermfg=3   cterm=bold
hi ALEErrorSign     ctermbg=NONE  ctermfg=1   cterm=bold

let g:ale_linters = {
\   'c': ['ccls', 'clang'],
\   'cpp': ['ccls', 'clang'],
\   'javascript': ['eslint'],
\   'php': ['php'],
\   'python': ['pyls', 'flake8'],
\   'sh': ['language_server', 'shellcheck', 'shell'],
\   'zsh': ['language_server', 'shellcheck', 'shell'],
\}
let g:ale_fixers = {
\   '*': ['trim_whitespace', 'remove_trailing_lines'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'css': ['prettier'],
\   'go': ['gofmt'],
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'php': ['prettier'],
\   'python': ['black'],
\   'sh': ['shfmt'],
\   'scss': ['prettier'],
\   'yaml': ['prettier'],
\}

" fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Function'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Visual'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'ErrorMsg'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Default fzf layout
let g:fzf_layout = { 'down': '~50%' }

" ctrlp configuration
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_cmd = 'CtrlP'

" Python paths, needed for virtualenvs
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" Syntax highlighting
let g:python_highlight_all = 1

" Go - $ go get -u github.com/stamblerre/gocode
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" Whitspace
let g:extra_whitespace_ignored_filetypes = [ 'help', 'vim-plug' ]

" GitGutter
set updatetime=100
hi GitGutterChange       ctermfg=3    cterm=bold
hi GitGutterAdd          ctermfg=2    cterm=bold
hi GitGutterDelete       ctermfg=1    cterm=bold
hi GitGutterChangeDelete ctermfg=5 	  cterm=bold

" Open Nerd Tree if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Emmet settings
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Deoplete - autocompletion
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

call deoplete#custom#source('ultisnips', 'rank', 1000)

" AutoPairs
let g:AutoPairs={'(':')', '[':']', '{':'}', "'":"'", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"} "'<':'>',

" On startup, go to the last changes
"au BufEnter * :'.

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

"===================
" Language-specific
"===================
augroup langindentation
	autocmd Filetype c setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype php setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

"==============
" Key Bindings
"==============
" Leader key
let mapleader = ' '

" Enable/Disable deoplete
map <Leader>d :call deoplete#toggle()<CR>

" Gitgutter maping
map <Leader>gt :GitGutterToggle<CR>
nmap gn <Plug>(GitGutterNextHunk)
nmap gN <Plug>(GitGutterPrevHunk)
nmap gs <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gp <Plug>(GitGutterPreviewHunk)

" Disable hlsearch
map <C-s> :noh<CR>

" Go to last change
map <Leader>l :'.<CR>

" Complete with <TAB>
"inoremap <expr> <silent> <Tab>  pumvisible()?"\<C-n>":"\<TAB>"
"inoremap <expr> <silent> <S-TAB>  pumvisible()?"\<C-p>":"\<S-TAB>"

" When line overflows, it will go
" one _visual_ line and not actual
map j gj
map k gk

" fzf, fuzzy finder
"nnoremap <C-p> :Files<CR>
"nnoremap <C-g> :GFiles<CR>
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }

" CtrlP
let g:ctrlp_map = '<c-p>'
map <C-i> :CtrlPBufTag<CR>

map <C-n> :NERDTreeToggle<CR>

" SuperTab
let g:SuperTabMappingTabLiteral = '<a-tab>'
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'

" ALE - Asynchronous Lint Engine
map fw :FixWhitespace<CR>
map <Leader>af :ALEFix<CR>
map <Leader>an :ALENext<CR>
map <Leader>aN :ALEPrevious<CR>
map <Leader>ad :ALEDetail<CR>
map <Leader>ag :ALEGoToDefinitionInSplit<CR>
map <Leader>aG :ALEGoToDefinition<CR>

" Tab Managment
map <C-o> :tabnew<CR>
map <C-c> :tabclose<CR>
nnoremap <Leader>k gT
nnoremap <Leader>j gt

" Split Managment
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Spell-check (English US and Polish)
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=pl<CR>

" Sudo read-only file
cnoremap sudow w !sudo tee % >/dev/null

" Open terminal
map <C-A-t> :split term://zsh<CR>:resize 10<CR>

" Exit from terminal mode
tnoremap <C-e> <C-\><C-n>

" UltiSnips
let g:UltiSnipsExpandTrigger='<C-z>'
let g:UltiSnipsJumpForwardTrigger='<C-s>'
let g:UltiSnipsJumpBackwardTrigger='<C-g>'
let g:UltiSnipsListSnippets='<C-l>'

" Identify the syntax highlighting group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"==Encoding==
scriptencoding utf-8
