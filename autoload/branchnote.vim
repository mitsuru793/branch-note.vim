" branchnote.vim
" Maintainer: mitsuru793 <mitsuru793@gmail.com>
" Version:  0.0.1

if &cp || exists("g:autoloaded_branchnote")
  finish
endif
let g:autoloaded_branchnote= '1'

let s:cpo_save = &cpo
set cpo&vim

let &cpo = s:cpo_save

" Utility Functions: {{{

function! s:chomp(string) abort
  return substitute(a:string, '\n\+$', '', '')
endfunction

function! s:system(command) abort
  let result = s:chomp(system(a:command))

  if v:shell_error
    echoerr 'External command failed: "'.a:command.'", Message: '.result
  endif

  return result
endfunction

function! s:get_current_branch() abort
  return s:system('git rev-parse --abbrev-ref HEAD')
endfunction

function! s:get_repository_name() abort
  return s:system('basename `git rev-parse --show-toplevel`')
endfunction

function! s:get_repo_dir() abort
  let url = s:system('git config --get remote.origin.url')
  return g:branchnote_path . substitute(url, '^.*://', '', '') . '/'
endfunction

function! s:get_branch_dir() abort
  return s:get_repo_dir() . s:get_current_branch() . '/'
endfunction
"}}}

" Function:

function! branchnote#open(type) abort
  let branch_dir = s:get_branch_dir()
  if !v:shell_error && !isdirectory(branch_dir)
    call mkdir(branch_dir, 'p')
  endif

  let file_name = a:type . '.' . g:branchnote_note_suffix
  exec 'edit' branch_dir . file_name
endfunction

command! -nargs=1 BNoteOpen :call branchnote#open(<q-args>)

let &cpo = s:cpo_save

" vim:set ft=vim ts=2 sw=2 sts=2:
