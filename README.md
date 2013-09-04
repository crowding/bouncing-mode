## bouncing-mode

A simple minor mode that makes every command bounce.

"Bouncing" is the hehavior exhibited by `kmacro-end-and-call-macro`
(normally bound to `C-x e` where you can repeat the last macro
invocation by just pressing the `e` (instead of typing `C-x` again.)

Bouncing mode does that for any multi-keystroke command. So if `C-x
C-t` does `transpose-lines`, you can drag a line as far as you want
with `C-x C-t C-t C-t ...`

Install it:

```emacs-lisp
(add-to-path 'load-path "path/to/bouncing-mode")
(require 'bouncing)
(global-bouncing-mode)
```
