"-------------- Key-mapping(F2-F11 are free) ------------""
"Switch between .cpp/.hpp files
nnoremap <F2> :FSHere<CR>

call coc#config('languageserver', {
            \ 'clangd': {
            \   "command": "${CLANGD}",
            \   "args": ["--background-index"],
            \   "rootPatterns": ["compile_flags.txt", "compile_commands.json", ".vim/", ".git/", ".hg/"],
            \   "filetypes": ["c", "cpp", "objc", "objcpp"]
            \ }
            \})

"---------- clang-format settings --------""
let g:clang_format#code_style="webkit"
let g:clang_format#auto_format=1
let g:clang_format#auto_formatexpr=1
let g:clang_format#auto_format_on_insert_leave=0

"------------- vim-quickui settings  ------------------"
let s:cmake = "cd build; cmake"
let s:cd_top = "cd ..;"
let s:link_json = "ln -s build/compile_commands.json .;"
let s:make = "cd build/; make; \n"

let s:update = "update | w |"
let s:ccc = "clear; cd build; cmake"
let s:make_debug   = s:cmake ." ". $CMAKE_ARGS ." ". $CMAKE_EXPORT_JSON ." ". $C_COMPILER ." ". $CXX_COMPILER ." ". $CMAKE_DEBUG . s:cd_top . s:link_json . s:make
let s:make_release = s:cmake ." ". $CMAKE_ARGS ." ". $CMAKE_EXPORT_JSON ." ". $C_COMPILER ." ". $CXX_COMPILER ." ". $CMAKE_RELEASE . s:cd_top . s:link_json . s:make
let s:make_test    = s:cmake ." ". $CMAKE_ARGS ." ". $CMAKE_EXPORT_JSON ." ". $C_BUILD_TEST ." ". $C_COMPILER ." ". $CXX_COMPILER ." ". $CMAKE_DEBUG . s:cd_top . s:link_json . s:make
let s:project_clear = "clear; rm -rfv build/**; rm -rfv debug/**; rm -rfv release/**; rm -rfv compile_commands.json; \n"

let s:cmake_configure = s:cmake ." ". " -L .. | less && exit \n"
let s:cmake_show_vars = s:cmake ." ". $C_COMPILER ." ". "..  -LAH | less && exit \n"
let s:cmake_show_help = "cmake --help-full | less && exit \n"

call quickui#menu#clear('P&roject')
" dgmrtsc--pvfe--iu--b
call quickui#menu#install('P&roject', [
            \ [ 'make(&debug)', s:update.'call HTerminal(0.4, 300.0, "'. s:make_debug .'")' ],
            \ [ 'run(debu&g)', s:update.'call HTerminal(0.4, 300.0, "clear; debug/'. $NAME .' \n")' ],
            \ [ '&make(release)', s:update.'call HTerminal(0.4, 300.0, "'. s:make_release .'")' ],
            \ [ '&run(release)', s:update.'call HTerminal(0.4, 300.0, "clear; release/'. $NAME .'\n")' ],
            \ [ 'make(&test)', s:update.'call HTerminal(0.4, 300.0, "'. s:make_test .'")' ],
            \ [ 'run(te&st)', s:update.'call HTerminal(0.4, 300.0, "clear; build/tests/tests \n")' ],
            \ [ '&clean-project', s:update.'call HTerminal(0.4, 300.0, "'. s:project_clear .'")' ],
            \ [ "--", '' ],
            \ [ "cmake-hel&p", 'call FTerminal("'. s:cmake_show_help .'")' ],
            \ [ "cmake-&vars", 'call FTerminal("'. s:cmake_show_vars .'")' ],
            \ [ "cmake-con&figure", 'call FTerminal("'. s:cmake_configure .'")' ],
            \ [ "cmake-help-s&earch", 'call CmakeSH()' ],
            \ [ "--", '' ],
            \ [ "l&ibc-help", 'call LibcSH()' ],
            \ [ "libc-help-&under-cursor", 'call LibcSHUC()' ],
            \ [ "--", '' ],
            \ [ "nix-collect-gar&bage", 'call HTerminal(0.4, 300.0, "clear; nix-store --gc \n")' ],
            \ ], 5000)

"coiustrpfs
call quickui#menu#install('&Debugging', [
            \ [ "&continue\tF(5)", 'call feedkeys("\<Plug>VimspectorContinue")' ],
            \ [ "step-&over\tF(6)", 'call feedkeys("\<Plug>VimspectorStepOver")' ],
            \ [ "step-&into\tF(7)", 'call feedkeys("\<Plug>VimspectorStepInto")' ],
            \ [ "step-o&ut\tF(8)", 'call feedkeys("\<Plug>VimspectorStepOut")' ],
            \ [ "&stop\tF(9)", 'call feedkeys("\<Plug>VimspectorStop")' ],
            \ [ "&toggle-breakpoint\tF(10)", 'call feedkeys("\<Plug>VimspectorToggleBreakpoint")' ],
            \ [ "&pause\tShift-p", 'call feedkeys("\<Plug>VimspectorPause")' ],
            \ [ "&restart\tShift-r", 'call feedkeys("\<Plug>VimspectorRestart")' ],
            \ [ "clo&se-debugger\tShift-s", ':call vimspector#Reset()' ],
            \ ], 5001)

"rutnpm
call quickui#menu#install('&Test', [
            \ [ "&run", 'GTestRun' ],
            \ [ "run-&under-cursor", 'GTestRunUnderCursor' ],
            \ [ "&toggle-enable", 'GTestToggleEnabled' ],
            \ [ "&next", 'GTestNext' ],
            \ [ "&previous", 'GTestPrev' ],
            \ [ "ju&mp-to-test", 'GTestJump' ],
            \ ], 5002)

"casmgn--pd--eb--xfoiat
call quickui#menu#install('C&oc', [
            \ [ "&config", 'CocConfig' ],
            \ [ "code-&action", 'exec "normal \<Plug>(coc-codeaction)"' ],
            \ [ "codeaction-&selected", 'exec "normal \<Plug>(coc-codeaction-selected)"' ],
            \ [ "co&mmand", 'call feedkeys("\<Plug>(coc-command)")' ],
            \ [ "dia&gnostics", 'exec "normal \<Plug>(coc-diagnostics)"' ],
            \ [ "cha&nnel-output", 'CocCommand workspace.showOutput' ],
            \ [ "--", '' ],
            \ [ "im&plementation", 'call feedkeys("\<Plug>(coc-implementation)")' ],
            \ [ "&definition", 'call feedkeys("\<Plug>(coc-definition)")' ],
            \ [ "--", '' ],
            \ [ "&enable", 'CocEnable' ],
            \ [ "disa&ble", 'CocDisable' ],
            \ [ "--", '' ],
            \ [ "e&xtensions", ':CocList extensions' ],
            \ [ "&fix-current", 'exec "normal \<Plug>(coc-fix-current)"' ],
            \ [ "f&ormat-selected", 'exec "normal \<Plug>(coc-format-selected)"' ],
            \ [ "&info", 'CocInfo' ],
            \ [ "inst&all", 'exec "noraml \<Plug>(coc-install)"' ],
            \ [ "lis&t", ':CocList' ],
            \ [ "log", ':CocOpenLog' ],
            \ [ "outline", ':CocList outline' ],
            \ [ "rename", 'exec "noraml \<Plug>(coc-rename)"' ],
            \ [ "restart", 'CocRestart' ],
            \ [ "references", 'exec "noraml \<Plug>(coc-references)"' ],
            \ [ "type-definition", 'exec "noraml \<Plug>(coc-type-definition)"' ],
            \ ], 5003)
