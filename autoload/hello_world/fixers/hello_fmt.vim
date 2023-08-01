" Author: coolaj86 (AJ ONeal) <coolaj86@proton.me>
" Description: Integration of HelloLang Formatter with ALE.

call ale#Set('hellolang_hello_fmt_executable', 'hello-fmt')
call ale#Set('hellolang_hello_fmt_use_global', get(g:, 'ale_use_global_executables', 0))
call ale#Set('hellolang_hello_fmt_options', '')

" function! ale#fixers#hello_fmt#GetExecutable(buffer) abort
function! hello_world#fixers#hello_fmt#GetExecutable(buffer) abort
    return ale#path#FindExecutable(a:buffer, 'hellolang_hello_fmt', [
    \   'node_modules/hellolang-tools/bin/fmt.js',
    \   'node_modules/.bin/hello-fmt',
    \])
endfunction

" function! ale#fixers#hello_fmt#Fix(buffer) abort
function! hello_world#fixers#hello_fmt#Fix(buffer) abort
    let l:executable = ale#Var(a:buffer, 'hellolang_hello_fmt_executable')
    let l:options = ale#Var(a:buffer, 'hellolang_hello_fmt_options')

    if !executable(l:executable)
        return 0
    endif

    return {
    \   'command': ale#Escape(l:executable)
    \       . ' fmt'
    \       . ale#Pad(l:options)
    \       . ' --stdin-filepath %s',
    \}

    " seems to have an issue reading from stdin when writing to stdout
    " return {
    " \   'command': ale#Escape(l:executable)
    " \       . ' fmt'
    " \       . ale#Pad(l:options)
    " \       . ' --stdin-filepath %s -o %t',
    " \   'read_temporary_file': 1,
    " \}
endfunction
