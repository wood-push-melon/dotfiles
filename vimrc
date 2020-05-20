set nocompatible                                 " be iMproved, required
filetype off

" enable file type detection
" enable loading the plugin files for specific file types
" enable loading the indent file for specific file types
filetype plugin indent on

" enable matchit plugin
" extend matching with %
runtime macros/matchit.vim

"
" Settings
"
set noerrorbells                                 " no beeps
set number                                       " show line numbers
set backspace=indent,eol,start                   " makes backspace key more powerful
set showcmd                                      " show me what I'm typing
set nobackup                                     " don't create backup files
set nowritebackup
set noswapfile                                   " don't use swapfile
set splitright                                   " split vertical windows right to the current windows
set splitbelow                                   " split horizontal windows below to the current window
set autoread                                     " reread files changed outside Vim

set ruler                                        " show line and column number of the cursor position

set encoding=utf-8                               " set default char encoding used inside Vim
set fileencoding=utf-8
set fileformat=unix

set noshowmode                                   " don't show Vim mode in the last line
set incsearch                                    " show the match while typing
set hlsearch                                     " highlight search
set ignorecase                                   " seach case insensitive
set smartcase                                    " but not when search pattern contains upper case chars

set showmatch                                    " show matching bracket

" make Vim to handle long lines nicely
set wrap
set textwidth=79

set norelativenumber

set autoindent                                   " copy indent from current line when starting a new line
" set smartindent
set smarttab

set tabstop=4                                    " how many columns Vim uses when you hit Tab in insert mode
set expandtab                                    " use appropriate number of spaces to insert a Tab in insert mode
set shiftwidth=4                                 " how many spaces to use for each step of indent. Used for cindent, >>, <<
set softtabstop=4                                " number of spaces that a Tab counts for while performing editing operations

" change the current working directory whenever open a file, switch buffer,
" delete a buffer or open/close a window
set autochdir

" the mouse pointer is hidden when typing characters
set mousehide

" show cursor line
set cursorline
set cursorcolumn

set colorcolumn=+1                               " highlight column after 'textwidth'

set cmdheight=2                                  " set command line window size

set wildmode=list:longest                        " mode used for the char specified with wildchar
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" set fold
" set foldmethod=syntax

syntax enable                                    " enable syntax highlight
" syntax on                                      " Vim will overrule your settings

set t_Co=256                                     " number of colors

" set guifont=Apple\ Color\ Emoji:h12
set guifont=Inconsolata:h12                      " font style and size

" better completion
set complete-=i
" set completeopt=longest,menu

" minimal number of screen lines to keep above and below the cursor
if !&scrolloff
    set scrolloff=5
endif

" minimum number of screen columns to keep to the left and to the right of the cursor
if !&sidescrolloff
    set sidescrolloff=5
endif

" open help window vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" see difference between the current buffer and the file it was loaded from
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \	exe "normal! g`\"" |
      \ endif

" ----------------------------------------- "
" Mappings                                  "
" ----------------------------------------- "
nmap oo o<ESC>
nmap OO O<ESC>

" ----------------------------------------- "
" Plugins                                   "
" ----------------------------------------- "
" Pathogen
" call pathogen#infect()
" call pathogen#helptags()

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Plugin 'vim-syntastic/syntastic'
Plugin 'scooloose/nerdtree'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'pangloss/vim-javascript'
Plugin 'w0rp/ale'
Plugin 'majutsushi/tagbar'
Plugin 'hashivim/vim-terraform'
Plugin 'elzr/vim-json'
Plugin 'easymotion/vim-easymotion'
Plugin 'jnurmine/Zenburn'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'jpalardy/vim-slime'
Plugin 'morhetz/gruvbox'
Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

call vundle#end()

" ----------------------------------------- "
" Color Schemes
" ----------------------------------------- "

colorscheme gruvbox
set background=dark

" ----------------------------------------- "
" Plugin configs 			    			"
" ----------------------------------------- "

" ==================== NerdTree ====================
map <Leader>nt :NERDTree %:p:h<CR>:pwd<CR>       " open current directory in NERDTree and show the current directory
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=40
let g:netrw_dirhistmax=0                         " don't save .netrwhist history
let NERDTreeShowHidden=1                         " show hidden files
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

" Syntastic
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']

" ==================== CtrlP ====================
set rtp^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command=['.git', 'cd %s && git ls-files -co --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" ==================== Tagbar ====================
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus=1

" ==================== ALE ====================
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=0
let g:ale_sign_column_always=1
let g:ale_fixers={
            \  'javascript': ['eslint'],
            \}
let g:ale_fix_on_save=1
let b:ale_linters=['/usr/local/bin/flake8', '/usr/local/bin/pylint']
let g:ale_sign_error='>>'
let g:ale_sign_warning='--'
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_set_loclist=0
let g:ale_set_quickfix=1
" <C-k> <C-j> nagivate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap gp :silent %!prettier --stdin --trailing-comma all --single-quote<CR>

" ==================== vim-json ====================
let g:vim_json_syntax_conceal = 0

" ==================== vim-terraform ====================
let g:terraform_fmt_on_save=1

" ==================== vim-commentary ====================
autocmd FileType *.py setlocal commentstring=#\ %s

" ==================== YouCompleteMe ====================
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_min_num_of_chars_for_completion=1
" let g:ycm_key_invoke_completion='<S-Space>'
let g:ycm_goto_buffer_command='new-tab'

nnoremap <Leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>jl :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>jg :YcmCompleter GoTo<CR>
nnoremap <Leader>jr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>jh :YcmCompleter GetDoc<CR>
nmap <F4> :YcmDiags<CR>

" ==================== vim-better-whitespace ====================
" auto strip whitespace except for file with extention blacklisted
let blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | StripWhitespace

" ==================== vim-airline  ====================
let g:airline_powerline_fonts=1
let g:airline_extensions=[]
let g:airline_theme='solarized'

" ==================== vim-bookmarks  ====================
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 0
let g:bookmark_auto_save = 0

" ==================== vim-easymotion ====================
nmap ss <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_smartcase = 1

" ==================== vim-slime ====================
let g:slime_target = 'vimterminal'
let g:slime_python_ipython = 1

" ==================== Powerline ====================
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
" if has ("python3")
	" Bundle 'powerline/powerline', {'rpt': 'powerline/bindings/vim/'}
	" let g:Powerline_colorscheme = 'tmux'
	" let g:Powerline_symbols = 'fancy'
	" set fillchars+=stl:\ ,stlnc:\
	" set laststatus=2
	" set t_Co=256
" endif

" ----------------------------------------- "
" File Type settings 			    		"
" ----------------------------------------- "
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
au BufNewFile,BufRead html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.vue set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.yml,*.yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.pp set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix

hi PreProc term=bold ctermfg=1 guifg=navajowhite

" Source the vimrc file after saving it
" if has ("autocmd")
	" autocmd bufwritepost .vimrc source $MYVIMRC
" endif
augroup VimrcGroup
    autocmd!
    autocmd bufwritepost .vimrc source $MYVIMRC
augroup END
