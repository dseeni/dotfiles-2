" Fill rest of line with characters
function! FillLine( str )
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    .s/[[:space:]]*$//
    let reps = (tw - col("$")) / len(a:str)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction


" CALLING COMMANDS -------------------------------------------------------------
command! -nargs=+ FillLine call FillLine('<args>')
