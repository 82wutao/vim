"========================================
" let g:deoplete#enable_at_startup = 1
" 
" " Sets the maximum length of completion description text. 
" " If this is exceeded, a simple description is used instead. Default: 50
" let g:deoplete#sources#jedi#statement_length=120 
" 
" " Enables type information of completions. 
" " If you disable it, you will get the faster results. Default: 1
" let g:deoplete#sources#jedi#enable_typeinfo=1 
" 
" " Enables short completion types. Default: 0
" let g:deoplete#sources#jedi#enable_short_types=0
" " Short types mapping dictionary. 
" " Default: { 
" "   'import': 'imprt', 
" "   'function': 'def', 
" "   'globalstmt': 'var', 
" "   'instance': 'var', 
" "   'statement': 'var', 
" "   'keyword': 'keywd', 
" "   'module': 'mod', 
" "   'param': 'arg', 
" "   'property': 'prop', 
" "   'bytes': 'byte', 
" "   'complex': 'cmplx', 
" "   'object': 'obj', 
" "   'mappingproxy': 'dict', 
" "   'member_descriptor': 'cattr', 
" "   'getset_descriptor': 'cprop', 
" "   'method_descriptor': 'cdef', }
" let g:deoplete#sources#jedi#short_types_map= {'import':'impr'}
" 
" " Shows docstring in preview window. Default: 0
" let g:deoplete#sources#jedi#show_docstring=1 
" 
" " Set the Python interpreter path to use for the completion server. 
" " It defaults to "python", i.e. the first available python in $PATH. 
" " Note: This is different from Neovim's Python (:python) in general.
" let g:deoplete#sources#jedi#python_path="python3"
" 
" " A list of extra paths to add to sys.path when performing completions.
" let g:deoplete#sources#jedi#extra_path="" 
" 
" " Ignore jedi errors for completions. Default: 0
" let g:deoplete#sources#jedi#ignore_errors=1 
" 
" " Ignore private members from completions. Default: 0
" let g:deoplete#sources#jedi#ignore_private_members=1 
"==========================================

let g:jedi#goto_definitions_command = ""

let g:jedi#auto_initialization=1 "1/0
let g:jedi#completions_command = "<C-/>" "<Ctrl-Space>

let g:jedi#goto_command="<leader>d"
let g:jedi#goto_assignments_command="<leader>g"
let g:jedi#goto_stubs_command="<leader>s"
let g:jedi#documentation_command="<D>"
let g:jedi#rename_command="<leader>r"
let g:jedi#usages_command="<leader>n"

"  Open module by name                :Pyimport xxmodel
let g:jedi#auto_vim_configuration=1 "1/0

let g:jedi#completions_enabled=1
let g:jedi#case_insensitive_completion=0
let g:jedi#popup_on_dot=1
let g:jedi#popup_select_first=1
let g:jedi#auto_close_doc=1

let g:jedi#show_call_signatures=2 "0:disable/ 1:show signatures in popup /2:show it in cmdline
let g:jedi#show_call_signatures_delay=700

let g:jedi#use_tabs_not_buffers=1 "0 open src in buffer in current window / 1 open src in a new tab
let g:jedi#use_splits_not_buffers="right" "Options: top, left, right, bottom or winwidth

let g:jedi#squelch_py_warning=0 "0 show warning/ 1 suppress

let g:jedi#force_py_version = "auto"   " Options: 2, 2.7, 3, 3.5, 3.6, ...
let g:jedi#smart_auto_mappings=1
let g:jedi#use_tag_stack=1

" Examples: "/usr/bin/python3.9", 
""venv", 
""../venv", 
""../venv/bin/python"
let g:jedi#environment_path="auto" 
" Examples: ["../site-packages"]
let g:jedi#added_sys_path=[] 

"======================================================================================
" path to directory where library can be found or path directly to the library file
let g:clang_library_path='/usr/lib/llvm-10/lib/libclang.so.1'

" Compiler options can be configured in a .clang_complete file in each project root. 
" -DDEBUG
" -include ../config.h
" -I../common
" -I/usr/include/c++/4.5.3/
" -I/usr/include/c++/4.5.3/x86_64-slackware-linux/

" If set, clang_complete won't be loaded.  Default: unset.
" let g:clang_complete_loaded*

" If equal to 0, nothing is selected.
" If equal to 1, automatically select the first entry in the popup menu, but without inserting it into the code.
" If equal to 2, automatically select the first entry in the popup menu, and insert it into the code.
" Default: 0
let g:clang_auto_select=1

" If equal to 1, automatically complete after ->, ., :: 。Default: 1
let g:clang_complete_auto=1

" If equal to 1, open quickfix window on error.  Default: 0
let g:clang_complete_copen=0

" If equal to 1, it will highlight the warnings and errors the same way clang does it.  Default: 1
let g:clang_hl_errors=0

" If equal to 1, it will periodically update the quickfix window.  Default: 0
" Note: You could use the g:ClangUpdateQuickFix() to do the same with a mapping.
let g:clang_periodic_quickfix=0

" If equal to 1, it will do some snippets magic on code placeholders like
" function argument, template parameters, etc.
" Default: 0
let g:clang_snippets=1

" The snippets engine (clang_complete, ultisnips... see the snippets subdirectory).  Default: "clang_complete"
let g:clang_snippets_engine="clang_complete"

" Note: This option is specific to clang_complete snippets engine.
" If equal to 1, clang_complete will use vim 7.3 conceal feature to hide the snippet placeholders.
" Default: 1 (0 if conceal not available)
let g:clang_conceal_snippets=0


" If equal to 1, it will add optional arguments to the function call snippet.
" Snippet replaceable object will not be only the argument, but the preceding
" comma will be included as well, so you can press backspace to delete the
" optional argument, while the replaceable is selected.
" Example: foo($`T param1`, $`T param2`$`, T optional_param`)
" Default: 0
let g:clang_complete_optional_args_in_snippets=0

" Note: This option is specific to clang_complete snippets engine.
" If equal to 1, clang_complete will add a trailing placeholder after functions
" to let you add you continue writing code faster.
" Default: 0
let g:clang_trailing_placeholder=1

" This option is used for versions of Vim without the Dictionary version of
" |maparg()| introduced in 7.3.32. The variable is executed after completion to
" restore the insert-mode map of <CR>. Occurrences of "<SID>" in the variable
" are replaced with the appropriate "<SNR>" code based on the original map.
" Default: 'iunmap <buffer> <CR>'
" let g:clang_restore_cr_imap=

" If equal to 1, the preview window will be close automatically after a completion.  
" Default: 0
let g:clang_close_preview=1

" Additional compilation argument passed to libclang.  Default: ""
let g:clang_user_options = "-std=c++11"


" Set sources for user options passed to clang. Available sources are:
" - path - use &path content as list of include directories (relative paths are ignored);
" - .clang_complete - use information from .clang_complete file Multiple options are separated by comma;
" - compile_commands.json - get the compilation arguments for the sources from a compilation database. 
"   For example, recent versions of CMake (>=2.8.7) can output this information. 
"   clang_complete will search upwards from where vi was started for a database named 'compile_commands.json'.
"   Note : compilation databases can only be used when 'g:clang_use_library' equals 1 and the clang libraries are recent enough (clang>=3.2). 
"   The compilation database only contains information for the C/C++ sources files,
"   so when editing a header, clang_complete will reuse the compilation
"   arguments from the last file found in the database.
" - {anything} else will be treaded as a custom option source in the following
"   manner: clang_complete will try to load the autoload-function named
"   getopts#{anything}#getopts, which then will be able to modify
"   b:clang_user_options variable. See help on |autoload| if you don't know
"   what it is.
" Default: ".clang_complete, path"
" let g:clang_auto_user_options= ".clang_complete, path"


" By default, clang_complete will search upwards from where it was started to find a compilation database. 
" In case this behaviour does not match your needs,
" you can set |g:clang_compilation_database| to the directory where the database can be loaded from.
" g:clang_compilation_database*

" Instead of calling the clang/clang++ tool use libclang directly. This gives
" access to many more clang features. Furthermore it automatically caches all
" includes in memory. Updates after changes in the same file will therefore be a
" lot faster.
" Note: This version doesn't support calling clang binary for completion. If you
" cannot use libclang, you should download clang_complete from vim.org website.
" Default: 1
let g:clang_use_library=1

" How results are sorted (alpha, priority, none). Currently only works with libclang.
" Default: "priority"
let g:clang_sort_algo="alpha"

" If clang should complete preprocessor macros and constants.  Default: 0
let g:clang_complete_macros=1

" If clang should complete code patterns, i.e loop constructs etc.  Default: 0
let g:clang_complete_patterns=1

" Set the key used to jump to declaration.  Default: "<C-]>"
" Note: You could use the g:ClangGotoDeclaration() to do the same with a mapping.
let g:clang_jumpto_declaration_key ="<C-]>"

" Set the key used to jump to declaration in a preview window.  Default: "<C-W>]"
" Note: You could use the g:ClangGotoDeclarationPreview() to do the same with a mapping.
let g:clang_jumpto_declaration_in_preview_key="<C-W>]"

" Set the key used to jump back.  Default: "<C-T>"
" Note: Effectively this will be remapped to <C-O>. 
" The default value is chosen to be coherent with ctags implementation.
let g:clang_jumpto_back_key="<C-[>"

" If this option is set, the default keymappings will be set by clang_complete.
" Otherwise none are set and the user will have to provide those keymappings.
" Default: 1
let g:clang_make_default_keymappings=1

" Omnicppcomplete compatibility mode. Keeps omni auto-completion in control of
" omnicppcomplete, disables clang's auto-completion (|g:clang_complete_auto|)
" and enables only <C-X><C-U> as main clang completion function.
" Default: 0
" let g:clang_omnicppcomplete_compliance*
