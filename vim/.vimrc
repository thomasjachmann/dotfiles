" The following settings are taken from the example .vimrc (see end of file)

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
syntax on
filetype plugin indent on

call plug#begin('~/.vim/plugged')

" colorschemes
"Plug 'sickill/vim-monokai'
"Plug 'altercation/vim-colors-solarized'
"Plug 'w0ng/vim-hybrid'
"Plug 'BlakeWilliams/vim-tomorrow'
"Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'therubymug/vim-pyte'
"Plug 'vim-scripts/buttercream.vim'
"Plug 'jgdavey/vim-railscasts'
"Plug '29decibel/codeschool-vim-theme'
Plug 'freeo/vim-kalisi'

" visuals
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-airline'
Plug 'ap/vim-css-color'
Plug 'bronson/vim-trailing-whitespace'

" navigation
Plug 'kien/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher', { 'do': 'CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh' }
Plug 'mattn/ctrlp-register'
Plug 'scrooloose/nerdtree'
Plug 'artnez/vim-wipeout'
"Plug 'bogado/file-line'
"Plug 'moll/vim-bbye' " :Bdelete that doesn't close the window when closing a buffer

" search
Plug 'rking/ag.vim'
Plug 'skwp/greplace.vim' " :Gsearch/:Greplace for search/replace in a result buffer
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" editing
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise' " insert end statements wisely in ruby
"Plug 'p0deje/vim-ruby-interpolation'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'junegunn/vim-easy-align'

" syntaxes
Plug 'cakebaker/scss-syntax.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-haml'
Plug 'pangloss/vim-javascript'
"Plug 'tpope/vim-markdown'
" this seems to be better for github flavored markdown but fails miserable
" for automatic list formatting/word wrap - check tpope's plugin flp setting
Plug 'gabrielelana/vim-markdown'
"Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
"Plug 'stephpy/vim-yaml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chakrit/upstart.vim'
Plug 'rust-lang/rust.vim'

" version control
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'

" other
Plug 'tpope/vim-abolish' " tpope's multi variants abbreviation/substitution plugin
Plug 'rizzatti/dash.vim' " integration with Dash.app
"Plug 'reedes/vim-pencil' " various prose modes

call plug#end()

set visualbell
set pastetoggle=<Leader>p

set backspace=indent,eol,start                    " allow backspacing over everything in insert mode
set ruler		                                      " show the cursor position all the time
set showcmd		                                    " display incomplete commands
set incsearch		                                  " do incremental searching
set ignorecase                                    " do case insensitive search
set smartcase                                     " except for when I include uppercase characters

set splitright
set splitbelow

" try some performance improvements
set noshowcmd
set lazyredraw
set ttyfast
set synmaxcol=255 " only syntax highlight the first 255 characters of a line, should be sufficient for most cases

set spelllang= "empty for now to prevent spell checking, later: en,de

let g:signify_vcs_list = ['git']

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
"   syntax on
  set hlsearch
endif

" let custom tja settings begin

colorscheme kalisi
set background=dark

" for the character, see http://www.unicode.org/charts/PDF/U2500.pdf (u2502)
let g:indentLine_color_term = 237
let g:indentLine_color_gui = '#3a3a3a' " see https://gist.github.com/MicahElliott/719710
let g:indentLine_char = '│'

" configure YouCompleteMe to complete from/into strings/comments
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
highlight Pmenu ctermfg=250 ctermbg=242 guifg=#aaaaaa guibg=#555555

" configure greplace to use ag
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

let mapleader=","                                 " defines the leader

runtime macros/matchit.vim        " Load the matchit plugin.

" make auto completion more zsh like instead of completing the first match
set wildmenu
set wildmode=list:longest

" highlight invisible characters
" (NonText: eol/extends/precedes, SpecialKey: nbsp/tab/trail)
" see http://vimcasts.org/episodes/show-invisibles/
set list
set listchars=tab:▸\ ,extends:>,precedes:<,trail:•,eol:¬
highlight NonText ctermfg=237 ctermbg=none guifg='#3a3a3a' guibg=NONE
highlight SpecialKey ctermfg=237 ctermbg=none guifg='#3a3a3a' guibg=NONE

vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>r <Plug>(EasyAlign)

" add two spaces before soft wrapped line continuations
set showbreak=\ \ 

set showmatch " blink matching opening brackets when typing a closing bracket

" highlight trailing spaces
" see http://vim.wikia.com/wiki/Highlight_unwanted_spaces
"highlight ExtraWhitespace ctermbg=196 guibg=196
"match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

" edit and reload .vimrc
nmap <C-v>e :tabe ~/.vimrc<CR>
nmap <C-v>r :source ~/.vimrc<CR>

" 'smooth' scrolling both in normal and insert mode (taken from tips.txt)
nmap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
nmap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
imap <C-U> <Esc><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>i
imap <C-D> <Esc><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>i

" screen line navigation as standard
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" close current buffer
map <Leader>qb :bd<CR>
" close current window
map <Leader>qw :q\|Wipeout<CR>
" close current tab
" TODO go to last tab on tabclose: http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
function! CloseCurrentTab()
  exec tabpagenr('$') == 1 ? 'tabnew|tabonly' : 'tabclose'
  Wipeout
endfunction
map <Leader>qt :call CloseCurrentTab()<CR>
" close all tabs (opening a new one)
map <Leader>qW :tabnew\|tabonly\|Wipeout<CR>
map <Leader>qT :tabnew\|tabonly\|Wipeout<CR>
" close everyting (exiting)
map <Leader>qq :qall<CR>
" close everything without saving (exiting)
map <Leader>qQ :qall!<CR>

map <Leader>/ :noh<CR>
map <Leader>7 :noh<CR>
map <Leader>w :w<CR>
" Allow saving of files as sudo when I forgot to start vim using sudo.
map <Leader>W :w !sudo tee > /dev/null %<CR>

" tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

" switching current window back to previous buffer
nmap <Leader><Leader> :b#<CR>

" git stuff
map <Leader>gs :Gstatus<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gco :Gread<CR>
map <Leader>ga :Gwrite<CR>

function! OpenGitModified()
  let modifiedFiles = system("git status --porcelain | grep -v '/$' | awk '{print $2}'")
  for file in split(modifiedFiles, '\n')
    execute 'tabe ' . file
  endfor
endfunction
map <Leader>gm :call OpenGitModified()<CR>

function! StartProse()
  setlocal textwidth=80
  setlocal formatoptions=tcroqa1j
  setlocal autoindent
endfunction
command! StartProse call StartProse()
autocmd Filetype markdown call StartProse()

" project wide search
map <Leader>f :Ag!<Space>
map <Leader>F :Ag!<Space>-i<Space>

" ctrlp mapping
map <Leader>t :CtrlP<CR>
map <Leader>T :CtrlPBuffer<CR>
map <Leader>r :CtrlPBufTag<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>y :CtrlPRegister<CR>

" adds nerdtree tab toggle
" adds nerdtree toggle
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nn :NERDTree<CR>
map <Leader>nf :NERDTreeFind<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw = 0

" let ctrlp only work on the current directory, not some kind of root (eg git
" root)
let g:ctrlp_working_path_mode = ''
let g:ctrlp_switch_buffer = ''
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_new_file = 't' " open newly created file in new tab
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](tmp|\.(git|hg|svn|bundle|DS_Store)|node_modules)$',
  \ }

" see https://github.com/FelikZ/ctrlp-py-matcher/blob/master/doc/pymatcher.txt
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_abbrev = {
  \ 'gmode': 'i',
  \ 'abbrevs': [
    \ {
      \ 'pattern': 'ac ',
      \ 'expanded': 'app/controllers/',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': 'am ',
      \ 'expanded': 'app/models/',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': 'av ',
      \ 'expanded': 'app/views/',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': 'tc ',
      \ 'expanded': 'test/controllers/',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': 'tm ',
      \ 'expanded': 'test/models/',
      \ 'mode': 'pfrz',
    \ },
    \ ]
  \ }


" configure airline
let g:airline_theme = 'kalisi'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '│'
let g:airline_right_alt_sep = '│'
set laststatus=2 " needed for airline to also show up when only one window is present

" prevent multiple-cursors to lose the selections when exiting from visual
" and insert modes
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0


" sets window size in gui
if has("gui_running")
  set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  set guioptions=egm " default: egmrL, see :help guioptions - remove everything so there are no scrollbars
  set showcmd
  set showtabline=2 " always show tabs
  set titlestring=%{$PWD}
end

" shows line numbers
set number

" shows mode in status bar
set showmode

" let buffers with unsaved changes be hidden (switching to another buffer)
set hidden

set nobackup                           " Just don't backup
set nowritebackup                      " No write backups
set noswapfile                         " And no swap files

set tabstop=2                          " set tab width when pressing tab
set shiftwidth=2                       " set tab width when using retab
set expandtab                          " expand tabs to spaces
set smarttab                           " also delete all spaces on <BS>

set cursorline                         " highlight the line with the cursor
highlight clear CursorLine             " only highlight the line number since
augroup CLClear
  autocmd! ColorScheme * highlight clear CursorLine
augroup END
set colorcolumn=81,82,83,84,85
highlight ColorColumn ctermbg=236 guibg='#3a3a3a'
au BufReadPost quickfix set colorcolumn=
nmap <Leader>d :Dash<CR>

" color the desired end of the first line of git commit messages
" so that it's easier to know how much space is left
" also define <C-c> to delete the whole buffer, save and exit
" to abort the commit
autocmd BufNewFile,BufRead COMMIT_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ
autocmd BufNewFile,BufRead PULLREQ_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ
autocmd BufEnter NERD_tree_\d\+ set scrolloff=0
autocmd BufLeave NERD_tree_\d\+ set scrolloff=2
set scrolloff=2

function! InitDir()
  tabnew
  tabonly
  Wipeout
  NERDTreeToggle
endfunction
command! InitDir call InitDir()

" load everything else in its own config file
runtime! config/**/*

" " An example for a vimrc file.
" "
" " Maintainer:	Bram Moolenaar <Bram@vim.org>
" " Last change:	2008 Jul 02
" "
" " To use it, copy it to
" "     for Unix and OS/2:  ~/.vimrc
" "	      for Amiga:  s:.vimrc
" "  for MS-DOS and Win32:  $VIM\_vimrc
" "	    for OpenVMS:  sys$login:.vimrc
" 
" " When started as "evim", evim.vim will already have done these settings.
" if v:progname =~? "evim"
"   finish
" endif
" 
" " Use Vim settings, rather then Vi settings (much better!).
" " This must be first, because it changes other options as a side effect.
" set nocompatible
" 
" " allow backspacing over everything in insert mode
" set backspace=indent,eol,start
" 
" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   set backup		" keep a backup file
" endif
" set history=50		" keep 50 lines of command line history
" set ruler		" show the cursor position all the time
" set showcmd		" display incomplete commands
" set incsearch		" do incremental searching
" 
" " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" " let &guioptions = substitute(&guioptions, "t", "", "g")
" 
" " Don't use Ex mode, use Q for formatting
" map Q gq
" 
" " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" " so that you can undo CTRL-U after inserting a line break.
" inoremap <C-U> <C-G>u<C-U>
" 
" " In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"   set mouse=a
" endif
" 
" " Switch syntax highlighting on, when the terminal has colors
" " Also switch on highlighting the last used search pattern.
" if &t_Co > 2 || has("gui_running")
"   syntax on
"   set hlsearch
" endif
" 
" " Only do this part when compiled with support for autocommands.
" if has("autocmd")
" 
"   " Enable file type detection.
"   " Use the default filetype settings, so that mail gets 'tw' set to 72,
"   " 'cindent' is on in C files, etc.
"   " Also load indent files, to automatically do language-dependent indenting.
"   filetype plugin indent on
" 
"   " Put these in an autocmd group, so that we can delete them easily.
"   augroup vimrcEx
"   au!
" 
"   " For all text files set 'textwidth' to 78 characters.
"   autocmd FileType text setlocal textwidth=78
" 
"   " When editing a file, always jump to the last known cursor position.
"   " Don't do it when the position is invalid or when inside an event handler
"   " (happens when dropping a file on gvim).
"   " Also don't do it when the mark is in the first line, that is the default
"   " position when opening a file.
"   autocmd BufReadPost *
"     \ if line("'\"") > 1 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif
" 
"   augroup END
" 
" else
" 
"   set autoindent		" always set autoindenting on
" 
" endif " has("autocmd")
" 
" " Convenient command to see the difference between the current buffer and the
" " file it was loaded from, thus the changes you made.
" " Only define it when not defined already.
" if !exists(":DiffOrig")
"   command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" 		  \ | wincmd p | diffthis
" endif
" 
