" AutoSave.vim: Automatically persist a buffer frequently.
"
" DEPENDENCIES:
"   - AutoSave.vim autoload script
"
" Copyright: (C) 2011-2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	18-Dec-2013	file creation from ingocommands.vim.
"	000	12-Apr-2011	Initial implementation.

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AutoSave') || (v:version < 700)
    finish
endif
let g:loaded_AutoSave = 1

command! -bar -bang AutoSave   call AutoSave#AutoSave(1, <bang>0)
command! -bar       NoAutoSave call AutoSave#AutoSave(0, 0)

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
