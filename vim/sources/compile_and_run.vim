function CompileAndRun(cmd)
    if has('nvim') " you will have no way to break infinite loop
        exec "nnoremap <buffer> <F8> :w <bar> split <bar> term ".a:cmd."<CR>i"
    else
        exec "nnoremap <buffer> <F8> :w <bar> !".a:cmd."<CR>"
    endif
endfunction

" ------------------------------------------------------------------------------

" BASIC // for Vintage BASIC
autocmd filetype basic call CompileAndRun("vintbas %")

" C
autocmd filetype c call CompileAndRun("gcc -std=gnu11 -g % -o %< && ./%<")

" C++
autocmd filetype cpp call CompileAndRun("g++ -std=gnu++11 -g % -o %< && ./%<")

" Haskell
autocmd filetype haskell call CompileAndRun("ghc -o %< %; rm %<.hi %<.o && ./%<")

" HTML
autocmd filetype html nnoremap <buffer> <F8> :w <bar> !firefox %<CR><CR>

" LaTeX
autocmd filetype tex nnoremap <buffer> <F8> :w <bar> !latexmk -pdf % && latexmk -c && zathura %<.pdf<CR>

" Lisp
autocmd filetype lisp call CompileAndRun("clisp %")

" Lua
autocmd filetype lua call CompileAndRun("lua %")

" Markdown // depends on Markdown Preview plugin
autocmd filetype markdown nnoremap <buffer> <F8> :MarkdownPreview<CR>

" Python
autocmd filetype python call CompileAndRun("python3 %")

" Rust
autocmd filetype rust call CompileAndRun("rustc % && ./%<")

" Shell Script
autocmd filetype sh call CompileAndRun("%:p")
