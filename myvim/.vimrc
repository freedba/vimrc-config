syntax on
set nu

"tab缩进
set tabstop=4

" 每层缩进的空格数
set shiftwidth=4

" 开启文件类型侦测
filetype on

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 使用空格代替TAB
set expandtab

set smarttab

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 高亮显示搜索结果
set hlsearch

" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 自动补全只显示匹配项目
set completeopt=menu
set pumheight=10

" 当文件被外部改变时自动读取
set autoread


" 自动进入二进制模式
augroup Binary
au!
au BufReadPre *.exe,*.dll let &bin=1
au BufReadPost *.exe,*.dll if &bin | %!xxd
au BufReadPost *.exe,*.dll set ft=xxd | endif
au BufWritePre *.exe,*.dll if &bin | %!xxd -r
au BufWritePre *.exe,*.dll endif
au BufWritePost *.exe,*.dll if &bin | %!xxd
au BufWritePost *.exe,*.dll set nomod | endif
augroup EN


" 自动缩进
set autoindent

" 智能缩进
set smartindent

" 禁用自动换行
"set nowrap

" 显示tab和尾部空格
"set list
set listchars=tab:>-,trail:$

" 显示匹配括号
set showmatch

" 历史记录数
set history=400

" 光标上下两侧最少保留的屏幕行数
set scrolloff=7


" 启用命令行补全
set wildmenu

" 命令行区的高度
set cmdheight=2


" 显示标尺
set ruler

" 启用magic
set magic

"光标所在行和列高亮显示
set cursorcolumn
set cursorline
highlight CursorLine   cterm=NONE ctermbg=black  ctermfg=white guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black  ctermfg=white guibg=NONE guifg=NONE

"打开文件后跳转到最后编辑的文件位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


" 自动补全设置
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set completefunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" python文件使用空格缩进
"au FileType python,c set shiftwidth=4 | set tabstop=4 | set expandtab | set softtabstop=4
au FileType c set expandtab

" Code from:
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" then https://coderwall.com/p/if9mda
" and then https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
" to fix the escape time problem with insert mode.
"
" Docs on bracketed paste mode:
" http://www.xfree86.org/current/ctlseqs.html
" Docs on mapping fast escape codes in vim
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim

if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>

" 注释的颜色
hi comment ctermfg=darkred

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
