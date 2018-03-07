" The following settings are taken from the example .vimrc (see end of file)

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
syntax on
filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'bronson/vim-trailing-whitespace'

" ASYNC stuff: http://hew.tools/blog/posts/asynchronous-neovim-in-2016/

" navigation
Plug 'ctrlpvim/ctrlp.vim' " maybe see https://github.com/junegunn/fzf as an async alternative?
Plug 'JazzCore/ctrlp-cmatcher', { 'do': 'CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh' }
Plug 'mattn/ctrlp-register'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' " see https://devhub.io/repos/junegunn-fzf.vim
Plug 'scrooloose/nerdtree'
"Plug 'tpope/vim-vinegar'
Plug 'artnez/vim-wipeout'
"Plug 'bogado/file-line'
"Plug 'moll/vim-bbye' " :Bdelete that doesn't close the window when closing a buffer

" search
Plug 'rking/ag.vim'
" Deprecated: See [this comment](https://github.com/rking/ag.vim/issues/124#issuecomment-227038003) for more info. Maybe try [ack.vim](https://github.com/mileszs/ack.vim#can-i-use-ag-the-silver-searcher-with-this) as an alternative. ##

" fast, but opens first search result in currently active window - eg NerdTREE d'oh!
Plug 'tjennings/git-grep-vim'
" no - doesn't seem to populate quickfix window, but does add motions which is nice
"Plug 'teoljungberg/vim-grep'
Plug 'skwp/greplace.vim' " :Gsearch/:Greplace for search/replace in a result buffer
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py' }
Plug 'junegunn/vim-slash'

" editing
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise' " insert end statements wisely in ruby
"Plug 'p0deje/vim-ruby-interpolation'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
Plug 'mbbill/undotree'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" syntaxes
Plug 'cakebaker/scss-syntax.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-haml'
Plug 'pangloss/vim-javascript'
"Plug 'tpope/vim-markdown'
" this seems to be better for github flavored markdown but fails miserable
" for automatic list formatting/word wrap - check tpope's plugin flp setting
Plug 'gabrielelana/vim-markdown'
let g:markdown_mapping_switch_status = '<Leader><Space>'
"Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
"Plug 'stephpy/vim-yaml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chakrit/upstart.vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/applescript.vim'
Plug 'vim-scripts/nginx.vim'
Plug 'vim-scripts/groovy.vim'

" version control
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'mhinz/vim-signify' " async alternative: https://github.com/airblade/vim-gitgutter
Plug 'Xuyuanp/nerdtree-git-plugin'

" other
Plug 'tpope/vim-abolish' " tpope's multi variants abbreviation/substitution plugin
Plug 'rizzatti/dash.vim' " integration with Dash.app
"Plug 'nelstrom/vim-markdown-preview'
"Plug 'wikimatze/hammer.vim' " alternative to the above? needs installed gems, though
"Plug 'reedes/vim-pencil' " various prose modes
"Plug 'mikewest/vimroom'
"Plug 'vitalk/vim-simple-todo'
"Plug 'skalnik/vim-vroom' " ruby test runner
"let g:vroom_use_spring=1
"let g:vroom_test_unit_command="ruby -Ikonect_core/test"

" modify cursor shape based on mode
" TODO fix it for vim
"if exists('$TMUX')
"    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
"    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
"else
"    let &t_SI = "\e[5 q"
"    let &t_EI = "\e[2 q"
"endif

if !has("gui_running")
  Plug 'benmills/vimux' " tmux integration

  "doesn't work in neovim due to it's lack of ruby support
  "Plug 'pgr0ss/vimux-ruby-test' " ruby test runner (requires tmux)
  "let g:vimux_ruby_cmd_unit_test = "bundle exec ruby"

  "doesn't work with nested projects inside workspace and uses :line syntax
  "which minitest doesn't understand
  "Plug 'skalnik/vim-vroom'
  "let g:vroom_use_vimux = 1
  "let g:vroom_test_unit_command = 'ruby -Itest ../'

  "doesn't work at all...
  "Plug 'jgdavey/vim-turbux'

  nmap <Leader>r call VimuxRunCommand("bundle exec ruby -Itest " . expand('%:p') . " -l " . line("."))<CR>
  nmap <Leader>R call VimuxRunCommand("bundle exec ruby -Itest " . expand('%:p'))<CR>
endif

call plug#end()

function! MakeIt(startline, endline)
  if &filetype == "coffee"
    exec a:startline.",".a:endline."CoffeeCompile vertical"
  elseif &filetype == "ruby"
    call VimuxRunCommand("bundle exec ruby -Itest " . expand('%:p') . " -l " . line("."))
  else
    echo "don't know how to make files of type '".&filetype."'"
  endif
endfunction
nmap <Leader>m :call MakeIt(0, '$')<CR>
vmap <Leader>m :call MakeIt("'<", "'>")<CR>

"function! s:MakeIt(startline, endline)
"  if &filetype == "coffee"
"    exec a:startline.",".a:endline."CoffeeCompile vertical"
"  else
"    echo "don't know how to make files of type '".&filetype."'"
"  endif
"endfunction
"command! -buffer -range=% -bar -complete=customlist,s:MakeIt MakeIt call s:MakeIt(<line1>, <line2>)
"nmap <Leader>m :MakeIt<CR>
"vmap <Leader>m :MakeIt<CR>

let g:UltiSnipsExpandTrigger='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
let g:UltiSnipsEditSplit='vertical'

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

" activate true color, see https://deductivelabs.com/en/2016/03/using-true-color-vim-tmux/
if has("nvim")
  if has("termguicolors") " introduced in neovim 0.1.5
    set termguicolors
  else
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
endif

colorscheme kalisi
set background=dark

" for the character, see http://www.unicode.org/charts/PDF/U2500.pdf (u2502)
let g:indentLine_color_term = 237
let g:indentLine_color_gui = '#3a3a3a' " see https://gist.github.com/MicahElliott/719710
let g:indentLine_char = '│'
" without this, conceallevel is set to 2 which messes with json files
" but with this, the indentlines aren't shown any more - d'oh
let g:indentLine_conceallevel = 0

" configure YouCompleteMe to complete from/into strings/comments
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'unite' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}
"taken out:
"      \ 'markdown' : 1,
"      \ 'text' : 1,
highlight Pmenu ctermfg=250 ctermbg=242 guifg=#aaaaaa guibg=#555555

" configure greplace to use ag
"set grepprg=ag
"let g:grep_cmd_opts = '--line-numbers --noheading'
set grepprg=/usr/local/bin/rg
let g:grep_cmd_options = '--vimgrep'

let mapleader=","                                 " defines the leader

runtime macros/matchit.vim        " Load the matchit plugin.

" make auto completion more zsh like instead of completing the first match
set wildmenu
set wildmode=list:longest

" highlight invisible characters
" (NonText: eol/extends/precedes, SpecialKey: nbsp/tab/trail)
" see http://vimcasts.org/episodes/show-invisibles/
set list
set listchars=tab:▸\ ,extends:>,precedes:<,trail:•
highlight NonText ctermfg=237 ctermbg=none guifg='#3a3a3a' guibg=NONE
highlight SpecialKey ctermfg=237 ctermbg=none guifg='#3a3a3a' guibg=NONE

vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>r <Plug>(EasyAlign)

" session storage/restorage
" default: sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,unix,winsize
"nmap <Leader>ss :mksession! ~/.vimsession.vim<CR>
"nmap <Leader>sl :source ~/.vimsession.vim<CR>

" define how soft wrapping works
set linebreak " wrap lines at characters in breakat instead of on line length, supposed not to work with list set, but does
" add two spaces before soft wrapped line continuations
set showbreak=\ \ 

set showmatch " blink matching opening brackets when typing a closing bracket

" edit and reload .config/nvim/init.vim
nmap <C-v>e :tabe ~/.config/nvim/init.vim<CR>
nmap <C-v>r :source ~/.config/nvim/init.vim<CR>
" When vimrc is edited, reload it
autocmd! BufWritePost init.vim source %

" screen line navigation as standard
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Space toggle folds
nnoremap <Space> za
vnoremap <Space> za

" formatting, see :help fo-table and :help formatoptions
"set formatoptions+=a1
set formatoptions=crqnlj

" display long last line partially
set display=lastline

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
map <Leader>gh :Gbrowse<CR>

function! OpenGitModified()
  let modifiedFiles = system("git status --porcelain | grep -v '/$' | awk '{print $2}'")
  for file in split(modifiedFiles, '\n')
    execute 'tabe ' . file
  endfor
endfunction
map <Leader>gm :call OpenGitModified()<CR>

" TODO: expand strings with wildcards
function! TabOpen(...)
  for file in a:000
    execute 'tabe ' . file
  endfor
endfunction
command! -nargs=* Tabo call TabOpen(<f-args>)

function! StartProse()
  setlocal textwidth=80
  setlocal formatoptions=tcrqan1j
  setlocal autoindent
endfunction
command! StartProse call StartProse()
"autocmd Filetype markdown call StartProse()

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
" taken from https://github.com/linhmtran168/mac_dotfiles/blob/master/.vimrc#L353
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
nmap <D-j> <M-j>
nmap <D-k> <M-k>
vmap <D-j> <M-j>
vmap <D-k> <M-k>

" Remap indentation shortcuts to keep selection
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" project wide search
"map <Leader>f :Ag!<Space>
"map <Leader>F :Ag!<Space>-i<Space>
map <Leader>f :GitGrep<Space>
map <Leader>F :GitGrep<Space>-i<Space>
let g:ag_highlight=1

" FZF configuration
" use ag for FZF file list input, because ag is configured to ignore all
" .gitignore'd files
" see https://github.com/junegunn/fzf.vim/issues/121
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabe'
      \ }

" ctrlp mapping
" files
map <Leader>Tf :CtrlP<CR>
map <Leader>T :CtrlP<CR>
map <Leader>tf :FZF --preview="cat -e {}"<CR>
map <Leader>t :FZF --preview="cat -e {}"<CR>
" buffers
map <Leader>tb :CtrlPBuffer<CR>
" tags (local/global)
map <Leader>tt :CtrlPBufTag<CR>
map <Leader>tT :CtrlPTag<CR>
" yank registers
map <Leader>ty :CtrlPRegister<CR>

" quickfix settings
"DAMMIT they clash with NERDCommenter
"map <Leader>co :copen<CR>
"map <Leader>cc :cclose<CR>
"map <Leader>ch :colder<CR>
"map <Leader>cl :cnewer<CR>

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
let g:ctrlp_open_new_file = 't' " open newly created file in new tab

" taken from http://blog.patspam.com/2014/super-fast-ctrlp
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
  \ --ignore tmp
  \ --ignore .git
  \ --ignore .hg
  \ --ignore .svn
  \ --ignore .bundle
  \ --ignore .DS_Store
  \ --ignore node_modules
  \ --ignore "**/*.pyc"
  \ -g ""'

" see https://github.com/FelikZ/ctrlp-py-matcher/blob/master/doc/pymatcher.txt
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

let g:ctrlp_abbrev = {
  \ 'gmode': 'i',
  \ 'abbrevs': [
    \ {
      \ 'pattern': 'a ',
      \ 'expanded': 'app/',
      \ 'mode': 'pfrz',
    \ },
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
      \ 'pattern': 'ah ',
      \ 'expanded': 'app/helpers/',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': 'av ',
      \ 'expanded': 'app/views/',
      \ 'mode': 'pfrz',
    \ },
    \ {
      \ 'pattern': 't ',
      \ 'expanded': 'test/',
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
    \ {
      \ 'pattern': 'th ',
      \ 'expanded': 'test/helpers/',
      \ 'mode': 'pfrz',
    \ },
    \ ]
  \ }


" configure airline
let g:airline_theme = 'kalisi'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '│'
let g:airline_right_alt_sep = '│'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
set laststatus=2 " needed for airline to also show up when only one window is present

" prevent multiple-cursors to lose the selections when exiting from visual
" and insert modes
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

if has("gui_running")
  set guifont=Hack:h11
  set guioptions=egm " default: egmrL, see :help guioptions - remove everything so there are no scrollbars
  set showcmd
  set showtabline=2 " always show tabs
  set titlestring=%{$PWD}
else
  execute 'silent !echo -ne "\e]1;${PWD\#\#*/}\a"'
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
" hm... doesn't work?
"set autoread                           " Automatically read unchanged buffers when corresponding file changes on disk

set tabstop=2                          " set tab width when pressing tab
set shiftwidth=2                       " set tab width when using retab
set expandtab                          " expand tabs to spaces
set smarttab                           " also delete all spaces on <BS>

" eliminate delay in switching to normal mode
" see http://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0

" allow me to comment stuff, see https://github.com/amix/vimrc
iab meee <c-r>=strftime("[thomas, %Y-%m-%d]")<cr>

" switch off cursorline since it slows down ruby syntax highlighting: http://stackoverflow.com/questions/22949067/macvim-quite-slow-when-syntax-is-set-to-ruby
"set cursorline                         " highlight the line with the cursor
"highlight clear CursorLine             " only highlight the line number since
"augroup CLClear
"  autocmd! ColorScheme * highlight clear CursorLine
"augroup END

" insert mode cursor for console based vim
" https://www.iterm2.com/documentation-escape-codes.html
" http://sts10.github.io/blog/2015/10/24/true-hex-colors-with-neovim-and-iterm2/#post-2632598645
"if $TERM_PROGRAM =~ "iTerm"
"  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"  "let &t_SI = "\<esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
"  "let &t_EI = "\<esc>]50;CursorShape=0\x7" " Block in normal mode
"  if exists('$TMUX')
"    let &t_SI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=2\x7\<esc>\\"
"    let &t_EI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
"    " https://gist.github.com/andyfowler/1195581#gistcomment-532290
"    "let &t_SI = "\<Esc>[2 q"
"    "let &t_EI = "\<Esc>[0 q"
"  else
"    let &t_SI = "\<esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<esc>]50;CursorShape=0\x7"
"  endif
"endif
" https://github.com/neovim/neovim/issues/2475#issuecomment-212010187

nmap <Leader>d :Dash<CR>

" color the desired end of the first line of git commit messages
" so that it's easier to know how much space is left
" also define <C-c> to delete the whole buffer, save and exit
" to abort the commit
" see http://learnvimscriptthehardway.stevelosh.com/chapters/14.html for augroup
augroup git_messages
  autocmd!
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ
  autocmd BufNewFile,BufRead PULLREQ_EDITMSG set colorcolumn=51 | map <C-c> <Esc>ggdGZZ
augroup END

augroup nerd_tree_scrolloff
  autocmd!
  autocmd BufEnter NERD_tree_\d\+ set scrolloff=0
  autocmd BufLeave NERD_tree_\d\+ set scrolloff=2
augroup END
set scrolloff=2

au BufReadPost Jenkinsfile set ft=groovy

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
