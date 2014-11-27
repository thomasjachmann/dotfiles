" The following settings are taken from the example .vimrc (see end of file)

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
syntax on
filetype plugin indent on

" taken from https://github.com/MarcWeber/vim-addon-manager#recommended-setup-checking-out-vam-
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  " let c.log_to_buf = 1
  let c.auto_install = 1
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {'auto_install' : 0})
endfun
call SetupVAM()

" colorschemes
VAMActivate github:sickill/vim-monokai
VAMActivate github:altercation/vim-colors-solarized
VAMActivate github:w0ng/vim-hybrid
VAMActivate github:BlakeWilliams/vim-tomorrow
VAMActivate github:chriskempson/vim-tomorrow-theme
VAMActivate github:therubymug/vim-pyte
VAMActivate github:vim-scripts/buttercream.vim
VAMActivate github:jgdavey/vim-railscasts
VAMActivate github:29decibel/codeschool-vim-theme

" visuals
VAMActivate github:Yggdroot/indentLine
VAMActivate github:bling/vim-airline
VAMActivate github:ap/vim-css-color
VAMActivate github:bronson/vim-trailing-whitespace

" navigation
VAMActivate github:kien/ctrlp.vim
VAMActivate github:JazzCore/ctrlp-cmatcher
VAMActivate github:mattn/ctrlp-register
VAMActivate github:scrooloose/nerdtree
VAMActivate github:jistr/vim-nerdtree-tabs
VAMActivate github:artnez/vim-wipeout
"VAMActivate github:bogado/file-line
"VAMActivate github:moll/vim-bbye " :Bdelete that doesn't close the window when closing a buffer

" search
VAMActivate github:rking/ag.vim
VAMActivate github:skwp/greplace.vim " :Gsearch/:Greplace for search/replace in a result buffer
VAMActivate github:Valloric/YouCompleteMe

" editing
VAMActivate github:scrooloose/nerdcommenter
VAMActivate github:tpope/vim-surround
VAMActivate github:terryma/vim-multiple-cursors
VAMActivate github:tpope/vim-repeat
VAMActivate github:tpope/vim-endwise " insert end statements wisely in ruby
VAMActivate github:p0deje/vim-ruby-interpolation
VAMActivate github:ecomba/vim-ruby-refactoring

" syntaxes
VAMActivate github:cakebaker/scss-syntax.vim
VAMActivate github:kchmck/vim-coffee-script
VAMActivate github:tpope/vim-haml
VAMActivate github:pangloss/vim-javascript
VAMActivate github:tpope/vim-markdown
VAMActivate github:mustache/vim-mustache-handlebars
VAMActivate github:tpope/vim-rails
VAMActivate github:vim-ruby/vim-ruby
"VAMActivate github:stephpy/vim-yaml

" version control
VAMActivate github:tpope/vim-fugitive
VAMActivate github:mhinz/vim-signify

" other
VAMActivate github:tpope/vim-abolish " tpope's multi variants abbreviation/substitution plugin
"VAMActivate github:reedes/vim-pencil " various prose modes

set visualbell
set pastetoggle=<Leader>p

set backspace=indent,eol,start                    " allow backspacing over everything in insert mode
set ruler		                                      " show the cursor position all the time
set showcmd		                                    " display incomplete commands
set incsearch		                                  " do incremental searching

set splitright
set splitbelow

" try some performance improvements
set noshowcmd
set lazyredraw
set ttyfast
set synmaxcol=255 " only syntax highlight the first 255 characters of a line, should be sufficient for most cases

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

colorscheme Tomorrow-Night

" for the character, see http://www.unicode.org/charts/PDF/U2500.pdf (u2502)
let g:indentLine_color_term = 237
let g:indentLine_color_gui = '#3a3a3a' " see https://gist.github.com/MicahElliott/719710
let g:indentLine_char = '│'

" configure YouCompleteMe to complete from/into strings/comments
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
highlight Pmenu ctermfg=250 ctermbg=242 guifg=#aaaaaa guibg=#555555

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
nmap <C-v>e :e ~/.vimrc<CR>
nmap <C-v>r :source ~/.vimrc<CR>

" 'smooth' scrolling both in normal and insert mode (taken from tips.txt)
nmap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
nmap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
imap <C-U> <Esc><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>i
imap <C-D> <Esc><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>i

" close current buffer
map <Leader>qb :bd<CR>
" close current window
map <Leader>qw :q\|Wipeout<CR>
" close current tab
map <Leader>qt :tabclose\|Wipeout<CR>
" close all tabs (opening a new one)
map <Leader>qW :tabnew\|tabonly\|Wipeout<CR>
map <Leader>qT :tabnew\|tabonly\|Wipeout<CR>
" close everyting (exiting)
map <Leader>qq :qall<CR>
" close everything without saving (exiting)
map <Leader>qQ :qall!<CR>

map <Leader>/ :noh<CR>
map <Leader>w :w<CR>

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
map <Leader>F :Ag!<Space>
map <Leader>f :Ag!<Space>-i<Space>

" ctrlp mapping
map <Leader>t :CtrlP<CR>
map <Leader>T :CtrlPBuffer<CR>
map <Leader>r :CtrlPBufTag<CR>
map <Leader>R :CtrlPTag<CR>
map <Leader>y :CtrlPRegister<CR>

" adds nerdtree tab toggle
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nT :NERDTreeTabsToggle<CR>
map <Leader>nn :NERDTree<CR>
map <Leader>nf :NERDTreeFind<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw = 0
let g:nerdtree_tabs_open_on_gui_startup = 0

" let ctrlp only work on the current directory, not some kind of root (eg git
" root)
let g:ctrlp_working_path_mode = ''
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_new_file = 't' " open newly created file in new tab
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](tmp|\.(git|hg|svn|bundle))$',
  \ }
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }

" see https://github.com/FelikZ/ctrlp-py-matcher/blob/master/doc/pymatcher.txt
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" configure airline
let g:airline_theme = 'molokai'
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

" color the desired end of the first line of git commit messages
" so that it's easier to know how much space is left
" also define <C-c> to delete the whole buffer, save and exit
" to abort the commit
autocmd BufNewFile,BufRead COMMIT_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ
autocmd BufNewFile,BufRead PULLREQ_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ

function! InitDir()
  tabnew
  tabonly
  Wipeout
  NERDTreeTabsToggle
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
