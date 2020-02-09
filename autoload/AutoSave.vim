" AutoSave.vim: Automatically persist a buffer frequently.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2011-2020 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

let s:autoSavedBuffers = {}
function! s:AutoSaveTrigger( isAggressive ) abort
    " Must collect all errors because of the single v:errmsg and previous
    " :echomsg outputs may not be visible any more.
    let l:errors = []

    for l:bufnr in keys(s:autoSavedBuffers)
	" Attention! l:bufnr is a String when we retrieve it from the
	" Dictionary, but we need an Integer.
	let l:bufnr = l:bufnr + 0

	if a:isAggressive && ! getbufvar(l:bufnr, 'AutoSave_Aggressive', 0)
	    continue    " Skip non-aggressive buffers during aggressive event handling.
	endif

	try
	    call ingo#buffer#visible#Execute(l:bufnr, ingo#list#JoinNonEmpty([g:AutoSave_UpdateModifiers, getbufvar(l:bufnr, 'AutoSave_UpdateModifiers'), 'update']))
	catch /^Vim\%((\a\+)\)\=:E45:/	" E45: 'readonly' option is set
	    " Special case: the default Vim error is misleading; the user cannot
	    " simply add ! here.
	    call add(l:errors, bufname(l:bufnr) . ': file is readonly')
	catch /^Vim\%((\a\+)\)\=:/
	    call add(l:errors, bufname(l:bufnr) . ': ' . ingo#msg#MsgFromVimException())
	endtry
    endfor

    if ! empty(l:errors)
	" XXX: Error message only briefly flickers (even with :redraw and
	" :sleep) when the current windows does not contain the erroring buffer.
	call ingo#msg#ErrorMsg('Error saving buffer' . (len(l:errors) > 1 ? 's' : '') . ': ' . join(l:errors, '; '))
    endif
endfunction
function! AutoSave#AutoSave( isEnable, isMoreAggressive ) abort
    " Note: We cannot install individual buffer-scoped autocmds a la
    "	autocmd FocusLost <buffer> update
    " Only the autocmd for the buffer that is active when Vim loses focus is
    " invoked. Instead, use a glocal autocmd and store all buffers in a
    " dictionary.

    if a:isEnable
	let b:autosave = 1 " Mark buffer to enable easy flagging in statusline.
	let s:autoSavedBuffers[bufnr('')] = 1

	" Memorize :noautocmd intention in a buffer-local flag.
	if &eventignore ==# 'all'
	    let b:AutoSave_UpdateModifiers = 'noautocmd'
	else
	    unlet! b:AutoSave_UpdateModifiers
	endif

	let b:AutoSave_Aggressive = a:isMoreAggressive
    else
	unlet! b:autosave
	unlet! b:AutoSave_UpdateModifiers
	unlet! b:AutoSave_Aggressive
	silent! unlet s:autoSavedBuffers[bufnr('')]
    endif

    if a:isEnable && (len(s:autoSavedBuffers) == 1 || a:isMoreAggressive && ! exists('#AutoSave#CursorHold'))
	" Install autocmd on first added buffer or when aggressive autocmds
	" don't exist yet.
	augroup AutoSave
	    autocmd!
	    autocmd FocusLost,VimLeavePre * nested call <SID>AutoSaveTrigger(0)
	    if a:isMoreAggressive
		autocmd CursorHold,CursorHoldI * nested call <SID>AutoSaveTrigger(1)
	    endif
	augroup END
    elseif ! a:isEnable && len(s:autoSavedBuffers) == 0
	" Remove autocmd on final removed buffer.
	augroup AutoSave
	    autocmd!
	augroup END
    endif
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
