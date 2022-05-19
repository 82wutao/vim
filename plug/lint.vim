" ------------------------------------------------
" For ale
" normal下sp, sn跳转到上一个，下一个错误，lc关闭或者打开错误列表
" ------------------------------------------------
" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁



"let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK'] "在vim自带的状态栏中整合ale
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()} "设置状态栏显示的内容

"如果你有使用airline的话，会发现airline默认也能显示ale相关的symbol，error对应的是”E”，warning对应的是”W”，
"如果你想把自定义的error和warning图标整合到airline的话，
"需要修改~/.vim/plugged/vim-airline/autoload/airline/extensions/ale.vim这个文件，方法是打开上面提到的ale.vim文件，找到下面这两句并注释掉
"let s:error_symbol = get(g:, 'airline#extensions#ale#error_symbol', 'E:')
"let s:warning_symbol = get(g:, 'airline#extensions#ale#warning_symbol', 'W:')
"然后再添加下面这两句就可以了
"let s:error_symbol = get(g:, 'airline#extensions#ale#error_symbol', '✗ ')
"let s:warning_symbol = get(g:, 'airline#extensions#ale#warning_symbol', '⚡ ')



""  ALE - Asynchronous Lint Engine
""  
""  ===============================================================================
""  CONTENTS                                                         *ale-contents*
""  
""    1. Introduction.........................|ale-introduction|
""    2. Supported Languages & Tools..........|ale-support|
""    3. Linting..............................|ale-lint|
""      3.1 Linting On Other Machines.........|ale-lint-other-machines|
""      3.2 Adding Language Servers...........|ale-lint-language-servers|
""      3.3 Other Sources.....................|ale-lint-other-sources|
""    4. Fixing Problems......................|ale-fix|
""    5. Language Server Protocol Support.....|ale-lsp|
""      5.1 Completion........................|ale-completion|
""      5.2 Go To Definition..................|ale-go-to-definition|
""      5.3 Go To Type Definition.............|ale-go-to-type-definition|
""      5.4 Go To Implementation..............|ale-go-to-type-implementation|
""      5.5 Find References...................|ale-find-references|
""      5.6 Hovering..........................|ale-hover|
""      5.7 Symbol Search.....................|ale-symbol-search|
""      5.8 Refactoring: Rename, Actions......|ale-refactor|
""    6. Global Options.......................|ale-options|
""      6.1 Highlights........................|ale-highlights|
""    7. Linter/Fixer Options.................|ale-integration-options|
""      7.1 Options for alex..................|ale-alex-options|
""      7.2 Options for cspell................|ale-cspell-options|
""      7.3 Options for languagetool..........|ale-languagetool-options|
""      7.4 Options for write-good............|ale-write-good-options|
""      7.5 Other Linter/Fixer Options........|ale-other-integration-options|
""    8. Commands/Keybinds....................|ale-commands|
""    9. API..................................|ale-api|
""    10. Special Thanks......................|ale-special-thanks|
""    11. Contact.............................|ale-contact|
""  
""  ===============================================================================
""  1. Introduction                                              *ale-introduction*
""  
""  ALE provides the means to run linters asynchronously in Vim in a variety of languages and tools. 
""  ALE sends the contents of buffers to linter programs using the |job-control| features available in Vim 8 and NeoVim. 
""  For Vim 8, Vim must be compiled with the |job| and |channel| and |timers| features as a minimum.
""  
""  ALE supports the following key features for linting:
""  
""  1. Running linters when text is changed.
""  2. Running linters when files are opened.
""  3. Running linters when files are saved. (When a global flag is set.)
""  4. Populating the |loclist| with warning and errors.
""  5. Setting |signs| with warnings and errors for error markers.
""  6. Using |echo| to show error messages when the cursor moves.
""  7. Setting syntax highlights for errors.
""  
""  ALE can fix problems with files with the |ALEFix| command, using the same job control functionality used for checking for problems. 
""  Try using the |ALEFixSuggest| command for browsing tools that can be used to fix problems for the current buffer.
""  
""  If you are interested in contributing to the development of ALE, read the developer documentation. 
""  See |ale-development|
""  
""  ===============================================================================
""  2. Supported Languages & Tools                                    *ale-support*
""  
""  ALE supports a wide variety of languages and tools. See |ale-supported-list| for the full list.
""  
""  ===============================================================================
""  3. Linting                                                           *ale-lint*
""  
""  ALE's primary focus is on checking for problems with your code with various programs via some Vim code for integrating with those programs, referred to as 'linters.' 
""  ALE supports a wide array of programs for linting by default,
""  but additional programs can be added easily by defining files in |runtimepath| with the filename pattern `ale_linters/<filetype>/<filename>.vim`. 
""  For more information on defining new linters, see the extensive documentation for |ale#linter#Define()|.
""  
""  Without any configuration, ALE will attempt to check all of the code for every file you open in Vim with all available tools by default. 
""  To see what ALE is doing, and what options have been set, try using the |:ALEInfo| command.
""  
""  Most of the linters ALE runs will check the Vim buffer you are editing instead of the file on disk. 
""  This allows you to check your code for errors before you have even saved your changes. 
""  ALE will check your code in the following circumstances, which can be configured with the associated options.
""  
""  * When you modify a buffer.                - |g:ale_lint_on_text_changed|
""  * On leaving insert mode.                  - |g:ale_lint_on_insert_leave|
""  * When you open a new or modified buffer.  - |g:ale_lint_on_enter|
""  * When you save a buffer.                  - |g:ale_lint_on_save|
""  * When the filetype changes for a buffer.  - |g:ale_lint_on_filetype_changed|
""  * If ALE is used to check code manually.   - |:ALELint|
""  
""                                                   *ale-lint-settings-on-startup*
""  
""  It is worth reading the documentation for every option. 
""  You should configure which events ALE will use before ALE is loaded, so it can optimize which autocmd commands to run. 
""  You can force autocmd commands to be reloaded with `:ALEDisable | ALEEnable`
""  
""  This also applies to the autocmd commands used for |g:ale_echo_cursor|.
""  
""                                                          *ale-lint-file-linters*
""  
""  Some programs must be run against files which have been saved to disk, 
""  and simply do not support reading temporary files or stdin, either of which are required for ALE to be able to check for errors as you type. 
""  The programs which behave this way are documented in the lists and tables of supported programs. 
""  ALE will only lint files with these programs in the following circumstances.
""  
""  * When you open a new or modified buffer.  - |g:ale_lint_on_enter|
""  * When you save a buffer.                  - |g:ale_lint_on_save|
""  * When the filetype changes for a buffer.  - |g:ale_lint_on_filetype_changed|
""  * If ALE is used to check code manually.   - |:ALELint|
""  
""  ALE will report problems with your code in the following ways, listed with their relevant options.
""  
""  * By updating loclist. (On by default)             - |g:ale_set_loclist|
""  * By updating quickfix. (Off by default)           - |g:ale_set_quickfix|
""  * By setting error highlights.                     - |g:ale_set_highlights|
""  * By creating signs in the sign column.            - |g:ale_set_signs|
""  * By echoing messages based on your cursor.        - |g:ale_echo_cursor|
""  * By inline text based on your cursor.             - |g:ale_virtualtext_cursor|
""  * By displaying the preview based on your cursor.  - |g:ale_cursor_detail|
""  * By showing balloons for your mouse cursor        - |g:ale_set_balloons|
""  
""  Please consult the documentation for each option, which can reveal some other ways of tweaking the behavior of each way of displaying problems. 
""  You can disable or enable whichever options you prefer.
""  
""  Most settings can be configured for each buffer. (|b:| instead of |g:|), including disabling ALE for certain buffers with |b:ale_enabled|. 
""  The |g:ale_pattern_options| setting can be used to configure files differently based on regular expressions for filenames. 
""  For configuring entire projects,
""  the buffer-local options can be used with external plugins for reading Vim project configuration files. 
""  Buffer-local settings can also be used in ftplugin files for different filetypes.
""  
""  ALE offers several options for controlling which linters are run.
""  
""  * Selecting linters to run.            - |g:ale_linters|
""  * Aliasing filetypes for linters       - |g:ale_linter_aliases|
""  * Only running linters you asked for.  - |g:ale_linters_explicit|
""  * Disabling only a subset of linters.  - |g:ale_linters_ignore|
""  * Disabling LSP linters and `tsserver`.  - |g:ale_disable_lsp|
""  
""  You can stop ALE any currently running linters with the |ALELintStop| command.
""  Any existing problems will be kept.
""  
""  -------------------------------------------------------------------------------
""  3.1 Linting On Other Machines                         *ale-lint-other-machines*
""  
""  ALE offers support for running linters or fixers on files you are editing locally on other machines, 
""  so long as the other machine has access to the file you are editing. 
""  This could be a linter or fixer run inside of a Docker image, running in a virtual machine, running on a remote server, etc.
""  
""  In order to run tools on other machines, you will need to configure your tools to run via scripts that execute commands on those machines, 
""  `such as by setting the ALE `_executable` options for those tools to a path for a script to run, 
""  or by using |g:ale_command_wrapper| to specify a script to wrap all commands that are run by ALE, before they are executed. 
""  For tools that ALE runs where ALE looks for locally installed executables first, 
""  you may need to set the `_use_global` options for those tools to `1`, or you can set |g:ale_use_global_executables| to `1` before ALE is loaded to only use global executables for all tools.
""  
""  In order for ALE to properly lint or fix files which are running on another file system, 
""  you must provide ALE with |List|s of strings for mapping paths to and from your local file system and the remote file system, such as the file system of your Docker container. 
""  See |g:ale_filename_mappings| for all of the different ways these filename mappings can be configured.
""  
""  For example, you might configure `pylint` to run via Docker by creating a script like so. >
""  
""    #!/usr/bin/env bash
""  
""    exec docker run -i --rm -v "$(pwd):/data" cytopia/pylint "$@"
""  <
""  
""  You will run to run Docker commands with `-i` in order to read from stdin.
""  
""  With the above script in mind, you might configure ALE to lint your Python project with `pylint` by providing the path to the script to execute, 
""  and mappings which describe how to between the two file systems in your `python.vim` |ftplugin| file, like so: >
""  
""    if expand('%:p') =~# '^/home/w0rp/git/test-pylint/'
""      let b:ale_linters = ['pylint']
""      let b:ale_python_pylint_use_global = 1
""      " This is the path to the script above.
""      let b:ale_python_pylint_executable = '/home/w0rp/git/test-pylint/pylint.sh'
""      " /data matches the path in Docker.
""      let b:ale_filename_mappings = {
""      \ 'pylint': [
""      \   ['/home/w0rp/git/test-pylint', '/data'],
""      \ ],
""      \}
""    endif
""  <
""  
""  You might consider using a Vim plugin for loading Vim configuration files specific to each project, if you have a lot of projects to manage.
""  
""  
""  -------------------------------------------------------------------------------
""  3.2 Adding Language Servers                         *ale-lint-language-servers*
""  
""  ALE comes with many default configurations for language servers, so they can be detected and run automatically. 
""  ALE can connect to other language servers by defining a new linter for a filetype. 
""  New linters can be defined in |vimrc|, in plugin files, or `ale_linters` directories in |runtimepath|.
""  
""  See |ale-linter-loading-behavior| for more information on loading linters.
""  
""  A minimal configuration for a language server linter might look so. >
""  
""    call ale#linter#Define('filetype_here', {
""    \   'name': 'any_name_you_want',
""    \   'lsp': 'stdio',
""    \   'executable': '/path/to/executable',
""    \   'command': '%e run',
""    \   'project_root': '/path/to/root_of_project',
""    \})
""  <
""  For language servers that use a TCP or named pipe socket connection, you should define the address to connect to instead. >
""  
""    call ale#linter#Define('filetype_here', {
""    \   'name': 'any_name_you_want',
""    \   'lsp': 'socket',
""    \   'address': 'servername:1234',
""    \   'project_root': '/path/to/root_of_project',
""    \})
""  <
""    Most of the options for a language server can be replaced with a |Funcref| for a function accepting a buffer number for dynamically computing values
""    such as the executable path, the project path, the server address, etc, most of which can also be determined based on executing some other asynchronous task. 
""    See |ale#command#Run()| for computing linter options based on asynchronous results.
""  
""    See |ale#linter#Define()| for a detailed explanation of all of the options for configuring linters.
""  
""  
""  -------------------------------------------------------------------------------
""  3.3 Other Sources                                      *ale-lint-other-sources*
""  
""  Problem for a buffer can be taken from other sources and rendered by ALE.
""  This allows ALE to be used in combination with other plugins which also want to display any problems they might find with a buffer. 
""  ALE's API includes the following components for making this possible.
""  
""  * |ale#other_source#StartChecking()| - Tell ALE that a buffer is being checked.
""  * |ale#other_source#ShowResults()|   - Show results from another source.
""  * |ALEWantResults|                   - A signal for when ALE wants results.
""  
""  Other resources can provide results for ALE to display at any time, following ALE's loclist format. (See |ale-loclist-format|) 
""  For example: >
""  
""    " Tell ALE to show some results.
""    " This function can be called at any time.
""    call ale#other_source#ShowResults(bufnr(''), 'some-linter-name', [
""    \ {'text': 'Something went wrong', 'lnum': 13},
""    \])
""  <
""  
""  Other sources should use a unique name for identifying themselves. 
""  A single linter name can be used for all problems from another source, or a series of unique linter names can be used. 
""  Results can be cleared for that source by providing an empty List.
""  
""  |ale#other_source#StartChecking()| should be called whenever another source starts checking a buffer, 
""  so other tools can know that a buffer is being checked by some plugin. 
""  The |ALEWantResults| autocmd event can be used to start checking a buffer for problems every time that ALE does. 
""  When |ALEWantResults| is signaled, |g:ale_want_results_buffer| will be set to the number of the buffer that ALE wants to check.
""  |ale#other_source#StartChecking()| should be called synchronously, and other sources should perform their checks on a buffer in the background asynchronously, 
""  so they don't interrupt editing.
""  
""  |ale#other_source#ShowResults()| must not be called synchronously before ALE's engine executes its code after the |ALEWantResults| event runs. 
""  If there are immediate results to provide to ALE, 
""  a 0 millisecond timer with |timer_start()| can be set instead up to call |ale#other_source#ShowResults()| after ALE has first executed its engine code for its own sources.  
""  A plugin might integrate its own checks with ALE like so: >
""  
""    augroup SomeGroupName
""      autocmd!
""      autocmd User ALEWantResults call Hook(g:ale_want_results_buffer)
""    augroup END
""  
""    function! DoBackgroundWork(buffer) abort
""      " Start some work in the background here.
""      " ...
""      " Then call WorkDone(a:buffer, results)
""    endfunction
""  
""    function! Hook(buffer) abort
""      " Tell ALE we're going to check this buffer.
""      call ale#other_source#StartChecking(a:buffer, 'some-name')
""      call DoBackgroundWork(a:buffer)
""    endfunction
""  
""    function! WorkDone(buffer, results) abort
""      " Send results to ALE after they have been collected.
""      call ale#other_source#ShowResults(a:buffer, 'some-name', a:results)
""    endfunction
""  <
""  
""  ===============================================================================
""  4. Fixing Problems                                                    *ale-fix*
""  
""  ALE can fix problems with files with the |ALEFix| command.
""  |ALEFix| accepts names of fixers to be applied as arguments. 
""  Alternatively, when no arguments are provided, the variable |g:ale_fixers| will be read for getting a |List| of commands for filetypes, split on `.`, 
""  and the functions named in |g:ale_fixers| will be executed for fixing the errors.
""  
""  The |ALEFixSuggest| command can be used to suggest tools that be used to fix problems for the current buffer.
""  
""  The values for `g:ale_fixers` can be a list of |String|, |Funcref|, or |lambda| values. 
""  String values must either name a function, or a short name for a function set in the ALE fixer registry.
""  
""  Each function for fixing errors must accept either one argument `(buffer)` or two arguments `(buffer, lines)`, 
""  representing the buffer being fixed and the lines to fix. 
""  The functions must return either `0`, for changing nothing, a |List| for new lines to set, a |Dictionary| for describing a command to be run in the background, or the result of |ale#command#Run()|.
""  
""  Functions receiving a variable number of arguments will not receive the second argument `lines`. 
""  Functions should name two arguments if the `lines` argument is desired. 
""  This is required to avoid unnecessary copying of the lines of the buffers being checked.
""  
""  When a |Dictionary| is returned for an |ALEFix| callback, the following keys are supported for running the commands.
""  
""    `cwd`                 An optional |String| for setting the working directory for the command.
""  
""                        If not set, or `v:null`, the `cwd` of the last command that spawn this one will be used.
""  
""    `command`             A |String| for the command to run. This key is required.
""  
""                        When `%t` is included in a command string, a temporary file will be created, 
""                        containing the lines from the file after previous adjustment have been done.
""  
""                        See |ale-command-format-strings| for formatting options.
""  
""    `read_temporary_file` When set to `1`, ALE will read the contents of the temporary file created for `%t`. 
""                        This option can be used for commands which need to modify some file on disk in order to fix files.
""  
""    `process_with`        An optional callback for post-processing.
""  
""                        The callback must accept arguments `(bufnr, output)`:
""                        the buffer number undergoing fixing and the fixer's output as a |List| of |String|s. 
""                        It must return a |List| of |String|s that will be the new contents of the buffer.
""  
""                        This callback is useful to remove excess lines from the command's output or apply additional changes to the output.
""  
""  
""    `read_buffer`         An optional key for disabling reading the buffer.
""  
""                        When set to `0`, ALE will not pipe the buffer's data into the command via stdin. 
""                        This option is ignored and the buffer is not read when `read_temporary_file` is `1`.
""  
""                        This option defaults to `1`.
""  
""                                                          *ale-fix-configuration*
""  
""  Synchronous functions and asynchronous jobs will be run in a sequence for fixing files, and can be combined. 
""  For example:
""  >
""    let g:ale_fixers = {
""    \   'javascript': [
""    \       'DoSomething',
""    \       'eslint',
""    \       {buffer, lines -> filter(lines, 'v:val !=~ ''^\s*//''')},
""    \   ],
""    \}
""  
""    ALEFix
""  <
""  The above example will call a function called `DoSomething` which could act upon some lines immediately, 
""  then run `eslint` from the ALE registry, and then call a lambda function which will remove every single line comment from the file.
""  
""  For buffer-local settings, such as in |g:ale_pattern_options| or in ftplugin files, a |List| may be used for configuring the fixers instead.
""  >
""    " Same as the above, only a List can be used instead of a Dictionary.
""    let b:ale_fixers = [
""    \   'DoSomething',
""    \   'eslint',
""    \   {buffer, lines -> filter(lines, 'v:val !=~ ''^\s*//''')},
""    \]
""  
""    ALEFix
""  <
""  For convenience, a plug mapping is defined for |ALEFix|, so you can set up a keybind easily for fixing files. >
""  
""    " Bind F8 to fixing problems with ALE
""    nmap <F8> <Plug>(ale_fix)
""  <
""  Files can be fixed automatically with the following options, which are all off by default.
""  
""  |g:ale_fix_on_save| - Fix files when they are saved.
""  
""  Fixers can be disabled on save with |g:ale_fix_on_save_ignore|. They will still be run when you manually run |ALEFix|.
""  
""  Fixers can be run on another machines, just like linters, such as fixers run from a Docker container, running in a virtual machine, running a remote server, etc. 
""  See |ale-lint-other-machines|.
""  
""  
""  ===============================================================================
""  5. Language Server Protocol Support                                   *ale-lsp*
""  
""  ALE offers some support for integrating with Language Server Protocol (LSP) servers. 
""  LSP linters can be used in combination with any other linter, and will automatically connect to LSP servers when needed. 
""  ALE also supports `tsserver` for TypeScript, which uses a different but very similar protocol.
""  
""  If you want to use another plugin for LSP features and tsserver, 
""  you can use the |g:ale_disable_lsp| setting to disable ALE's own LSP integrations, or ignore particular linters with |g:ale_linters_ignore|.
""  
""  -------------------------------------------------------------------------------
""  5.1 Completion                                                 *ale-completion*
""  
""  ALE offers support for automatic completion of code while you type.
""  Completion is only supported while at least one LSP linter is enabled. 
""  ALE will only suggest symbols provided by the LSP servers.
""  
""                                                       *ale-deoplete-integration*
""  
""  ALE integrates with Deoplete for offering automatic completion data. 
""  ALE's completion source for Deoplete is named `'ale'`, and should enabled automatically if Deoplete is enabled and configured correctly. 
""  Deoplete integration should not be combined with ALE's own implementation.
""  
""                                                   *ale-asyncomplete-integration*
""  
""  ALE additionally integrates with asyncomplete.vim for offering automatic completion data. 
""  ALE's asyncomplete source requires registration and should use the defaults provided by the |asyncomplete#sources#ale#get_source_options| function >
""  
""    " Use ALE's function for asyncomplete defaults
""    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
""        \ 'priority': 10, " Provide your own overrides here
""        \ }))
""  >
""  ALE also offers its own completion implementation, which does not require any other plugins. 
""  Suggestions will be made while you type after completion is enabled. 
""  ALE's own completion implementation can be enabled by setting |g:ale_completion_enabled| to `1`. 
""  This setting must be set to `1` before ALE is loaded. The delay for completion can be configured with |g:ale_completion_delay|. 
""  This setting should not be enabled if you wish to use ALE as a completion source for other plugins.
""  
""  ALE automatic completion will not work when 'paste' is active. 
""  Only set 'paste' when you are copy and pasting text into your buffers.
""  
""  ALE automatic completion will interfere with default insert completion with `CTRL-N` and so on (|compl-vim|). 
""  You can write your own keybinds and a function in your |vimrc| file to force insert completion instead, like so: >
""  
""    function! SmartInsertCompletion() abort
""      " Use the default CTRL-N in completion menus
""      if pumvisible()
""        return "\<C-n>"
""      endif
""  
""      " Exit and re-enter insert mode, and use insert completion
""      return "\<C-c>a\<C-n>"
""    endfunction
""  
""    inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>
""  <
""  ALE provides an 'omnifunc' function |ale#completion#OmniFunc| for triggering completion manually with CTRL-X CTRL-O. |i_CTRL-X_CTRL-O| >
""  
""    " Use ALE's function for omnicompletion.
""    set omnifunc=ale#completion#OmniFunc
""  <
""                                                        *ale-completion-fallback*
""  
""  You can write your own completion function and fallback on other methods of completion by checking if there are no results that ALE can determine. 
""  For example, for Python code, you could fall back on the `python3complete` function. >
""  
""    function! TestCompletionFunc(findstart, base) abort
""      let l:result = ale#completion#OmniFunc(a:findstart, a:base)
""  
""      " Check if ALE couldn't find anything.
""      if (a:findstart && l:result is -3)
""      \|| (!a:findstart && empty(l:result))
""        " Defer to another omnifunc if ALE couldn't find anything.
""        return python3complete#Complete(a:findstart, a:base)
""      endif
""  
""      return l:result
""    endfunction
""  
""    set omnifunc=TestCompletionFunc
""  <
""  See |complete-functions| for documentation on how to write completion functions.
""  
""  ALE will only suggest so many possible matches for completion. 
""  The maximum number of items can be controlled with |g:ale_completion_max_suggestions|.
""  
""  If you don't like some of the suggestions you see, 
""  you can filter them out with |g:ale_completion_excluded_words| or |b:ale_completion_excluded_words|.
""  
""  The |ALEComplete| command can be used to show completion suggestions manually, even when |g:ale_completion_enabled| is set to `0`. 
""  For manually requesting completion information with Deoplete, consult Deoplete's documentation.
""  
""  ALE supports automatic imports from external modules. 
""  This behavior can be disabled by setting the |g:ale_completion_autoimport| variable to `0`.
""  Disabling automatic imports can drop some or all completion items from some LSP servers (e.g. eclipselsp).
""  
""  You can manually request imports for symbols at the cursor with the |ALEImport| command. 
""  The word at the cursor must be an exact match for some potential completion result which includes additional text to insert into the current buffer, which ALE will assume is code for an import line. 
""  This command can be useful when your code already contains something you need to import.
""  
""  You can execute other commands whenever ALE inserts some completion text with the |ALECompletePost| event.
""  
""  When working with TypeScript files, ALE can remove warnings from your completions by setting the |g:ale_completion_tsserver_remove_warnings| variable to 1.
""  
""                                                 *ale-completion-completeopt-bug*
""  
""  ALE Automatic completion implementation replaces |completeopt| before opening the omnicomplete menu with <C-x><C-o>. 
""  In some versions of Vim, the value set for the option will not be respected. 
""  If you experience issues with Vim automatically inserting text while you type, set the following option in vimrc, and your issues should go away. >
""  
""    set completeopt=menu,menuone,preview,noselect,noinsert
""  <
""  Or alternatively, if you want to show documentation in popups: >
""  
""    set completeopt=menu,menuone,popup,noselect,noinsert
""  <
""                                                                    *ale-symbols*
""  
""  ALE provides a set of basic completion symbols. 
""  If you want to replace those symbols with others, 
""  you can set the variable |g:ale_completion_symbols| with a mapping of the type of completion to the symbol or other string that you would like to use. 
""  An example here shows the available options for symbols  >
""  
""    let g:ale_completion_symbols = {
""    \ 'text': '',
""    \ 'method': '',
""    \ 'function': '',
""    \ 'constructor': '',
""    \ 'field': '',
""    \ 'variable': '',
""    \ 'class': '',
""    \ 'interface': '',
""    \ 'module': '',
""    \ 'property': '',
""    \ 'unit': 'unit',
""    \ 'value': 'val',
""    \ 'enum': '',
""    \ 'keyword': 'keyword',
""    \ 'snippet': '',
""    \ 'color': 'color',
""    \ 'file': '',
""    \ 'reference': 'ref',
""    \ 'folder': '',
""    \ 'enum member': '',
""    \ 'constant': '',
""    \ 'struct': '',
""    \ 'event': 'event',
""    \ 'operator': '',
""    \ 'type_parameter': 'type param',
""    \ '<default>': 'v'
""    \ }
""  <
""  -------------------------------------------------------------------------------
""  5.2 Go To Definition                                     *ale-go-to-definition*
""  
""  ALE supports jumping to the files and locations where symbols are defined through any enabled LSP linters. 
""  The locations ALE will jump to depend on the information returned by LSP servers. 
""  The |ALEGoToDefinition| command will jump to the definition of symbols under the cursor. 
""  See the documentation for the command for configuring how the location will be displayed.
""  
""  ALE will update Vim's |tagstack| automatically unless |g:ale_update_tagstack| is set to `0`.
""  
""  -------------------------------------------------------------------------------
""  5.3 Go To Type Definition                           *ale-go-to-type-definition*
""  
""  ALE supports jumping to the files and locations where symbols' types are defined through any enabled LSP linters. 
""  The locations ALE will jump to depend on the information returned by LSP servers. 
""  The |ALEGoToTypeDefinition| command will jump to the definition of symbols under the cursor. 
""  See the documentation for the command for configuring how the location will be displayed.
""  
""  -------------------------------------------------------------------------------
""  5.4 Go To Implementation                             *ale-go-to-implementation*
""  
""  ALE supports jumping to the files and locations where symbols are implemented through any enabled LSP linters. 
""  The locations ALE will jump to depend on the information returned by LSP servers. 
""  The |ALEGoToImplementation| command will jump to the implementation of symbols under the cursor. 
""  See the documentation for the command for configuring how the location will be displayed.
""  
""  -------------------------------------------------------------------------------
""  5.5 Find References                                       *ale-find-references*
""  
""  ALE supports finding references for symbols though any enabled LSP linters with the |ALEFindReferences| command. 
""  See the documentation for the command for a full list of options.
""  
""  -------------------------------------------------------------------------------
""  5.6 Hovering                                                        *ale-hover*
""  
""  ALE supports "hover" information for printing brief information about symbols at the cursor taken from LSP linters. 
""  The following commands are supported:
""  
""  |ALEHover| - Print information about the symbol at the cursor.
""  
""  Truncated information will be displayed when the cursor rests on a symbol by default, as long as there are no problems on the same line. 
""  You can disable this behavior by setting |g:ale_hover_cursor| to `0`.
""  
""  If |g:ale_set_balloons| is set to `1` and your version of Vim supports the |balloon_show()| function, 
""  then "hover" information also show up when you move the mouse over a symbol in a buffer. 
""  Diagnostic information will take priority over hover information for balloons. 
""  If a line contains a problem, that problem will be displayed in a balloon instead of hover information.
""  
""  Hover information can be displayed in the preview window instead by setting |g:ale_hover_to_preview| to `1`.
""  
""  When using Neovim or Vim with |popupwin|, if |g:ale_hover_to_floating_preview| or |g:ale_floating_preview| is set to 1, the hover information will show in a floating window. 
""  And |g:ale_floating_window_border| for the border setting.
""  
""  For Vim 8.1+ terminals, mouse hovering is disabled by default. 
""  Enabling |balloonexpr| commands in terminals can cause scrolling issues in terminals, so ALE will not attempt to show balloons unless |g:ale_set_balloons| is set to `1` before ALE is loaded.
""  
""  For enabling mouse support in terminals, you may have to change your mouse settings. 
""  For example: >
""  
""    " Example mouse settings.
""    " You will need to try different settings, depending on your terminal.
""    set mouse=a
""    set ttymouse=xterm
""  <
""  
""  Documentation for symbols at the cursor can be retrieved using the |ALEDocumentation| command. 
""  This command is only available for `tsserver`.
""  
""  -------------------------------------------------------------------------------
""  5.7 Symbol Search                                           *ale-symbol-search*
""  
""  ALE supports searching for workspace symbols via LSP linters with the |ALESymbolSearch| command. 
""  See the documentation for the command for a full list of options.
""  
""  -------------------------------------------------------------------------------
""  5.8 Refactoring: Rename, Actions                                 *ale-refactor*
""  
""  ALE supports renaming symbols in code such as variables or class names with the |ALERename| command.
""  
""  `ALEFileRename` will rename file and fix import paths (tsserver only).
""  
""  |ALECodeAction| will execute actions on the cursor or applied to a visual range selection, such as automatically fixing errors.
""  
""  Actions will appear in the right click mouse menu by default for GUI versions of Vim, unless disabled by setting |g:ale_popup_menu_enabled| to `0`.
""  
""  Make sure to set your Vim to move the cursor position whenever you right click, and enable the mouse menu: >
""  
""    set mouse=a
""    set mousemodel=popup_setpos
""  <
""  You may wish to remove some other menu items you don't want to see: >
""  
""    silent! aunmenu PopUp.Select\ Word
""    silent! aunmenu PopUp.Select\ Sentence
""    silent! aunmenu PopUp.Select\ Paragraph
""    silent! aunmenu PopUp.Select\ Line
""    silent! aunmenu PopUp.Select\ Block
""    silent! aunmenu PopUp.Select\ Blockwise
""    silent! aunmenu PopUp.Select\ All
""  <
""  ===============================================================================
let g:ale_set_highlights = has('syntax')                      " 1/0     
let g:ale_exclude_highlights=[]     "['line too long', 'foo.*bar']

let g:ale_type_map={}                     " This option can be set re-map problem types for linters. 
"""     Each key in the |Dictionary| should be the name of a linter, and each value must be a |Dictionary| mapping problem types from one type to another. 
"""     The following types are supported:
"""     `'E'`  - `{'type': 'E'}`
"""     `'ES'` - `{'type': 'E', 'sub_type': 'style'}`
"""     `'W'`  - `{'type': 'W'}`
"""     `'WS'` - `{'type': 'W', 'sub_type': 'style'}`
"""     `'I'`  - `{'type': 'I'}`
"""     let g:ale_type_map = {'flake8': {'ES': 'WS', 'E': 'W'}}
let g:ale_linters={}
"""     {default
"""     \   'apkbuild': ['apkbuild_lint', 'secfixes_check'],
"""     \   'csh': ['shell'],
"""     \   'elixir': ['credo', 'dialyxir', 'dogma'],
"""     \   'go': ['gofmt', 'golint', 'gopls', 'govet'],
"""     \   'hack': ['hack'],
"""     \   'help': [],
"""     \   'inko': ['inko'],
"""     \   'json': ['jsonlint', 'spectral'],
"""     \   'json': ['jsonlint', 'spectral', 'vscodejson'],
"""     \   'json5': [],
"""     \   'jsonc': [],
"""     \   'perl': ['perlcritic'],
"""     \   'perl6': [],
"""     \   'python': ['flake8', 'mypy', 'pylint', 'pyright'],
"""     \   'rust': ['cargo', 'rls'],
"""     \   'spec': [],
"""     \   'text': [],
"""     \   'vue': ['eslint', 'vls'],
"""     \   'zsh': ['shell'],
"""     \   'v': ['v'],
"""     \}
let g:ale_linters = {
            \   'c': [  'gcc'],
            \   'cpp': [ 'gcc'],
            \   'python': ['pylint' ],
            \   'reStructuredText':['rstcheck'],
            \   'bash': ['shellcheck'],
            \   'go': ['gofmt', 'golint', 'gopls', 'govet','go build'],
            \   'java': ['javac'],
            \   'javascript': ['eslint'],
            \}
let g:ale_lint_on_enter=1
let g:ale_linters_ignore={}
let g:ale_linters_explicit=1           " 除g:ale_linters指定，其他不可用
let g:ale_linter_aliases={}            " This |Dictionary| will be merged with a default dictionary containing the following values: >
"""     let g:ale_linter_aliases = {'foobar': 'php'}
"""     let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_lint_on_save=1
let g:ale_lint_on_filetype_changed=1
let g:ale_lint_on_text_changed='never' 
"""     `'always'`, `'1'`, or `1` - Check buffers on |TextChanged| or |TextChangedI|.
"""     `'normal'`            - Check buffers only on |TextChanged|.
"""     `'insert'`            - Check buffers only on |TextChangedI|.
"""     `'never'`, `'0'`, or `0`  - Never check buffers on changes.
let g:ale_lint_on_insert_leave=0
let g:ale_lint_delay=500

let g:ale_fixers={}
"""       " Fix Python files with 'bar'.
"""       " Don't fix 'html' files.
"""       " Fix everything else with 'foo'.
"""       let g:ale_fixers = {'python': ['bar'], 'html': [], '*': ['foo']}
let g:ale_fixers = {
            \   'python': [ 'autopep8' ],
            \   'javascript': ['eslint'],
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}
let g:ale_fix_on_save=0
let g:ale_fix_on_save_ignore={} "{'cpp':['a','b']}
" let g:ale_fix_on_save_ignore=[]



let g:ale_c_gcc_options = '-Wall -O2 -std=c11'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = '-Wall -O2 -std=c11'
let g:ale_cpp_cppcheck_options = '-Wall -O2 -std=c++11'
let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']
" 如果没有 gcc 只有 clang 时（FreeBSD）
""if executable('gcc') == 0 && executable('clang')
""    let g:ale_linters.c += ['clang']
""    let g:ale_linters.cpp += ['clang']
""endif
" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
" 设置 flake8/pylint 的参数
""let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
""let g:ale_python_pylint_options .= ' --disable=W'
""let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')


let g:ale_completion_enabled=0
let g:ale_completion_delay=600
let g:ale_completion_tsserver_remove_warnings=0
let g:ale_completion_autoimport=1
let g:ale_completion_excluded_words=[]
let g:ale_completion_symbols = {
\ 'text': 'txt',
\ 'method': 'mthd',
\ 'function': 'func',
\ 'constructor': 'cstr',
\ 'field': 'fld',
\ 'variable': 'var',
\ 'class': 'clz',
\ 'interface': 'inf',
\ 'module': 'mdl',
\ 'property': 'prop',
\ 'unit': 'unt',
\ 'value': 'val',
\ 'enum': 'enm',
\ 'keyword': 'kw',
\ 'snippet': 'snp',
\ 'color': 'clo',
\ 'file': 'fil',
\ 'reference': 'ref',
\ 'folder': 'fold',
\ 'enum_member': 'emem',
\ 'constant': 'const',
\ 'struct': 'stru',
\ 'event': 'evnt',
\ 'operator': 'oprt',
\ 'type_parameter': 'tprm',
\ '<default>': 'deft'
\ }
let g:ale_completion_max_suggestions=20

let g:ale_set_signs=has('signs')  
"""     ALE will use the following highlight groups for problems:
"""   
"""     |ALEErrorSign|        - Items with `'type': 'E'`
"""     |ALEWarningSign|      - Items with `'type': 'W'`
"""     |ALEInfoSign|         - Items with `'type': 'I'`
"""     |ALEStyleErrorSign|   - Items with `'type': 'E'` and `'sub_type': 'style'`
"""     |ALEStyleWarningSign| - Items with `'type': 'W'` and `'sub_type': 'style'`
"""   
"""     In addition to the style of the signs, the style of lines where signs appear can be configured with the following highlights:
"""   
"""     |ALEErrorLine|   - All items with `'type': 'E'`
"""     |ALEWarningLine| - All items with `'type': 'W'`
"""     |ALEInfoLine|    - All items with `'type': 'I'`
"""   
"""     With Neovim 0.3.2 or higher, ALE can use the `numhl` option to highlight the 'number' column. It uses the following highlight groups.
"""   
"""     |ALEErrorSignLineNr|        - Items with `'type': 'E'`
"""     |ALEWarningSignLineNr|      - Items with `'type': 'W'`
"""     |ALEInfoSignLineNr|         - Items with `'type': 'I'`
"""     |ALEStyleErrorSignLineNr|   - Items with `'type': 'E'` and `'sub_type': 'style'`
"""     |ALEStyleWarningSignLineNr| - Items with `'type': 'W'` and `'sub_type': 'style'`
"""   
"""     To enable line number highlighting |g:ale_sign_highlight_linenrs| must be set to `1` before ALE is loaded.
"""   
"""     The markers for the highlights can be customized with the following options:
"""   
"""     |g:ale_sign_error|
"""     |g:ale_sign_warning|
"""     |g:ale_sign_info|
"""     |g:ale_sign_style_error|
"""     |g:ale_sign_style_warning|
"""   
"""     When multiple problems exist on the same line, the signs will take precedence in the order above, from highest to lowest.
"""   
"""     To limit the number of signs ALE will set, see |g:ale_max_signs|.
"""   
"""   
let g:ale_sign_priority=30                  " The larger this value is, the higher priority ALE signs have over other plugin signs.
let g:ale_sign_column_always=0              " By 0, the sign gutter will disappear when all warnings and errors have been fixed for a file. 
let g:ale_change_sign_column_color=1
let g:ale_max_signs=-1
" let g:ale_sign_info                         Default: `g:ale_sign_warning`
let g:ale_sign_warning='--'
let g:ale_sign_error='>>'
" let g:ale_sign_style_warning                Default: `g:ale_sign_warning`
" let g:ale_sign_style_error                  Default: `g:ale_sign_error`
"""   
let g:ale_sign_offset=1000000
let g:ale_sign_highlight_linenrs=1


let g:ale_disable_lsp=1
let g:ale_lsp_show_message_format='%severity%:%linter%: %s'
"""       `%s`           - replaced with the message text
"""       `%linter%`     - replaced with the name of the linter
"""       `%severity%`   - replaced with the severity of the message     
"""   
let g:ale_lsp_show_message_severity='warning' " Log severity level are always discarded.
"""     `'error'`       - Displays only errors.
"""     `'warning'`     - Displays errors and warnings.
"""     `'information'` - Displays errors, warnings and infos
"""     `'log'`         - Same as `'information'`
"""     `'disabled'`    - Doesn't display any information at all.

let g:ale_lsp_suggestions=1




let g:ale_cursor_detail=0

let g:ale_echo_cursor=1
let g:ale_echo_delay=100
let g:ale_echo_msg_format= '[%linter%] [%severity%]  %code% : %s'    " |g:ale_echo_cursor| needs to be set to 1 for messages to be displayed.
" `%s`           - replaced with the text for the problem
" `%...code...% `- replaced with the error code
" `%linter%`     - replaced with the name of the linter
" `%severity%`   - replaced with the severity of the problem
let g:ale_echo_msg_error_str='Error'          " The string used for `%severity%` for errors.
let g:ale_echo_msg_info_str='Info'
let g:ale_echo_msg_log_str='Log'
let g:ale_echo_msg_warning_str='Warning'


let g:ale_command_wrapper=''
" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
    let g:ale_command_wrapper = 'nice -n5'
endif
let g:ale_history_enabled=1
let g:ale_max_buffer_history_size=10
let g:ale_history_log_output=0

let g:ale_detail_to_floating_preview=1
let g:ale_floating_preview=0
let g:ale_floating_window_border=['|', '-', '+', '+', '+', '+']
" If the terminal supports Unicode, you might try setting the value to ` ['│', '─', '╭', '╮', '╯', '╰']`, to make it look nicer.

let g:ale_hover_cursor=1
let g:ale_hover_to_preview=0
let g:ale_hover_to_floating_preview=0
let g:ale_close_preview_on_insert=0

let g:ale_popup_menu_enabled=has('gui_running')

let g:ale_set_loclist=1 
" let g:ale_loclist_msg_format " Default: g:ale_echo_msg_format ,The strings for configuring `%severity%` are also used for this option.
let g:ale_set_quickfix=1 " instead of the loclist
let g:ale_open_list=1
let g:ale_list_window_size=10
let g:ale_keep_list_window_open=0
let g:ale_list_vertical=0

let g:ale_filename_mappings ={}       "     NOTE: Only fixers registered with a short name can support filename mapping by their fixer names. 
"""     let g:ale_filename_mappings = {
"""     \   'pylint': [
"""     \       ['/home/john/proj', '/data'],
"""     \   ],
"""     \}
"""      or 
"""     let g:ale_filename_mappings = {
"""     \ [
"""     \       ['/home/john/proj', '/data'],
"""     \ ]
"""    

let g:ale_pattern_options_enabled=1 
let g:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}


"let g:ale_set_balloons=has('balloon_eval') && has('gui_running')
let g:ale_set_balloons = has('gui_running') ? 'hover' : 0
let g:ale_set_balloons_legacy_echo=0

let g:ale_enabled=1
let g:ale_windows_node_executable_path='node.exe'
let g:ale_update_tagstack=1
let g:ale_root={}
let g:ale_cache_executable_check_failures=0
let g:ale_default_navigation='buffer'
let g:ale_virtualenv_dir_names=['.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv']
" let let g:ale_use_global_executables   This option can be set to change the default for all `_use_global` options.
" let g:ale_maximum_file_size       A maximum file size in bytes for ALE to check. 
let g:airline#extensions#ale#enabled=0

let g:ale_rename_tsserver_find_in_comments=0
let g:ale_rename_tsserver_find_in_strings=0

let g:ale_warn_about_trailing_blank_lines=0
let g:ale_warn_about_trailing_whitespace=0 

let g:ale_virtualtext_cursor=0
let g:ale_virtualtext_delay=10
let g:ale_virtualtext_prefix='V> '

" let g:ale_shell                         Override the shell used by ALE for executing commands. 
" let g:ale_shell_arguments               If this option is not set, 'shellcmdflag' will be used instead.


"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp  <Plug>(ale_previous_wrap)
nmap sn  <Plug>(ale_next_wrap)
nmap <Leader>at :ALEToggle<CR>                        " <Leader>s触发/关闭语法检查
nmap <Leader>ad :ALEDetail<CR>                        "<Leader>d查看错误或警告的详细信息

" highlight
" complete
" lsp
" echo
" lint
" fix
" list
" hover
" cursor
" refactor
" shell

"""   -------------------------------------------------------------------------------
"""   6.1. Highlights                                                *ale-highlights*
"""   
"""   ALEError                                                             *ALEError*
"""   
"""     Default: `highlight link ALEError SpellBad`
"""   
"""     The highlight for highlighted errors. See |g:ale_set_highlights|.
"""   
"""   
"""   ALEErrorLine                                                     *ALEErrorLine*
"""   
"""     Default: Undefined
"""   
"""     The highlight for an entire line where errors appear. 
"""     Only the first line for a problem will be highlighted.
"""   
"""     See |g:ale_set_signs| and |g:ale_set_highlights|.
"""   
"""   
"""   ALEErrorSign                                                     *ALEErrorSign*
"""   
"""     Default: `highlight link ALEErrorSign error`
"""   
"""     The highlight for error signs. See |g:ale_set_signs|.
"""   
"""   
"""   ALEErrorSignLineNr                                         *ALEErrorSignLineNr*
"""   
"""     Default: `highlight link ALEErrorSignLineNr CursorLineNr`
"""   
"""     The highlight for error signs. See |g:ale_set_signs|.
"""   
"""     NOTE: This highlight is only available on Neovim 0.3.2 or higher.
"""   
"""   
"""   ALEInfo                                                              *ALEInfo.*
"""                                                               *ALEInfo-highlight*
"""     Default: `highlight link ALEInfo ALEWarning`
"""   
"""     The highlight for highlighted info messages. See |g:ale_set_highlights|.
"""   
"""   
"""   ALEInfoSign                                                       *ALEInfoSign*
"""   
"""     Default: `highlight link ALEInfoSign ALEWarningSign`
"""   
"""     The highlight for info message signs. See |g:ale_set_signs|.
"""   
"""   
"""   ALEInfoLine                                                       *ALEInfoLine*
"""   
"""     Default: Undefined
"""   
"""     The highlight for entire lines where info messages appear. 
"""     Only the first line for a problem will be highlighted.
"""   
"""     See |g:ale_set_signs| and |g:ale_set_highlights|.
"""   
"""   
"""   ALEInfoSignLineNr                                           *ALEInfoSignLineNr*
"""   
"""     Default: `highlight link ALEInfoSignLineNr CursorLineNr`
"""   
"""     The highlight for error signs. See |g:ale_set_signs|.
"""   
"""     NOTE: This highlight is only available on Neovim 0.3.2 or higher.
"""   
"""   
"""   ALEStyleError                                                   *ALEStyleError*
"""   
"""     Default: `highlight link ALEStyleError ALEError`
"""   
"""     The highlight for highlighted style errors. See |g:ale_set_highlights|.
"""   
"""   
"""   ALEStyleErrorSign                                           *ALEStyleErrorSign*
"""   
"""     Default: `highlight link ALEStyleErrorSign ALEErrorSign`
"""   
"""     The highlight for style error signs. See |g:ale_set_signs|.
"""   
"""   
"""   ALEStyleErrorSignLineNr                               *ALEStyleErrorSignLineNr*
"""   
"""     Default: `highlight link ALEStyleErrorSignLineNr CursorLineNr`
"""   
"""     The highlight for error signs. See |g:ale_set_signs|.
"""   
"""     NOTE: This highlight is only available on Neovim 0.3.2 or higher.
"""   
"""   
"""   ALEStyleWarning                                               *ALEStyleWarning*
"""   
"""     Default: `highlight link ALEStyleWarning ALEError`
"""   
"""     The highlight for highlighted style warnings. See |g:ale_set_highlights|.
"""   
"""   
"""   ALEStyleWarningSign                                       *ALEStyleWarningSign*
"""   
"""     Default: `highlight link ALEStyleWarningSign ALEWarningSign`
"""   
"""     The highlight for style warning signs. See |g:ale_set_signs|.
"""   
"""   
"""   ALEStyleWarningSignLineNr                           *ALEStyleWarningSignLineNr*
"""   
"""     Default: `highlight link ALEStyleWarningSignLineNr CursorLineNr`
"""   
"""     The highlight for error signs. See |g:ale_set_signs|.
"""   
"""     NOTE: This highlight is only available on Neovim 0.3.2 or higher.
"""   
"""   
"""   ALEVirtualTextError                                       *ALEVirtualTextError*
"""   
"""     Default: `highlight link ALEVirtualTextError ALEError`
"""   
"""     The highlight for virtualtext errors. See |g:ale_virtualtext_cursor|.
"""   
"""   
"""   ALEVirtualTextInfo                                         *ALEVirtualTextInfo*
"""   
"""     Default: `highlight link ALEVirtualTextInfo ALEVirtualTextWarning`
"""   
"""     The highlight for virtualtext info. See |g:ale_virtualtext_cursor|.
"""   
"""   
"""   ALEVirtualTextStyleError                             *ALEVirtualTextStyleError*
"""   
"""     Default: `highlight link ALEVirtualTextStyleError ALEVirtualTextError`
"""   
"""     The highlight for virtualtext style errors. See |g:ale_virtualtext_cursor|.
"""   
"""   
"""   ALEVirtualTextStyleWarning                         *ALEVirtualTextStyleWarning*
"""   
"""     Default: `highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning`
"""   
"""     The highlight for virtualtext style warnings. See |g:ale_virtualtext_cursor|.
"""   
"""   
"""   ALEVirtualTextWarning                                   *ALEVirtualTextWarning*
"""   
"""     Default: `highlight link ALEVirtualTextWarning ALEWarning`
"""   
"""     The highlight for virtualtext errors. See |g:ale_virtualtext_cursor|.
"""   
"""   
"""   ALEWarning                                                         *ALEWarning*
"""   
"""     Default: `highlight link ALEWarning SpellCap`
"""   
"""     The highlight for highlighted warnings. See |g:ale_set_highlights|.
"""   
"""   
"""   ALEWarningLine                                                 *ALEWarningLine*
"""   
"""     Default: Undefined
"""   
"""     The highlight for entire lines where warnings appear. 
"""     Only the first line for a problem will be highlighted.
"""   
"""     See |g:ale_set_signs| and |g:ale_set_highlights|.
"""   
"""   
"""   ALEWarningSign                                                 *ALEWarningSign*
"""   
"""     Default: `highlight link ALEWarningSign todo`
"""   
"""     The highlight for warning signs. See |g:ale_set_signs|.
"""   
"""   
"""   ALEWarningSignLineNr                                     *ALEWarningSignLineNr*
"""   
"""     Default: `highlight link ALEWarningSignLineNr CursorLineNr`
"""   
"""     The highlight for error signs. See |g:ale_set_signs|.
"""   
"""     NOTE: This highlight is only available on Neovim 0.3.2 or higher.
"""   
"""   
"""   ===============================================================================
"""   7. Linter/Fixer Options                               *ale-integration-options*
"""   
"""   Linter and fixer options are documented below and in individual help files.
"""   
"""   Every option for programs can be set globally, or individually for each buffer. 
"""   For example, `b:ale_python_flake8_executable` will override any values set for `g:ale_python_flake8_executable`.
"""   
"""                                              *ale-integrations-local-executables*
"""   
"""   Some tools will prefer to search for locally-installed executables, unless configured otherwise. 
"""   For example, the `eslint` linter will search for various executable paths in `node_modules`. 
"""   The `flake8` linter will search for virtualenv directories.
"""   
"""   If you prefer to use global executables for those tools, set the relevant `_use_global` and `_executable` options for those linters. >
"""   
"""     " Use the global executable with a special name for eslint.
"""     let g:ale_javascript_eslint_executable = 'special-eslint'
"""     let g:ale_javascript_eslint_use_global = 1
"""   
"""     " Use the global executable with a special name for flake8.
"""     let g:ale_python_flake8_executable = '/foo/bar/flake8'
"""     let g:ale_python_flake8_use_global = 1
"""   <
"""   |g:ale_use_global_executables| can be set to `1` in your vimrc file to make ALE use global executables for all linters by default.
"""   
"""   The option |g:ale_virtualenv_dir_names| controls the local virtualenv paths ALE will use to search for Python executables.
"""   
"""   
"""   -------------------------------------------------------------------------------
"""   7.1. Options for alex                                        *ale-alex-options*
"""   
"""   The options for `alex` are shared between all filetypes, so options can be configured once.
"""   
"""   g:ale_alex_executable                                   *g:ale_alex_executable*
"""                                                           *b:ale_alex_executable*
"""     Type: |String|
"""     Default: `'alex'`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   g:ale_alex_use_global                                   *g:ale_alex_use_global*
"""                                                           *b:ale_alex_use_global*
"""     Type: |Number|
"""     Default: `get(g:, 'ale_use_global_executables', 0)`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   -------------------------------------------------------------------------------
"""   7.2. Options for cspell                                    *ale-cspell-options*
"""   
"""   The options for `cspell` are shared between all filetypes, so options can be configured only once.
"""   
"""   g:ale_cspell_executable                               *g:ale_cspell_executable*
"""                                                         *b:ale_cspell_executable*
"""     Type: |String|
"""     Default: `'cspell'`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   g:ale_cspell_options                                     *g:ale_cspell_options*
"""                                                            *b:ale_cspell_options*
"""     Type: |String|
"""     Default: `''`
"""   
"""     This variable can be set to pass additional options to `cspell`.
"""   
"""   
"""   g:ale_cspell_use_global                               *g:ale_cspell_use_global*
"""                                                         *b:ale_cspell_use_global*
"""     Type: |Number|
"""     Default: `get(g: 'ale_use_global_executables', 0)`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   -------------------------------------------------------------------------------
"""   7.3. Options for dprint                                    *ale-dprint-options*
"""   
"""   `dprint` is a fixer for many file types, including: (java|type)script, json(c?), markdown, and more. 
"""   See https://dprint.dev/plugins for an up-to-date list of supported plugins and their configuration options.
"""   
"""   g:ale_dprint_executable                               *g:ale_dprint_executable*
"""                                                         *b:ale_dprint_executable*
"""     Type: |String|
"""     Default: `'dprint'`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   g:ale_dprint_config                                       *g:ale_dprint_config*
"""                                                             *b:ale_dprint_config*
"""     Type: |String|
"""     Default: `'dprint.json'`
"""   
"""     This variable can be changed to provide a config file to `dprint`. 
"""     The default is the nearest `dprint.json` searching upward from the current buffer.
"""   
"""     See https://dprint.dev/config and https://plugins.dprint.dev
"""   
"""   
"""   g:ale_dprint_options                                     *g:ale_dprint_options*
"""                                                            *b:ale_dprint_options*
"""     Type: |String|
"""     Default: `''`
"""   
"""     This variable can be set to pass additional options to `dprint`.
"""   
"""   
"""   g:ale_dprint_use_global                               *g:ale_dprint_use_global*
"""                                                         *b:ale_dprint_use_global*
"""     Type: |Number|
"""     Default: `get(g: 'ale_use_global_executables', 0)`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   -------------------------------------------------------------------------------
"""   7.4. Options for languagetool                        *ale-languagetool-options*
"""   
"""   g:ale_languagetool_executable                   *g:ale_languagetool_executable*
"""                                                   *b:ale_languagetool_executable*
"""   
"""     Type: |String|
"""     Default: `'languagetool'`
"""   
"""     The executable to run for languagetool.
"""   
"""   
"""   g:ale_languagetool_options                         *g:ale_languagetool_options*
"""                                                      *b:ale_languagetool_options*
"""     Type: |String|
"""     Default: `'--autoDetect'`
"""   
"""     This variable can be set to pass additional options to languagetool.
"""   
"""   
"""   -------------------------------------------------------------------------------
"""   7.5. Options for write-good                            *ale-write-good-options*
"""   
"""   The options for `write-good` are shared between all filetypes, so options can be configured once.
"""   
"""   g:ale_writegood_executable                         *g:ale_writegood_executable*
"""                                                      *b:ale_writegood_executable*
"""     Type: |String|
"""     Default: `'writegood'`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   g:ale_writegood_options                               *g:ale_writegood_options*
"""                                                         *b:ale_writegood_options*
"""     Type: |String|
"""     Default: `''`
"""   
"""     This variable can be set to pass additional options to writegood.
"""   
"""   
"""   g:ale_writegood_use_global                         *g:ale_writegood_use_global*
"""                                                      *b:ale_writegood_use_global*
"""     Type: |Number|
"""     Default: `get(g:, 'ale_use_global_executables', 0)`
"""   
"""     See |ale-integrations-local-executables|
"""   
"""   
"""   -------------------------------------------------------------------------------
"""   7.6. Other Linter/Fixer Options                 *ale-other-integration-options*
"""   
"""   ALE supports a very wide variety of tools. 
"""   Other linter or fixer options are documented in additional help files.
"""   
"""     ada.....................................|ale-ada-options|
"""       cspell................................|ale-ada-cspell|
"""       gcc...................................|ale-ada-gcc|
"""       gnatpp................................|ale-ada-gnatpp|
"""       ada-language-server...................|ale-ada-language-server|
"""     ansible.................................|ale-ansible-options|
"""       ansible-lint..........................|ale-ansible-ansible-lint|
"""     apkbuild................................|ale-apkbuild-options|
"""       apkbuild-lint.........................|ale-apkbuild-apkbuild-lint|
"""       secfixes-check........................|ale-apkbuild-secfixes-check|
"""     asciidoc................................|ale-asciidoc-options|
"""       cspell................................|ale-asciidoc-cspell|
"""       write-good............................|ale-asciidoc-write-good|
"""       textlint..............................|ale-asciidoc-textlint|
"""     asm.....................................|ale-asm-options|
"""       gcc...................................|ale-asm-gcc|
"""     avra....................................|ale-avra-options|
"""       avra..................................|ale-avra-avra|
"""     awk.....................................|ale-awk-options|
"""       gawk..................................|ale-awk-gawk|
"""     bats....................................|ale-bats-options|
"""       shellcheck............................|ale-bats-shellcheck|
"""     bazel...................................|ale-bazel-options|
"""       buildifier............................|ale-bazel-buildifier|
"""     bib.....................................|ale-bib-options|
"""       bibclean..............................|ale-bib-bibclean|
"""     bitbake.................................|ale-bitbake-options|
"""       oelint-adv............................|ale-bitbake-oelint_adv|
"""     c.......................................|ale-c-options|
"""       astyle................................|ale-c-astyle|
"""       cc....................................|ale-c-cc|
"""       ccls..................................|ale-c-ccls|
"""       clangd................................|ale-c-clangd|
"""       clang-format..........................|ale-c-clangformat|
"""       clangtidy.............................|ale-c-clangtidy|
"""       cppcheck..............................|ale-c-cppcheck|
"""       cquery................................|ale-c-cquery|
"""       cspell................................|ale-c-cspell|
"""       flawfinder............................|ale-c-flawfinder|
"""       uncrustify............................|ale-c-uncrustify|
"""     chef....................................|ale-chef-options|
"""       cookstyle.............................|ale-chef-cookstyle|
"""       foodcritic............................|ale-chef-foodcritic|
"""     clojure.................................|ale-clojure-options|
"""       clj-kondo.............................|ale-clojure-clj-kondo|
"""       joker.................................|ale-clojure-joker|
"""     cloudformation..........................|ale-cloudformation-options|
"""       cfn-python-lint.......................|ale-cloudformation-cfn-python-lint|
"""     cmake...................................|ale-cmake-options|
"""       cmakelint.............................|ale-cmake-cmakelint|
"""       cmake-lint............................|ale-cmake-cmake-lint|
"""       cmake-format..........................|ale-cmake-cmakeformat|
"""     cpp.....................................|ale-cpp-options|
"""       astyle................................|ale-cpp-astyle|
"""       cc....................................|ale-cpp-cc|
"""       ccls..................................|ale-cpp-ccls|
"""       clangcheck............................|ale-cpp-clangcheck|
"""       clangd................................|ale-cpp-clangd|
"""       clang-format..........................|ale-cpp-clangformat|
"""       clangtidy.............................|ale-cpp-clangtidy|
"""       clazy.................................|ale-cpp-clazy|
"""       cppcheck..............................|ale-cpp-cppcheck|
"""       cpplint...............................|ale-cpp-cpplint|
"""       cquery................................|ale-cpp-cquery|
"""       cspell................................|ale-cpp-cspell|
"""       flawfinder............................|ale-cpp-flawfinder|
"""       uncrustify............................|ale-cpp-uncrustify|
"""     c#......................................|ale-cs-options|
"""       csc...................................|ale-cs-csc|
"""       cspell................................|ale-cs-cspell|
"""       dotnet-format.........................|ale-cs-dotnet-format|
"""       mcs...................................|ale-cs-mcs|
"""       mcsc..................................|ale-cs-mcsc|
"""       uncrustify............................|ale-cs-uncrustify|
"""     css.....................................|ale-css-options|
"""       cspell................................|ale-css-cspell|
"""       fecs..................................|ale-css-fecs|
"""       prettier..............................|ale-css-prettier|
"""       stylelint.............................|ale-css-stylelint|
"""       vscodecss.............................|ale-css-vscode|
"""     cuda....................................|ale-cuda-options|
"""       nvcc..................................|ale-cuda-nvcc|
"""       clangd................................|ale-cuda-clangd|
"""       clang-format..........................|ale-cuda-clangformat|
"""     d.......................................|ale-d-options|
"""       dfmt..................................|ale-d-dfmt|
"""       dls...................................|ale-d-dls|
"""       uncrustify............................|ale-d-uncrustify|
"""     dafny...................................|ale-dafny-options|
"""       dafny.................................|ale-dafny-dafny|
"""     dart....................................|ale-dart-options|
"""       analysis_server.......................|ale-dart-analysis_server|
"""       dart-analyze..........................|ale-dart-analyze|
"""       dart-format...........................|ale-dart-format|
"""       dartfmt...............................|ale-dart-dartfmt|
"""     desktop.................................|ale-desktop-options|
"""       desktop-file-validate.................|ale-desktop-desktop-file-validate|
"""     dhall...................................|ale-dhall-options|
"""       dhall-format..........................|ale-dhall-format|
"""       dhall-freeze..........................|ale-dhall-freeze|
"""       dhall-lint............................|ale-dhall-lint|
"""     dockerfile..............................|ale-dockerfile-options|
"""       dockerfile_lint.......................|ale-dockerfile-dockerfile_lint|
"""       dprint................................|ale-dockerfile-dprint|
"""       hadolint..............................|ale-dockerfile-hadolint|
"""     elixir..................................|ale-elixir-options|
"""       mix...................................|ale-elixir-mix|
"""       mix_format............................|ale-elixir-mix-format|
"""       dialyxir..............................|ale-elixir-dialyxir|
"""       elixir-ls.............................|ale-elixir-elixir-ls|
"""       credo.................................|ale-elixir-credo|
"""       cspell................................|ale-elixir-cspell|
"""     elm.....................................|ale-elm-options|
"""       elm-format............................|ale-elm-elm-format|
"""       elm-ls................................|ale-elm-elm-ls|
"""       elm-make..............................|ale-elm-elm-make|
"""     erlang..................................|ale-erlang-options|
"""       dialyzer..............................|ale-erlang-dialyzer|
"""       elvis.................................|ale-erlang-elvis|
"""       erlc..................................|ale-erlang-erlc|
"""       erlfmt................................|ale-erlang-erlfmt|
"""       syntaxerl.............................|ale-erlang-syntaxerl|
"""     eruby...................................|ale-eruby-options|
"""       erblint...............................|ale-eruby-erblint|
"""       ruumba................................|ale-eruby-ruumba|
"""     fish....................................|ale-fish-options|
"""       fish_indent...........................|ale-fish-fish_indent|
"""     fortran.................................|ale-fortran-options|
"""       gcc...................................|ale-fortran-gcc|
"""       language_server.......................|ale-fortran-language-server|
"""     fountain................................|ale-fountain-options|
"""     fusionscript............................|ale-fuse-options|
"""       fusion-lint...........................|ale-fuse-fusionlint|
"""     git commit..............................|ale-gitcommit-options|
"""       gitlint...............................|ale-gitcommit-gitlint|
"""     glsl....................................|ale-glsl-options|
"""       glslang...............................|ale-glsl-glslang|
"""       glslls................................|ale-glsl-glslls|
"""     go......................................|ale-go-options|
"""       bingo.................................|ale-go-bingo|
"""       cspell................................|ale-go-cspell|
"""       gobuild...............................|ale-go-gobuild|
"""       gofmt.................................|ale-go-gofmt|
"""       gofumpt...............................|ale-go-gofumpt|
"""       golangci-lint.........................|ale-go-golangci-lint|
"""       golangserver..........................|ale-go-golangserver|
"""       golines...............................|ale-go-golines|
"""       golint................................|ale-go-golint|
"""       gometalinter..........................|ale-go-gometalinter|
"""       gopls.................................|ale-go-gopls|
"""       govet.................................|ale-go-govet|
"""       revive................................|ale-go-revive|
"""       staticcheck...........................|ale-go-staticcheck|
"""     graphql.................................|ale-graphql-options|
"""       eslint................................|ale-graphql-eslint|
"""       gqlint................................|ale-graphql-gqlint|
"""       prettier..............................|ale-graphql-prettier|
"""     hack....................................|ale-hack-options|
"""       hack..................................|ale-hack-hack|
"""       hackfmt...............................|ale-hack-hackfmt|
"""       hhast.................................|ale-hack-hhast|
"""     handlebars..............................|ale-handlebars-options|
"""       prettier..............................|ale-handlebars-prettier|
"""       ember-template-lint...................|ale-handlebars-embertemplatelint|
"""     haskell.................................|ale-haskell-options|
"""       brittany..............................|ale-haskell-brittany|
"""       cspell................................|ale-haskell-cspell|
"""       floskell..............................|ale-haskell-floskell|
"""       ghc...................................|ale-haskell-ghc|
"""       ghc-mod...............................|ale-haskell-ghc-mod|
"""       cabal-ghc.............................|ale-haskell-cabal-ghc|
"""       hdevtools.............................|ale-haskell-hdevtools|
"""       hfmt..................................|ale-haskell-hfmt|
"""       hindent...............................|ale-haskell-hindent|
"""       hlint.................................|ale-haskell-hlint|
"""       hls...................................|ale-haskell-hls|
"""       stack-build...........................|ale-haskell-stack-build|
"""       stack-ghc.............................|ale-haskell-stack-ghc|
"""       stylish-haskell.......................|ale-haskell-stylish-haskell|
"""       hie...................................|ale-haskell-hie|
"""       ormolu................................|ale-haskell-ormolu|
"""     hcl.....................................|ale-hcl-options|
"""       terraform-fmt.........................|ale-hcl-terraform-fmt|
"""     help....................................|ale-help-options|
"""       cspell................................|ale-help-cspell|
"""     html....................................|ale-html-options|
"""       angular...............................|ale-html-angular|
"""       cspell................................|ale-html-cspell|
"""       fecs..................................|ale-html-fecs|
"""       html-beautify.........................|ale-html-beautify|
"""       htmlhint..............................|ale-html-htmlhint|
"""       prettier..............................|ale-html-prettier|
"""       stylelint.............................|ale-html-stylelint|
"""       tidy..................................|ale-html-tidy|
"""       vscodehtml............................|ale-html-vscode|
"""       write-good............................|ale-html-write-good|
"""     idris...................................|ale-idris-options|
"""       idris.................................|ale-idris-idris|
"""     ink.....................................|ale-ink-options|
"""       ink-language-server...................|ale-ink-language-server|
"""     inko....................................|ale-inko-options|
"""       inko..................................|ale-inko-inko|
"""     ispc....................................|ale-ispc-options|
"""       ispc..................................|ale-ispc-ispc|
"""     java....................................|ale-java-options|
"""       checkstyle............................|ale-java-checkstyle|
"""       cspell................................|ale-java-cspell|
"""       javac.................................|ale-java-javac|
"""       google-java-format....................|ale-java-google-java-format|
"""       pmd...................................|ale-java-pmd|
"""       javalsp...............................|ale-java-javalsp|
"""       eclipselsp............................|ale-java-eclipselsp|
"""       uncrustify............................|ale-java-uncrustify|
"""     javascript..............................|ale-javascript-options|
"""       cspell................................|ale-javascript-cspell|
"""       deno..................................|ale-javascript-deno|
"""       dprint................................|ale-javascript-dprint|
"""       eslint................................|ale-javascript-eslint|
"""       fecs..................................|ale-javascript-fecs|
"""       flow..................................|ale-javascript-flow|
"""       importjs..............................|ale-javascript-importjs|
"""       jscs..................................|ale-javascript-jscs|
"""       jshint................................|ale-javascript-jshint|
"""       prettier..............................|ale-javascript-prettier|
"""       prettier-eslint.......................|ale-javascript-prettier-eslint|
"""       prettier-standard.....................|ale-javascript-prettier-standard|
"""       standard..............................|ale-javascript-standard|
"""       xo....................................|ale-javascript-xo|
"""     json....................................|ale-json-options|
"""       cspell................................|ale-json-cspell|
"""       dprint................................|ale-json-dprint|
"""       eslint................................|ale-json-eslint|
"""       fixjson...............................|ale-json-fixjson|
"""       jsonlint..............................|ale-json-jsonlint|
"""       jq....................................|ale-json-jq|
"""       prettier..............................|ale-json-prettier|
"""       spectral..............................|ale-json-spectral|
"""       vscodejson............................|ale-json-vscode|
"""     jsonc...................................|ale-jsonc-options|
"""       eslint................................|ale-jsonc-eslint|
"""     jsonnet.................................|ale-jsonnet-options|
"""       jsonnetfmt............................|ale-jsonnet-jsonnetfmt|
"""       jsonnet-lint..........................|ale-jsonnet-jsonnet-lint|
"""     json5...................................|ale-json5-options|
"""       eslint................................|ale-json5-eslint|
"""     julia...................................|ale-julia-options|
"""       languageserver........................|ale-julia-languageserver|
"""     kotlin..................................|ale-kotlin-options|
"""       kotlinc...............................|ale-kotlin-kotlinc|
"""       ktlint................................|ale-kotlin-ktlint|
"""       languageserver........................|ale-kotlin-languageserver|
"""     latex...................................|ale-latex-options|
"""       cspell................................|ale-latex-cspell|
"""       write-good............................|ale-latex-write-good|
"""       textlint..............................|ale-latex-textlint|
"""     less....................................|ale-less-options|
"""       lessc.................................|ale-less-lessc|
"""       prettier..............................|ale-less-prettier|
"""       stylelint.............................|ale-less-stylelint|
"""     llvm....................................|ale-llvm-options|
"""       llc...................................|ale-llvm-llc|
"""     lua.....................................|ale-lua-options|
"""       cspell................................|ale-lua-cspell|
"""       lua-format............................|ale-lua-lua-format|
"""       luac..................................|ale-lua-luac|
"""       luacheck..............................|ale-lua-luacheck|
"""       luafmt................................|ale-lua-luafmt|
"""       selene................................|ale-lua-selene|
"""       stylua................................|ale-lua-stylua|
"""     markdown................................|ale-markdown-options|
"""       cspell................................|ale-markdown-cspell|
"""       dprint................................|ale-markdown-dprint|
"""       markdownlint..........................|ale-markdown-markdownlint|
"""       mdl...................................|ale-markdown-mdl|
"""       pandoc................................|ale-markdown-pandoc|
"""       prettier..............................|ale-markdown-prettier|
"""       remark-lint...........................|ale-markdown-remark-lint|
"""       textlint..............................|ale-markdown-textlint|
"""       write-good............................|ale-markdown-write-good|
"""     mercury.................................|ale-mercury-options|
"""       mmc...................................|ale-mercury-mmc|
"""     nasm....................................|ale-nasm-options|
"""       nasm..................................|ale-nasm-nasm|
"""     nim.....................................|ale-nim-options|
"""       nimcheck..............................|ale-nim-nimcheck|
"""       nimlsp................................|ale-nim-nimlsp|
"""       nimpretty.............................|ale-nim-nimpretty|
"""     nix.....................................|ale-nix-options|
"""       nixfmt................................|ale-nix-nixfmt|
"""       nixpkgs-fmt...........................|ale-nix-nixpkgs-fmt|
"""       statix................................|ale-nix-statix|
"""     nroff...................................|ale-nroff-options|
"""       write-good............................|ale-nroff-write-good|
"""     objc....................................|ale-objc-options|
"""       clang.................................|ale-objc-clang|
"""       clangd................................|ale-objc-clangd|
"""       uncrustify............................|ale-objc-uncrustify|
"""       ccls..................................|ale-objc-ccls|
"""     objcpp..................................|ale-objcpp-options|
"""       clang.................................|ale-objcpp-clang|
"""       clangd................................|ale-objcpp-clangd|
"""       uncrustify............................|ale-objcpp-uncrustify|
"""     ocaml...................................|ale-ocaml-options|
"""       merlin................................|ale-ocaml-merlin|
"""       ocamllsp..............................|ale-ocaml-ocamllsp|
"""       ols...................................|ale-ocaml-ols|
"""       ocamlformat...........................|ale-ocaml-ocamlformat|
"""       ocp-indent............................|ale-ocaml-ocp-indent|
"""     openapi.................................|ale-openapi-options|
"""       ibm_validator.........................|ale-openapi-ibm-validator|
"""       prettier..............................|ale-openapi-prettier|
"""       yamllint..............................|ale-openapi-yamllint|
"""     pascal..................................|ale-pascal-options|
"""       ptop..................................|ale-pascal-ptop|
"""     pawn....................................|ale-pawn-options|
"""       uncrustify............................|ale-pawn-uncrustify|
"""     perl....................................|ale-perl-options|
"""       perl..................................|ale-perl-perl|
"""       perlcritic............................|ale-perl-perlcritic|
"""       perltidy..............................|ale-perl-perltidy|
"""     perl6...................................|ale-perl6-options|
"""       perl6.................................|ale-perl6-perl6|
"""     php.....................................|ale-php-options|
"""       cspell................................|ale-php-cspell|
"""       langserver............................|ale-php-langserver|
"""       phan..................................|ale-php-phan|
"""       phpcbf................................|ale-php-phpcbf|
"""       phpcs.................................|ale-php-phpcs|
"""       phpmd.................................|ale-php-phpmd|
"""       phpstan...............................|ale-php-phpstan|
"""       psalm.................................|ale-php-psalm|
"""       php-cs-fixer..........................|ale-php-php-cs-fixer|
"""       php...................................|ale-php-php|
"""       tlint.................................|ale-php-tlint|
"""       intelephense..........................|ale-php-intelephense|
"""     po......................................|ale-po-options|
"""       write-good............................|ale-po-write-good|
"""     pod.....................................|ale-pod-options|
"""       write-good............................|ale-pod-write-good|
"""     pony....................................|ale-pony-options|
"""       ponyc.................................|ale-pony-ponyc|
"""     powershell..............................|ale-powershell-options|
"""       cspell................................|ale-powershell-cspell|
"""       powershell............................|ale-powershell-powershell|
"""       psscriptanalyzer......................|ale-powershell-psscriptanalyzer|
"""     prolog..................................|ale-prolog-options|
"""       swipl.................................|ale-prolog-swipl|
"""     proto...................................|ale-proto-options|
"""       buf-format............................|ale-proto-buf-format|
"""       buf-lint..............................|ale-proto-buf-lint|
"""       protoc-gen-lint.......................|ale-proto-protoc-gen-lint|
"""       protolint.............................|ale-proto-protolint|
"""     pug.....................................|ale-pug-options|
"""       puglint...............................|ale-pug-puglint|
"""     puppet..................................|ale-puppet-options|
"""       puppet................................|ale-puppet-puppet|
"""       puppetlint............................|ale-puppet-puppetlint|
"""       puppet-languageserver.................|ale-puppet-languageserver|
"""     purescript..............................|ale-purescript-options|
"""       purescript-language-server............|ale-purescript-language-server|
"""       purs-tidy.............................|ale-purescript-tidy|
"""       purty.................................|ale-purescript-purty|
"""     pyrex (cython)..........................|ale-pyrex-options|
"""       cython................................|ale-pyrex-cython|
"""     python..................................|ale-python-options|
"""       autoflake.............................|ale-python-autoflake|
"""       autoimport............................|ale-python-autoimport|
"""       autopep8..............................|ale-python-autopep8|
"""       bandit................................|ale-python-bandit|
"""       black.................................|ale-python-black|
"""       cspell................................|ale-python-cspell|
"""       flake8................................|ale-python-flake8|
"""       flakehell.............................|ale-python-flakehell|
"""       isort.................................|ale-python-isort|
"""       mypy..................................|ale-python-mypy|
"""       prospector............................|ale-python-prospector|
"""       pycodestyle...........................|ale-python-pycodestyle|
"""       pydocstyle............................|ale-python-pydocstyle|
"""       pyflakes..............................|ale-python-pyflakes|
"""       pylama................................|ale-python-pylama|
"""       pylint................................|ale-python-pylint|
"""       pylsp.................................|ale-python-pylsp|
"""       pyre..................................|ale-python-pyre|
"""       pyright...............................|ale-python-pyright|
"""       reorder-python-imports................|ale-python-reorder_python_imports|
"""       unimport..............................|ale-python-unimport|
"""       vulture...............................|ale-python-vulture|
"""       yapf..................................|ale-python-yapf|
"""     qml.....................................|ale-qml-options|
"""       qmlfmt................................|ale-qml-qmlfmt|
"""     r.......................................|ale-r-options|
"""       languageserver........................|ale-r-languageserver|
"""       lintr.................................|ale-r-lintr|
"""       styler................................|ale-r-styler|
"""     reasonml................................|ale-reasonml-options|
"""       merlin................................|ale-reasonml-merlin|
"""       ols...................................|ale-reasonml-ols|
"""       reason-language-server................|ale-reasonml-language-server|
"""       refmt.................................|ale-reasonml-refmt|
"""     restructuredtext........................|ale-restructuredtext-options|
"""       cspell................................|ale-restructuredtext-cspell|
"""       textlint..............................|ale-restructuredtext-textlint|
"""       write-good............................|ale-restructuredtext-write-good|
"""     robot...................................|ale-robot-options|
"""       rflint................................|ale-robot-rflint|
"""     ruby....................................|ale-ruby-options|
"""       brakeman..............................|ale-ruby-brakeman|
"""       cspell................................|ale-ruby-cspell|
"""       debride...............................|ale-ruby-debride|
"""       prettier..............................|ale-ruby-prettier|
"""       rails_best_practices..................|ale-ruby-rails_best_practices|
"""       reek..................................|ale-ruby-reek|
"""       rubocop...............................|ale-ruby-rubocop|
"""       ruby..................................|ale-ruby-ruby|
"""       rufo..................................|ale-ruby-rufo|
"""       solargraph............................|ale-ruby-solargraph|
"""       sorbet................................|ale-ruby-sorbet|
"""       standardrb............................|ale-ruby-standardrb|
"""     rust....................................|ale-rust-options|
"""       analyzer..............................|ale-rust-analyzer|
"""       cargo.................................|ale-rust-cargo|
"""       cspell................................|ale-rust-cspell|
"""       rls...................................|ale-rust-rls|
"""       rustc.................................|ale-rust-rustc|
"""       rustfmt...............................|ale-rust-rustfmt|
"""     salt....................................|ale-salt-options|
"""       salt-lint.............................|ale-salt-salt-lint|
"""     sass....................................|ale-sass-options|
"""       sasslint..............................|ale-sass-sasslint|
"""       stylelint.............................|ale-sass-stylelint|
"""     scala...................................|ale-scala-options|
"""       cspell................................|ale-scala-cspell|
"""       metals................................|ale-scala-metals|
"""       sbtserver.............................|ale-scala-sbtserver|
"""       scalafmt..............................|ale-scala-scalafmt|
"""       scalastyle............................|ale-scala-scalastyle|
"""     scss....................................|ale-scss-options|
"""       prettier..............................|ale-scss-prettier|
"""       sasslint..............................|ale-scss-sasslint|
"""       stylelint.............................|ale-scss-stylelint|
"""     sh......................................|ale-sh-options|
"""       bashate...............................|ale-sh-bashate|
"""       cspell................................|ale-sh-cspell|
"""       sh-language-server....................|ale-sh-language-server|
"""       shell.................................|ale-sh-shell|
"""       shellcheck............................|ale-sh-shellcheck|
"""       shfmt.................................|ale-sh-shfmt|
"""     sml.....................................|ale-sml-options|
"""       smlnj.................................|ale-sml-smlnj|
"""     solidity................................|ale-solidity-options|
"""       solc..................................|ale-solidity-solc|
"""       solhint...............................|ale-solidity-solhint|
"""       solium................................|ale-solidity-solium|
"""     spec....................................|ale-spec-options|
"""       rpmlint...............................|ale-spec-rpmlint|
"""     sql.....................................|ale-sql-options|
"""       dprint................................|ale-sql-dprint|
"""       pgformatter...........................|ale-sql-pgformatter|
"""       sqlfmt................................|ale-sql-sqlfmt|
"""       sqlformat.............................|ale-sql-sqlformat|
"""     stylus..................................|ale-stylus-options|
"""       stylelint.............................|ale-stylus-stylelint|
"""     sugarss.................................|ale-sugarss-options|
"""       stylelint.............................|ale-sugarss-stylelint|
"""     svelte..................................|ale-svelte-options|
"""       prettier..............................|ale-svelte-prettier|
"""       svelteserver..........................|ale-svelte-svelteserver|
"""     swift...................................|ale-swift-options|
"""       apple-swift-format....................|ale-swift-apple-swift-format|
"""       cspell................................|ale-swift-cspell|
"""       sourcekitlsp..........................|ale-swift-sourcekitlsp|
"""     systemd.................................|ale-systemd-options|
"""       systemd-analyze.......................|ale-systemd-analyze|
"""     tcl.....................................|ale-tcl-options|
"""       nagelfar..............................|ale-tcl-nagelfar|
"""     terraform...............................|ale-terraform-options|
"""       checkov...............................|ale-terraform-checkov|
"""       terraform-fmt-fixer...................|ale-terraform-fmt-fixer|
"""       terraform.............................|ale-terraform-terraform|
"""       terraform-ls..........................|ale-terraform-terraform-ls|
"""       terraform-lsp.........................|ale-terraform-terraform-lsp|
"""       tflint................................|ale-terraform-tflint|
"""     tex.....................................|ale-tex-options|
"""       chktex................................|ale-tex-chktex|
"""       cspell................................|ale-tex-cspell|
"""       lacheck...............................|ale-tex-lacheck|
"""       latexindent...........................|ale-tex-latexindent|
"""       texlab................................|ale-tex-texlab|
"""     texinfo.................................|ale-texinfo-options|
"""       cspell................................|ale-texinfo-cspell|
"""       write-good............................|ale-texinfo-write-good|
"""     text....................................|ale-text-options|
"""       cspell................................|ale-text-cspell|
"""       textlint..............................|ale-text-textlint|
"""       write-good............................|ale-text-write-good|
"""     thrift..................................|ale-thrift-options|
"""       thrift................................|ale-thrift-thrift|
"""       thriftcheck...........................|ale-thrift-thriftcheck|
"""     toml....................................|ale-toml-options|
"""       dprint................................|ale-toml-dprint|
"""     typescript..............................|ale-typescript-options|
"""       cspell................................|ale-typescript-cspell|
"""       deno..................................|ale-typescript-deno|
"""       dprint................................|ale-typescript-dprint|
"""       eslint................................|ale-typescript-eslint|
"""       prettier..............................|ale-typescript-prettier|
"""       standard..............................|ale-typescript-standard|
"""       tslint................................|ale-typescript-tslint|
"""       tsserver..............................|ale-typescript-tsserver|
"""       xo....................................|ale-typescript-xo|
"""     v.......................................|ale-v-options|
"""       v.....................................|ale-v-v|
"""       vfmt..................................|ale-v-vfmt|
"""     vala....................................|ale-vala-options|
"""       uncrustify............................|ale-vala-uncrustify|
"""     verilog/systemverilog...................|ale-verilog-options|
"""       hdl-checker...........................|ale-verilog-hdl-checker|
"""       iverilog..............................|ale-verilog-iverilog|
"""       verilator.............................|ale-verilog-verilator|
"""       vlog..................................|ale-verilog-vlog|
"""       xvlog.................................|ale-verilog-xvlog|
"""       yosys.................................|ale-verilog-yosys|
"""     vhdl....................................|ale-vhdl-options|
"""       ghdl..................................|ale-vhdl-ghdl|
"""       hdl-checker...........................|ale-vhdl-hdl-checker|
"""       vcom..................................|ale-vhdl-vcom|
"""       xvhdl.................................|ale-vhdl-xvhdl|
"""     vim help................................|ale-vim-help-options|
"""       write-good............................|ale-vim-help-write-good|
"""     vim.....................................|ale-vim-options|
"""       vimls.................................|ale-vim-vimls|
"""       vint..................................|ale-vim-vint|
"""     vue.....................................|ale-vue-options|
"""       cspell................................|ale-vue-cspell|
"""       prettier..............................|ale-vue-prettier|
"""       vls...................................|ale-vue-vls|
"""       volar.................................|ale-vue-volar|
"""     wgsl....................................|ale-wgsl-options|
"""       naga..................................|ale-wgsl-naga|
"""     xhtml...................................|ale-xhtml-options|
"""       cspell................................|ale-xhtml-cspell|
"""       write-good............................|ale-xhtml-write-good|
"""     xml.....................................|ale-xml-options|
"""       xmllint...............................|ale-xml-xmllint|
"""     yaml....................................|ale-yaml-options|
"""       actionlint............................|ale-yaml-actionlint|
"""       circleci..............................|ale-yaml-circleci|
"""       prettier..............................|ale-yaml-prettier|
"""       spectral..............................|ale-yaml-spectral|
"""       swaglint..............................|ale-yaml-swaglint|
"""       yaml-language-server..................|ale-yaml-language-server|
"""       yamlfix...............................|ale-yaml-yamlfix|
"""       yamllint..............................|ale-yaml-yamllint|
"""     yang....................................|ale-yang-options|
"""       yang-lsp..............................|ale-yang-lsp|
"""     zeek....................................|ale-zeek-options|
"""       zeek..................................|ale-zeek-zeek|
"""     zig.....................................|ale-zig-options|
"""       zls...................................|ale-zig-zls|
"""   
"""   
"""   ===============================================================================
"""   8. Commands/Keybinds                                             *ale-commands*
"""   
"""   ALEComplete                                                       *ALEComplete*
"""   
"""     Manually trigger LSP autocomplete and show the menu. 
"""     Works only when called from insert mode. >
"""   
"""       inoremap <silent> <C-Space> <C-\><C-O>:ALEComplete<CR>
"""   <
"""     A plug mapping `<Plug>(ale_complete)` is defined for this command. >
"""   
"""       imap <C-Space> <Plug>(ale_complete)
"""   <
"""   ALEDocumentation                                             *ALEDocumentation*
"""   
"""     Similar to the |ALEHover| command, retrieve documentation information for the symbol at the cursor. 
"""     Documentation data will always be shown in a preview window, no matter how small the documentation content is.
"""   
"""     NOTE: This command is only available for `tsserver`.
"""   
"""     A plug mapping `<Plug>(ale_documentation)` is defined for this command.
"""   
"""   
"""   ALEFindReferences                                           *ALEFindReferences*
"""   
"""     Find references in the codebase for the symbol under the cursor using the enabled LSP linters for the buffer. 
"""     ALE will display a preview window containing the results if some references are found.
"""   
"""     The window can be navigated using the usual Vim navigation commands. 
"""     The Enter key (`<CR>`) can be used to jump to a referencing location, or the `t` key can be used to jump to the location in a new tab.
"""   
"""     The locations opened in different ways using the following variations.
"""   
"""     `:ALEFindReferences -tab`       - Open the location in a new tab.
"""     `:ALEFindReferences -split`     - Open the location in a horizontal split.
"""     `:ALEFindReferences -vsplit`    - Open the location in a vertical split.
"""     `:ALEFindReferences -quickfix`  - Put the locations into quickfix list.
"""   
"""     The default method used for navigating to a new location can be changed by modifying |g:ale_default_navigation|.
"""   
"""     You can add `-relative` to the command to view results with relatives paths, instead of absolute paths. 
"""     This option has no effect if `-quickfix` is used.
"""   
"""     The selection can be opened again with the |ALERepeatSelection| command.
"""   
"""     You can jump back to the position you were at before going to a reference of something with jump motions like CTRL-O. 
"""     See |jump-motions|.
"""   
"""     A plug mapping `<Plug>(ale_find_references)` is defined for this command.
"""     You can define additional plug mapping with any additional options you want like so: >
"""   
"""     nnoremap <silent> <Plug>(my_mapping) :ALEFindReferences -relative<Return>
"""   <
"""   
"""   ALEFix                                                                 *ALEFix*
"""   
"""     Fix problems with the current buffer. See |ale-fix| for more information.
"""   
"""     If the command is run with a bang (`:ALEFix!`), all warnings will be suppressed, 
"""     including warnings about no fixers being defined, and warnings about not being able to apply fixes to a file because it has been changed.
"""   
"""     A plug mapping `<Plug>(ale_fix)` is defined for this command.
"""   
"""   
"""   ALEFixSuggest                                                   *ALEFixSuggest*
"""   
"""     Suggest tools that can be used to fix problems in the current buffer.
"""   
"""     See |ale-fix| for more information.
"""   
"""   
"""   ALEGoToDefinition `<options>`                               *ALEGoToDefinition*
"""   
"""     Jump to the definition of a symbol under the cursor using the enabled LSP linters for the buffer. 
"""     ALE will jump to a definition if an LSP server provides a location to jump to. 
"""     Otherwise, ALE will do nothing.
"""   
"""     The locations opened in different ways using the following variations.
"""   
"""     `:ALEGoToDefinition -tab`    - Open the location in a new tab.
"""     `:ALEGoToDefinition -split`  - Open the location in a horizontal split.
"""     `:ALEGoToDefinition -vsplit` - Open the location in a vertical split.
"""   
"""     The default method used for navigating to a new location can be changed by modifying |g:ale_default_navigation|.
"""   
"""     You can jump back to the position you were at before going to the definition of something with jump motions like CTRL-O. 
"""     See |jump-motions|.
"""   
"""     You should consider using the 'hidden' option in combination with this command. 
"""     Otherwise, Vim will refuse to leave the buffer you're jumping from unless you have saved your edits.
"""   
"""     The following Plug mappings are defined for this command, which correspond to the following commands.
"""   
"""     `<Plug>(ale_go_to_definition)`           - `:ALEGoToDefinition`
"""     `<Plug>(ale_go_to_definition_in_tab)`    - `:ALEGoToDefinition -tab`
"""     `<Plug>(ale_go_to_definition_in_split)`  - `:ALEGoToDefinition -split`
"""     `<Plug>(ale_go_to_definition_in_vsplit)` - `:ALEGoToDefinition -vsplit`
"""   
"""   
"""   ALEGoToTypeDefinition                                   *ALEGoToTypeDefinition*
"""   
"""     This works similar to |ALEGoToDefinition| but instead jumps to the definition of a type of a symbol under the cursor. 
"""     ALE will jump to a definition if an LSP server provides a location to jump to. 
"""     Otherwise, ALE will do nothing.
"""   
"""     The locations opened in different ways using the following variations.
"""   
"""     `:ALEGoToTypeDefinition -tab`    - Open the location in a new tab.
"""     `:ALEGoToTypeDefinition -split`  - Open the location in a horizontal split.
"""     `:ALEGoToTypeDefinition -vsplit` - Open the location in a vertical split.
"""   
"""     The default method used for navigating to a new location can be changed by modifying |g:ale_default_navigation|.
"""   
"""     You can jump back to the position you were at before going to the definition of something with jump motions like CTRL-O. 
"""     See |jump-motions|.
"""   
"""     The following Plug mappings are defined for this command, which correspond to the following commands.
"""   
"""     `<Plug>(ale_go_to_type_definition)`           - `:ALEGoToTypeDefinition`
"""     `<Plug>(ale_go_to_type_definition_in_tab)`    - `:ALEGoToTypeDefinition -tab`
"""     `<Plug>(ale_go_to_type_definition_in_split)`  - `:ALEGoToTypeDefinition -split`
"""     `<Plug>(ale_go_to_type_definition_in_vsplit)` - `:ALEGoToTypeDefinition -vsplit`
"""   
"""   
"""   ALEGoToImplementation                                   *ALEGoToImplementation*
"""   
"""     This works similar to |ALEGoToDefinition| but instead jumps to the implementation of symbol under the cursor. 
"""     ALE will jump to a definition if an LSP server provides a location to jump to. 
"""     Otherwise, ALE will do nothing.
"""   
"""     The locations opened in different ways using the following variations.
"""   
"""     `:ALEGoToImplementation -tab`    - Open the location in a new tab.
"""     `:ALEGoToImplementation -split`  - Open the location in a horizontal split.
"""     `:ALEGoToImplementation -vsplit` - Open the location in a vertical split.
"""   
"""     The default method used for navigating to a new location can be changed by modifying |g:ale_default_navigation|.
"""   
"""     You can jump back to the position you were at before going to the definition of something with jump motions like CTRL-O. 
"""     See |jump-motions|.
"""   
"""     The following Plug mappings are defined for this command, which correspond to the following commands.
"""   
"""     `<Plug>(ale_go_to_implementation)`           - `:ALEGoToImplementation`
"""     `<Plug>(ale_go_to_implementation_in_tab)`    - `:ALEGoToImplementation -tab`
"""     `<Plug>(ale_go_to_implementation_in_split)`  - `:ALEGoToImplementation -split`
"""     `<Plug>(ale_go_to_implementation_in_vsplit)` - `:ALEGoToImplementation -vsplit`
"""   
"""   
"""   ALEHover                                                             *ALEHover*
"""   
"""     Print brief information about the symbol under the cursor, taken from any
"""     available LSP linters. There may be a small non-blocking delay before
"""     information is printed.
"""   
"""     NOTE: In Vim 8, long messages will be shown in a preview window, 
"""     as Vim 8 does not support showing a prompt to press enter to continue for long messages from asynchronous callbacks.
"""   
"""     A plug mapping `<Plug>(ale_hover)` is defined for this command.
"""   
"""   
"""   ALEImport                                                           *ALEImport*
"""   
"""     Try to import a symbol using `tsserver` or a Language Server.
"""   
"""     ALE will look for completions for the word at the cursor which contain additional text edits that possible insert lines to import the symbol. 
"""     The first match with additional text edits will be used, and may add other code to the current buffer other than import lines.
"""   
"""     If linting is enabled, and |g:ale_lint_on_text_changed| is set to ever check buffers when text is changed, the buffer will be checked again after changes are made.
"""   
"""     A Plug mapping `<Plug>(ale_import)` is defined for this command. 
"""     This mapping should only be bound for normal mode.
"""   
"""   
"""   ALEOrganizeImports                                         *ALEOrganizeImports*
"""   
"""     Organize imports using tsserver. Currently not implemented for LSPs.
"""   
"""   
"""   ALERename                                                           *ALERename*
"""   
"""     Rename a symbol using `tsserver` or a Language Server.
"""   
"""     The symbol where the cursor is resting will be the symbol renamed, and a prompt will open to request a new name.
"""   
"""     The rename operation will save all modified buffers when `set nohidden` is set, because that disables leaving unsaved buffers in the background. 
"""     See `:help hidden` for more details.
"""   
"""   ALEFileRename                                                   *ALEFileRename*
"""   
"""     Rename a file and fix imports using `tsserver`.
"""   
"""   ALECodeAction                                                   *ALECodeAction*
"""   
"""     Apply a code action via LSP servers or `tsserver`.
"""   
"""     If there is an error present on a line that can be fixed, ALE will automatically fix a line, unless there are multiple possible code fixes to apply.
"""   
"""     This command can be run in visual mode apply actions, such as applicable refactors. 
"""     A menu will be shown to select code action to apply.
"""   
"""   
"""   ALERepeatSelection                                         *ALERepeatSelection*
"""   
"""     Repeat the last selection displayed in the preview window.
"""   
"""   
"""   ALESymbolSearch `<query>`                                     *ALESymbolSearch*
"""   
"""     Search for symbols in the workspace, taken from any available LSP linters.
"""   
"""     The arguments provided to this command will be used as a search query for finding symbols in the workspace, such as functions, types, etc.
"""   
"""     You can add `-relative` to the command to view results with relatives paths, instead of absolute paths.
"""   
"""                                                                        *:ALELint*
"""   ALELint                                                               *ALELint*
"""   
"""     Run ALE once for the current buffer. 
"""     This command can be used to run ALE manually, instead of automatically, if desired.
"""   
"""     This command will also run linters where `lint_file` is evaluates to `1`, meaning linters which check the file instead of the Vim buffer.
"""   
"""     A plug mapping `<Plug>(ale_lint)` is defined for this command.
"""   
"""   
"""   ALELintStop                                                       *ALELintStop*
"""   
"""     Stop any currently running jobs for checking the current buffer.
"""   
"""     Any problems from previous linter results will continue to be shown.
"""   
"""   
"""   ALEPopulateQuickfix                                       *ALEPopulateQuickfix*
"""   ALEPopulateLocList                                         *ALEPopulateLocList*
"""   
"""     Manually populate the |quickfix| or |location-list| and show the corresponding list. 
"""     Useful when you have other uses for both the |quickfix| and |location-list| and don't want them automatically populated. 
"""     Be sure to disable auto populating: >
"""   
"""       let g:ale_set_quickfix = 0
"""       let g:ale_set_loclist = 0
"""   <
"""     With these settings, ALE will still run checking and display it with signs, highlighting, and other output described in |ale-lint-file-linters|.
"""   
"""   ALEPrevious                                                       *ALEPrevious*
"""   ALEPreviousWrap                                               *ALEPreviousWrap*
"""   ALENext                                                               *ALENext*
"""   ALENextWrap                                                       *ALENextWrap*
"""   ALEFirst                                                             *ALEFirst*
"""   ALELast                                                               *ALELast*
"""                                                         *ale-navigation-commands*
"""   
"""     Move between warnings or errors in a buffer. 
"""     ALE will only navigate between the errors or warnings it generated, even if both |g:ale_set_quickfix| and |g:ale_set_loclist| are set to `0`.
"""   
"""     `ALEPrevious` and `ALENext` will stop at the top and bottom of a file, 
"""     while `ALEPreviousWrap` and `ALENextWrap` will wrap around the file to find the last or first warning or error in the file, respectively.
"""   
"""     `ALEPrevious` and `ALENext` take optional flags arguments to custom their behavior :
"""     `-wrap` enable wrapping around the file
"""     `-error`, `-warning` and `-info` enable jumping to errors, warnings or infos respectively, ignoring anything else. 
"""       They are mutually exclusive and if several are provided the priority is the following: error > warning > info.
"""     `-style` and `-nostyle` allow you to jump respectively to style error or warning and to not style error or warning. 
"""       They also are mutually exclusive and nostyle has priority over style.
"""   
"""     Flags can be combined to create create custom jumping. 
"""     Thus you can use ":ALENext -wrap -error -nosyle" to jump to the next error which is not a style error while going back to the beginning of the file if needed.
"""   
"""     `ALEFirst` goes to the first error or warning in the buffer, while `ALELast` goes to the last one.
"""   
"""     The following |<Plug>| mappings are defined for the commands: >
"""     <Plug>(ale_previous) - ALEPrevious
"""     <Plug>(ale_previous_wrap) - ALEPreviousWrap
"""     <Plug>(ale_previous_error) - ALEPrevious -error
"""     <Plug>(ale_previous_wrap_error) - ALEPrevious -wrap -error
"""     <Plug>(ale_previous_warning) - ALEPrevious -warning
"""     <Plug>(ale_previous_wrap_warning) - ALEPrevious -wrap -warning
"""     <Plug>(ale_next) - ALENext
"""     <Plug>(ale_next_wrap) - ALENextWrap
"""     <Plug>(ale_next_error) - ALENext -error
"""     <Plug>(ale_next_wrap_error) - ALENext -wrap -error
"""     <Plug>(ale_next_warning) - ALENext -warning
"""     <Plug>(ale_next_wrap_warning) - ALENext -wrap -warning
"""     <Plug>(ale_first) - ALEFirst
"""     <Plug>(ale_last) - ALELast
"""   <
"""     For example, these commands could be bound to the keys Ctrl + j and Ctrl + k: >
"""   
"""     " Map movement through errors without wrapping.
"""     nmap <silent> <C-k> <Plug>(ale_previous)
"""     nmap <silent> <C-j> <Plug>(ale_next)
"""     " OR map keys to use wrapping.
"""     nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"""     nmap <silent> <C-j> <Plug>(ale_next_wrap)
"""   <
"""   
"""   ALEToggle                                                           *ALEToggle*
"""   ALEEnable                                                           *ALEEnable*
"""   ALEDisable                                                         *ALEDisable*
"""   ALEToggleBuffer                                               *ALEToggleBuffer*
"""   ALEEnableBuffer                                               *ALEEnableBuffer*
"""   ALEDisableBuffer                                             *ALEDisableBuffer*
"""   
"""     `ALEToggle`, `ALEEnable`, and `ALEDisable` enable or disable ALE linting, including all of its autocmd events, loclist items, quickfix items, signs, current jobs, etc., globally. 
"""     Executing any of these commands will change the |g:ale_enabled| variable.
"""   
"""     ALE can be disabled or enabled for only a single buffer with `ALEToggleBuffer`, `ALEEnableBuffer`, and `ALEDisableBuffer`. 
"""     Disabling ALE for a buffer will not remove autocmd events, 
"""     but will prevent ALE from checking for problems and reporting problems for whatever buffer the `ALEDisableBuffer` or `ALEToggleBuffer` command is executed from. 
"""     These commands can be used for temporarily disabling ALE for a buffer. 
"""     These commands will modify the |b:ale_enabled| variable.
"""   
"""     ALE linting cannot be enabled for a single buffer when it is disabled globally, as disabling ALE globally removes the autocmd events needed to perform linting with.
"""   
"""     The following plug mappings are defined, for conveniently defining keybinds:
"""   
"""     |ALEToggle|        - `<Plug>(ale_toggle)`
"""     |ALEEnable|        - `<Plug>(ale_enable)`
"""     |ALEDisable|       - `<Plug>(ale_disable)`
"""     |ALEToggleBuffer|  - `<Plug>(ale_toggle_buffer)`
"""     |ALEEnableBuffer|  - `<Plug>(ale_enable_buffer)`
"""     |ALEDisableBuffer| - `<Plug>(ale_disable_buffer)`
"""   
"""     For removing problems reported by ALE, but leaving ALE enabled, see |ALEReset| and |ALEResetBuffer|.
"""   
"""                                                                      *:ALEDetail*
"""   ALEDetail                                                           *ALEDetail*
"""   
"""     Show the full linter message for the problem nearest to the cursor on the given line in the preview window. 
"""     The preview window can be easily closed with the `q` key. 
"""     If there is no message to show, the window will not be opened.
"""   
"""     If a loclist item has a `detail` key set, the message for that key will be preferred over `text`. See |ale-loclist-format|.
"""   
"""     A plug mapping `<Plug>(ale_detail)` is defined for this command.
"""   
"""   
"""                                                                        *:ALEInfo*
"""   ALEInfo                                                               *ALEInfo*
"""   ALEInfoToClipboard                                         *ALEInfoToClipboard*
"""   
"""     Print runtime information about ALE, 
"""     including the values of global and buffer-local settings for ALE, the linters that are enabled, the commands that have been run, and the output of commands.
"""   
"""     ALE will log the commands that are run by default. 
"""     If you wish to disable this, set |g:ale_history_enabled| to `0`. 
"""     Because it could be expensive, ALE does not remember the output of recent commands by default. 
"""     Set |g:ale_history_log_output| to `1` to enable logging of output for commands.
"""     ALE will only log the output captured for parsing problems, etc.
"""   
"""     The command `:ALEInfoToClipboard` can be used to output ALEInfo directly to your clipboard. 
"""     This might not work on every machine.
"""   
"""     `:ALEInfoToFile` will write the ALE runtime information to a given filename.
"""     The filename works just like |:w|.
"""   
"""   
"""   ALEReset                                                             *ALEReset*
"""   ALEResetBuffer                                                 *ALEResetBuffer*
"""   
"""     `ALEReset` will remove all problems reported by ALE for all buffers.
"""     `ALEResetBuffer` will remove all problems reported for a single buffer.
"""   
"""     Either command will leave ALE linting enabled, so ALE will report problems when linting is performed again. 
"""     See |ale-lint| for more information.
"""   
"""     The following plug mappings are defined, for conveniently defining keybinds:
"""   
"""     |ALEReset|       - `<Plug>(ale_reset)`
"""     |ALEResetBuffer| - `<Plug>(ale_reset_buffer)`
"""   
"""     ALE can be disabled globally or for a buffer with |ALEDisable| or |ALEDisableBuffer|.
"""   
"""   
"""   ALEStopAllLSPs                                                 *ALEStopAllLSPs*
"""   
"""     `ALEStopAllLSPs` will close and stop all channels and jobs for all LSP-like clients, 
"""     including tsserver, remove all of the data stored for them, and delete all of the problems found for them, updating every linted buffer.
"""   
"""     This command can be used when LSP clients mess up and need to be restarted.
"""   
"""   
"""   ===============================================================================
