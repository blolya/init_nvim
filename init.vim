call plug#begin('~/.local/share/nvim/plugged')
" rust
Plug 'rust-lang/rust.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" ncm2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'dense-analysis/ale'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'

" themes
Plug 'sainnhe/gruvbox-material'

call plug#end()

" nvim settings ----------------
syntax enable
filetype plugin indent on
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
set hidden
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}

" remapping -------------------
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <C-Left> :bprevious<CR>                                                                            
nnoremap <C-Right> :bnext<CR>
nnoremap <C-j> :bprevious<CR>                                                                            
nnoremap <C-k> :bnext<CR>
nnoremap <F6> :make run<CR>

let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vex
    endif
endfunction
noremap <silent> <C-E> :call ToggleNetrw()<CR>

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
set number
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" ale settings ------------------
let g:ale_linters = {'rust': ['analyzer']}

" languageClient settings ------
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }

" rooter settings --------------
let g:rooter_patterns = ['.Cargo.toml']

" theme settings ---------------
" For dark version.
set background=dark
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'soft'
" For better performance
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material

