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

let g:changelog_dateformat = "%Y-%m-%d"
let g:changelog_username = "celeron1ghz"
let s:envrc = $HOME . '/.vim/' . system('uname -n | tr -d "\n"') . '.vimrc'

if filereadable(s:envrc)
	"echo s:envrc
	execute "source " . s:envrc
endif


if has("syntax")
    syntax on
    function! InvisibleChactersIndicator()
        syntax match WideSpace "　" display containedin=ALL
        highlight WideSpace term=underline ctermbg=red guibg=red
        syntax match LowerMatch '\.\*?' display containedin=ALL
        highlight LowerMatch term=underline ctermbg=blue guibg=blue
        syntax match EntryMatch '^	\*.*' display containedin=ALL
        highlight EntryMatch term=underline ctermbg=blue guibg=blue
		" check for matching .*?
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call InvisibleChactersIndicator()
    augroup END
endif


if has('win32')
    if has("gui_running")
        let &guifont = iconv('Osaka－等幅:h9:cSHIFTJIS', &encoding, 'cp932')
    endif
endif

if has("gui_running")
    set clipboard+=unnamed
    colorscheme darkblue
endif


map <silent> <C-p> :bNext<cr>
map <silent> <C-n> :bnext<cr>
map <silent> ,l    :ls<cr>

autocmd FileType yaml map <F5> :!plagger -c % 2>&1 <Enter>
autocmd FileType yaml map <F6> :!plagger -c % 2>&1 \| less -r <Enter>
autocmd FileType perl map <F5> :!perl -Ilib % 2>&1 <Enter>
autocmd FileType perl map <F6> :!perl -Ilib % 2>&1 \| less -r <Enter>
autocmd FileType perl map <F7> :!perl -Ilib -c %<Enter>
autocmd FileType changelog runtime ftplugin/changelog.vim

autocmd BufNewFile,BufRead *.t            :set filetype=perl
autocmd BufNewFile,BufRead *.tt           :set filetype=html
autocmd BufNewFile,BufRead *.epl          :set filetype=html
autocmd BufNewFile,BufRead *.cgi          :set filetype=perl
autocmd BufNewFile,BufRead *.crontab      :set filetype=crontab
autocmd BufNewFile,BufRead *.vimperatorrc :set filetype=vim
