"" pyenv support ---- begin
let g:python_host_prog = $PYENV_ROOT . '/shims/python2'
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
"" pyenv support ---- end

"" Plug manager ---- begin
call plug#begin('~/.local/share/nvim/plugged')
" basic ---
Plug 'tpope/vim-sensible'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Townk/vim-autoclose'
Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins', 'for': ['haskell', 'python', 'rust']}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" syntax checker
Plug 'w0rp/ale', {'for': ['rust']}
" git ---
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" GUIs ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'rakr/vim-one'
" Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'
" Plug 'freeo/vim-kalisi'
" tex ---
Plug 'lervag/vimtex', {'for': 'tex'}
" haskel ---
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}  " syntax highlighting
Plug 'nbouscal/vim-stylish-haskell', {'for': 'haskell'}  " formatting
Plug 'itchyny/vim-haskell-indent', {'for': 'haskell'}  " smart indent
call plug#end()
"" Plug manager ---- end

"" Deoplete ---- begin
let g:deoplete#enable_at_startup = 1
"" Deoplete ---- end

"" Fugitive ---- begin
nmap [figitive] <Nop>
map <Leader>g [figitive]
nmap <silent> [figitive]s :<C-u>Gstatus<CR>
nmap <silent> [figitive]d :<C-u>Gdiff<CR>
nmap <silent> [figitive]b :<C-u>Gblame<CR>
nmap <silent> [figitive]l :<C-u>Glog<CR>
"" Fugitive ---- end

"" QuickFix ---- begin
augroup quickfix_config
    au!
    au QuickFixCmdPost *grep* cwindow  " open quickFix on (vim)grep
augroup END
" adjust height
au FileType qf call AdjustWindowHeight(1, 3)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
"" QuickFix ---- end

"" haskell-vim ---- begin
let g:haskell_indent_disable = 1
let g:haskell_classic_highlighting = 1  " haskell-vim
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
"" haskell-vim ---- end

""
" override the defaults for a particular FileType
autocmd FileType rust
            \ let b:AutoClosePairs = AutoClose#ParsePairs("() [] {} ` \"")
""

"" vim-hindent ---- begin
let g:hindent_on_save = 0
let g:hindent_indent_size = 4
let g:hindent_line_index = 100
"" vim-hindent ---- end

"" vimtex ---- begin
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '@line @pdf @tex'
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
let g:vimtex_latexmk_options = '-pdfdvi'
"" vimtex ---- end

"" nerdtree ---- begin
" Auto open when specifying directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"" nerdtree ---- end

"" LanguageClinet ---- begin
set hidden
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"" LanguageClinet ---- end

"" Airline ---- begin
" let g:airline_theme='papercolor'
" let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
"" Airline ---- end

"" Default ---- begin
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set number
set ruler
set laststatus=2
set scrolloff=5

nnoremap j gj
nnoremap k gk
noremap <C-c> <esc>
tnoremap <silent> <C-[> <C-\><C-n>
let mapleader = "\<Space>"

syntax enable
filetype indent plugin on
set termguicolors
set background=dark
colorscheme NeoSolarized
" set background=light
" colorscheme PaperColor
set t_Co=256
"" Default ---- end
