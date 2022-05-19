""  
""  3.1. Customisation summary                             *NERDTreeSettingsSummary*
""  |loaded_nerd_tree|                     Turns off the script.
""  If this plugin is making you feel homicidal, it may be a good idea to turn it off with this line in your vimrc: >
"" let g:loaded_nerd_tree=1
""  ------------------------------------------------------------------------------
""  |NERDTreeAutoCenter|                   Controls whether the NERDTree window centers when the cursor moves within a specified distance to the top/bottom of the window.
""  |NERDTreeAutoCenterThreshold|          Controls the sensitivity of autocentering.
let g:NERDTreeAutoCenter=1             "1/0
let g:NERDTreeAutoCenterThreshold=4   
""  ------------------------------------------------------------------------------
""  |NERDTreeCaseSensitiveSort|            Tells the NERDTree whether to be case sensitive or not when sorting nodes.
""  |NERDTreeNaturalSort|                  Tells the NERDTree whether to use natural sort order or not when sorting nodes.
""  |NERDTreeSortHiddenFirst|              Tells the NERDTree whether to take the dot at the beginning of the hidden file names into account when sorting nodes.
""  |NERDTreeSortOrder|                    Tell the NERDTree how to sort the nodes in the tree.
let g:NERDTreeCaseSensitiveSort =1     " 1/0
let g:NERDTreeNaturalSort=0            " 1/0
let g:NERDTreeSortHiddenFirst=0        " 1/0
let g:NERDTreeSortOrder=['\/$', '*', '\.swp$',  '\.bak$', '\~$']
""  ------------------------------------------------------------------------------
""  |NERDTreeChDirMode|                    Tells the NERDTree if/when it should change vim's current working directory.
""  |NERDTreeUseTCD|                       Tells the NERDTree use 'cd' or 'tcd' to change the current working directory
let g:NERDTreeChDirMode =1             " 0 never chagne 
                                     " 1 change when nerdtree loaded first and fix 
                                     " 2 change when nerdtree loaded first and change
                                     " 3 the CWD is changed whenever changing tabs to whatever the tree root is on that tab.
let g:NERDTreeUseTCD =1
""  ------------------------------------------------------------------------------
""  |NERDTreeHighlightCursorline|          Tell the NERDTree whether to highlight the current cursor line.
let g:NERDTreeHighlightCursorline =1
""  ------------------------------------------------------------------------------
""  |NERDTreeHijackNetrw|                  Tell the NERDTree whether to replace the netrw autocommands for exploring local directories.
let g:NERDTreeHijackNetrw =0
""  ------------------------------------------------------------------------------
""  |NERDTreeIgnore|                       Tells the NERDTree which files to ignore.
let g:NERDTreeIgnore=[]
let g:NERDTreeIgnore=['\.vim$[[dir]]', '\.o$[[file]]', 'tmp/cache$[[path]]','\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']    " 忽略一下文件的显示
""  ------------------------------------------------------------------------------
""  |NERDTreeRespectWildIgnore|            Tells the NERDTree to respect `'wildignore'`.
let g:NERDTreeRespectWildIgnore=1
""  ------------------------------------------------------------------------------
""  |NERDTreeBookmarksFile|                Where the bookmarks are stored. Default: $HOME/.NERDTreeBookmarks
""  |NERDTreeMarkBookmarks|                Render bookmarked nodes with markers.

""  |NERDTreeShowBookmarks|                Tells the NERDTree whether to display the bookmarks table on startup.
""  |NERDTreeBookmarksSort|                Control how the Bookmark table is sorted.
let g:NERDTreeBookmarksSort=2 " 0 not sorted ;1sorted in a case-insensitive 2sorted in a case-sensitive 
let g:NERDTreeMarkBookmarks=0
let g:NERDTreeShowBookmarks=0
""  ------------------------------------------------------------------------------
""  |NERDTreeMouseMode|                    Manage the interpretation of mouse clicks.
""                                                               *NERDTreeMouseMode*
let g:NERDTreeMouseMode=1   " 1 double any node;2 single dir double file;3 single any
""  ------------------------------------------------------------------------------
""  |NERDTreeQuitOnOpen|                   Closes the tree window or bookmark table after opening a file.
let g:NERDTreeQuitOnOpen=0
""   -------+-------------------------------------------------------
""   0      | No change
""   1      | Closes after opening a file
""   2      | Closes the bookmark table after opening a bookmark
""   3(1+2) | Same as both 1 and 2
""  ------------------------------------------------------------------------------
""  |NERDTreeShowFiles|                    Tells the NERDTree whether to display files in the tree on startup.
""  |NERDTreeShowHidden|                   Tells the NERDTree whether to display hidden files on startup.
let g:NERDTreeShowFiles=1
let g:NERDTreeShowHidden=1
""  ------------------------------------------------------------------------------
""  |NERDTreeShowLineNumbers|              Tells the NERDTree whether to display line numbers in the tree window.
""  |NERDTreeStatusline|                   Set a statusline for NERDTree windows.
let g:NERDTreeShowLineNumbers=0
let g:NERDTreeStatusline=-1 " Values: Any valid `'statusline'` setting.  Default: %{exists('b:NERDTree')?b:NERDTree.root.path.str():''}
""  ------------------------------------------------------------------------------
""  |NERDTreeWinPos|                       Tells the script where to put the NERDTree window.
""  |NERDTreeWinSize|                      Sets the window size when the NERDTree is opened.
""  |NERDTreeWinSizeMax|                   Sets the maximum window size when the NERDTree is zoomed.
let g:NERDTreeWinPos="left" " left or right
let g:NERDTreeWinSize=31
let g:NERDTreeWinSizeMax=40
""  ------------------------------------------------------------------------------
""  |NERDTreeMinimalUI|                    Disables display of the 'Bookmarks' label and 'Press ? for help' text.
""  |NERDTreeMinimalMenu|                  Use a compact menu that fits on a single line for adding, copying, deleting, etc
""                                                               *NERDTreeMinimalUI*
let g:NERDTreeMinimalUI=0 "disables the 'Bookmarks' label 'Press ? for help' text.
let g:NERDTreeMinimalMenu=0
""  ------------------------------------------------------------------------------
""  |NERDTreeCascadeSingleChildDir|        Collapses on the same line directories that have only one child directory.
""  |NERDTreeCascadeOpenSingleChildDir|    Cascade open while selected directory has only one child that also is a directory.
let g:NERDTreeCascadeSingleChildDir=1
let g:NERDTreeCascadeOpenSingleChildDir=1
""  ------------------------------------------------------------------------------
""  |NERDTreeAutoDeleteBuffer|             Tells the NERDTree to automatically remove a buffer when a file is being deleted or renamed via a context menu command.
let g:NERDTreeAutoDeleteBuffer=1
""  ------------------------------------------------------------------------------
""  |NERDTreeCreatePrefix|                 Specify a prefix to be used when creating the NERDTree window.
let g:NERDRreddCreatePrefix='silent' " silent keepalt keepjumps
""  ------------------------------------------------------------------------------
""  |NERDTreeRemoveFileCmd|                Specify a custom shell command to be used when deleting files. Note that it should include one space character at the end of the command and it applies only to files.
""  |NERDTreeRemoveDirCmd|                 Specify a custom shell command to be used when deleting directories. Note that it should include one space character at the end of the command and it applies only to directories.
""  ------------------------------------------------------------------------------
""  |NERDTreeDirArrowCollapsible|          These characters indicate when a directory is
""  |NERDTreeDirArrowExpandable|           either collapsible or expandable.
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"
""  ------------------------------------------------------------------------------
""  |NERDTreeNodeDelimiter|                A single character that is used to separate the file or directory name from the rest of the characters on the line of text.
let g:NERDTreeNodeDelimiter="\u00b7"   "middle dot
""  ------------------------------------------------------------------------------
""  |NERDTreeCustomOpenArgs|               A dictionary with values that control how a node is opened with the |NERDTree-<CR>| key.
""  
""                                                          *NERDTreeCustomOpenArgs*
""  Values: A nested dictionary, as described below
""  Default: {'file': {'reuse': 'all', 'where': 'p'}, 'dir': {}}
""  
""  This dictionary contains two keys, 'file' and 'dir', whose values each are
""  another dictionary. The inner dictionary is a set of parameters used by
""  |NERDTree-<CR>| to open a file or directory. Setting these parameters allows you
""  to customize the way the node is opened. The default value matches what
""  |NERDTree-o| does. To change that behavior, use these keys and
""  values in the inner dictionaries:
""  
""  'where':    specifies whether the node should be opened in a new split ("h" or
""              "v"), in a new tab ("t") or, in the last window ("p").
""  'reuse':    if file is already shown in a window, jump there; takes values
""              "all", "currenttab", or empty
""  'keepopen': boolean (0 or 1); if true, the tree window will not be closed
""  'stay':     boolean (0 or 1); if true, remain in tree window after opening
""  
""  For example:
""  To open files and directories (creating a new NERDTree) in a new tab, >
""      {'file':{'where': 't'}, 'dir':{'where':'t'}}
""  <
""  To open a file always in the current tab, and expand directories in place, >
""      {'file': {'reuse':'currenttab', 'where':'p', 'keepopen':1, 'stay':1}}









" " Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree
" " Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" " Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" " Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" " Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif



" " Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" " Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
" " Mirror the NERDTree before showing it. This makes it the same on all tabs.
" nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>


" let g:NERDTreeDirArrows = 1
let g:NERDTreeKeepTreeInNewTab=1

"修改树的显示图标
let g:NERDTreeGitStatusIndicatorMapCustom ={
            \ "Modified"  : "Mdf",
            \ "Staged"    : "Stg",
            \ "Untracked" : "Utr",
            \ "Renamed"   : "Rnm",
            \ "Unmerged"  : "Umg",
            \ "Deleted"   : "Del",
            \ "Dirty"     : "Dty",
            \ "Clean"     : "Cln",
            \ "Ignored"   : "Ign",
            \ "Unknown"   : "Ukn"
            \ }

let g:NERDTreeGitStatusUseNerdFonts = 0 " you should install nerdfonts by yourself.  default: 0
let g:NERDTreeGitStatusShowIgnored = 0 " a heavy feature may cost much more time.  default: 0
let g:NERDTreeGitStatusUntrackedFilesMode = 'normal' " all is a heavy feature too.  default: normal
"let g:NERDTreeGitStatusGitBinPath = '/your/file/path' " default: git (auto find in path)
let g:NERDTreeGitStatusShowClean = 1 " default: 0
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0 DO NOT enable this feature if you have also installed vim-devicons.

nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>
noremap <leader>f :NERDTreeFind<CR>

