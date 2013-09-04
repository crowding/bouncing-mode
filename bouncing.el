(require 'repeat)

(define-minor-mode bouncing-mode
  "Toggle bouncing mode.

   When bouncing mode is enabled, any time a multi-keystroke
   command is entered, repeating the last keystroke will repeat
   the command. Thus the behavior of {kmacro-end-and-call-macro}
   is replicated for any command that is bound to a multiple key
   sequence.

   Interactively with no argument, this command toggles the mode.
   A positive prefix argument enables the mode, any other prefix
   argument disables it.  From Lisp, argument omitted or nil
   enables the mode, `toggle' toggles the state.
   Configuration variables:"

  :lighter " ⌇" nil "" nil

  (bouncing-enable-if))

(define-globalized-minor-mode global-bouncing-mode
  bouncing-mode
  bouncing-enable)

(defun bouncing-enable-if ()
  (if bouncing-mode
      (bouncing-enable)
    (bouncing-disable)))

(defun bouncing-enable ()
  (remove-hook 'pre-command-hook 'bouncing-check 'local)
  (add-hook 'post-command-hook 'bouncing-check nil 'local))

(defun bouncing-disable ()
  (remove-hook 'post-command-hook 'bouncing-check 'local))

(defun bouncing-check ()
  (remove-hook 'pre-command-hook 'bouncing-check 'local)
  (if (> (length (this-command-keys-vector)) 1)
        (bouncing-set-repeat)))

(defun bouncing-set-repeat ()
  (when (equal last-repeatable-command last-command)
    (let* ((km (make-sparse-keymap))
           (key (this-command-keys-vector))
           (lastkey (elt key (1- (length key)))))
      (unless (mouse-event-p lastkey) ;mouse-down&mouse-up does not count
        (define-key km (vector lastkey) 'repeat)
        ;; (message "Binding %S %S to repeat last command"
        ;;          key (key-description (vector lastkey)))
        (set-temporary-overlay-map km t)))))

(provide 'bouncing)
