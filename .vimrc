if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" install dein from github if not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" plugin settings
"Bundle 'petdance/vim-perl'
"Bundle 'hotchpotch/perldoc-vim'
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/neosnippet'
"Bundle 'Shougo/neosnippet-snippets'
"Bundle 'thinca/vim-quickrun'
"Bundle 'tpope/vim-surround'

" editor setting
syntax on

set number
set hlsearch
set nobackup
set showmatch
set autoindent
set showmode
set expandtab

set tabstop=4
set directory=~/.swap

set backspace=start

set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

ab du use YAML; warn YAML::Dump

map ,p :set nonumber paste<enter>
map ,P :set number   nopaste<enter>
map ,t :!clear; carton exec perl -Ilib %<enter>

if has("syntax")
    syntax on
    function! InvisibleChactersIndicator()
        syntax match WideSpace "　" display containedin=ALL
        highlight WideSpace term=underline ctermbg=red guibg=red
        syntax match LowerMatch '\.\*?' display containedin=ALL
        highlight LowerMatch term=underline ctermbg=blue guibg=blue
        syntax match EntryMatch '^	\*.*' display containedin=ALL
        highlight EntryMatch term=underline ctermbg=blue guibg=blue
        syntax match AngularJSMatch '{{.*}}' display containedin=ALL
        highlight AngularJSMatch term=underline ctermbg=blue guibg=blue
		" check for matching .*? {{aaa}}
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call InvisibleChactersIndicator()
    augroup END
endif

if has("gui_running")
    set clipboard+=unnamed
    colorscheme darkblue
endif

"autocmd FileType perl map <F5> :!source ~/.zshrc; perl -Ilib % 2>&1 <Enter>
autocmd BufNewFile,BufRead *.t            :set filetype=perl
