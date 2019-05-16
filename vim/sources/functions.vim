" Fill rest of line with characters
function! s:FillLine(str)
    .s/[[:space:]]*$//
    let reps = (s:textwidth - col("$")) / len(a:str)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" Repeats given string
function! s:RepeatStr(times, str)
    execute ":normal a" . repeat(a:str, a:times)
endfunction

" Toggle cursor line and column highlight
function s:CursorHighlightToggle()
    setlocal cursorcolumn!
    if (s:CursorHighlight_state == 1)
        hi CursorLine cterm=none ctermbg=none
        let s:CursorHighlight_state = 0
    else
        hi CursorLine cterm=none ctermbg=235
        let s:CursorHighlight_state = 1
    endif
    echo
endfunction

" Sorts lines based on visual-block selected portion of the lines
function! s:VisSort(isnmbr) range
    if visualmode() != "\<c-v>"
        exe "sil! ".a:firstline.",".a:lastline.s:vissort_sort
        return
    endif
    let firstline= line("'<")
    let lastline = line("'>")
    let keeprega = @a
    silent norm! gv"ay
    '<,'>s/^/@@@/
    silent! keepj norm! '<0"aP
    if a:isnmbr
        sil! '<,'>s/^\s\+/\=substitute(submatch(0),' ','0','g')/
    endif
    execute "sil! keepj '<,'>".s:vissort_sort
    execute "sil! keepj ".firstline.",".lastline.'s/^.\{-}@@@//'
    let @a= keeprega
endfun

" Toggle Netrw window
function! s:ToggleNetrw()
    if t:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout! " . i
            endif
            let i-=1
        endwhile
        let t:NetrwIsOpen=0
    else
        let t:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Delete "expired" cache files
" TODO


" NECESSARY VARIABLES ----------------------------------------------------------

let s:CursorHighlight_state = 0
let s:textwidth             = 80
let s:vissort_sort          = "sort i"

autocmd VimEnter,TabEnter * let t:NetrwIsOpen=0

" CALLING COMMANDS -------------------------------------------------------------

command! -nargs=+ FillLine call <SID>FillLine('<args>')
command! -nargs=+ RepeatStr call <SID>RepeatStr(<f-args>)
command! -range -nargs=0 -bang Vissort sil! keepj <line1>,<line2>call <SID>VisSort(<bang>0)


" MAPPINGS ---------------------------------------------------------------------

map <F3> :call <SID>CursorHighlightToggle()<CR>
noremap <silent> <F4> :call <SID>ToggleNetrw()<CR>
