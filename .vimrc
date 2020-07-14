syntax on

set number
set hlsearch
set nobackup
set showmatch
set autoindent
set showmode
set expandtab

set tabstop=4
set backspace=start
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

ab du use YAML; warn YAML::Dump

map ,p :set nonumber paste<enter>
map ,P :set number   nopaste<enter>
