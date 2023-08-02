" global config
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1

" add 'hellofmt' to configured fixers
if !exists('g:ale_fixers')
    let g:ale_fixers = {}
endif
let g:ale_fixers['hellolang'] = ['hellofmt']

" NOTE: generally you don't need to manually configure ale_linters
" " add 'hellolint' to configured linters
" if !exists('g:ale_linters')
"   let g:ale_linters = {}
" endif
" let g:ale_linters['hellolang'] = ['hellolint']
