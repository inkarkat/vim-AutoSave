AUTO SAVE   
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

When developing scripts or programs, one frequently switches between a short
edit in Vim and a test or compiler run in a terminal. If one forgets to
persist the changes in Vim (:w), that run is of no avail, and one has to
switch back to Vim, save, and repeat.

This plugin allows to designate certain buffers for automatic persistence when
GVIM (and Vim in terminals that support the FocusLost event) lose focus, or
optionally also when 'updatetime' passes without a keypress in Vim. With that,
you can just make your edits, switch to another application, and the changes
will have been saved to the file, regardless of whether that file was
currently active inside Vim.

### RELATED WORKS

- The todo.txt has an entry for an 'autosave' option, which would persist a
  buffer shortly after the last change.
- vim-auto-save ([vimscript #4521](http://www.vim.org/scripts/script.php?script_id=4521)) automatically persists _all_ (toggled with
  :AutoSaveToggle) buffers on CursorHold events (and reduces 'updatetime' to
  200 ms).

USAGE
------------------------------------------------------------------------------

    :AutoSave[!], :NoAutoSave
                            Turn on / off automatic saving of the current buffer
                            whenever Vim loses focus (in the GUI) or exits; with !
                            also on CursorHold.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-AutoSave
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim AutoSave*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.016 or
  higher.

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-AutoSave/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.00    13-Nov-2017
- First published version.

##### 0.01    12-Apr-2011
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2011-2017 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat <ingo@karkat.de>
