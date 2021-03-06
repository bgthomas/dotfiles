""""""""""""""""""""""""""""""""""""""""""""""""""
"  Windows instructions  "
"  1. Clone my dotfiles
"  2. Clone vundle in .dotfiles/vim/bundle/vundle (bundles are ignored by git)
"     (also checkout vundle for windows wiki on github)
"  3. Create a ~/_vimrc with the following 2 lines
"     set rtp+=~/.dotfiles/vim
"     source ~/.dotfiles/vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
if has("gui_running")
  set guioptions-=m "menu bar
  set guioptions-=T "tool bar

  "Full screen
  if has("gui_win32")
    if $LANG == "FR"
      au GUIEnter * simalt ~n
    endif
  endif
endif

set guifont=Monospace\ 14
" Resize fonts in gvim
Plugin 'fontzoom.vim'
let g:fontzoom_no_default_key_mappings = 1
map <M-=> :Fontzoom!<cr>
map <M--> <Plug>(fontzoom-smaller)
map <M-+> <Plug>(fontzoom-larger)


if &term == "screen-256color" "tmux sessions
  " Enter with <C-V>key
  set <F1>=OP
  set <S-F1>=[1;2P

  set <F2>=OQ
  set <S-F2>=[1;2Q

  set <F3>=OR
  set <S-F3>=[1;2R

  set <F4>=OS
  set <S-F4>=[1;2S

  set <F5>=[15~
  set <S-F5>=[15;2~

  set <F6>=[17~
  set <S-F6>=[17;2~

  set <F7>=[18~
  set <S-F7>=[18;2~

  set <F8>=[19~
  set <S-F8>=[19;2~

  set <F9>=[20~
  set <S-F9>=[20;2~

  " set <F10>=(virtualbox host key)
  set <F10>=[21~
  " set <F11>=(gnome-terminal full-screen)
  set <F12>=[24~
  set <S-F12>=[24;2~

  set <S-LEFT>=[1;2D
  set <S-RIGHT>=[1;2C
  set <S-UP>=[1;2A
  set <S-DOWN>=[1;2B

  " Alternate (meta) arrow keys
  " Seems buggy with tmux afterall
  " set <xLEFT>=[1;3D
  " set <xRIGHT>=[1;3C
  " set <xUP>=[1;3A
  " set <xDOWN>=[1;3B

  " " <A-D> doesn't seem to work inside gnome-terminal anyways
  " set <A-D>=d
endif

" Tmux
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;orange\x7\x1b\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;red\x7\x1b\\"
  silent !printf '\033Ptmux;\033\033]12;red\007\033\\'
  autocmd VimLeave * silent !printf '\033Ptmux;\033\033]12;green\007\033\\'
else
  if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;orange\x7"
    " use a red cursor otherwise
    let &t_EI = "\<Esc>]12;red\x7"
    silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]12;green\007"
    " use \003]12;gray\007 for gnome-terminal
  endif
endif


set nocompatible               " be iMproved
set nomodeline                 " for security

filetype off                   " required!

noremap <silent> <C-L> :nohls<CR><C-L>

" Swap those keys for inline searching
nnoremap , ;
nnoremap ; ,

" Default encoding is needed for Windows XP and this mapleader
set encoding=utf8

" For performance reason (default = syntax)
set foldmethod=manual

" inoremap <C-D> <Del>
" inoremap <A-D> <C-O>de

" inoremap » <ESC>

" Align a ruby hash (1.9)
nmap _arh vip:Tabularize/\w:\zs/l0l1<CR>
vmap _arh :Tabularize/\w:\zs/l0l1<CR>

" Change to do (convert ruby block '{}' to 'do end' syntax)
nmap _ctd 0f{sdo<ESC>2f\|ls<CR><ESC>f}s<CR>end<ESC>

" Underlining (buffer makes the mapping apply only in the text file buffer)
autocmd bufEnter *.txt imap <buffer> _= <ESC>yypVr=o<CR>
autocmd bufEnter *.txt imap <buffer> _- <ESC>yypVr-o<CR>

"autocmd bufEnter *.txt imap <buffer> ^dt <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Increment/Decrement dates
Plugin 'tpope/vim-speeddating'

Plugin 'tpope/vim-surround'

" Repeat surround commands with .
Plugin 'tpope/vim-repeat'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-unimpaired'

" Simulates M-t emacs function
Plugin 'transpose-words'
nmap <Leader>t <Plug>Transposewords
imap <Leader>t <Plug>Transposewords
cmap <Leader>t <Plug>Transposewords

" Haml and Sass syntax hl and indentation
Plugin 'https://github.com/tpope/vim-haml.git'

" Alternate column colors. Toggle with <Leader>ig
Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=magenta
hi IndentGuidesEven ctermbg=cyan

" Highligths matching tags
Plugin 'https://github.com/gregsexton/MatchTag.git'

" less css syntax highlighting
Plugin 'https://github.com/groenewege/vim-less.git'

" I fixed scss -> css indenting issues by copying a custom
" vim.css in ~/.vim/indent/css.vim
" I debugged the issue with ':verbose set indentexpr' inside vim

" Don't think I need those for now
" Plugin 'css3-syntax-plus'
" Plugin 'https://github.com/cakebaker/scss-syntax.vim.git'
" Plugin 'https://github.com/hail2u/vim-css3-syntax.git'

"Plugin 'https://github.com/othree/html5-syntax.vim.git'
" Don't think I need this anymore since I use snippets now
" Plugin 'https://github.com/othree/html5.vim.git'

" Ruby syntax files, etc.
Plugin 'vim-ruby/vim-ruby'

Plugin 'https://github.com/spf13/vim-colors.git'

Plugin 'https://github.com/jiangmiao/auto-pairs.git'
let g:AutoPairsShortcutToggle = "<Leader>p""
let g:AutoPairs = {'`': '`', '"': '"', '{': '}', '''': '''', '(': ')', '[': ']', '|': '|'}

Plugin 'matchit.zip'

" Align double quotes
" :Tabularize / "/l0"
Plugin 'https://github.com/godlygeek/tabular.git'

Plugin 'xmledit'

Plugin 'scrooloose/nerdtree'
" Single click to open filepath elements
set encoding=utf-8
let NERDTreeMouseMode = 3
map <C-T> :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
"let g:NERDTreeDirArrows=0 " Fixes weird encoding issue when opening the tree
" map <C-T> :Explore<CR>
" let g:netrw_liststyle=3

" lauch ctrl-p, then less ~/.cache/ctrlp/project
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|tmp|bower_components|fonts|vendor)$',
  \ 'file': '\v\.(exe|so|dll|gif|jpg|jpeg|svg|png|eml|csv)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

" Allow mouse use.
" This enables click select in normal mode + NERDTree click
if has('mouse')
  " Enable mouse in terminal, just in normal mode
  " set mouse=a
  set mouse=n "n works better with NERDTree
endif

" vim-snipmate better alternative
Plugin 'https://github.com/SirVer/ultisnips.git'
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsEditSplit="horizontal"
" let g:UltiSnipsListSnippets="<F9>"

" SQL formatting with <LEADER>sfs
Plugin 'SQLUtilities'
let g:sqlutil_align_comma = 1

" Turn off this annoying key binding for sql stuff (<C-C> by default)
let g:ftplugin_sql_omni_key = 'F99'

" Dependency
Plugin 'Align'

" Snippets + syntax highlighting
autocmd bufEnter *.xml.erb set ft=eruby.html
autocmd bufEnter *.pdf.erb set ft=eruby.html
autocmd bufEnter *.html.erb set ft=eruby.html
autocmd bufEnter *.scala.html set ft=scala.html

autocmd bufEnter *.cf.erb set ft=eruby.conf
autocmd bufEnter *.arb set ft=ruby

" psql command line utility
"autocmd bufEnter,bufNewFile,bufRead *psql.edit* set ft=sql
autocmd bufEnter *psql.edit* set ft=sql
autocmd bufEnter *.json.jbuilder set ft=ruby

autocmd bufEnter *.scss UltiSnipsAddFiletypes scss.css

" Auto-complete on hyphens (only within current buffer)
autocmd fileType html,eruby.html,css,scss setlocal iskeyword+=-

" Setting this variable allows me to override the default snippets with a bang!
" Otherwise the default snippets still show up.
let g:UltiSnipsDontReverseSearchPath="0"

" I tried to make a toggle function but the search path does not get updated
" For now the best solution is to modify vimrc and restart vim
" let g:DefaultSnippetsInhibited=1
" if g:DefaultSnippetsInhibited
"   let g:UltiSnipsSnippetDirectories=['snippets']
" else
"   let g:UltiSnipsSnippetDirectories=['snippets', 'UltiSnips']
" endif
" snippets is a reserved directory name
let g:UltiSnipsSnippetDirectories=['my_snippets']


Plugin 'https://github.com/kien/ctrlp.vim.git'
" Set this to 1 to set searching by filename (as opposed to full path) as the default: >
" Toggle by filename or by filepath with <C-D>
" Toggle regex mode with <C-R>
" let g:ctrlp_by_filename = 1
nmap <F2> :CtrlP %:h<CR>
nmap <F3> :CtrlPMRU<CR>
let g:ctrlp_clear_cache_on_exit = 0 " Refresh the cache with <F-5>



filetype plugin indent on     " required!

" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..

"=========================
" Plugins
" ========================
" place 'stty -ixon' in bashrc first, to use <C-S>
" map <C-S> :echo 'c-s ok'<CR>
" map <C-C> :echo 'c-c ok'<CR>

" NERD-Commenter is more flexible than tComment
Plugin 'The-NERD-Commenter'
" NERDCommenter will add space after comment
" <Leader>cc # Comment line or selection
" 3<Leader>cc # Comment next 3 lines
" <Leader>cu # Uncomment line or selection
" <Leader>ci # Inverts comment state
"
" <Leader>c<Space> # Toggle state on and off
" <Leader>cA # Comment to end of line
" <Leader>cl # Comment symbol are aligned in line
" <Leader>ca # Switch to alternative comment symbol
let NERDSpaceDelims = 1

" map <F3> :call NERDComment(0, 'uncomment')<CR>+
" map <S-F3> :call NERDComment(0, 'uncomment')<CR>
" map <F4> :call NERDComment(0, 'norm')<CR>+
" map <S-F4> :call NERDComment(0, 'norm')<CR>
" imap <F4> <ESC>:call NERDComment(0, 'insert')<CR><Esc>==$xA

Plugin 'https://github.com/mattn/gist-vim'

" gist-vim dependency
Plugin 'https://github.com/mattn/webapi-vim'

" Better than grep
Plugin 'https://github.com/mileszs/ack.vim'

" Gives a 'Subvert' command to quickly search for ModelName and model_name
Plugin 'https://github.com/tpope/vim-abolish'

" Better javascript syntax highlighting and indentation
Plugin 'pangloss/vim-javascript'

" Typescript syntax highlighter
Plugin 'leafgarland/typescript-vim'

au BufRead,BufNewFile *.ts setlocal filetype=typescript

Plugin 'scrooloose/syntastic'
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_always_populate_loc_list = 1
" setlocal formatprg=rubocop\ -a\ --stdin\ %\ \|sed\ '1,/====================/d'
" let g:syntastic_go_checkers = []

Plugin 'EasyMotion'
let g:EasyMotion_leader_key = '<F10>'
let g:EasyMotion_mapping_f = '<C-C>'

" let g:EasyMotion_mapping_F = '<F8>'
" let g:EasyMotion_mapping_f = '<F9>'
" let g:EasyMotion_mapping_f = '<C-F>'
" let g:EasyMotion_mapping_F = '<C-B>'
" let g:EasyMotion_mapping_k = 'k'
" let g:EasyMotion_mapping_j = 'j'
" let g:EasyMotion_mapping_f = 'f'
" let g:EasyMotion_mapping_F = 'F'

" Not loading the plugin's ftdetect somehow so loading in manually for now.
Plugin 'https://github.com/honza/dockerfile.vim.git'
autocmd BufNewFile,BufRead Dockerfile set filetype=dockerfile

" Vim plugins for Go
" Install required binaries with :GoInstallBinaries
Plugin 'fatih/vim-go'
autocmd bufEnter *.go set ft=go
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>ds <Plug>(go-def-split)

" autocmd FileType go autocmd! BufWritePre <buffer> Fmt
" autocmd FileType go nmap <F6> :!go run %<CR>
" autocmd FileType go nmap <F6> :Fmt<CR>

" Golang code completion
" nsf/gocode dependency
" go get -u github.com/nsf/gocode (-u flag for "update")
" go get -u -ldflags -H=windowsgui github.com/nsf/gocode # windows
"Plugin 'nsf/gocode', {'rtp': 'vim/'}
" Plugin 'mdempsky/gocode', {'rtp': 'vim/'}

" This is a Vim plugin that provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
Plugin 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
Plugin 'racer-rust/vim-racer'
let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH="~/Downloads/rustc-1.13.0/src"
let g:racer_experimental_completer = 1

Plugin 'AndrewRadev/inline_edit.vim'
let g:inline_edit_autowrite = 1

Plugin 'scala.vim'

Plugin 'Valloric/YouCompleteMe'
" Override default TAB and S-TAB completion (want to keep them for snippets triggering)
" Use Up and Down or default C-N and C-P
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

let g:ycm_filetype_whitelist = {
      \ 'golang' : 1,
      \ 'rust' : 1,
      \ 'javascript' : 1,
      \ 'java' : 1,
      \}

Plugin 'https://github.com/ElmCast/elm-vim'
autocmd bufEnter *.elm set ft=elm

Plugin 'https://github.com/ledger/vim-ledger'
autocmd bufEnter *.ledger set ft=ledger
autocmd FileType ledger set relativenumber
autocmd FileType ledger set formatprg=~/code/github.com/benjamin-thomas/manage-ledger/bin/align_ledger_amounts

" Helpers to use at end of line
autocmd FileType ledger imap <buffer> <F2> <CR>Assets:Clearing<ESC>gqip
" sa -> same account
autocmd FileType ledger imap <buffer> ^sa <ESC>yypWC
autocmd FileType ledger imap <buffer> ^gr_ <C-R>=strftime("%Y-%m-%d")<CR> Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr0 <ESC>:call InsertDate(0)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr1 <ESC>:call InsertDate(1)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr2 <ESC>:call InsertDate(2)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr3 <ESC>:call InsertDate(3)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr4 <ESC>:call InsertDate(4)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr5 <ESC>:call InsertDate(5)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr6 <ESC>:call InsertDate(6)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr7 <ESC>:call InsertDate(7)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr8 <ESC>:call InsertDate(8)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>
autocmd FileType ledger imap <buffer> ^gr9 <ESC>:call InsertDate(9)<CR>A Utile<CR>; <C-R>gExp:gr<C-X><C-O><SPACE><SPACE>

" Expense -> Assets:Bank
autocmd FileType ledger inoremap <buffer> <F4> <CR>  Assets:Bank<ESC>gqipgqap
"autocmd FileType ledger inoremap <buffer> <F4> <ESC>{}-yypcwBudget<ESC>ElDgqip
"autocmd FileType ledger noremap <buffer> <F4> {}-yypcwBudget<ESC>ElDgqip
" Overwrite last line of transaction with clipboard content, for ofx2ledger
"autocmd FileType ledger noremap <buffer> <F6> }-"zyEV"+p}-dE"zPgqip
"autocmd FileType ledger noremap <buffer> <F6> }?  [A-Z]<CR>"zyEV"+p}-dE"zPgqip

" F6 copy/paste helper for ofxsync
" autocmd FileType ledger noremap <buffer> <F6> }?  [A-Z]<CR>V"+p:nohlsearch<CR>
autocmd FileType ledger noremap <buffer> <F6> }?  [A-Z]<CR>V"+p:nohlsearch<CR>jr,ddpkJxkkddp
autocmd FileType ledger map <buffer>  <F7> :call ledger#transaction_state_toggle(line('.'), ' *!')<CR>


" copy paste date of transaction above, and increment `cnt` times
function! InsertDate(cnt)
  execute "normal {+yt }jp$zz"
  call speeddating#increment(a:cnt)
endfunction

autocmd FileType ledger imap <buffer> ^_ <C-R>=strftime("%Y-%m-%d")<CR><SPACE>
" Specify param manually
autocmd FileType ledger imap <buffer> ^? <ESC>:call InsertDate()<LEFT>

autocmd FileType ledger imap <buffer> ^0 <ESC>:call InsertDate(0)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^1 <ESC>:call InsertDate(1)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^2 <ESC>:call InsertDate(2)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^3 <ESC>:call InsertDate(3)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^4 <ESC>:call InsertDate(4)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^5 <ESC>:call InsertDate(5)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^6 <ESC>:call InsertDate(6)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^7 <ESC>:call InsertDate(7)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^8 <ESC>:call InsertDate(8)<CR>A<SPACE>
autocmd FileType ledger imap <buffer> ^9 <ESC>:call InsertDate(9)<CR>A<SPACE>

" set formatprg=astyle\ --indent=spaces=2
Plugin 'https://github.com/kburdett/vim-nuuid'

" UML
autocmd bufEnter *.uml set ft=plantuml
Plugin 'aklt/plantuml-syntax'

Plugin 'DrawIt'

" Colorize escape sequences
" Usage: :AnsiEsc<ENTER>
Plugin 'AnsiEsc.vim'

Plugin 'leafo/moonscript-vim'
autocmd bufEnter *.moon set ft=moon

" no more :set paste!
Plugin 'ConradIrwin/vim-bracketed-paste'

" Interactive tables
" Activate with: ':TableModeEnable'
" Then start line with: '|'
" To create a line separator, start line with: '||'
"
" To create a table quickly, type. 1,2,3 visual select then <leader>tt
" To right align a column replace '-' with a ':' just before the ending pipe at the ---- line
" Middle align is not available
" <leader>tr to realign
Plugin 'dhruvasagar/vim-table-mode'

" Plugin 'kotarak/vimpire'
Plugin 'tpope/vim-fireplace'

"Plugin 'jpalardy/vim-slime'
"let g:slime_target = "tmux"

" 0.1 is the second pane within the current window 0, whether it's horizontal
" or vertical
"let g:slime_default_config = {"socket_name": "default", "target_pane": "0.1"}

Plugin 'fvictorio/vim-extract-variable'

Plugin 'wakatime/vim-wakatime'

" Not related to ycm per se but this closes the preview 'scratch' buffer after
" leaving insert mode -- the best option I'v found so far.
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

call vundle#end()
"=========================
" Vim configuration
" ========================

set history=1000          " Keep x lines of command line history
set undolevels=1000       " Use many levels of undo                                        "
set ruler                 " Show the cursor position all the time (normally on by default)
set showcmd               " Displays incomplete commands and if the leader key was pressed
set incsearch             " Do incremental searching (this moves the cursor as I search)
set relativenumber
set number  " after rel -> shows line number instead of 0
set ic                    " Ignore case on search
set scs                   " Smartcase
set wildmode=list:longest " Prevent command line completion cycle effect
set go-=r                 " Pas d'ascenseur dans gvim
set foldcolumn=1          " Noter dans la marge les plis existants
syntax on                 " Turns syntax highlighting on
set hlsearch              " Highlight search
set nobackup

" swp swapfiles dir
" Trailing // makes vim build the swap file based upon the file's path
let swap_dir=$HOME . "/.cache/vim/swap"
if !isdirectory(swap_dir)
  call mkdir(swap_dir, 'p', 0700)
endif
let &directory=swap_dir . '//'

" This converts tabs to spaces. This should be better overall
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set t_Co=256
set bg=dark
" pacman -S vim-molokai
colorscheme molokai
" override scheme paren highlight (ctermfg=curr, ctermbg=match)
hi MatchParen cterm=none ctermfg=green ctermbg=none

nmap <F7> :set hlsearch!<CR>
set pastetoggle=<F8>

nnoremap n nzz
nnoremap N Nzz

" Display the annoying unicode char 00a0 (non-breaking space) with a '%'
set listchars+=nbsp:%

" Default is croql.
" tcrq is a better setting for me
" the 'o' flag is off so I can stop autocommenting on new lines with <C-O>O
" This way, there's no need to customize 'formatoptions' per file.
au BufEnter * set fo=tcrq

" Get rid of hidden non-breaking-space
imap <CHAR-0x00a0> <CHAR-0x20>

" Not sure what this one does anymore
set backspace=indent,eol,start whichwrap+=<,>,[,]

" This is actually done with <ALT-O> by default
" inoremap <C-O> <C-O>o

inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-H> <Left>
inoremap <C-L> <Right>

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

noremap <F1> :q<CR>
noremap <S-F1> :qa!<CR>

inoremap <F5> <ESC>:silent update<CR>
nnoremap <F5> :silent update<CR>

inoremap <C-S> <ESC>:update<CR>
nnoremap <C-S> :update<CR>

" Cycle through folds easily
nmap <S-UP> zk
nmap <S-DOWN> zj
nmap <S-LEFT> zc
nmap <S-RIGHT> zo

" " Cycle quickly through buffers
" map <S-LEFT> :bp<CR>
" map <S-RIGHT> :bn<CR>
" map <S-UP> :ls<CR>:b
" " This is the same like the built-in <C-S-6> shortcut
" map <S-DOWN> :b#<CR>

" ci" and ci' work even if I'm not inside the quotes range
" ci< ci( and ci{ however require being inside the brackets range.
" So I can use ci> ci) ci} to mimick the behaviour of ci" and ci'
nnoremap ci> f<ci<
nnoremap ci) f(ci(
nnoremap ci} f{ci{
nnoremap ci] f[ci[

if has("autocmd")
  " Apply .vimrc modifications automatically
  autocmd! bufwritepost .vimrc source ~/.vimrc

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "
  " This is already called by vundle but I'm leaving it there anyways
  " filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
  augroup END
else
  " Always set autoindenting on
  " This mustn't load if filetype plugin indent is on
  set autoindent
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Folds text according to syntax highlighting rules
"set foldmethod=syntax " This will make vim INCREDIBLY SLOW, don't do this!!
set foldmethod=indent
" Don't close folds on file open (default=0 => all folds are closed)
set foldlevel=999

" Not needed anymore due to UtilSnip's html5 tag
" autocmd bufNewfile *.html 0r ~/.vim/my_skels/skel.html

autocmd bufEnter *.txt set tw=79

" Cycle through folds easily
" if &term == "screen-256color" "tmux sessions
"   nmap <Esc>[1;2A zk
"   nmap <Esc>[1;2B zj
"   nmap <Esc>[1;2D zc
"   nmap <Esc>[1;2C zo
" else
  nmap <C-S-UP> zk
  nmap <C-S-DOWN> zj
  nmap <C-S-LEFT> zc
  nmap <C-S-RIGHT> zo
" endif

" Navigation
nnoremap <Space> <C-F>
nnoremap <BS> <C-B>

" <cword> permet de désigner le mot sous le curseur.
" :map <C-W> :!lynx http://fr.wikipedia.org/wiki/<cword><CR><CR>

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" See https://github.com/sunaku/vim-ruby-minitest
" Vim syntax highlighting and i_CTRL-X_CTRL-U completion of MiniTest methods and assertions.
set completefunc=syntaxcomplete#Complete

" Bubble lines START
" Use in gvim
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>
" Bubble lines END

highlight TrailingWhiteSpace ctermbg=red guibg=red
autocmd fileType go match TrailingWhiteSpaceAndTabs /\s\+$/

highlight TrailingWhiteSpaceAndTabs ctermbg=red guibg=red
autocmd fileType ruby match TrailingWhiteSpaceAndTabs /\s\+$\|\t/
