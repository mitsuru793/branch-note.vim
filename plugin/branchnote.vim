" branchnote.vim
" Maintainer: mitsuru793 <mitsuru793@gmail.com>
" Version:  0.0.1

if (exists("g:loaded_branchnote") && g:loaded_branchnote) || &cp
  finish
endif
let g:loaded_branchnote = 1

let s:cpo_save = &cpo
set cpo&vim

if !exists('g:branchnote_path')
  let g:branchnote_path = $HOME . "/branchnote/"
endif

if !exists('g:branchnote_memo_suffix')
  let g:branchnote_note_suffix = "md"
endif

command! -nargs=1 BNoteOpen :call branchnote#open(<args>)

let &cpo = s:cpo_save

" vim:set ft=vim ts~2 sw=2 sts=2
