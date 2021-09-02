"
" Plugins
"

" Plugins with nvim-plug
call plug#begin('/opt/nvim-plug')
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'lervag/vimtex', { 'for': ['tex']}
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
        " 9000+ Snippets
        Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" Configure statusline (airline)
let g:airline_theme='onedark'
"let g:airline_powerline_fonts = 1

" Configure markdown-preview
" options for markdown render
"   middle: mean the cursor position always show at the middle of the preview
"           page
"   top: mean the vim top viewport always show at the top of the preview page
"   relative: mean the cursor position always show at the relative position of
"             the preview page
let g:mkdp_preview_options = {
\ 'sync_scroll_type': 'relative',
\ }
" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '${name}'

" Configure NERDTree
let NERDTreeQuitOnOpen = 1
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree')
    \ && b:NERDTree.isTabTree() | quit | endif
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Make NERDTree prettier
let NERDTreeMinimalUI = 1

" Configure COQ
let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'match.unifying_chars': ["_"]
    \ }

" Configure auto-pairs
" Change or disable all insert mode shortcuts
let g:AutoPairsShortcutToggle = '<C-M-b>'    " For Brackets
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

"
" Miscellaneous
"

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Filetype and format configuration
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set suffixes-=.h
set suffixes-=.obj
" For automatic comment features
set formatoptions+=ro

" Highlight the 81st non-whitespace character on all lines
set textwidth=80
hi ColorColumn ctermbg=red guibg=DarkRed
call matchadd('ColorColumn', '\%81v\S', 100)
" Highlight trailing whitespace when not in insert mode on or after it.
highlight ExtraWhitespace ctermbg=red guibg=Red
match ExtraWhitespace /\s\+\%#\@<!$/

" When on, the ":substitute" flag 'g' is default on.  This means that all
" matches in a line are substituted instead of one.
set gdefault

" Improve colours if not in TTY (Arc-Dark inspired theme)
if !empty($DISPLAY)
    set termguicolors
    " Visual selection
    hi Visual guibg=#555555
    " Search highlight colour (gold is more pleasant)
    hi Search guibg=#eec600 guifg=black
    " Pop-up menu
    hi Pmenu guibg=#4b5162
    hi PmenuSel guibg=#63a5f3 guifg=#000000
    " Line numbers
    hi LineNr guifg=#5c6273
    hi CursorLineNr guifg=#7c818c
    " Tabline
    hi TabLineFill guifg=#383c4a
    hi TabLine guifg=#cccccc guibg=#383c4a
    hi TabLineSel guifg=White guibg=#4b5162
    " Window border
    hi VertSplit guifg=#494d5b guibg=#494d5b
endif

" Enable and configure spellcheck
set spell
setlocal spell spelllang=en_gb
"setlocal spell spelllang=da_dk
"setlocal spell spelllang=fr_fr
"setlocal spell spelllang=en_us
set spellsuggest+=10

" General shortcuts
" Split window shortcuts
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>
" Autocorrect or autocomplete spelling and move to the end of a word.
inoremap <silent> <C-s> <C-c>1z=ea
" Automatically format Code and return to the previous absolute location
" (the format command should be a shell alias to a formatting tool)
nmap <C-c> ma:%!format<CR>`a
" Diff original file and buffer
nmap <C-M-o> :Difforig<CR>
" Delete (Eliminate) the next word without saving to register
inoremap <C-e> <C-o>"_de

" Plugin Shortcuts
" markdown-preview shortcuts
nmap <C-p> <Plug>MarkdownPreviewToggle
nmap <C-M-p> <Plug>MarkdownPreviewStop
" NERDTree shortcuts
nnoremap <C-n> :NERDTreeFind<CR>
nnoremap <C-M-n> :NERDTreeToggle<CR>


" Show @@@ in the last line if it is truncated.
set display=truncate

" Show the line number relative to the line with the cursor in front of each
" line to help you use the some vertical motion commands, except on the
" current line where absolute line number is shown.
set relativenumber
set number

" Searching with smartcase will only act case sensitive if the search pattern
" contains an uppercase letter.
set ignorecase
set smartcase

" Configure tabs and indentation.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Apply indentation of the current line to the next when created.
set smartindent

" When 'confirm' is on, certain operations that would normally fail because of
" unsaved changes to a buffer, e.g. ":q" and ":e", instead raise a dialog
" asking if you wish to save the current file(s).
set confirm

" Use X clipboard.
set clipboard=unnamedplus

" Use Q for formatting. Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
set mouse=a

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand Difforig".
command Difforig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
\ | wincmd p | diffthis

