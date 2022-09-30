"
" Plugins
"

" Plugins with nvim-plug
call plug#begin('/opt/nvim-plug')
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() },
         \ 'for': ['markdown', 'vim-plug']}
    " Latex integration
    Plug 'lervag/vimtex', { 'for': ['tex']}
    " Status bar
    Plug 'vim-airline/vim-airline'
    " File browser
    Plug 'preservim/nerdtree'
    " Git client
    Plug 'tpope/vim-fugitive'
    " LSP
    Plug 'neovim/nvim-lspconfig'
    " Autocomplete suggestions
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
        " 9000+ Snippets
        Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    " Improved markdown lists
    Plug 'dkarter/bullets.vim'
    " Automatic language detection
    Plug 'Konfekt/vim-DetectSpellLang'
    " Automatic punctuation pairs
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" COQ
let g:coq_settings = {
    \ 'auto_start'                  : 'shut-up',
    \ 'match.unifying_chars'        : ["_"],
    \ 'display.ghost_text.context'  : [ " ", ""],
    \ 'keymap.jump_to_mark'         : "<c-q>"
    \ }                               " Default <c-h> breaks for us

" LSP and keybinds
lua << EOF
local lsp = require 'lspconfig'
local coq = require 'coq'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<M-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>s', '<cmd>ClangdSwitchSourceHeader<CR>', opts)

  buf_set_keymap('n', '<C-l>', '<cmd> LspStart<CR>', opts)
  -- 'LspStop' is broken for us
  buf_set_keymap('n', '<C-M-l>', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'texlab', 'rust_analyzer' }
for _, srv in ipairs(servers) do
  lsp[srv].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }))
end
EOF

" vimtex
let g:tex_flavor='latex'
let g:tex_conceal='abdmgs'
" Disable continuous compilation because we don't have a supported pdf viewer
let g:vimtex_compiler_latexmk = {'continuous': 0}
let maplocalleader = " "

" airline
let g:airline_theme='onedark'
"let g:airline_powerline_fonts = 1

" markdown-preview
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
" Echo preview page URL in command line when opened
let g:mkdp_echo_preview_url = 1

" NERDTree
"let NERDTreeQuitOnOpen = 0
" Close the tab if NERDTree is the only window remaining in it.
au BufEnter * if winnr('$') == 1 && exists('b:NERDTree')
    \ && b:NERDTree.isTabTree() | quit | endif
" Start NERDTree when Vim is started without file arguments.
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists('s:std_in')
                                \ | NERDTree | wincmd p | endif
" Make NERDTree prettier
let NERDTreeMinimalUI = 1

" vim-DetectSpellLang
let g:detectspelllang_langs = {
    \ 'hunspell': [ 'en_GB', 'fr_FR', 'da_DK', 'en_US' ],
    \ 'aspell'  : [ 'en_GB', 'fr_FR', 'da_DK', 'en_US' ],
    \ }

" auto-pairs
" Change or disable all unnecessary insert mode shortcuts
let g:AutoPairsShortcutFastWrap = ''
"let g:AutoPairsShortcutJump = ''   " <M-n>
let g:AutoPairsShortcutBackInsert = ''
" Disable unneeded options
let g:AutoPairsMapCh = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0
" Tweak pairs for filetypes
au Filetype markdown let b:AutoPairs = { '(':')',
                                     \   '[':']',
                                     \   '{':'}',
                                     \   "'":"'",
                                     \   '"':'"',
                                     \   '`':'`',
                                     \ '```':'```',
                                     \   '*':'*',
                                     \  '**':'**' }
au Filetype c,cpp,objc,objcpp,cf,java,arduino
    \ let b:AutoPairs = { '(':')',
                      \   '[':']',
                      \   '{':'}',
                      \   "'":"'",
                      \   '"':'"',
                      \   "`":"`",
                      \  '/*':'*/' }
au Filetype tex
    \ let b:AutoPairs = { '(':')',
                      \   '[':']',
                      \   '{':'}',
                      \   "'":"'",
                      \   '"':'"',
                      \   "`":"`",
                      \   '$':'$' }

"
" Plugin keybindings
"

" markdown-preview
nmap <silent> <C-p> <Plug>MarkdownPreviewToggle
nmap <silent> <C-M-p> <Plug>MarkdownPreviewStop

" NERDTree
nnoremap <silent> <C-n> :NERDTreeFind<CR>
nnoremap <silent> <C-M-n> :NERDTreeToggle<CR>

" auto-pairs
let g:AutoPairsShortcutToggle = '<C-M-a>'   " Toggle Auto-pairs

"
" Internal keybindings
"

" Swap backslash and space for leader
let mapleader = " "
nmap <bslash> <space>

" Use Q for formatting.
map Q gq

" Split window and tab shortcuts
nmap <silent> <C-M-k> :wincmd k<CR>
nmap <silent> <C-M-j> :wincmd j<CR>
nmap <silent> <C-M-h> :wincmd h<CR>
nmap <silent> <C-M-l> :wincmd l<CR>

nmap <silent> <C-j> :tabNext<CR>
nmap <silent> <C-k> :tabnext<CR>
nmap <silent> <C-l> :tablast<CR>
nmap <silent> <C-h> :tabfirst<CR>

" Automatically format Code and return to the previous absolute location
" (the cfmt command is a shell alias to a formatting tool for C style languages.
au Filetype c,cpp,objc,objcpp,cf,java,arduino
    \ nmap <buffer> <C-c> m`:%!cfmt<CR>``zz<CR>
au Filetype rust
    \ nmap <buffer> <C-c> m`:%!rustfmt<CR>``zz<CR>

" Diff original file and buffer
nmap <C-M-o> :Difforig<CR>:wincmd p<CR>

" Insert result of an expression, like a calculation
inoremap <C-f> <C-r>=

" Autocorrect previous misspelling and move back to previous cursor position.
inoremap <silent> <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
" Open spelling suggestion menu on current word
inoremap <C-M-s> <C-x>s

" Delete (Eliminate) the next word without saving to register
inoremap <silent> <C-e> <C-o>"_de

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U (delete from cursor to beginning of line) after
" inserting a line break.
inoremap <silent> <C-u> <C-G>u<C-U>

" Similarly, to delete from cursor until the end of the line.
inoremap <silent> <C-M-u> <C-o>D

" Prevent omnifunc from opening preview window
set completeopt-=preview

"
" Visual
"

" Highlight the 81st and over non-whitespace character on all lines
hi Over80Chars ctermbg=red guibg=DarkRed
let w:m1=matchadd('Over80Chars', '\%>80v.\+', -1)
" Highlight trailing whitespace when not in insert mode on or after it.
hi ExtraWhitespace ctermbg=red guibg=Red
match ExtraWhitespace /\s\+\%#\@<!$/

" Automatically render some symbols and markup (useful for latex and markdown)
set conceallevel=1

" Improve colours if not in TTY (Arc-Dark inspired theme)
if !empty($DISPLAY)
    set termguicolors
    " Visual selection
    hi Visual guibg=#4c5263
    " Concealed text
    hi Conceal guibg=#3c4253
    " Search highlight colour (gold is more pleasant)
    hi Search guibg=#ffc000 guifg=black
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
    " Window border and statusline intersection
    hi VertSplit guifg=#3e4452 guibg=#3e4452
    hi StatusLineNC guifg=#3e4452
    hi Statusline guifg=#3e4452
    " Comments should be in italics
    hi Comment gui=italic
    " Brighter gold and italics for TODO and similar special words
    hi Todo guibg=#ffd700 gui=italic
    " 'gutter' used by LSP
    hi SignColumn guibg=NONE ctermbg=NONE
endif

"
" Miscellaneous
"

" Use semi-persistent history.
call mkdir("/tmp/nvim-1000/undo", "p", 0700)
set undodir=/tmp/nvim-1000/undo
set undofile

" Disable default mode indicator (we have airline)
set noshowmode

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Filetype and format configuration
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,
              \.png,.toc
set suffixes-=.h
set suffixes-=.obj
" For line-based features
set formatoptions+=ron2l
set textwidth=80

" When on, the ":substitute" flag 'g' is default on.  This means that all
" matches in a line are substituted instead of one.
set gdefault

" Enable and configure spellcheck
set spell
" Selection is not needed thanks to vim-DetectSpellLang
"setlocal spell spelllang=en_gb
"setlocal spell spelllang=fr
"setlocal spell spelllang=da
"setlocal spell spelllang=en_us
set spellsuggest=10

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
" Every wrapped line will continue visually indented (same amount of space as
" the beginning of that line)
set breakindent
" Place case labels at the indent level of the switch statement
set cino=:0

" When 'confirm' is on, certain operations that would normally fail because of
" unsaved changes to a buffer, e.g. ":q" and ":e", instead raise a dialog asking
" if you wish to save the current file(s).
set confirm

" Use X clipboard.
set clipboard=unnamedplus

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
set mouse=a

" When editing a file, always jump to the last known cursor position and centre
" the line.  Don't do it when the position is invalid, when inside an event
" handler (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
au BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\"zz"
    \ | endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command Difforig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
