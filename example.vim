let g:ale_fix_on_save = 1

if exists('g:ale_fixers')

    let g:ale_fixers['hellolang'] = ['hellofmt']

else

    let g:ale_fixers = {
    \   'hellolang': ['hellofmt'],
    \}

endif

let g:ale_lint_on_save = 1

if exists('g:ale_linters')

  let g:ale_linters['hellolang'] = ['hellolint']

else

  let g:ale_linters = {
  \   'hellolang': ['hellolint'],
  \}

endif
