" The following settings are taken from the example .vimrc (see end of file)

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
syntax on
filetype plugin indent on

" TODO: evaluate plugin manager https://github.com/vim-volt/volt
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
Plug 'joshdick/onedark.vim'

" visuals
" Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'itchyny/lightline.vim' lighter alternative to airline?
Plug 'ap/vim-css-color'
Plug 'bronson/vim-trailing-whitespace'

" ASYNC stuff: http://hew.tools/blog/posts/asynchronous-neovim-in-2016/

" navigation
" Plug '/usr/local/opt/fzf' " 'junegunn/fzf'
" see https://github.com/junegunn/fzf.vim/issues/210
" this should fix error with wrap but doesn't...
" TODO: check https://github.com/jhawthorn/fzy
" TODO: check floating windows: https://github.com/junegunn/fzf.vim/issues/664

Plug '/usr/local/opt/fzf' " set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim' " see https://devhub.io/repos/junegunn-fzf.vim or https://github.com/junegunn/fzf/blob/master/README-VIM.md
Plug 'scrooloose/nerdtree'
" Plug 'tpope/vim-vinegar'
Plug 'artnez/vim-wipeout'
"Plug 'bogado/file-line'
"Plug 'moll/vim-bbye' " :Bdelete that doesn't close the window when closing a buffer
Plug 'yssl/QFEnter'
" Allow :Bopen <gem name> and gf in Gemfile.lock
Plug 'tpope/vim-bundler'

" database
Plug 'tpope/vim-dadbod'

" search
Plug 'mhinz/vim-grepper'
Plug 'skwp/greplace.vim' " :Gsearch/:Greplace for search/replace in a result buffer
" Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TODO see ~/.config/coc

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" TODO see more from https://github.com/neoclide/coc.nvim


Plug 'junegunn/vim-slash'

" editing
"Plug 'scrooloose/nerdcommenter'
" Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" switching between symbols and strings in ruby, see https://github.com/tpope/vim-surround/issues/145, not fully repeatable yet
let g:surround_58 = ":\r"
nmap cs:' csw'X
nmap cs:" csw"X
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise' " insert end statements wisely in ruby
"Plug 'p0deje/vim-ruby-interpolation'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
Plug 'mbbill/undotree'
nmap <Leader>u :UndotreeShow<CR>:UndotreeFocus<CR>
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_prefix = '<Leader>'
let g:peekaboo_ins_prefix = '<C-x>'

Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki' ", { 'on': ['VimwikiIndex', 'VimwikiUISelect'] }
let g:vimwiki_map_prefix = '<Leader>v'
let g:vimwiki_list = [
      \ {'path': '~/Documents/vimwiki/vimwiki/', 'auto_tags': 1, 'auto_diary_index': 1},
      \ {'path': '~/Documents/vimwiki/markdown/', 'syntax': 'markdown', 'ext': '.md'},
      \ {'path': '~/Projects/sumcumo/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1, 'auto_diary_index': 1}
      \]
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_auto_chdir = 1
" disable table mappings (CR and TAB), for TAB collides with COC
" TODO: find a solution here
let g:vimwiki_table_mappings = 0
" let g:vimwiki_listsyms = '✗○◐●✓'
" let g:vimwiki_listsym_rejected = '✗'
" TODO: calendar for diary
" Plug 'itchyny/calendar.vim'
" taken from https://blog.mague.com/?p=602
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
function! CommitAndPush()
  execute ":G add -u"
  execute ":Gcommit"
  execute ":Gpush"
endfunction
augroup vimwiki_custom_mappings
  autocmd!
  autocmd FileType vimwiki noremap <Leader>d :VimwikiMakeDiaryNote<CR>
  autocmd FileType vimwiki noremap <Leader>c :call ToggleCalendar()<CR>
  autocmd FileType vimwiki noremap <Leader>gp :call CommitAndPush()<CR>
augroup END

" Plug 'tbabej/taskwiki', { 'do': 'pip3 install --upgrade -r requirements.txt' }
Plug 'blindFS/vim-taskwarrior'

" linting
" Plug 'w0rp/ale'

" let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
" Plug 'ngmy/vim-rubocop'

" let g:blockle_mapping = '<Leader>b'
" Plug 'jgdavey/vim-blockle'
Plug 'AndrewRadev/splitjoin.vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" syntaxes
Plug 'cakebaker/scss-syntax.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-haml'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['sh', 'ruby', 'sql']
" this seems to be better for github flavored markdown but fails miserable
" for automatic list formatting/word wrap - check tpope's plugin flp setting
" Plug 'gabrielelana/vim-markdown'
" let g:markdown_mapping_switch_status = '<Leader><Space>'
" let g:markdown_enable_mappings = 0
"Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
let g:ruby_indent_block_style = 'do'
Plug 'kana/vim-textobj-user' " needed for nelstrom/vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock'
"Plug 'stephpy/vim-yaml'
Plug 'lmeijvogel/vim-yaml-helper'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chakrit/upstart.vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/applescript.vim'
Plug 'vim-scripts/nginx.vim'
Plug 'vim-scripts/groovy.vim'
Plug 'sirtaj/vim-openscad'

" version control
Plug 'tpope/vim-fugitive'
" TODO: cannot open files in gitlab yet, get a 404, cannot open commits,
" configure access tokens so that issue linking works
Plug 'tpope/vim-rhubarb' " github browsing from fugitive
Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gitlab.sumcumo.net']
Plug 'gregsexton/gitv'
Plug 'junegunn/gv.vim'
"Plug 'mhinz/vim-signify' " signify is asynchronous now, as well, check it!
Plug 'airblade/vim-gitgutter' " async alternative to vim-signify
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

if !has("gui_running")
  Plug 'benmills/vimux' " tmux integration

  "doesn't work in neovim due to it's lack of ruby support
  "Plug 'pgr0ss/vimux-ruby-test' " ruby test runner (requires tmux)
  "let g:vimux_ruby_cmd_unit_test = "bundle exec ruby"

  "doesn't work with nested projects inside workspace and uses :line syntax
  "which minitest doesn't understand
  Plug 'skalnik/vim-vroom'
  let g:vroom_use_vimux = 1
  "let g:vroom_use_terminal = 1
  let g:vroom_map_keys = 0
  let g:vroom_clear_screen = 0
  "let g:vroom_write_all = 0

  "let g:vroom_test_unit_command = 'ruby -Itest ../'

  "doesn't work at all...
  "Plug 'jgdavey/vim-turbux'

  nmap <Leader>v call VroomRunTestFile<CR>
  nmap <Leader>V call VroomRunNearestTest<CR>
  "nmap <Leader>r call VimuxRunCommand("bundle exec ruby -Itest " . expand('%:p') . " -l " . line("."))<CR>
  "nmap <Leader>R call VimuxRunCommand("bundle exec ruby -Itest " . expand('%:p'))<CR>
endif

call plug#end()

" yanking
vmap gy "*y
nmap gy$ "*y$
nmap gyy "*yy
nmap gyp "*yip
nmap gyY :%y*<CR>

" TODO: test lua for things like this: `:help lua-stdlib`
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

" function! RunIt(startline, endline) range
function! RunIt(startline, endline) range
  let file = tempname()

  " write the selection to a file, setting buftype to nofile so that the
  " current buffer doesn't get the path if it is Unnamed yet
  setlocal buftype=nofile
  exec "silent ".a:startline.",".a:endline."write ".file
  setlocal buftype=

  " make new vertical split and execute file
  vnew
  setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
  nmap <buffer> q <C-w>q
  " exec "silent r ".file
  exec "silent r !bundle exec ruby ".file
  setlocal nomodifiable

  " TODO:
  " * delete first line
  " * separator between code and output
  " * both execs sequentially
  " * ft
  " * async
  " * marker that it's done
  " * mapping doesn't work initially, you have to source vimrc manually first
endfunction
nmap <Leader>run :call RunIt(0, '$')<CR>
" vmap <Leader>run :call RunIt("'<", "'>")<CR>
vmap <Leader>run :<C-u>call RunIt("'<", "'>")<CR>

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
"set noshowcmd
set lazyredraw
set ttyfast
set synmaxcol=255 " only syntax highlight the first 255 characters of a line, should be sufficient for most cases

set spelllang= "empty for now to prevent spell checking, later: en,de

"let g:signify_vcs_list = ['git']

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

" " for the character, see http://www.unicode.org/charts/PDF/U2500.pdf (u2502)
" let g:indentLine_color_term = 237
" let g:indentLine_color_gui = '#3a3a3a' " see https://gist.github.com/MicahElliott/719710
" let g:indentLine_char = '│'
" " without this, conceallevel is set to 2 which messes with json files
" " but with this, the indentlines aren't shown any more - d'oh
" let g:indentLine_conceallevel = 0

" configure YouCompleteMe to complete from/into strings/comments
" let g:ycm_min_num_of_chars_for_completion = 5 " to avoid auto popups while typing but still have them on semantic triggers (.)
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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
" map <Leader>qb :bd<CR>
" close current window
" map <Leader>qw :q\|Wipeout<CR>
" close current tab
" TODO go to last tab on tabclose: http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
function! CloseCurrentTab()
  exec tabpagenr('$') == 1 ? 'tabnew|tabonly' : 'tabclose'
  Wipeout
endfunction
map <Leader>qt :call CloseCurrentTab()<CR>
" close all tabs (opening a new one)
" map <Leader>qW :tabnew\|tabonly\|Wipeout<CR>
" map <Leader>qT :tabnew\|tabonly\|Wipeout<CR>
" close everyting (exiting)
" map <Leader>qq :qall<CR>
" close everything without saving (exiting)
" map <Leader>qQ :qall!<CR>

" disable Ex-Modus
map Q <Nop>
nmap Q :<C-U>qall<CR>

" <C-U> removes the visual range ('<,'>) the mapping would add after the : when hit in
" visual mode
map <C-w>Q :<C-U>qall<CR>
map <C-w><C-q> :<C-U>qall<CR>

map <C-w>t :tabnew<CR>
" ATTN: remaps existing mapping! :tab help CTRL-W
map <C-w>T :tabclose<CR>

map <Leader>/ :noh<CR>
map <Leader>7 :noh<CR>
map <Leader>w :w<CR>
" the next should replace the previous at some point since that one is
" rendered unusable by vimwiki (not anymore, remapped it to <Leader>v)
map W :<C-U>w<CR>
" Allow saving of files as sudo when I forgot to start vim using sudo.
map <Leader>W :w !sudo tee > /dev/null %<CR>

" tab navigation
nmap <C-Tab> gt
nmap <C-S-Tab> gT

" switching current window back to previous buffer
nmap <Leader><Leader> :b#<CR>

" git stuff
map <Leader>gs :Gstatus<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gco :Gread<CR>
map <Leader>ga :Gwrite<CR>
" open objects on the git remote in the browser
nmap <Leader>gB :.Gbrowse<CR>
vmap <Leader>gB :'<,'>Gbrowse<CR>
" copy objects' URL on the git remote to the clipboard
nmap <Leader>gU :.Gbrowse!<CR>
vmap <Leader>gU :'<,'>Gbrowse!<CR>

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

" Allow tmux style window navigation
map <C-b>h <C-w>h
map <C-b>j <C-w>j
map <C-b>k <C-w>k
map <C-b>l <C-w>l
map <C-b>v <C-w>v
map <C-b>s <C-w>s

" configure greplace to use ripgrep
set grepprg=rg
" set grepformat=%f:%l:%c:%m,%f:%l:%m
let g:grep_cmd_options = '--with-filename --no-heading --vimgrep --hidden --sort-files --smart-case'

" project wide search
let g:grepper = {}            " initialize g:grepper with empty dictionary
let g:grepper.prompt_text = '$t> '
" TODO use g:grepper configuration for this, see grepper-tools
map <Leader>f :Grepper -tool rg -highlight -grepprg rg -H --no-heading --vimgrep --hidden --sort-files --smart-case<CR>
map <Leader>F :Grepper -tool rg -highlight -grepprg rg -H --no-heading --vimgrep --hidden --sort-files --case-sensitive<CR>
" not needed, just hit return with an empty prompt and it will search cword: map <Leader>* :Grepper -tool rg -highlight -cword -noprompt<CR>
" TODO see help grepper
" nmap gs  <plug>(GrepperOperator)
" xmap gs  <plug>(GrepperOperator)

" TODO map :%s///gn to something intuitive to count matches for previous
" search (with /)

" FZF configuration
" use ag for FZF file list input, because ag is configured to ignore all
" .gitignore'd files
" see https://github.com/junegunn/fzf.vim/issues/121
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND = 'fd --hidden --no-ignore --no-ignore-vcs --type f --exclude ".git"'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabe'
      \ }
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>']
let g:qfenter_keymap.topen = ['<C-t>']

set tags+=.git/tags
" fzf mapping
" files
" let g:fzf_files_options = '--preview="cat -e {}"' THIS one, if highlight is not installed, dependencies: boost and lua
let g:fzf_files_options = '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
map <Leader>tf :FzfFiles<CR>
map <Leader>t :FzfFiles<CR>
" buffers
map <Leader>tb :FzfBuffers<CR>
" tags (local/global)
map <Leader>tt :FzfBTags<CR>
" TODO: This doesn't work with my ~/.ctags (putting tags in .git/tags)
" https://github.com/junegunn/fzf.vim/blob/364fea3ca09b7c70294e4b856893919b0b689375/autoload/fzf/vim.vim
" tagfiles is empty (search "Generate?")
" https://github.com/junegunn/fzf.vim/issues/263
" https://github.com/junegunn/fzf.vim/pull/127
" https://github.com/ludovicchabant/vim-gutentags
map <Leader>tT :FzfTags<CR>
" git commits
map <Leader>tc :FzfCommits<CR>
augroup fzf_close_on_blur
" TODO: make fzf disappear when it's losing focus
"   au FileType fzf WinLeave <Esc>
augroup END

" quickfix settings
"DAMMIT they clash with NERDCommenter
"map <Leader>co :copen<CR>
"map <Leader>cc :cclose<CR>
"map <Leader>ch :colder<CR>
"map <Leader>cl :cnewer<CR>

" taken from http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
augroup quickfix_window_height
  au FileType qf call AdjustWindowHeight(3, &lines / 3)
augroup END
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$") + 1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
augroup quickfix_navigation_mappings
  au FileType qf nnoremap <buffer> J :cn<CR>zz<C-w><C-p>
  au FileType qf nnoremap <buffer> K :cp<CR>zz<C-w><C-p>
  au FileType qf nnoremap <buffer> q :ccl<CR>
  au FileType qf nnoremap <buffer> <Esc> :ccl<CR>
augroup END

" adds nerdtree toggle
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nn :NERDTree<CR>
map <Leader>nf :NERDTreeFind<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw = 0
" see https://medium.com/@victormours/a-better-nerdtree-setup-3d3921abc0b9
let g:NERDTreeMinimalUI = 1

" see https://shapeshed.com/vim-netrw/
let g:netrw_liststyle = 3
" let g:netrw_banner = 0

" configure airline
let g:airline_theme = 'kalisi'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '│'
let g:airline_right_alt_sep = '│'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_tab_nr = 1
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
" I actually wanted to activate swap files for recovering unnamed files when
" my keyboard acts up again. But There was a segfault when trying `vim -r
" .swp` or some weird behaviour with `vim -r ""` for recovering unnamed files
" set swapfile
set autoread                           " Automatically read unchanged buffers when corresponding file changes on disk

set tabstop=2                          " set tab width when pressing tab
set shiftwidth=2                       " set tab width when using retab
set expandtab                          " expand tabs to spaces
set smarttab                           " also delete all spaces on <BS>

" eliminate delay in switching to normal mode
" see http://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0

" shorten updatetime, mainly needed for gitgutter to enable real time git
" status signs
set updatetime=250
"let g:gitgutter_highlight_lines=1 " make gitgutter highlight lines on hunks

" allow me to comment stuff, see https://github.com/amix/vimrc
iab meee <c-r>=strftime("[thomas, %Y-%m-%d]")<cr>

" switch off cursorline since it slows down ruby syntax highlighting: http://stackoverflow.com/questions/22949067/macvim-quite-slow-when-syntax-is-set-to-ruby
" set cursorline                         " highlight the line with the cursor
" highlight clear CursorLine             " only highlight the line number since
" augroup CLClear
"   autocmd! ColorScheme * highlight clear CursorLine
" augroup END

" activate cursorline for non-active windows in order to see which line is
" highlighted when navigating files from the quickfix window
" dammit, this is also slow when scrolling non-active windows using the
" trackpad!
" augroup CursorLine
"   au WinEnter * setlocal nocursorline
"   au WinLeave * setlocal cursorline
" augroup END

" TODO: How can I check if this setting is available?!
" if has("guicursor")
  " this is actually the default cursor with an added color since sometimes
  " they were black on dark gray and thus hardly visible, also adds blinking
  " default: guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
  highlight iCursor ctermfg=160 ctermbg=0 guifg=red guibg=black
  set guicursor=n-v-c-sm:block
  set guicursor+=i-ci-ve:ver25-iCursor-blinkwait500-blinkon500-blinkoff50
  set guicursor+=r-cr-o:hor20-iCursor-blinkwait500-blinkon500-blinkoff50
" endif

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

" doesn't work yet.. why?
" augroup nerd_tree_mappings
"   autocmd!
"   autocmd FileType nerdtree nnoremap <buffer> <Space> <CR>
" augroup END

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
