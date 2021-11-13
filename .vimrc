set encoding=UTF-8
set termguicolors
set nocompatible
syntax on
filetype off
call plug#begin('~/.vim/plugged')
autocmd FileType elixir let b:coc_root_patterns = ['.elixir_ls']
command! -nargs=0 Prettier :CocCommand prettier.formatFile
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <TAB>
     \ pumvisible() ? coc#_select_confirm() :
     \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
     \ <SID>check_back_space() ? "\<TAB>" :
     \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"let g:coc_snippet_next = '<TAB>'
"autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
Plug 'mattn/emmet-vim'
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:user_emmet_leader_key='<space>'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
let g:mix_format_silent_errors = 1
"Plug 'fatih/vim-go'
"Plug 'honza/vim-snippets'
"Plug 'codota/tabnine-vim'
set autowrite
let g:mix_format_on_save = 1
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
call plug#end()
filetype plugin indent on
colorscheme dracula
set noerrorbells
set number
set nobackup
set noswapfile
set wildmenu
set autowrite
set smartcase
set scrolloff=3
set backspace=2
set expandtab
set shiftwidth=2
set cursorline
set softtabstop=2
set tabstop=2
set shortmess=atI
"aTIO
:nmap <space><space> :NERDTreeToggle<CR>
"map <C-l> :NERDTreeToggle<CR>
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap / /<ESC>i
