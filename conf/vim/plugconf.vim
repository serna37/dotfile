" ### AI Copilot
let g:codeium_disable_bindings = 1
inoremap <silent><C-n> <Cmd>call codeium#CycleCompletions(1)<CR>
inoremap <silent><C-p> <Cmd>call codeium#CycleCompletions(-1)<CR>
inoremap <script><silent><nowait><expr><C-i><C-i> codeium#Accept()
inoremap <silent><C-d> <Cmd>call codeium#Clear()<CR>

" ### Enhanced vim motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys='sfjkdawh'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_disable_two_key_combo = 1
nnoremap s <Plug>(clever-f-reset)<Plug>(easymotion-s2)
nnoremap <Leader><Leader>s <Plug>(clever-f-reset)<Plug>(easymotion-sn)
nnoremap <Leader><Leader>w <Plug>(easymotion-overwin-w)
nnoremap <C-j> <Plug>(edgemotion-j)<Plug>(anchor)
nnoremap <C-k> <Plug>(edgemotion-k)<Plug>(anchor)
let g:clever_f_smart_case = 1
let g:clever_f_timeout_ms = 1500
let g:clever_f_highlight_timeout_ms = 1500
aug cleaver_f
    au!
    au ColorScheme * hi CleverFDefaultLabel cterm=BOLD,underline ctermfg=40 ctermbg=0
aug END
aug cleaver_f
    au!
    au ColorScheme * hi QuickScopePrimary ctermfg=204 cterm=BOLD
    au ColorScheme * hi QuickScopeSecondary ctermfg=81 cterm=BOLD
aug END
let fscope_around_row = 1
let g:fscope_highlight_priority = 0
let g:fscope_init_active = 0
" <Plug>(fscope-around-toggle)
nnoremap <leader>w <Plug>(clever-f-reset):QuickScopeToggle<CR>
nnoremap # <Plug>(asterisk-z*)<Plug>(quickhl-manual-this)
nnoremap <silent><Leader>q <Plug>(quickhl-manual-reset)<Plug>(clever-f-reset):noh<CR>
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_interval = 1000.0 / 60
let g:comfortable_motion_friction = 70.0
let g:comfortable_motion_air_drag = 5.0
nnoremap <silent><C-f> :cal comfortable_motion#flick(200)<CR>
nnoremap <silent><C-b> :cal comfortable_motion#flick(-200)<CR>
set termwinkey=<C-e>
tnoremap <C-w> <Esc><BS>
tnoremap <C-x> <C-w><S-n>
tnoremap <silent><C-t> <C-\><C-n>:FloatermNew<CR>
tnoremap <silent><S-Tab> <C-\><C-n>:FloatermNext<CR>
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width = 0.6
let g:floaterm_height = 0.8
let g:floaterm_position = 'bottomright'

" ### Enhanced Visualization
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
fu! s:moveBuf(flg) abort
    let current_id = ''
    let buf_arr = []
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            cal add(buf_arr, x[0])
            if stridx(x[1], '%') != -1
                let current_id = x[0]
            endif
        endif
    endfor
    let buf_idx = a:flg == 'next' ? match(buf_arr, current_id) + 1 : match(buf_arr, current_id) - 1
    let buf_id = buf_idx == len(buf_arr) ? buf_arr[0] : buf_arr[buf_idx]
    exe 'b '.buf_id
endf
fu! s:closeBuf() abort
    let now_b = bufnr('%')
    cal s:moveBuf('prev')
    execute('bd ' . now_b)
endf
noremap <silent><Plug>(buf-prev) :<C-u>cal <SID>moveBuf('prev')<CR>
noremap <silent><Plug>(buf-next) :<C-u>cal <SID>moveBuf('next')<CR>
noremap <silent><Plug>(buf-close) :<C-u>cal <SID>closeBuf()<CR>
nnoremap <C-n> <Plug>(buf-prev)
nnoremap <C-p> <Plug>(buf-next)
nnoremap <Leader>x <Plug>(buf-close)
nnoremap <silent><Leader>z :Goyo<CR>
let g:highlightedyank_highlight_duration = 300
nnoremap <silent><Leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

" ### Filer
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'TwoDark'
let g:fzf_preview_use_dev_icons = 1
nnoremap <silent><Leader>f :cal execute('CocCommand fzf-preview.'.(system('git rev-parse --is-inside-work-tree') =~ 'fatal'?'DirectoryFiles':'ProjectFiles'))<CR>
nnoremap <silent><Leader>b :CocCommand fzf-preview.Buffers<CR>
nnoremap <silent><Leader>hf :CocCommand fzf-preview.MruFiles<CR>
nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>
nnoremap <silent><Leader>s :CocCommand fzf-preview.Lines<CR>
nnoremap <silent><Leader>m :CocCommand fzf-preview.Bookmarks<CR>
nnoremap <silent><Leader>nn :CocCommand fzf-preview.MemoList<CR>
nnoremap <silent><Leader>ng :CocCommand fzf-preview.MemoListGrep .<CR>
fu s:grep() abort
    let w = input('[word]>>', expand('<cword>'))
    execute('CocCommand fzf-preview.ProjectGrep '.w)
endf
nnoremap <silent><Leader>g :cal <SID>grep()<CR>
au DirChanged * cal execute('CocCommand explorer --no-focus --width 30')

" ### Reading
au VimEnter * RainbowParentheses
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_exclude_filetypes = ['help', 'coc-explorer', 'startify']
let g:indent_guides_auto_colors = 0
aug indent_guide
    au!
    au ColorScheme * hi IndentGuidesOdd ctermbg=236
    au ColorScheme * hi IndentGuidesEven ctermbg=234
aug END
let g:vista_sidebar_width = 15
let g:minimap_git_colors = 1

" ### Writing
inoremap <C-s> <Plug>(coc-snippets-expand)
"let g:UltiSnipsExpandTrigger="<C-s>"
"let g:UltiSnipsJumpForwardTrigger="<Tab>"
"let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
fu! s:expandSnippet() abort
    cal feedkeys("A\<C-s>\<Esc>", 'x')
    w
endf
nnoremap <silent><Leader>t :cal <SID>expandSnippet()<CR>
fu! s:tailsemi() abort
    if getline('.')[-1:] != ';'
        execute('normal A;')
    endif
endf
" 右端に行きたい
inoremap {{ <Esc>A{}<Left>
" 一番下行から書く時に、画面真ん中に
fu! Format() abort
    try | cal CocAction('format') | catch | endtry
endf
nnoremap O zz:cal Format()<CR>O
" SNIPモードを強制終了
inoremap <C-k> <Esc>:w<CR>:e!<CR>zza
noremap <silent><Plug>(tailsemi) :<C-u>cal <SID>tailsemi()<CR>
inoremap ;; <Esc><Plug>(tailsemi)<Esc>:w<CR>
inoremap ;<CR> <Esc><Plug>(tailsemi)<Esc>:w<CR>o
let g:move_key_modifier_visualmode = 'C'
let g:AutoPairsMapCh = 0

" ### LSP IDE
let g:coc_global_extensions = ['coc-explorer', 'coc-snippets', 'coc-fzf-preview',
            \ 'coc-sh', 'coc-vimlsp', 'coc-json', 'coc-sql',
            \ 'coc-html', 'coc-css', 'coc-tsserver',
            \ 'coc-clangd', 'coc-rust-analyzer', 'coc-go',
            \ 'coc-pyright', 'coc-java',
            \ ]
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
au CursorHold * sil cal CocActionAsync('highlight')
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
nnoremap <Leader>d <Plug>(coc-definition)
nnoremap <silent><Leader>r :CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent><Leader>o :CocCommand fzf-preview.CocOutline<CR>
nnoremap <silent><Leader>? :cal CocAction('doHover')<CR>
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : comfortable_motion#flick(100)
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : comfortable_motion#flick(-100)
"aug fmt_cpp
    "au!
    "au BufWrite *.cpp :try | cal CocAction('format') | catch | endtry
"aug END

" ### util
let g:silicon = {}
let g:silicon['output'] = '~/Desktop/tmp.png'
let g:ac_vim_bell_times_at = [5, 15, 30]
let g:ac_vim_bell_times_interval = []
let g:ac_vim_bell_times_redzone = 30
let g:ac_vim_bell_times_limit = 31
let g:ac_vim_test_cmd = "cpp_build main.cpp && mv main a.out && oj t"

" startify -------------------------------
let s:start = #{}

" ぼっちざろっく{{{
let s:start.btr_logo = [
    \'                                                                                                                                              dN',
    \'                                                                                                              ..                             JMF',
    \'                                                                                                         ..gMMMM%                           JMF',
    \'                                                                                                       .MM9^ .MF                           (MF',
    \'                                                                                              .(,      ("   .M#                  .g,      .MF',
    \'                                        .,  dN                                             gg,,M@          .M#                  .M#!      (M>',
    \'                                        JM} M#             .MNgg.                     .g,  ?M[ 7B         .MMg+gg,.           .MM"        ."',
    \'                                ...gNMN,.Mb MN           .gMM9!                      .(MN,  .=           .MMM9=  ?MN,         (WN,      .MM ',
    \'                   jN-      ..gMMN#!     (Mp(M}       .+MMYMF                    ..kMMWM%               ,M#^       dN.          .WNJ,   JM',
    \'                   MM     .MM9^  dN,                 dNB^ (M%                   ?M"!  ,M\        .,               .M#   .&MMMN,    ?"   M#',
    \'                   MN            .MN#^                    dM:  ..(J-,                 ,B         .TM             .M#   ,M@  .MF',
    \'                   MN.       ..MMBMN_                     dN_.MM@"!?MN.   TMm     .a,                           (M@         MM^',
    \'                   MN.     .MM"  JMb....       ..        dMMM=     .Mb            ?HNgJ..,                   .MM^',
    \'                   dM{          -MMM#7"T""   .dN#TMo       ?      .MM^                 ?!                 +gM#=',
    \'                   (M]         .MN(N#       .M@  .MF              .MM^                                      ~',
    \'                   .MN          ?"""             MM!            .MMD',
    \'                    ?N[                                         7"',
    \'                     TMe',
    \'                      ?MN,',
    \'                        TMNg,'
    \]
"}}}

let g:startify_custom_header = s:start.btr_logo

" onedark ---------------------------------
if !glob('~/.vim/plugged/onedark.vim')->empty()
    aug onedark_comment
        au!
        au ColorScheme * hi Comment term=bold ctermfg=245 guifg=#5C6370
    aug END
    colorscheme onedark
endif

