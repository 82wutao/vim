
set nocompatible
set history=1000                          "Vim 需要记住多少次历史操作。

set lazyredraw                            " 延迟绘制（提升性能）
set winaltkeys=no                         " Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）

set noerrorbells                          "出错时，不要发出响声。
set novisualbell                          "出错时，发出视觉提示，通常是屏幕闪烁。
set noautochdir                           "自动切换工作目录。这主要用在一个 Vim 会话之中打开多个文件的情况，默认的工作目录是打开的第一个文件的目录。该配置可以将工作目录自动切换到，正在编辑的文件的目录。
set autoread                              "打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。
" set backup                              " 允许备份
" set writebackup                         " 保存时备份
" set backupdir=~/.vim/tmp                " 备份文件地址，统一管理
" set backupext=.bak                      " 备份文件扩展名
" set noswapfile                          " 禁用交换文件
" set noundofile                          " 禁用 undo文件



set showmatch                             " 显示匹配的括号
set matchtime=2                           " 显示括号匹配的时间

set scrolloff=5                           "垂直滚动时，光标距离顶部/底部的位置（单位：行）。
set sidescrolloff=15                      "水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用。
set splitright                            " 水平切割窗口时，默认在右边显示新窗口



" editing
set nospell spelllang=en_us "打开英语单词的拼写检查。
set nobackup "不创建备份文件。默认情况下，文件保存时，会额外创建一个备份文件，它的文件名是在原文件名的末尾，再添加一个波浪号（〜）。
set noswapfile "不创建交换文件。交换文件主要用于系统崩溃时恢复文件，文件名的开头是.、结尾是.swp。
set noundofile "保留撤销历史。保留撤销历史。
" set backupdir=~/.vim/.backup//  "结尾的//表示生成的文件名带有绝对路径，路径中用%替换目录分隔符，这样可以防止文件重名。
" set directory=~/.vim/.swp//     "结尾的//表示生成的文件名带有绝对路径，路径中用%替换目录分隔符，这样可以防止文件重名。
" set undodir=~/.vim/.undo//      "结尾的//表示生成的文件名带有绝对路径，路径中用%替换目录分隔符，这样可以防止文件重名。


" 这里就不设置了，airline 插件会覆盖
" set showtabline=2                       " 总是显示标签栏
" set laststatus=2                        "是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示。
" set statusline=                         " 清空状态了
" set statusline+=\ %F                    " 文件名 
" set statusline+=\ [%1*%M%*%n%R%H]       " buffer 编号和状态
" set statusline+=%=                      " 向右对齐
" set statusline+=\ %y                    " 文件类型
" 
" " 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
" set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)

" set ruler                                  "在状态栏显示光标的当前位置（位于哪一行哪一列）。
" set showmode
"

" search
set showmatch "光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号。
set hlsearch "搜索时，高亮显示匹配结果。
set incsearch " 输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果。
set ignorecase "搜索时忽略大小写。
set smartcase "如果同时打开了ignorecase，那么对于只有一个大写字母的搜索词，将大小写敏感；其他情况都是大小写不敏感。比如，搜索Test时，将不匹配test；搜索 test时，将匹配Test。

"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

" syntax
if has('syntax')
    syntax enable
    syntax on
endif


" txt show format
set formatoptions+=m                      " 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=B                      " 合并两行中文时，不在中间加空格
set ffs=unix,dos,mac                      " 文件换行符，默认使用 unix 换行符

set textwidth=120                         "设置行宽，即一行显示多少个字符
set linebreak                             "只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行。也就是说，不会在单词内部折行。
set wrap                                  "自动折行，即太长的行分成几行显示。
set wrapmargin=2                          "指定折行处与编辑窗口的右边缘之间空出的字符数。
set list                   "如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块。
set listchars=tab:›\ ,trail:•,extends:>,precedes:<,nbsp:.  ",eol:$ 空格等无效字符显示.set listchars=tab:»■,trail:■
set foldmethod=indent
set foldlevel=99


"----------------------------------------------------------------
" 编码设置
"----------------------------------------------------------------


" 解决菜单乱码
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim

" 解决consle输出乱码
"set termencoding = cp936  

" 设置中文提示
" language messages zh_CN.utf-8 



if has('multi_byte')
	" 在与屏幕/键盘交互时使用的编码(取决于实际的终端的设定)        
	set encoding=utf-8
	set langmenu=zh_CN.UTF-8

	" 设置打开文件的编码格式  
	set fileencoding=utf-8                                         " 文件默认编码
	set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1 " 打开文件时自动尝试下面顺序的编码
endif
" 设置中文帮助
set helplang=cn

"设置为双字宽显示，否则无法完整显示如:☆
" set ambiwidth=double



" indent and \tab
" filetype plugin indent on               "Vim 就是会找 Python 的缩进规则~/.vim/indent/python.vim
set shiftwidth=4                          "在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数。
set shiftround                            "表示缩进列数对齐到shiftwidth的整数倍"
" set smarttab                             表示插入tab 时使用shiftwidth"
" set smarttab                             这里不用智能是因为我们要控制 插入模式下\t 移动的距离
set expandtab                             "由于 Tab 键在不同的编辑器缩进不一致，该设置自动将 Tab 转为空格。
set softtabstop=4                         "Tab 转为多少个空格。
set tabstop=4                             "按下 Tab 键时，Vim 显示的空格数。
set autoindent                            " 按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致。
"set smartindent 设置新行，智能缩进，主要用于C语言一族。在smartindent模式下，每行缩进相同，直到}为止"
set nosmarttab nocindent nosmartindent
 
 
set title
set display=lastline                      " 显示最后一行
set signcolumn=yes                        " 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set number 
set norelativenumber                      "其他行相对当前
set showcmd
set cmdheight=1                           " 命令行（在状态行下）的高度，默认为1，这里是2
set wildmenu
set wildmode=longest:list,full            "命令模式下，底部操作指令按下 Tab 键自动补全。第一次按下 Tab，会显示所有匹配的操作指令的清单；第二次按下 Tab，会依次选择各个指令。
set cursorline                            "当前行高亮
"set cursorcolumn                        " 突出显示当前列

set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m    " 错误格式

filetype on
filetype plugin indent on

" 设置consolas字体"前面已经设置过
set guifont=Consolas\ for\ Powerline\ FixedD:h11

set t_Co=256
set t_ut=                                 " 防止vim背景颜色错误

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
    hi! SpellBad gui=undercurl guisp=red
    hi! SpellCap gui=undercurl guisp=blue
    hi! SpellRare gui=undercurl guisp=magenta
    hi! SpellRare gui=undercurl guisp=cyan
else
    hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
    hi! SpellCap term=underline cterm=underline
    hi! SpellRare term=underline cterm=underline
    hi! SpellLocal term=underline cterm=underline
endif

"去掉 sign column 的白色背景
hi! SignColumn guibg=NONE ctermbg=NONE 
" 修正补全目录的色彩：默认太难看
hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
" 修改行号为浅灰色，默认主题的黄色行号很难看，换主题可以仿照修改
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight Normal ctermbg=None
highlight clear SignColumn

set termguicolors
set background=dark

colorscheme gruvbox

let g:PaperColor_Theme_Options = {
            \ 'theme':{
            \ 'default':{
            \ 'transparent_background':0,
            \ 'override':{},
            \ 'allow_bold':0,
            \ 'allow_italic':0,
            \ }
            \ },
            \ 'language':{
            \ 'python':{'highlight_builtins':1},
            \ 'cpp':{'highlight_standard_library':1},
            \ 'c':{'highlight_builtins':1},
            \ 'go':{'highlight_builtins':1},
            \ 'sh':{}
            \ }
            \ }


set pyxversion=3
let g:python3_host_prog="/usr/bin/python3"





