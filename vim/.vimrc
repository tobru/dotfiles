"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managed with VAM
" https://github.com/MarcWeber/vim-addon-manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible | filetype indent plugin on | syn on

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

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()
" use <c-x><c-p> to complete plugin names

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin loading
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" libs
VAMActivate vim-addon-mw-utils
VAMActivate tlib

" statusline
VAMActivate vim-airline

" snippet management
VAMActivate UltiSnips
VAMActivate vim-snippets

" GIT helper
VAMActivate fugitive

" Puppet helper
VAMActivate github:rodjek/vim-puppet

" Syntax checking hacks for vim
VAMActivate Syntastic

" Vim script for text filtering and alignment
VAMActivate Tabular

" Vimwiki
VAMActivate vimwiki

" Completion
"VAMActivate YouCompleteMe

" Outliner
VAMActivate VOoM

" Fuzzy file, buffer, mru, tag, etc finder.
VAMActivate ctrlp
"VAMActivate FuzzyFinder

" plugin to visualize your Vim undo tree
VAMActivate Gundo

" NERD tree
VAMActivate github:scrooloose/nerdtree

" Buffer helper
VAMActivate Buffergator

" Syntax plugins
VAMActivate vim-css3-syntax
VAMActivate html5
"VAMActivate Markdown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hidden                                                " don't unload buffer when switching away
set modeline                                              " allow per-file settings via modeline
set secure                                                " disable unsafe commands in local .vimrc files
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8  " saving and encoding
set nobackup nowritebackup noswapfile autoread            " no backup or swap
set hlsearch incsearch ignorecase smartcase               " search
set wildmenu                                              " completion
set backspace=indent,eol,start                            " sane backspace
"set clipboard=unnamed,unnamedplus                         " use the system clipboard for yank/put/delete
"set mouse=a                                               " enable mouse for all modes settings
set nomousehide                                           " don't hide the mouse cursor while typing
set mousemodel=popup                                      " right-click pops up context menu
set ruler                                                 " show cursor position in status bar
set number                                                " show absolute line number of the current line
set nofoldenable                                          " I fucking hate code folding
set scrolloff=10                                          " scroll the window so we can always see 10 lines around the cursor
"set textwidth=120                                          " wrap at 80 characters like a valid human
"set cursorline                                            " highlight the current line
"set cursorcolumn                                          " highlight the current column
set printoptions=paper:a4                                 " use A4 as the print output format
set guioptions-=T                                         " turn off GUI toolbar (icons)
set guioptions-=r                                         " turn off GUI right scrollbar
set guioptions-=L                                         " turn off GUI left scrollbar
set winaltkeys=no                                         " turn off stupid fucking alt shortcuts
set laststatus=2                                          " always show status bar
set list                                                  " Show invisible characters
set showcmd                                               " the bottom line in your editor will show you information about the current command going on
set nowrap                                                " don't wrap lines


" check the parent directories for tags, too.
set tags=./tags,tags;$HOME

" middle-click paste
noremap! <s-insert> <middlemouse>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set background=dark
set t_Co=256 " 256 colors in terminal

if has('gui_gnome')
  set guifont=Ubuntu\ Mono\ 8.4
endif


" Tweaks for Molokai colorscheme (ignored if Molokai isn't used)
let g:molokai_original=1
let g:rehash256=1

" Use the first available colorscheme in this list
for scheme in [ 'solarized', 'molokai', 'desert' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor

" highlight the 80th column
"
" In Vim >= 7.3, also highlight columns 120+
if exists('+colorcolumn')
  " (I picked 120-320 because you have to provide an upper bound and 500 seems
  " to be enough.)
  "let &colorcolumn="80,".join(range(120,500),",")
  let &colorcolumn="80"
else
  " fallback for Vim < v7.3
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" List chars
set listchars=""             " Reset the listchars
set listchars=tab:\ \        " a tab should display as " ", trailing whitespace as "."
set listchars+=trail:.       " show trailing spaces as dots
set listchars+=extends:>     " The character to show in the last column when wrap is
                             " off and the line continues beyond the right of the screen
set listchars+=precedes:<    " The character to show in the first column when wrap is
                             " off and the line continues beyond the left of the screen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType make setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Helpers and Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline_powerline_fonts = 1

"" vimwiki
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.mkd': 'markdown', '.wiki': 'media'}

"" fugitive shortcuts
noremap \gs :Gstatus<cr>
noremap \gc :Gcommit<cr>
noremap \ga :Gwrite<cr>
noremap \gl :Glog<cr>
noremap \gd :Gdiff<cr>
noremap \gb :Gblame<cr>

"" UltiSnips
"let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsExpandTrigger="<F3>"
let g:UltiSnipsListSnippets="<F2>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"" CtrlP
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

"" Buffergator
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","

" paste mode toggle
set pastetoggle=<f4>

" toggle number
nmap <F5> :set number! number?<CR>

" NERDtree
map <leader>r :NERDTreeFind<cr>
map <leader>rc :NERDTreeClose<cr>

" buffer
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
"nmap <leader>bl :ls<CR>

" window splitting
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>

" buffer splitting
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

" buffer splitting navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specific File Types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set indenting for puppet files
autocmd FileType puppet setlocal shiftwidth=4 tabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load a host specific file
if filereadable(expand("$HOME/.vim/vimrc.local"))
  source $HOME/.vim/vimrc.local
endif

" Load .private_dotfiles vim config
if filereadable(expand("$HOME/.vimrc.private"))
  source $HOME/.vimrc.private
endif


"  " *:VimwikiTagsearch*
"  " *:VWT* /pattern/
"  "     Search for /^Tags: *\(pattern\)$/ in all files of current wiki.
"  "     This is useful for maintaining "Tags" metadata on across
"  "     all wiki pages.  Navigate matches using same commands
"  "     as for VimwikiSearch. Example: "VWT xxx\|yyy"
"
"  exe 'au FileType vimwiki command! -buffer -nargs=* VimwikiTagsearch lvimgrep "^tags: .*\(<args>\)" '.
"        \ escape(VimwikiGet('path').'**/*'.VimwikiGet('ext'), ' ')
"  exe 'au FileType vimwiki command! -buffer -nargs=* VWT lvimgrep "^tags: .*\(<args>\)" '.
"        \ escape(VimwikiGet('path').'**/*'.VimwikiGet('ext'), ' ')
"
"  " *:VimwikiUntagged*
"  " *:VWU*
"  "     Search for /^Tags: *$/ in all files of current wiki.
"  "     This is useful for maintaining "Tags" metadata on across
"  "     all wiki pages.  Navigate matches using same commands
"  "     as for VimwikiSearch.
"
"  exe 'au FileType vimwiki command! -buffer VimwikiUntagged lvimgrep "^tags: *$" '.
"        \ escape(VimwikiGet('path').'**/*'.VimwikiGet('ext'), ' ')
"  exe 'au FileType vimwiki command! -buffer VWU lvimgrep "^tags: *$" '.
"        \ escape(VimwikiGet('path').'**/*'.VimwikiGet('ext'), ' ')
