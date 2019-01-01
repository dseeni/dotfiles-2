" Set leader
let mapleader="`"
let maplocalleader=','
map <space> <leader>

" leader + sth
inoremap <leader><Tab> <C-v><Tab>
nnoremap <leader>v gg0vG$

" leader + function keys -- also mapped: <F1>, <F4>
noremap <leader><F2> :set wrap!<CR>

" Function keys -- also mapped: <F8>
inoremap <F1> <Esc>gTi
inoremap <F2> <Esc>gti
noremap <F1> gT
noremap <F2> gt
noremap <F4> :set invrelativenumber<CR>
noremap <F9> :w <bar> make<CR>

" Ctrl + sth
inoremap <C-d> <ESC>:t.<CR>i
inoremap <C-o> <C-x><C-o>
inoremap <C-p> <ESC>"+pa
noremap <C-d> :t.<CR>
noremap <C-p> "+p
noremap <C-q><C-q> q
noremap <C-y> "+y

" Normal keys
noremap '' ``
noremap - $
noremap 0 ^
noremap <CR> o<ESC>
noremap <Tab> <C-w><C-w>
noremap G G0
noremap gff <C-w>gf
noremap gfg gf
noremap gg gg0
noremap j gj
noremap k gk
noremap N Nzz
noremap n nzz

" <nop>
map ` <nop>
map c <nop>
map gh <nop>
map K <nop>
map q <nop>
map Q <nop>
map ZZ <nop>

" UNUSED -----------------------------------------------------------------------
" noremap <leader>= gg=G``
