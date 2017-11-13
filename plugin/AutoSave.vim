" AutoSave.vim: Automatically persist a buffer frequently.
"
" DEPENDENCIES:
"   - AutoSave.vim autoload script
"
" Copyright: (C) 2011-2017 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AutoSave') || (v:version < 700)
    finish
endif
let g:loaded_AutoSave = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:AutoSave_UpdateModifiers')
    let g:AutoSave_UpdateModifiers = ''
endif



"- commands --------------------------------------------------------------------

command! -bar -bang AutoSave   call AutoSave#AutoSave(1, <bang>0)
command! -bar       NoAutoSave call AutoSave#AutoSave(0, 0)

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
