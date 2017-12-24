set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf8

"pathogen.vimを使ってbundle配下のプラグインをpathに加える
"call pathogen#incubate()
"call pathogen#helptags()
execute pathogen#infect()

" --------------------------------------------------------------
" --------------------- 配色
" --------------------------------------------------------------

set t_Co=256
syntax on

"autocmd ColorScheme * highlight LineNr term=underline ctermfg=0 ctermbg=232 guibg=#465457
""autocmd ColorScheme * highlight Visual term=reverse ctermbg=206 guibg=#403D3D

if !exists("colors_name")
    colorscheme molokai
endif
" iTerm2で半透明にしているが、vimのcolorschemeを設定すると背景も変更されるため"
highlight Normal ctermbg=none

" markdownのハイライトを有効にする
set syntax=markdown
au BufRead,BufNewFile *.md set filetype=markdown

" --------------------------------------------------------------
" --------------------- 一般設定
" --------------------------------------------------------------

" Set to auto read when a file is changed from the outside
set autoread
"新しい行のインデントを現在行と同じにする
set autoindent
"バックアップファイルを作るディレクトリ
set backupdir=$HOME/.vimbackup
"Vim の undo 履歴を ~/.vimundo ディレクトリに保存して、次回起動時に復元する (Vim 7.3 以降)
set undodir=~/.vimundo undofile
"スワップファイル用のディレクトリ
set directory=$HOME/.vimbackup
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
"クリップボードをWindowsと連携
set clipboard=unnamed
"Vi互換をオフ
set nocompatible
"タブの代わりに空白文字を挿入する
set expandtab
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"インクリメンタルサーチを行う
set incsearch
"タブ文字、行末など不可視文字を表示する
"set list
"listで表示される文字のフォーマットを指定する
set listchars=eol:$,tab:>\ ,extends:<
"行番号を表示する
set number
"シフト移動幅
"set shiftwidth=4
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"タブを4スペースに
set ts=4
"検索時に大文字、小文字を区別しない
set ignorecase
set smartcase
"コメント入力中改行時に*を自動追加
"set formatoptions+=r
"インサートモードでバックスペースで削除出来るように
set backspace=start,eol,indent
" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" Turn on the WiLd menu
set wildmenu
set wildmode=longest,list,full
"Always show current position
set ruler
" Highlight search results
set hlsearch
" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2"
" Add a bit extra margin to the left

"画面分割時にcontrol + l, h, j, kで移動
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"自動インデント時にタブが2つ付くのを防ぐ
set softtabstop=4
set shiftwidth=4

"HTMLのインデントを無効にする.
"autocmd FileType html set indentexpr&
"autocmd FileType xhtml set indentexpr&

"閉じタグ補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" gitu
nnoremap gu :Gitu<CR>
" gitv
autocmd FileType git :setlocal foldlevel=99
nnoremap gv :Gitv<CR>
"fugitive
nnoremap gst :Gstatus<CR>
"インサートモードでjjを押下するとESC相当 + l相当
inoremap <silent> jj <ESC>l
"インサートモードでcountrol + jを押下するとESC
inoremap <silent> <C-j> <ESC>
"勝手に改行させない
set formatoptions=q
" coffeeの場合インデント2
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" ファイル形式の検出の有効化する
" ファイル形式別プラグインのロードを有効化する
" ファイル形式別インデントのロードを有効化する
filetype plugin indent on
" JSONファイルのconcealを無効に
let g:vim_json_syntax_conceal = 0

" オムニ補完
imap <C-f> <C-x><C-o>
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" set <Space> for Leader
" http://postd.cc/how-to-boost-your-vim-productivity/
let mapleader = ","

" http://qiita.com/szk3/items/e33df9acea5050f29a07
set synmaxcol=1000

" --------------------------------------------------------------
" --------------------- 拡張設定 (Vim タブ関連)
" --------------------------------------------------------------

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
  let bufnrs = tabpagebuflist(i)
  let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
  let no = i  " display 0-origin tabpagenr.
  let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
  let title = fnamemodify(bufname(bufnr), ':t')
  let title = '[' . title . ']'
  let s .= '%'.i.'T'
  let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
  let s .= no . ':' . title
  let s .= mod
  let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ


" --------------------------------------------------------------
" --------------------- 拡張設定 (Unite)
" --------------------------------------------------------------


" unite.vim
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]

"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 0

"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"全部のせ
nnoremap <silent> [unite]<Space> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "Shift+Enterで横に分割して開く
  nnoremap <silent> <buffer> <expr> <S-Enter> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <S-Enter> unite#do_action('vsplit')
  "Control+Enterでタブに分割して開く
  nnoremap <silent> <buffer> <expr> <C-Enter> unite#do_action('tab-drop')
  inoremap <silent> <buffer> <expr> <C-Enter> unite#do_action('tab-drop')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction

" unite-outline(開いているファイルのクラスのメンバ一覧表示)
nnoremap <silent><Space>fo : <C-u>Unite -vertical -winwidth=40 outline<CR>

" sort unite buffer by path
call unite#custom_source('buffer', 'sorters', 'sorter_word')

" --------------------------------------------------------------
" --------------------- 拡張設定 (vim-indent-guides)
" --------------------------------------------------------------

" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=1
" 自動カラーを無効にする
let g:indent_guides_auto_colors=0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=234
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#393939 ctermbg=235
" ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 100
" ガイドの幅
let g:indent_guides_guide_size = 1

" --------------------------------------------------------------
" --------------------- 拡張設定 (cake-vim)
" --------------------------------------------------------------

let g:cakephp_enable_auto_mode = 1
let g:cakephp_enable_fix_mode = 1

" バッファで開くキーバインド設定
nnoremap <Space>cc :Ccontroller
nnoremap <Space>cm :Cmodel
nnoremap <Space>cv :Cview
nnoremap <Space>cvw :Ccontrollerview
nnoremap <Space>cs :Cshell
nnoremap <Space>ct :Ctask
nnoremap <Space>ccf :Cconfig
nnoremap <Space>ccp :Ccomponent
nnoremap <Space>cl :Clog

" splitで開くキーバインド設定
nnoremap <Space>ccs :Ccontrollersp 
nnoremap <Space>cms :Cmodelsp
nnoremap <Space>cvs :Cviewsp
nnoremap <Space>cvws :Ccontrollerviewsp
nnoremap <Space>ccfs :Cconfigsp
nnoremap <Space>ccps :Ccomponentsp

" vsplitで開くキーバインド設定
nnoremap <Space>ccv :Ccontrollervsp
nnoremap <Space>cmv :Cmodelvsp
nnoremap <Space>cvv :Cviewvsp
nnoremap <Space>cvwv :Ccontrollerviewvsp
nnoremap <Space>ccfv :Cconfigvsp
nnoremap <Space>ccpv :Ccomponentvsp

" --------------------------------------------------------------
" --------------------- 拡張設定 (neosnippet)
" --------------------------------------------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" 自分用 snippet ファイルの場所
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.dotfiles/files/.vim/snippets/'
let g:neosnippet#disable_runtime_snippets = {'_' : 1}

" --------------------------------------------------------------
" --------------------- 拡張設定 (neocomplete)
" --------------------------------------------------------------

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
set completeopt-=preview
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType go setlocal omnifunc=go#complete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
let g:neocomplete#auto_complete_delay = 1000

let g:haskellmode_completion_ghc = 0 " Disable haskell-vim omnifunc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" --------------------------------------------------------------
" --------------------- 拡張設定 (その他)
" --------------------------------------------------------------

" neocomplcache(コード補完)を有効化
let g:neocomplcache_enable_at_startup = 0

" zencodingの設定
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_expandword_key = '<c-e>'

" NERD TREE
let g:NERDTreeWinPos = "right"
nmap <C-i> :<C-u>NERDTreeToggle<CR>
let NERDTreeShowHidden = 1



" " quickfix
" " Maximize the window after entering it, be sure to keep the quickfix window
" " at the specified height.
" au WinEnter * call MaximizeAndResizeQuickfix(8)
"
" " Maximize current window and set the quickfix window to the specified height.
" function MaximizeAndResizeQuickfix(quickfixHeight)
"   " Redraw after executing the function.
"   set lazyredraw
"   " Ignore WinEnter events for now.
"   set ei=WinEnter
"   " Maximize current window.
"   wincmd _
"   " If the current window is the quickfix window
"   if (getbufvar(winbufnr(winnr()), "&buftype") == "quickfix")
"     " Maximize previous window, and resize the quickfix window to the
"     " specified height.
"     wincmd p
"     resize
"     wincmd p
"     exe "resize " . a:quickfixHeight
"   else
"     " Current window isn't the quickfix window, loop over all windows to
"     " find it (if it exists...)
"     let i = 1
"     let currBufNr = winbufnr(i)
"     while (currBufNr != -1)
"       " If the buffer in window i is the quickfix buffer.
"       if (getbufvar(currBufNr, "&buftype") == "quickfix")
"         " Go to the quickfix window, set height to quickfixHeight, and jump to the previous
"         " window.
"         exe i . "wincmd w"
"         exe "resize " . a:quickfixHeight
"         wincmd p
"         break
"       endif
"       let i = i + 1
"       let currBufNr = winbufnr(i)
"     endwhile
"   endif
"   set ei-=WinEnter
"   set nolazyredraw
" endfunction
"
" " Remap ,m to make and open error window if there are any errors. If there
" " weren't any errors, the current window is maximized.
" map <silent> ,m :mak<CR><CR>:cw<CR>:call MaximizeIfNotQuickfix()<CR>
"
" " Maximizes the current window if it is not the quickfix window.
" function MaximizeIfNotQuickfix()
"   if (getbufvar(winbufnr(winnr()), "&buftype") != "quickfix")
"     wincmd _
"   endif
" endfunction

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['haskell'] }
let g:syntastic_haskell_checkers = ['hlint', 'ghc_mod']

" auto-ctags.vim
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git']
set tags+=.git/tags
nnoremap <C-]> g<C-]>

" vim-gitgutter 
let g:gitgutter_highlight_lines = 0
let g:gitgutter_sign_removed = '-'
highlight GitGutterAddLine gui=bold ctermbg=233
highlight GitGutterChangeLine gui=bold ctermbg=233
highlight GitGutterDeleteLine gui=bold ctermbg=233
highlight GitGutterChangeDeleteLine gui=bold ctermbg=233
highlight GitGutterAdd ctermbg=34 ctermfg=15
highlight GitGutterChange ctermbg=3 ctermfg=15
highlight GitGutterDelete ctermbg=124
highlight GitGutterChangeDelete ctermbg=13

" yankround-vim
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap yp <Plug>(yankround-prev)
nmap yn <Plug>(yankround-next)

" vim-airline
set laststatus=2
let g:airline_theme = 'kalisi'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" カッコよくなるがfontのインストールが必要
"let g:airline_powerline_fonts = 1

" tagbar-phpctags
let g:tagbar_phpctags_bin='~/.dotfiles/files/.vim/bin/phpctags'
let g:tagbar_width = 30
let g:tagbar_autoshowtag = 1
let g:tagbar_left = 1
let g:tagbar_map_togglesort = "r"
let g:tagbar_autofocus = 1
nmap <C-y> :TagbarToggle<CR>

" --------------------------------------------------------------
" --------------------- その他
" --------------------------------------------------------------

" 閉じタグコメントの生成(<!-- /.hoge -->など)
function! Endtagcomment()
    let reg_save = @@

    try
        silent normal vaty
    catch
        execute "normal \<Esc>"
        echohl ErrorMsg
        echo 'no match html tags'
        echohl None
        return
    endtry

    let html = @@

    let start_tag = matchstr(html, '\v(\<.{-}\>)')
    let tag_name  = matchstr(start_tag, '\v([a-zA-Z]+)')

    let id = ''
    let id_match = matchlist(start_tag, '\vid\=["'']([^"'']+)["'']')
    if exists('id_match[1]')
        let id = '#' . id_match[1]
    endif

    let class = ''
    let class_match = matchlist(start_tag, '\vclass\=["'']([^"'']+)["'']')
    if exists('class_match[1]')
        let class = '.' . join(split(class_match[1], '\v\s+'), '.')
    endif

    execute "normal `>va<\<Esc>`<"

    let comment = g:endtagcommentFormat
    let comment = substitute(comment, '%tag_name', tag_name, 'g')
    let comment = substitute(comment, '%id', id, 'g')
    let comment = substitute(comment, '%class', class, 'g')
    let @@ = comment

    normal ""P

    let @@ = reg_save
endfunction

let g:endtagcommentFormat = '<!-- /%id%class -->'
nnoremap .t :<C-u>call Endtagcomment()<CR>


"-------------------
"vim-go
"-------------------

autocmd BufWrite *.{go} :GoImports

let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

"-------------------
"slimv (lisp)
"-------------------

let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-CLISP "clisp -i ~/.vim/bundle/slimv/slime/start-swank.lisp"'
let g:slimv_repl_split = 4
let g:slimv_repl_name = 'REPL'
let g:slimv_repl_simple_eval = 0
let g:slimv_lisp = '/usr/local/bin/clisp'
let g:slimv_impl = 'clisp'
let g:slimv_preferred = 'clisp'
let g:lisp_rainbow=1
let g:paredit_electric_return = 0

"-------------------
"ghcmod.vim (haskell)
"-------------------
"
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
let g:necoghc_enable_detailed_browse = 1
hi ghcmodType ctermbg=lightcyan
let g:ghcmod_type_highlight = 'ghcmodType'

au BufNewFile,BufRead *.hs map <Leader>t :GhcModType<cr>
au BufNewFile,BufRead *.hs map <Leader>tt :GhcModTypeClear<cr>
let g:hoogle_search_count=15
let g:hoogle_search_buf_name='Hoogle'
au BufNewFile,BufRead *.hs map <silent> <leader>h :Hoogle<CR>
au BufNewFile,BufRead *.hs map <buffer> <Leader>hh :HoogleClose<CR>


au BufRead,BufNewFile *.qmu set filetype=qmu
