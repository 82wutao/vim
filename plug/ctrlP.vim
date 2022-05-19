" ------------------------------------------------
" For Ctrlp And funky
" ------------------------------------------------
let g:ctrlp_map = ''
noremap <c-p> :CtrlP<cr>          " CTRL+p 打开文件模糊匹配
noremap <c-n> :CtrlPMRUFiles<cr>  " CTRL+n 打开最近访问过的文件的匹配
noremap <m-p> :CtrlPFunky<cr>     " ALT+p 显示当前文件的函数列表
noremap <m-n> :CtrlPBuffer<cr>    " ALT+n 匹配 buffer

" 项目标志
let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
let g:ctrlp_working_path = 0
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|mp3|wav|sdf|suo|mht|pyc)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }

if executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
    let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
    let s:ctrlp_fallback = 'ack %s --nocolor -f'
    " On Windows use "dir" as fallback command.
else
    let s:ctrlp_fallback = 'find %s -type f'
endif

if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
endif
let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
            \ }
if isdirectory(expand("~/.vim/plugged/ctrlp-funky/"))
    " CtrlP extensions
    let g:ctrlp_extensions = ['funky']
    "funky
    nnoremap <leader>fu :CtrlPFunky<Cr>
endif
