"--------------------------------------------------------------------------
"vim-airline
"--------------------------------------------------------------------------
"  
"  " let g:airline_section_c = airline#section#create(['tagbar'])
"  " let g:airline_section_b = '%{strftime("%d/%m %H:%M")}'
"  " let g:airline_section_x = '%{expand("%")}'  " 显示文件名
"  " let g:airline_section_y = airline#section#create(['%{strftime("%D")}'])
"  " let g:airline_section_z = airline#section#create(['%{strftime("%m-%d %H:%M ")}', 'linenr', 'maxlinenr'])
"  
"  " let g:airline_skip_empty_sections=1
"  let g:airline_skip_empty_sections = 0
"  
"  
"  " ~/full/path-to/file-name.js
"  let g:airline#extensions#tabline#formatter = 'jsformatter' " path-to/f
"  " let g:airline#extensions#tabline#formatter = 'default'  " f/p/file-name.js
"  " let g:airline#extensions#tabline#formatter = 'unique_tail' " file-name.js
"  " let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " f/p/file-name.js
"  
"  
"  let g:airline#extensions#ale#enabled = 1
"  let g:airline#extensions#branch#enabled = 1
"  let g:airline#extensions#tagbar#enabled = 1
"  let g:airline#extensions#keymap#enabled = 1
"  let g:airline#extensions#whitespace#enabled=0
"  
"  
"  
" =========================
" +---------------------------------------------------------------------------
" + | A | B |                     C                          X | Y | Z |  [...] | 
" +---------------------------------------------------------------------------+ 
"
" A      displays mode + additional flags like crypt/spell/paste (INSERT)
" B      VCS information (branch, hunk summary) (master)
" C      filename + read-only flag (~/.vim/vimrc RO)
" X      filetype  (vim)
" Y      file encoding[fileformat] (utf-8[unix])
"        optionally may contain Byte Order Mark [BOM] and missing end of last
"        line [!EOL]
" Z      current position in the file
"            percentage % ln: current line/number of lines ☰ cn: column
"            So this: 10% ln:10/100☰ cn:20          
"            means:   
"                10%     - 10 percent 
"                ln:     - line number is
"                10/100☰ - 10 of 100 total lines
"                cn:     - column number is
"                20      - 20
" [...]  additional sections (warning/errors/statistics)
"        from external plugins (e.g. YCM/syntastic/...)       

" The following list of parts are predefined by vim-airline.
" `mode`         displays the current mode
" `iminsert`     displays the current insert method
" `paste`        displays the paste indicator
" `crypt`        displays the crypted indicator
" `spell`        displays the spell indicator
" `filetype`     displays the file type
" `readonly`     displays the read only indicator
" `file`         displays the filename and modified indicator
" `path`         displays the filename (absolute path) and modifier indicator
" `linenr`       displays the current line number
" `maxlinenr`    displays the number of lines in the buffer
" `ffenc`        displays the file format and encoding

"  `ale_error_count` `ale_warning_count` `branch` `eclim` `hunks`
"  `languageclient_error_count` `languageclient_warning_count` `lsp_error_count`
"  `lsp_warning_count``neomake_error_count` `neomake_warning_count`
"  `nvimlsp_error_count` `nvimlsp_warning_count` `obsession`
"  `syntastic-warn` `syntastic-err` `tagbar` `whitespace` `windowswap`
"  `ycm_error_count` `ycm_warning_count`
  
" mode; cur_dir,editing_file_path; file_type; encoding;row,clmn;...
" ============================================================================
" [ 'a', 'b', 'c' ], [ 'x', 'y', 'z', 'error', 'warning','statistics' ]
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ]
      \ ]  

" let g:airline#extensions#default#section_truncate_width = {
"   \ 'b': 79,
"   \ 'x': 60,
"   \ 'y': 88,
"   \ 'z': 45,
"   \ 'warning': 80,
"   \ 'error': 80,
"   \ }
let g:airline_section_a = airline#section#create(['mode', 'crypt'])
let g:airline_section_b = airline#section#create_left(['branch','hunks'])
let g:airline_section_c = airline#section#create(['%{getcwd()}','  ','file'])
let g:airline_section_x = airline#section#create(['ffenc',' ','bom',' ', 'eol' ])
let g:airline_section_y = airline#section#create(['%p',' ','linenr', 'maxlinenr','colnr'])
let g:airline_section_z = airline#section#create(['filetype',' '])


" let g:airline_section_b = '%-0.10{getcwd()}'
"let g:airline_section_c = '%t'

let g:airline_section_c_only_filename = 0
let g:airline_stl_path_style = 'short'   
" let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' 
"    variable names                default contents
"    ---------------------------------------------------------------------------
"    let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
"    let g:airline_section_b       (hunks, branch)[*]
"    let g:airline_section_c       (bufferline or filename, readonly)
"    let g:airline_section_gutter  (csv)
"    let g:airline_section_x       (tagbar, filetype, virtualenv)
"    let g:airline_section_y       (fileencoding, fileformat, 'bom', 'eol')
"    let g:airline_section_z       (percentage, line number, column number)
"    let g:airline_section_error   (ycm_error_count, syntastic-err, eclim, languageclient_error_count)
"    let g:airline_section_warning (ycm_warning_count, syntastic-warn, languageclient_warning_count, whitespace)   


" let airline#extensions#default#section_use_groupitems = 1
" Currently: Enable Vim9 Script implementation
" let g:airline_experimental = 0

let g:airline_theme="molokai" 
"  " :AirlineTheme tomorrow
"  " :AirlineTheme automic


let g:airline_detect_modified=1  
let g:airline_detect_paste=1  
let g:airline_detect_crypt=1    
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1  
let g:airline_detect_iminsert=0  

let g:airline_inactive_collapse=1
let g:airline_inactive_alt_sep=1

let g:airline_powerline_fonts = 1 
let g:airline_symbols_ascii = 1

let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ } 
let g:airline_filetype_overrides = {
    \ 'coc-explorer':  [ 'CoC Explorer', '' ],
    \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
    \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
    \ 'floggraph':  [ 'Flog', '%{get(b:, "flog_status_summary", "")}' ],
    \ 'gundo': [ 'Gundo', '' ],
    \ 'help':  [ 'Help', '%f' ],
    \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
    \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
    \ 'startify': [ 'startify', '' ],
    \ 'vim-plug': [ 'Plugins', '' ],
    \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
    \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
    \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
    \ }    
    
    
let g:airline_exclude_filenames = [] " see source for current list 
let g:airline_exclude_filetypes = [] " see source for current list 
let g:airline_exclude_preview = 0  

" let w:airline_disable_statusline = 1
" let b:airline_disable_statusline = 1 
" let g:airline_disable_statusline = 1  
let g:airline_statusline_ontop = 0  

" let w:airline_skip_empty_sections = 0  
let g:airline_skip_empty_sections = 0

let g:airline_highlighting_cache = 0
let g:airline_focuslost_inactive = 0


let g:airline_left_sep='>'
let g:airline_right_sep='<'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
" let g:airline_left_sep = '»'
" let g:airline_right_sep = '«'
let g:airline_left_alt_sep='»'
let g:airline_right_alt_sep='«'

let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.colnr = ' :'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ' :'
" let g:airline_symbols.maxlinenr = '☰ '
" let g:airline_symbols.dirty='⚡'
" 
" " old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'

let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = ['branch', 'tabline']

let g:airline#extensions#vimcmake#enabled = 1

let g:airline#extensions#branch#enabled = 1  
let g:airline#extensions#branch#empty_message = 'not repository'    
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
let g:airline#extensions#branch#use_vcscommand = 0
let g:airline#extensions#branch#displayed_head_limit = 16
let g:airline#extensions#branch#sha1_len = 8
" 0 unmodifed /1 'feature/foo' becomes 'foo' /2'foo/bar/baz' becomes 'f/b/baz'
let g:airline#extensions#branch#format = 1 
let g:airline#extensions#branch#vcs_checks = ['untracked', 'dirty']  
let g:airline#extensions#branch#custom_head = 'GetScmBranch'
function! GetScmBranch()
  if !exists('b:perforce_client')
    let b:perforce_client = system('p4 client -o | grep Client')
    " Invalidate cache to prevent stale data when switching clients. Use a
    " buffer-unique group name to prevent clearing autocmds for other
    " buffers.
    exec 'augroup perforce_client-'. bufnr("%")
        au!
        autocmd BufWinLeave <buffer> silent! unlet! b:perforce_client
    augroup END
  endif
  return b:perforce_client
endfunction 

let g:airline#extensions#ctrlp#color_template = 'insert'  " insert / normal / visual / replace  
let g:airline#extensions#ctrlp#show_adjacent_modes = 1 

let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#searchcount#enabled = 1

let g:airline#extensions#hunks#enabled = 1  
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#hunks#coc_git = 0

let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'

let g:airline#extensions#tabline#ignore_bufadd_pat='!|defx|gundo|nerd_tree|startify|tagbar|term://|undotree|vimfiler'

let airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#excludes = []
let g:airline#extensions#tabline#exclude_preview = 1


let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''  

let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_nr_type = 0 " 0only splites 1only tabs 2 splites and tabs
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr' 
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#tab_min_count = 0  
  
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#formatter = 'short_path' " 'unique_tail' 'unique_tail_improved' 
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#buffer_min_count = 0

let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#close_symbol = 'X'

"  let airline#extensions#tabline#ignore_bufadd_pat = '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'  
let airline#extensions#tabline#disable_refresh = 0
let airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1 "1 1-9 / 2 11-99 / 3 01-99
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab   
let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '0 ',
      \ '1': '1 ',
      \ '2': '2 ',
      \ '3': '3 ',
      \ '4': '4 ',
      \ '5': '5 ',
      \ '6': '6 ',
      \ '7': '7 ',
      \ '8': '8 ',
      \ '9': '9 '
      \}  

let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree'] 

"function! airline#extensions#tabline#formatters#foo#format(bufnr, buffers)
"  return fnamemodify(bufname(a:bufnr), ':t')
"endfunction
"let g:airline#extensions#tabline#formatter = 'foo' 


let g:airline#extensions#tabline#tabtitle_formatter = 'MyTabTitleFormatter' 
function MyTabTitleFormatter(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnr = buflist[winnr - 1]
  let winid = win_getid(winnr, a:n)
  let title = bufname(bufnr)

  if empty(title)
    if getqflist({'qfbufnr' : 0}).qfbufnr == bufnr
      let title = '[Quickfix List]'
    elseif winid && getloclist(winid, {'qfbufnr' : 0}).qfbufnr == bufnr
      let title = '[Location List]'
    else
      let title = '[No Name]'
    endif
  endif

  return title
endfunction  

let g:airline#extensions#scrollbar#enabled = 0
let g:airline#extensions#taboo#enabled = 0
let g:airline#extensions#nrrwrgn#enabled = 0
let g:airline#extensions#omnisharp#enabled = 0    
let g:airline#extensions#battery#enabled = 0
let g:airline#extensions#bookmark#enabled = 0
let g:airline#extensions#denite#enabled = 0
let g:airline#extensions#dirvish#enabled = 0
let g:airline#extensions#eclim#enabled = 0
let g:airline#extensions#fern#enabled = 0
let g:airline#extensions#fzf#enabled = 0
let g:airline#extensions#grepper#enabled = 0
let g:airline#extensions#gina#enabled = 0
let g:airline#extensions#poetv#enabled = 0
let g:airline#extensions#term#enabled = 0
let g:airline#extensions#tabws#enabled = 0
let g:airline#extensions#unite#enabled = 0
let g:airline#extensions#vimagit#enabled = 0
let g:airline#extensions#gen_tags#enabled = 0
let g:airline#extensions#taglist#enabled = 0
let g:airline#extensions#nerdtree_statusline = 0
let g:airline#extensions#vista#enabled = 0

let g:airline#extensions#tmuxline#enabled = 0
let airline#extensions#tmuxline#color_template = 'normal' " 'insert' / 'visual' / 'replace' 
let airline#extensions#tmuxline#snapshot_file =  "~/.tmux-statusline-colors.conf"

let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tagbar#flags = ''  " f/s/p
let g:airline#extensions#tagbar#searchmethod = 'nearest-stl'  " 'nearest' / 'scoped-stl' 

let g:airline#extensions#lsp#enabled = 0
let airline#extensions#lsp#error_symbol = 'E:'
let airline#extensions#lsp#warning_symbol = 'W:'
let airline#extensions#lsp#show_line_numbers = 1
let airline#extensions#lsp#open_lnum_symbol = '(L'
let airline#extensions#lsp#close_lnum_symbol = ')'
let g:airline#extensions#lsp#progress_skip_time = 0.3 
let g:airline#extensions#nvimlsp#enabled = 0
let airline#extensions#nvimlsp#error_symbol = 'E:'
let airline#extensions#nvimlsp#warning_symbol = 'W:'
let airline#extensions#vim9lsp#enabled = 0
let airline#extensions#vim9lsp#error_symbol = 'E:' 
let airline#extensions#vim9lsp#warning_symbol = 'W:'
let g:airline#extensions#coc#enabled = 0
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#show_coc_status = 0        

let g:airline#extensions#vimtex#enabled = 0
let g:airline#extensions#vimtex#left = "{"
let g:airline#extensions#vimtex#right = "}"
let g:airline#extensions#vimtex#main = ""
let g:airline#extensions#vimtex#sub_main = "m"
let g:airline#extensions#vimtex#sub_local = "l"
let g:airline#extensions#vimtex#compiled = "single"
let g:airline#extensions#vimtex#continuous = "continuous"
let g:airline#extensions#vimtex#viewer = "viewer"
let g:airline#extensions#vimtex#wordcount = 0 

let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#virtualenv#ft = ['python', 'markdown']

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 0 "0 1 2 
let g:airline#extensions#whitespace#symbol = '!'
            " indent: mixed indent within a line
            " long:   overlong lines
            " trailing: trailing whitespace
            " mixed-indent-file: different indentation in different lines
            " conflicts: checks for conflict markers
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file', 'conflicts' ] 
let g:airline#extensions#whitespace#max_lines = 20000            
let g:airline#extensions#whitespace#show_message = 1 
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format =  'mixed-indent[%s]'
let g:airline#extensions#whitespace#long_format = 'long[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mix-indent-file[%s]'
let g:airline#extensions#whitespace#conflicts_format = 'conflicts[%s]' 
let g:airline#extensions#whitespace#trailing_regexp = '\s$'
" let b:airline_whitespace_trailing_regexp = '\s$'            
let g:airline#extensions#whitespace#skip_indent_check_ft =  {'go': ['mixed-indent-file']}

let g:airline#extensions#windowswap#enabled = 0
let g:airline#extensions#windowswap#indicator_text = 'WS' 

let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#wordcount#filetypes = ['asciidoc', 'help', 'mail', 'markdown', 'nroff', 'org', 'plaintex', 'rst', 'tex', 'text']
let g:airline#extensions#wordcount#formatter = 'default' " 'readingtime'
"function! airline#extensions#wordcount#formatters#foo#to_string(wordcount)
"  return a:wordcount == 0 ? 'NONE' :
"      \ a:wordcount > 100 ? 'okay' : 'not enough' )
"endfunction
" let g:airline#extensions#wordline#formatter = 'foo'
let g:airline#extensions#wordcount#formatter#default#fmt = '%s words'
let g:airline#extensions#wordcount#formatter#default#fmt_short = '%sW'


let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#xkblayout#short_codes = {'2SetKorean': 'KR', 'Chinese': 'CN', 'Japanese': 'JP'}
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'

let g:airline#extensions#ycm#enabled = 0
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'

let g:airline#extensions#zoomwintab#enabled = 0
let g:airline#extensions#zoomwintab#status_zoomed_in = '> Zoomed' " 'Currently Zoomed In'
let g:airline#extensions#zoomwintab#status_zoomed_out = '' " 'Currently Zoomed Out'

let g:airline#extensions#ale#enabled = 0
let airline#extensions#ale#error_symbol = 'E:' 
let airline#extensions#ale#warning_symbol = 'W:' 
let airline#extensions#ale#show_line_numbers = 1 
let airline#extensions#ale#open_lnum_symbol = '(L' 
let airline#extensions#ale#close_lnum_symbol = ')'
  
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 1

let g:airline#extensions#capslock#enabled = 0
let g:airline#extensions#capslock#symbol = 'CAPS' 

let g:airline#extensions#csv#enabled = 0
let g:airline#extensions#csv#column_display = 'Number' 
let g:airline#extensions#csv#column_display = 'Name'

let g:airline#extensions#ctrlspace#enabled = 0
let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"

let g:airline#extensions#cursormode#enabled = 0
let g:cursormode_mode_func = 'mode'
let g:cursormode_color_map = {
\ "nlight": '#000000',
\ "ndark": '#BBBBBB',
\ "i": g:airline#themes#{g:airline_theme}#palette.insert.airline_a[1],
\ "R": g:airline#themes#{g:airline_theme}#palette.replace.airline_a[1],
\ "v": g:airline#themes#{g:airline_theme}#palette.visual.airline_a[1],
\ "V": g:airline#themes#{g:airline_theme}#palette.visual.airline_a[1],
\ "\<C-V>": g:airline#themes#{g:airline_theme}#palette.visual.airline_a[1],
\ }

let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#keymap#label = 'Layout:'
let g:airline#extensions#keymap#default = ''
let g:airline#extensions#keymap#short_codes = {'russian-jcukenwin': 'ru'}

let g:airline#extensions#languageclient#enabled = 0
let airline#extensions#languageclient#error_symbol = 'E:'
let airline#extensions#languageclient#warning_symbol = 'W:'
let airline#extensions#languageclient#show_line_numbers = 1
let airline#extensions#languageclient#open_lnum_symbol = '(L'
let airline#extensions#languageclient#close_lnum_symbol = ')'

let g:airline#extensions#localsearch#enabled = 0
let g:airline#extensions#localsearch#inverted = 0

let g:airline#extensions#neomake#enabled = 0
let airline#extensions#neomake#error_symbol = 'E:'
let airline#extensions#neomake#warning_symbol = 'W:'

let g:airline#extensions#obsession#enabled = 0
let g:airline#extensions#obsession#indicator_text = '$'

let g:airline#extensions#nrrwrgn#enabled = 0
let g:airline#extensions#omnisharp#enabled = 0

let g:airline#extensions#po#enabled = 0
let g:airline#extensions#po#displayed_limit = 0

let g:airline#extensions#promptline#enabled = 0
let airline#extensions#promptline#snapshot_file = "~/.shell_prompt.sh"
" 'insert'/'visual'/'replace'
let airline#extensions#promptline#color_template = 'normal' 

let g:airline#extensions#rufo#enabled = 0
let g:airline#extensions#rufo#symbol = 'R'

let g:airline#extensions#syntastic#enabled = 0
let airline#extensions#syntastic#error_symbol = 'E:'
let airline#extensions#syntastic#warning_symbol = 'W:'
let airline#extensions#syntastic#stl_format_err = '%E{[%fe(#%e)]}'
let airline#extensions#syntastic#stl_format_warn = '%W{[%fw(#%w)]}'

let g:airline#extensions#tabline#enabled = 0 " only ctrlspace
let g:airline#extensions#tabline#show_tabs = 1 " only ctrlspace
let g:airline#extensions#tabline#show_tab_count = 1 " only ctrlspace / 0:no 1show when more than one 2always show
let g:airline#extensions#tabline#show_buffers = 1 " only ctrlspace
let g:airline#extensions#tabline#switch_buffers_and_tabs = 0 " only ctrlspace
let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 0 " only ctrlspace
let g:airline#extensions#tabline#buffers_label = 'b' " only ctrlspace
let g:airline#extensions#tabline#tabs_label = 't' " only ctrlspace
let g:airline#extensions#tabline#formatter = 'default' " only ctrlspace

let airline#extensions#c_like_langs = ['arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php']
