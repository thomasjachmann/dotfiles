" enables pathogen
call pathogen#infect()
syntax on
filetype plugin indent on

" sets colorscheme
" set background=light
" if !has("gui_running")
"   let g:solarized_termcolors=256
" end
" colorscheme solarized
colorscheme monokai

" defines the leader
let mapleader=","

" edit and reload .vimrc
nmap <C-v>e :e ~/.vimrc<CR>
nmap <C-v>r :source ~/.vimrc<CR>

" make copying into system clipboard more accessible
map <C-y> "*y
map <C-p> "*p

" close current (w) or all (W) buffers
map <Leader>w :bd<CR>
map <Leader>W :1,999bd<CR>
map <Leader>b :b
map <Leader>bb :b#<CR>
nmap <Tab> :bn<CR>
" project wide search
map <Leader>F :Ag<Space>

" CHANGE ME
" adds nerdtree tab toggle
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1

" let ctrlp only work on the current directory, not some kind of root (eg git
" root)
let g:ctrlp_working_path_mode = ''

" configure airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
set laststatus=2 " needed for airline to also show up when only one window is present

" configure unity
" see http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" file searching TODO make this search in the current dir not in git's root
" repository or user's home (whatever is used right now)
nnoremap <C-p> :Unite file_rec/async<cr>
" content searching
nnoremap <space>/ :Unite grep:.<cr>
" yank history searching
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
" buffer searching/switching
nnoremap <space>s :Unite -quick-match buffer<cr>

" prevent multiple-cursors to lose the selections when exiting from visual
" and insert modes
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0


" sets window size in gui
if has("gui_running")
  set lines=50 columns=140
end

" shows line numbers
set number

" shows mode in status bar
set showmode

" shows where you are in a file
set ruler

" shows the current (uncompleted) command
set showcmd

" uses context for navigation (scroll early)
set so=5

" let buffers with unsaved changes be hidden (switching to another buffer)
set hidden

set nobackup                           " Just don't backup
set nowritebackup                      " No write backups
set noswapfile                         " And no swap files

set tabstop=2                          " set tab width when pressing tab
set shiftwidth=2                       " set tab width when using retab
set expandtab                          " expand tabs to spaces
set smarttab                           " also delete all spaces on <BS>

" color the desired end of the first line of git commit messages
" so that it's easier to know how much space is left
autocmd BufNewFile,BufRead COMMIT_EDITMSG set colorcolumn=51

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
if has('mouse')
  set mouse=a
endif
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
