" Powerline setting
set laststatus=2
set showtabline=2
set rtp+=~/Library/Python/3.6/lib/python/site-packages/powerline/bindings/vim/

noremap <silent> ,s :VimShell<cr>
noremap <silent>  :Unite buffer<cr>
noremap <silent>  :Unite -start-insert file_rec/git<cr>
noremap <silent>  :VimFiler -split -simple -winwidth=25 -no-quit<cr>
noremap <silent>gs :Unite giti/status<cr>
noremap <silent>gl :Unite giti/log<cr>

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

  let g:rc_dir    = expand('~/dotfiles/vim')
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


" dein managed plugin setting
let g:quickrun_config={
\   "_" : {
\       "runner" : "vimproc",
\       "outputter/buffer/split" : ":botright 8",
\   },
\   '*': {'split': ''}
\ }

let g:quickrun_config.perl = {'command' : 'perl', 'cmdopt': '-MProject::Libs' }

call unite#custom_source('file_rec/git', 'ignore_pattern', 'local/\|node_modules/\|\.git/')


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
