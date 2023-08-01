let g:ale_fix_on_save = 1

if exists('g:ale_fixers')

    let g:ale_fixers['hellolang'] = ['hello-fmt']

else

    let g:ale_fixers = {
    \   'hellolang': ['hello-fmt'],
    \}

endif
