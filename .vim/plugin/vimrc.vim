" Turn on line numbers
set number

" Let yourself jump from unsaved files, as explained here:
" https://stackoverflow.com/a/2414883/622049
"
" You typically need this when you're jumping from file to file with tags.
set hidden

" Disable the arrow keys (to remove the bad habit of using them)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Always use four spaces for a tab
" https://stackoverflow.com/a/234578
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Keep copied text on the clipboard when you exit VIM:
" https://stackoverflow.com/a/9381778
autocmd VimLeave * call system("xsel -ib", getreg('+'))
" This variation is your own
autocmd VimLeave * call system("xsel -ip", getreg('*'))

" Vundle setup, as described here:
" https://github.com/VundleVim/Vundle.vim
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" You also tried this, but it was very hard to setup:
" http://clang.llvm.org/docs/ClangFormat.html#vim-integration
"
" If you installed clang-format with the ubuntu package manager, you need to
" make sure you update the path to clang-format.py based on which clang-format
" package you installed:
" https://askubuntu.com/questions/730609/how-can-i-find-the-directory-to-clang-format
"
" There is a Python interpreter compiled into VIM:
" https://stackoverflow.com/questions/45217522
"
" It looks like it is a Python3 interpreter now:
" https://askubuntu.com/a/821235/612216
" https://reviews.llvm.org/D23319
"
" So, you can’t really use the default clang-format.py installed with ubuntu
" (it’s written for Python2).
Plugin 'rhysd/vim-clang-format'
autocmd FileType c,cpp ClangFormatAutoEnable

" ALE will find whatever linters you have installed.
Plugin 'w0rp/ale'

call vundle#end()            " required
filetype plugin indent on    " required

" These lines let you quickly navigate between errors:
" https://github.com/w0rp/ale#faq-navigation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

set tags=./tags;,tags;

" You select keys to map using :help map-which-keys as suggested here:
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)
:map <F2> :set syn=cpp<CR>
