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
  " let c.auto_install = 0
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

" visuals
VAMActivate github:Yggdroot/indentLine
VAMActivate github:bling/vim-airline
VAMActivate github:ap/vim-css-color
VAMActivate github:bronson/vim-trailing-whitespace

" navigation
VAMActivate github:kien/ctrlp.vim
VAMActivate github:FelikZ/ctrlp-py-matcher
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
"VAMActivate github:tpope/vim-abolish " tpope's multi variants abbreviation/substitution plugin
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

let g:signify_disable_by_default = 1
let g:signify_vcs_list = ['git']
"let g:signify_sign_overwrite = 1

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

colorscheme monokai

" for the character, see http://www.unicode.org/charts/PDF/U2500.pdf (u2502)
let g:indentLine_color_term = 237
let g:indentLine_color_gui = '#3a3a3a' " see https://gist.github.com/MicahElliott/719710
let g:indentLine_char = '│'

" configure YouCompleteMe to complete from/into strings/comments
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

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

map <Leader>q :qall<CR>
map <Leader>/ :noh<CR>
map <Leader>s :w<CR>

" close current (w) or all (W) buffers
map <Leader>w :bd<CR>
map <Leader>W :tabclose<CR>
map <Leader>bb :b#<CR>
nmap <Tab> gt
nmap <S-Tab> gT
nmap <Leader><Leader> :b#<CR>

" git stuff
map <Leader>gs :Gstatus<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gco :Gread<CR>
map <Leader>ga :Gwrite<CR>

" window navigation (see http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily)
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" project wide search
map <Leader>F :Ag<Space>

" ctrlp mapping
map <Leader>t :CtrlP<CR>
map <Leader>T :CtrlPBuffer<CR>
map <Leader>r :CtrlPBufTag<CR>
map <Leader>R :CtrlPTag<CR>

" CHANGE ME
" adds nerdtree tab toggle
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1

" let ctrlp only work on the current directory, not some kind of root (eg git
" root)
let g:ctrlp_working_path_mode = ''
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_new_file = 'r' " open newly created file in current window
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|bundle)$',
  \ }


" configure airline
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
  set guifont=Source\ Code\ Pro\ for\ Powerline:h14
  set guioptions=egm " default: egmrL, see :help guioptions - remove everything so there are no scrollbars
  set showcmd
end

" shows line numbers
set number

" shows mode in status bar
set showmode

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

set cursorline                         " highlight the line with the cursor
highlight clear CursorLine             " only highlight the line number since
augroup CLClear
  autocmd! ColorScheme * highlight clear CursorLine
augroup END
set colorcolumn=81,82,83,84,85
highlight ColorColumn ctermbg=236 guibg='#2a2a2a'

" color the desired end of the first line of git commit messages
" so that it's easier to know how much space is left
" also define <C-c> to delete the whole buffer, save and exit
" to abort the commit
autocmd BufNewFile,BufRead COMMIT_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ

function InitDir()
  tabnew
  tabonly
  Wipeout
  NERDTreeTabsToggle
endfunction
command InitDir call InitDir()

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
