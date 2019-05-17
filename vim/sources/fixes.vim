" tmux - WINDOW TITLE FIX
if has ("title")
    if &t_ts == "" && ( &term == "screen" || &term == "xterm" )
        let &t_ts = "\e]2;"
    endif
    if &t_ts != ""
        set title
    endif
endif

" Redraw after command 'silent'
command! -nargs=+ Silent execute 'silent <args>' | redraw!


" Filetype issues --------------------------------------------------------------
" Dict structure:   FILE ENDING : FILETYPE
"   FILE ENDING may or not may be with dot (eg. tags files)
let s:ft_issues = {
            \ ".asm"  : "nasm",
            \ ".js"   : "javascript",
            \ ".S"    : "asm",
            \}

for [ending, ft] in items(s:ft_issues)
    execute "autocmd BufWinEnter *".ending." setlocal filetype=".ft
endfor
