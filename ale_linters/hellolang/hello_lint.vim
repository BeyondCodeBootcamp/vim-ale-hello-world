" Author: AJ ONeal <aj@beyondcodebootcamp.com>
" Description: hellolang integration for ALE

" call ale#Set('hellolang_hello_lint_executable', 'tsserver')
call ale#Set('hellolang_hello_lint_executable', 'hello-lint')
call ale#Set('hellolang_hello_lint_config_path', '')
call ale#Set('hellolang_hello_lint_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#hellolang#hello_lint#FindProjectRoot(buffer) abort
    let l:project_root = ale#path#FindNearestFile(a:buffer, '.package.json')
    let l:mods = ':h'

    if empty(l:project_root)
        let l:project_root = ale#path#FindNearestDirectory(a:buffer, '.git')
        let l:mods = ':h:h'
    endif

    return !empty(l:project_root) ? fnamemodify(l:project_root, l:mods) : ''
endfunction

" \   'lsp': 'tsserver',
call ale#linter#Define('hellolang', {
\   'name': 'hellolint',
\   'lsp': 'stdio',
\   'executable': {b -> ale#path#FindExecutable(b, 'hellolang_hello_lint', [
\       'node_modules/hellolang/bin/lint.js',
\       'node_modules/.bin/hello-lint',
\   ])},
\   'command': '%e --stdio',
\   'language': 'hellolang',
\   'project_root': function('ale_linters#hellolang#hello_lint#FindProjectRoot'),
\})
