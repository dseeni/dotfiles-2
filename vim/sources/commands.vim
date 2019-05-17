command -nargs=+ Grep execute "vimgrep /".<f-args>."/j **"
command -nargs=+ Spelling execute 'setlocal spell spelllang=<args>'
command -range=% Enumerate normal :let i=1 | <line1>,<line2>g/^/s//\=i.'. '/ | let i=i+1 | noh<CR>
command -range=% Sort normal :<line1>,<line2>sort i<CR>
command Debug normal :Termdebug<CR><C-w>H
command SortBlock :normal! vip:sort i<CR>

" SIMPLE TOGGLE ----------------------------------------------------------------
command RelativeNumber setlocal relativenumber!
command Whitespace setlocal list!
command Wrap setlocal wrap!

" SHELL COMMANDS ---------------------------------------------------------------
command ExecCurrentLine normal :.w !sh<CR>
command SudoW :execute ':silent w !sudo tee % > /dev/null' | :edit!
