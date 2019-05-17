" Turns on detection, plugin and indent
filetype plugin indent on

" Open file at the last known position
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif

" Disable continuation of comments to the next line (it cannot be just '-cro')
autocmd FileType * set fo-=c fo-=r fo-=o

" Trim trailing whitespace
autocmd BufWritePre * silent! undojoin | %s/\s\+$//e | %s/\(\n\r\?\)\+\%$//e

" Markdown TAB = 2 SPACES
autocmd filetype markdown setlocal tabstop=2 softtabstop=2

" Clear all maches after leaving buffer
autocmd BufWinLeave * call clearmatches()

" C/C++ formatting
autocmd filetype c,cpp setlocal formatprg=astyle\ --style=kr\ -s4\ -N\ -S\ -xG\ -xU\ -f\ -k3\ -xj\ -p

" In some cases less than 80 columns of code is impossible
autocmd filetype java,javascript setlocal colorcolumn=

" Quit QuickFix window along with source file window
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" | q | endif

" QuickFix window below other windows
autocmd FileType qf wincmd J

" Open QuickFix window after Grep
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l*    lwindow

" Close Vim, if last window is netrw
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" | q | endif

" NETRW autocmds
autocmd filetype netrw nnoremap <buffer> <F1> gT
autocmd filetype netrw setlocal statusline=\ NETRW

" PACKAGES
packadd matchit
packadd termdebug


" FILETYPE ISSUES --------------------------------------------------------------
" Dict structure:   FILE ENDING : FILETYPE
"   FILE ENDING may or not may be with dot (eg. tags files)
let s:ft_issues = {
            \ ".asm"  : "nasm",
            \ ".conf" : "conf",
            \ ".js"   : "javascript",
            \ ".S"    : "asm",
            \}

for [ending, ft] in items(s:ft_issues)
    execute "autocmd BufWinEnter *".ending." setlocal filetype=".ft
endfor


" FOLDING ----------------------------------------------------------------------

autocmd BufReadPre * set foldmethod=indent
autocmd BufWinEnter * if &fdm == 'indent' | set foldmethod=manual | endif

let s:syntax_fold_languages = [ "c", "cpp", "java", "javascript" ]
for ft in s:syntax_fold_languages
    execute "autocmd filetype ".ft." setlocal foldmethod=syntax"
endfor
