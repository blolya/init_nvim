call plug#begin('~/.local/share/nvim/plugged')
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'

" search and navigation
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" themes
Plug 'sainnhe/gruvbox-material'

call plug#end()
" nvim settings ----------------
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
set hidden
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}

" remapping -------------------
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> K :ALEHover<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <F2> :ALERename<CR>
nnoremap <C-Left> :bprevious<CR>                                                                            
nnoremap <C-Right> :bnext<CR>
nnoremap <C-j> :bprevious<CR>                                                                            
nnoremap <C-k> :bnext<CR>
nnoremap <F6> :Cargo run<CR>

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
noremap <silent> <C-F> :Files <CR>

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
let g:ale_completion_enabled = 1

" rooter settings --------------
let g:rooter_patterns = ['Cargo.toml']

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

