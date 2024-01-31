" Plugins {{{
call plug#begin('~/.vim/plugged')

" integrations
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

" session
Plug 'tpope/vim-obsession'

" convenience
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }

" formatting
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'matze/vim-move'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

" linting
Plug 'w0rp/ale'

" autocomplete
Plug 'ervandew/supertab'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
Plug 'Shougo/echodoc.vim'

" snippets
Plug 'Shougo/neosnippet'

" search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --64' }
Plug 'junegunn/fzf.vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" docker
Plug 'ekalinin/dockerfile.vim'

" json
Plug 'elzr/vim-json'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'roxma/ncm-flow' non-LanguageClient implementation

" graphql
Plug 'jparise/vim-graphql'

" rust
Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer' non-LanguageClient implementation
"Plug 'roxma/nvim-cm-racer' non-LanguageClient implementation

" style and color
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'arcticicestudio/nord-vim', { 'tag': 'v0.8.0' }

"syntax vimwiki

Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki'

call plug#end()
" }}}

" Colors {{{

if has('termguicolors')
  set termguicolors " true color
endif

syntax enable
set background=dark
colorscheme nord
let g:airline_theme='nord'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}

" Indentation {{{
set expandtab
set tabstop=2
set shiftwidth=2
" }}}

" Cursor {{{
set cursorline " highlight current line

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" Activate cursor shape change in 0.2
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

if exists('$ITERM_SESSION_ID') && !exists('$TMUX')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
end
" }}}

" Folds {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
" }}}

" General settings {{{
set nocompatible
filetype plugin on

set noshowmode          " let airline do the work

set signcolumn=yes

set colorcolumn=80      " max length line
set number              " show string numbers
set relativenumber      " relative numbers

set timeoutlen=1000     " faster
set ttimeoutlen=10      " mode switching

set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set showmatch           " highlight matching [{()}]

set modelines=1
set inccommand=nosplit  " shows the effects of a command incrementally

set noswapfile
set nobackup
set nowritebackup

set hidden              " required for operations modifying multiple buffers like rename

" persistent undo
if !&diff
  set undodir=~/.vim/undodir
  set undofile
endif
" }}}

" Plugin settings {{{
" vim-jsx
let g:jsx_ext_required = 0 " activate vim-jsx for .js files

" vim-javascript
let g:javascript_plugin_flow = 1

" autocomplete
"set completeopt-=preview
let g:cm_sources_override = {
	\ 'flow': {'scopes':['javascript', 'javascript.jsx']}
	\ }
let g:LanguageClient_serverCommands = {
  \ 'javascript': ['flow-language-server', '--stdio'],
  \ 'javascript.jsx': ['flow-language-server', '--stdio'],
  \ 'rust': ['rls'],
  \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0

" ale
let g:ale_sign_column_always = 1

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1

let g:ale_linters =
\ { 'jsx': ['eslint', 'flow'],
  \ 'rust': ['rls'] }
let g:ale_fixers =
\ { 'jsx': ['prettier', 'eslint'],
  \ 'json': ['prettier'],
  \ 'graphql': ['prettier'],
  \ 'css': ['prettier'],
  \ 'rust': ['rustfmt'] }

let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_rust_cargo_use_check = 0


" snippets
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
let g:neosnippet#disable_runtime_snippets = {
		\   '_' : 1,
		\ }

" fzf
let g:fzf_buffers_jump = 1 " just to existing buffer if possible

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " show tabs
let g:airline#extensions#tmuxline#enabled = 1 " tmux style
let g:airline#extensions#ale#enabled = 1 " ale style

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" nord
let g:nord_italic_comments = 1
" }}}

" General mappings {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" }}}

" Plugin mappings {{{
" supertab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" LanguageClient
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" ale autofix
nnoremap <leader>el :ALEFix<CR>

" neosnippet
imap <c-j>     <Plug>(neosnippet_expand_or_jump)
vmap <c-j>     <Plug>(neosnippet_expand_or_jump)
inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
vmap <c-u>     <Plug>(neosnippet_expand_target)
" expand parameters
let g:neosnippet#enable_completed_snippet=1

" fzf
nnoremap <c-p> :FZF<cr>

" }}}

" Autoload {{{
autocmd BufWritePre * StripWhitespace
"autocmd CompleteDone * pclose " closes autocomplete preview automatically
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" }}}

" Commands {{{

" fzf + rg grep like search

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color=always '.shellescape(<q-args>), 1, <bang>0)
" }}}

" vim:foldmethod=marker:foldlevel=0
