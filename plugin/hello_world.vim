" hellolang
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.hello.txt set filetype=hellolang
    " use JS syntax because we're not creating a syntax for this demo
    au BufNewFile,BufRead *.hello.txt set syntax=javascript
augroup END

call ale#fix#registry#Add(
\  'hellofmt',
\  'hello_world#fixers#hello_fmt#Fix',
\  ['hellolang'],
\  'Apply HelloLang format to a file.'
\)
