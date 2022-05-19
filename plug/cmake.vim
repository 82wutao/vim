"" 
"" 
"" " Generating a project build system~ *:CMakeGenerate*
"" CMakeGenerate[!] [config] [opts]
"" 			Generate project build system for a CMake project.  If [!] is supplied, the existing build system is removed before generating a new one.  
""             [config] specifies the build configuration to generate.  
""             [opts] are passed directly to CMake.
"" 
"" default CMakeGenerate
"" 	cmake -D CMAKE_BUILD_TYPE=Debug [...]  -S <project_root> -B <build_dir_location>/Debug
"" 
"" buildtype_param CMakeGenerate Release [...]
"" 	cmake -D CMAKE_BUILD_TYPE=Release [...]  -S <project_root> -B <build_dir_location>/Release
"" 
"" config_param CMakeGenerate SomeConfigName -D CMAKE_BUILD_TYPE=Release [...]
"" 	cmake -D CMAKE_BUILD_TYPE=Release [...]  -S <project_root> -B <build_dir_location>/SomeConfigName
"" 
"" 
"" 
"" " Remove project build system relative to the current build configuration.
"" CMakeClean
"" 
"" 
"" 
"" " Building and installing a project~ *:CMakeBuild*
"" CMakeBuild[!] [opts] [target] [-- [nativeopts]]
"" 			Build a project using the generated build system from the current build configuration, 
""             and populate a quickfix list (see |cmake-quickfix|).  
""             If [!] is supplied, the existing build files are cleaned (using CMake's `--clean-first` option) before building the project.  
""             [opts] are passed directly to CMake.  
""             [target] is the target to build instead of the default target.  
""             [nativeopts] are passed directly to the native tool.
"" 
"" CMakeBuild --parallel 4 mytarget -- VERBOSE=1
"" CMakeBuild --parallel 4 <TAB> " tab for buildtarget
"" 
"" 
"" 
"" " Switching between build configurations~
"" :CMakeSwitch {config}   
""     Switch to build configuration {config}.  
""     The build configuration must exist, 
""     that is, there has to be a project build system (for instance generated with |:CMakeGenerate|) in the directory {config}.  
"" 
"" CMakeSwitch Release
"" 
"" 
"" 
"" " Opening and closing the CMake console~
"" CMakeOpen		
"" CMakeClose	
"" 
"" " Stopping the running command~
"" CMakeStop		
""     Stop the command that is currently running in the Vim-CMake console.  
""     Stopping a command does not trigger the associated events (see |cmake-events|).
"" 
"" Global <Plug> mappings~
"" 
"" <Plug>(CMakeGenerate)	Equivalent to `:CMakeGenerate`.
"" 
"" <Plug>(CMakeClean)	Equivalent to `:CMakeClean`.
"" 
"" <Plug>(CMakeBuild)	Equivalent to `:CMakeBuild`.
"" 
"" <Plug>(CMakeBuildTarget)
"" 			Inserts `:CMakeBuild` in the command line, and leaves
"" 			the cursor there.
"" 
"" <Plug>(CMakeInstall)	Equivalent to `:CMakeInstall`.
"" 
"" <Plug>(CMakeSwitch)	Inserts `:CMakeSwitch` in the command line, and leaves
"" 			the cursor there.
"" 
"" <Plug>(CMakeOpen)	Equivalent to `:CMakeOpen`.
"" 
"" <Plug>(CMakeClose)	Equivalent to `:CMakeClose`.
"" 
"" <Plug>(CMakeStop)	Equivalent to `:CMakeStop`.
"" 
"" Example usage of the <Plug> mappings:
"" 	nmap <leader>cg <Plug>(CMakeGenerate)
"" 	nmap <leader>cb <Plug>(CMakeBuild)
"" 	nmap <leader>ci <Plug>(CMakeInstall)
"" 	nmap <leader>cs <Plug>(CMakeSwitch)
"" 	nmap <leader>cq <Plug>(CMakeClose)
"" 
"" CMake console window key mappings~
"" 
"" cg			Run `:CMakeGenerate`.
"" cb			Run `:CMakeBuild`.
"" ci			Run `:CMakeInstall`.
"" cq			Close the CMake console window.
"" <C-C>			Stop the running command.

"" g:cmake_command (default: `'cmake'`)
"" 			Name (or full path) of the CMake executable.
"" 
"" g:cmake_default_config (default: `'Debug'`)
"" 			Default build configuration on start-up.
"" 
"" g:cmake_build_dir_location (default: `'.'`)
"" 			Location of the build directory, relative to the
"" 			project root.  Each build configuration creates a
"" 			build directory at this location.
"" 
"" g:cmake_generate_options (default: `[]`)
"" 			List of options to pass to CMake by default when
"" 			running |:CMakeGenerate|.
"" 
"" g:cmake_build_options (default: `[]`)
"" 			List of options to pass to CMake by default when
"" 			running |:CMakeBuild|.
"" 
"" g:cmake_native_build_options (default: `[]`)
"" 			List of options to pass to the native tool by default
"" 			when running |:CMakeBuild|.
"" 
"" g:cmake_console_size (default: `15`)
"" 			Size of the CMake console window.
"" 
"" g:cmake_console_position (default: `'botright'`)
"" 			Command modifier to use when opening the CMake console
"" 			window (see |:botright|).
"" 
"" g:cmake_console_echo_cmd (default: `1`)
"" 			Echo running command in the Vim-CMake console, before
"" 			showing the output for the command itself.
"" 
"" g:cmake_jump (default: `0`)
"" 			Whether to jump to the CMake console window when
"" 			running a `:CMake` command.
"" 
"" g:cmake_jump_on_completion (default: `0`)
"" 			Whether to jump to the CMake console window when a
"" 			`:CMake` command completes.
"" 
"" g:cmake_jump_on_error (default: `1`)
"" 			Whether to jump to the CMake console window when a
"" 			`:CMake` command returns an error.
"" 
"" g:cmake_link_compile_commands (default: `0`)
"" 			Whether to create a symlink in the CMake source
"" 			directory to the `compile_commands.json` file.  If
"" 			this is enabled, the CMake configuration options
"" 			`CMAKE_EXPORT_COMPILE_COMMANDS` will be set to `ON`
"" 			(unless explicitly set to something else in the
"" 			command-line arguments to `:CMakeGenerate`).  NOTE:
"" 			under MS-Windows, creating symlinks only work if the
"" 			"Developer mode" is enabled, or if running the console
"" 			as an administrator.
"" 
"" g:cmake_root_markers (default: `['.git', '.svn']`)
"" 			List of file/directory names used to locate the
"" 			project root.  When Vim-CMake is loaded, it looks for
"" 			the project root starting from the CWD.
"" 
"" g:cmake_log_file (default: `''`)
"" 			Path to a file where to store the log of Vim-CMake.
"" 			An empty value disables logging.
