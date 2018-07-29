" Environment {
  " Vundle {
    set nocompatible                " Must be first line
    filetype off

    " set the runtime path to include vundle and initialize
    set rtp+=~/.vim/bundle/vundle
    call vundle#begin()

    Plugin 'easymotion/vim-easymotion'
    Plugin 'altercation/vim-colors-solarized'

    " All plugins must be added before the following line
    call vundle#end()
  " }

  " Let Vim use utf-8 internally
  set encoding=utf-8
  " Let vim save file using utf-8
  set fileencoding=utf-8
  let g:netrw_dirhistmax=0
" }

" Key (re)Mappings {
  let mapleader = ','
  " Wrapped lines goes down/up to next row, rather than next line.
  noremap j gj
  noremap k gk
  map <C-L> <C-W>l<C-W>_
  map <C-H> <C-W>h<C-W>_

  " Let <CR> works like <C-Y> when pop menu is visible
  inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"
" }

" General {
  " Vim UI {
    " colorscheme industry
    " set background=dark             " Assume a dark background

    syntax on                       " Syntax highlighting

    set cursorline                  " Highlight current line
    set cursorcolumn                " Highlight current column
    " highlight CursorLine cterm=NONE ctermbg=242
    " highlight CursorColumn ctermbg=242

    " highlight clear SignColumn      " SignColumn should match background
    " highlight clear LineNr          " Current line number row will have same background color in relative mode

    set number
    set relativenumber

    set colorcolumn=80

    set scrolloff=10                " Minimum lines to keep above and below cursor

    set incsearch                   " Find as you type search
    set ignorecase
    set smartcase                   " Case sensitive when upper case present
    set hlsearch                    " Highlight search matches

    set list
    set listchars=tab:>\ ,trail:•

    set matchpairs+=<:>

    set wildmenu                    " Show list instead of just completing

    if has('cmdline_info')
      set ruler
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    endif

    if has('statusline')
      set laststatus=2            " Always show status line

      set statusline=%<%f
      set statusline+=%m%r
      "set statusline+=%w%h%m%r
      set statusline+=[%{&ff}/%Y]
      set statusline+=[%{getcwd()}]
      set statusline+=%=%14.(%l,%c%V%)\ %p%%
    endif
  " }

  " Formatting {
    "set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every 4 columns
    set softtabstop=2               " Let backspace delete indent
    set backspace=indent,eol,start

    " C++ {
      autocmd FileType cpp setlocal cinoptions=N-s
    " }
  " }
" }

" Plugin {
  " EasyMotion {
    let g:EasyMotion_smartcase = 1
    map <Leader> <Plug>(easymotion-prefix)
    nmap s <Plug>(easymotion-s2)
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)
  " }
  " Solarized Colorscheme {
    let g:solarized_termcolors = 256
    let g:solarized_termtrans = 1
    set background=light
    colorscheme solarized
  " }
" }

" Complete {
  set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
  set complete-=k complete+=k
  if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
      \   if &omnifunc == "" |
      \       setlocal omnifunc=syntaxcomplete#Complete |
      \   endif
    autocmd BufRead,BufNewFile *.launch setfiletype xml
  endif

  set completeopt=menuone,longest

  " SmartTab {
    function! SmartTab()
      " current line
      let line = getline('.')
      " from the start of the current line to one character right of the cursor
      let substr = strpart(line, 0, col('.')-1)
      echom substr
      " word till cursor
      let substr = matchstr(substr, "[^ \t]*$")
      echom substr
      " nothing to match on empty string
      if(strlen(substr)==0)
        return "\<TAB>"
      endif
      let has_slash = match(substr, '\/') != -1   " position of slash, if any
      if(has_slash)
        return "\<C-X>\<C-F>"                     " file matching
      else
        return "\<C-N>"                           " plugin matching
      endif
    endfunction

    inoremap <expr> <TAB> SmartTab()
  " }
" }

" Matlab {
"        autocmd FileType matlab setlocal textwidth=70
" }


" }

"
