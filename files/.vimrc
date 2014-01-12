"pathogen.vimを使ってbundle配下のプラグインをpathに加える
call pathogen#incubate()
call pathogen#helptags()

" --------------------------------------------------------------
" --------------------- 一般設定
" --------------------------------------------------------------

" 色
set t_Co=256
syntax on

if !exists("colors_name")
    colorscheme molokai
endif

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
set clipboard=unnamed,autoselect
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
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
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

"画面分割時にcontrol + l, h, j, kで移動
map <C-j> <C-W>j<C-w>_
map <C-k> <C-W>k<C-w>_
map <C-h> <C-w>h<C-w>_
map <C-l> <C-w>l<C-w>_

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"タブUIの時のタブ移動キーマップ
nmap <C-S-tab> <Esc>:tabprevious<CR>
nmap <C-tab>   <Esc>:tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i

"自動インデント時にタブが2つ付くのを防ぐ
set softtabstop=4
set shiftwidth=4

"HTMLのインデントを無効にする.
autocmd FileType html set indentexpr&
autocmd FileType xhtml set indentexpr&

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

" --------------------------------------------------------------
" --------------------- 拡張設定 (その他)
" --------------------------------------------------------------

" neocomplcache(コード補完)を有効化
let g:neocomplcache_enable_at_startup = 1

" zencodingの設定
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_expandword_key = '<c-e>'

" NERD TREE
let g:NERDTreeWinPos = "right"
nmap <C-i> :<C-u>NERDTreeToggle<CR>


" syntastic
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html', 'php'] }


" ==================== バイナリモード ==================== "
"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END


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
nnoremap ,t :<C-u>call Endtagcomment()<CR>


