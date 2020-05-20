set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" code folding plugin
Plugin 'tmhedberg/SimpylFold'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
" Smart auto-indentation for Python
Plugin 'vim-scripts/indentpython.vim'
"supertab
Plugin 'ervandew/supertab'
" Auto-completing engine
Plugin 'Valloric/YouCompleteMe'
" Syntax checker
Plugin 'vim-syntastic/syntastic'
" Python backend for 'syntastic'
"Plugin 'nvie/vim-flake8'
" Status bar (powerline)
Plugin 'vim-airline/vim-airline'
" Awesome staring screen for Vim
Plugin 'mhinz/vim-startify'
" File manager
Plugin 'scrooloose/nerdtree'
" Search bar
Plugin 'kien/ctrlp.vim'
" Theme
Plugin 'crusoexia/vim-monokai'
" Powerful commenting utility
Plugin 'scrooloose/nerdcommenter'
" Rich python syntax highlighting
Plugin 'kh3phr3n/python-syntax'
" Buffer bar
Plugin 'bling/vim-bufferline'
" auto focus events"
Plugin 'tmux-plugins/vim-tmux-focus-events'
" Markdown Preview
Plugin 'JamshedVesuna/vim-markdown-preview'
"Auto Format"
Plugin 'Chiel92/vim-autoformat'
"isort"
Plugin 'fisadev/vim-isort'



" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

" pep 8
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

" make code look pretty
let python_highlight_all=1
syntax on
set background=dark

" color schemes
if has('gui_running')
   set background=dark
   set termguicolors
   colorscheme deep-space 
   let g:deepspace_italics=1
else
   colorscheme challenger_deep
endif
" F5 toggle
call togglebg#map("<F5>")

" hide pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" line numbers
set nu

" system clipboard
set clipboard=unnamed

" set mouse mode
set mouse=a

" python with virtualenv support
" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('pipenv --venv')
" The above system() call produces a non zero exit code whenever
" a proper virtual environment has not been found.
" So, second, we only point YCM to the virtual environment when
" the call to 'pipenv --venv' was successful.
" Remember, that 'pipenv --venv' only points to the root directory
" of the virtual environment, so we have to append a full path to
" the python executable.
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
else
  let g:ycm_python_binary_path = 'python'
endif

" system clipboar
set clipboard=unnamedplus

" Start nerdtree
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()

" bufferline
let g:airlineextensionsbufferlineenabled = 1
let g:airlineextensionsbufferlineoverwrite_variables = 1

" terminal 
function! ExitNormalMode()
    unmap <buffer> <silent> <RightMouse>
    call feedkeys("a")
endfunction

function! EnterNormalMode()
    if &buftype == 'terminal' && mode('') == 't'
        call feedkeys("\<c-w>N")
        call feedkeys("\<c-y>")
        map <buffer> <silent> <RightMouse> :call ExitNormalMode()<CR>
    endif
endfunction

tmap <silent> <ScrollWheelUp> <c-w>:call EnterNormalMode()<CR>


" setup auto read and write
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" markdown using grip
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"auto flake 8 
"autocmd BufWritePost *.py call flake8#Flake8()

"auto pep 8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
" add more aggressive options (--aggressive --aggressive)
let g:autopep8_aggressive=2
let g:autopep8_pep8_passes=100
let g:autopep8_max_line_length=79

"tabs stuff
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

"nerdtree cd
let g:NERDTreeChDirMode = 2
" issort stuff
nnoremap <C-i> :Isort<CR>
let g:vim_isort_python_version = 'python3'
