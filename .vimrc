" vim:fdm=marker

" Initialisation {{{
runtime! debian.vim
if has("syntax")
  syntax on
endif

set nocompatible
filetype on
let g:ale_completion_method=1

" }}}
" Plugin call {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'ycm-core/YouCompleteMe'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-unimpaired'		" https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'tyru/caw.vim'
Plugin 'kana/vim-repeat'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'lifepillar/vim-cheat40'
Plugin 'gerw/vim-latex-suite'
Plugin 'scrooloose/nerdtree'
Plugin 'joshdick/onedark.vim'
Plugin 'aklt/plantuml-syntax'
"Plugin 'dense-analysis/ale'
Plugin 'davidhalter/jedi-vim'
"Plugin 'instant-markdown/vim-instant-markdown'  " Turned off because I just
"kept closing it...
Plugin 'mzlogin/vim-markdown-toc'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" }}}
" Editor Base Behaviour {{{

" " Brief help
" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=	" Disable mouse usage (all modes)
set backspace=indent,eol,start
set scrolloff=20

colorscheme ron

" Configure backing up
set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.

" Configure airline
let g:airline_skip_empty_sections = 1
let g:airline_theme='onedark'

" Create clear register command and run on startup
command! ClearRegisters for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
autocmd VimEnter * ClearRegisters                                                         

" Add .rasi file syntax highlighting
au BufNewFile,BufRead /*.rasi setf css

" NERDTree was gettign bigger when closing a file, this restricts that
set noequalalways

" }}}
" Indentation {{{
"
set noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4
set clipboard+=unnamed

"Enable vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0
set ts=4 sw=2 noet
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1
let g:indent_guides_tab_guides=1


" }}}
" {{{ Bash Folding
let g:sh_fold_enabled=7
set foldmethod=syntax
" }}}
" Syntastic {{{

" Enable syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_filetype_map = {
	\ "plaintex": "tex",
	\ "gentoo-metadata": "xml" }
let g:syntastic_text_igor_exec = "~/Documents/igor-1.595/igor"
let g:syntastic_text_checkers = ['igor']
let g:syntastic_loc_list_height = 3
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR>

" Java-specific syntastic (uses javac)
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_javac_classpath = './target/classes:./target/test-classes'

" }}}
" Java {{{
autocmd FileType java setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
" }}}
" FZF {{{

" FZF configuration
let g:fzf_layout = { 'down': '20%' }
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Use preview when Files runs in fullscreen
command! -nargs=? -bang -complete=dir Files
	\ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)
command Changes call s:fzf_changes()

" }}}
" Focus Time {{{

" Goyo config
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction
let g:goyo_width=160
let g:goyo_height=85
let g:goyo_liner=10

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Limelight configuration
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'Black'
let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 2

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^'
let g:limelight_eop = '\n^'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" }}}
" LaTeX Suite {{{
let g:tex_flavor='latex'
let g:Tex_FoldedEnvironments = ',equation,minipage,itemize,enumerate'
" }}}
" Key Bindings {{{

" Rebindings
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-b> :BLines<CR>
nnoremap <C-g> :Goyo<CR>

" }}}
" Jedi {{{
let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#smart_auto_mappings = 1

" }}}
" Markdown {{{
let g:vmt_fence_text = "beginning-of-markdown-toc"
let g:vmt_fence_closing_text = "end-of-markdown-toc"
let g:instant_markdown_autoscroll = 1
" }}}

set background=dark
colorscheme onedark

