call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'


Plug 'junegunn/vim-plug'

Plug 'mhinz/vim-startify'                                          " cowsay and 数字键打开历史文件

Plug 'altercation/vim-colors-solarized'
Plug 'mavnn/mintty-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'Shougo/deoplete-clangx'
" Plug 'Shougo/neoinclude.vim'
Plug 'xavierd/clang_complete'
Plug 'davidhalter/jedi-vim'


Plug 'godlygeek/tabular'                                           " 必要插件，安装在vim-markdown前面
Plug 'plasticboy/vim-markdown', { 'for': ['markdown','md'] }

Plug 'dense-analysis/ale'                                          " 代码静态检查，代码格式修正, 见配置并需要安装各语言依赖, 如flake8

Plug 'cdelledonne/vim-cmake'




Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'itchyny/vim-cursorword'                                      " 给光标下的单词增加下滑线
Plug 'romainl/vim-cool'                                            " 当移动后取消所有search的高亮文本


call plug#end()

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

command! -nargs=1 LoadScript exec 'so '.s:home.'/'.'<args>'

exec 'set rtp+='.s:home
set rtp+=~/.vim

function! s:path(path)
    let path = expand(s:home . '/' . a:path )
    return substitute(path, '\\', '/', 'g')
endfunc

" source ~/vimconf/plug/airline.vim
" source ~/vimconf/plug/complete.vim
" source ~/vimconf/plug/startpage.vim
" source ~/vimconf/plug/ctrlP.vim
" source ~/vimconf/plug/git.vim
" source ~/vimconf/plug/effective.vim
" source ~/vimconf/plug/lint.vim
" source ~/vimconf/plug/markdown.vim
" source ~/vimconf/plug/cmake.vim
" source ~/vimconf/plug/filer.vim

LoadScript plug/airline.vim
LoadScript plug/complete.vim
LoadScript plug/startpage.vim
LoadScript plug/ctrlP.vim
LoadScript plug/git.vim
LoadScript plug/effective.vim
LoadScript plug/lint.vim
LoadScript plug/markdown.vim
LoadScript plug/cmake.vim
LoadScript plug/filer.vim
" 
" 
" 
" source ~/vimconf/conf/setting.vim
LoadScript conf/setting.vim
