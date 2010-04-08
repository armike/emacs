;; define several class of keywords
(defvar note-keywords
  '()
  "NOTE keywords.")

(defvar note-types
  '()
  "NOTE types.")

(defvar note-constants
  '()
  "NOTE constants.")

(defvar note-events
  '()
  ".")

(defvar note-functions
  '()
  "NOTE functions.")

;; create the regex string for each class of keywords
(defvar note-keywords-regexp "\\(^=*===$\\)") ;(regexp-opt note-keywords 'words))
(defvar note-type-regexp (regexp-opt note-types 'words))
(defvar note-constant-regexp "");"\\(^=*===$\\)")
(defvar note-event-regexp (regexp-opt note-events 'words))
(defvar note-functions-regexp "\\(^#*###$\\)")

;; clear unneeded memory
(setq note-keywords nil)
(setq note-types nil)
(setq note-constants nil)
(setq note-events nil)
(setq note-functions nil)

(define-derived-mode text-mode fundamental-mode
  (setq font-lock-defaults '(note-keywords))
  (setq mode-name "note-mode")
)

;; the command to comment/uncomment text
(defun note-comment-dwim (arg)
"Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
   (interactive "*P")
   (require 'newcomment)
   (let ((deactivate-mark nil) (comment-start "#") (comment-end ""))
     (comment-dwim arg)))

;; keywords for syntax coloring
(setq myKeywords
 `(
   ( ,(regexp-opt '("Sin" "Cos" "Sum") 'word) . font-lock-function-name-face)
   ( ,(regexp-opt '("Pi" "Infinity") 'word) . font-lock-constant-face)
  )
)


;;; syntax table
(defvar note-mode-syntax-table
  (let ((synTable (make-syntax-table)))
    ;; (modify-syntax-entry ?\/ ". 12b" synTable)
    ;; (modify-syntax-entry ?\n "> b" synTable)

    ;; (modify-syntax-entry ?= "." synTable)
    ;; (modify-syntax-entry ?< "." synTable)
    ;; (modify-syntax-entry ?> "." synTable)
    ;; (modify-syntax-entry ?+ "." synTable)
    ;; (modify-syntax-entry ?- "." synTable)
    ;; (modify-syntax-entry ?* "." synTable)
    ;; (modify-syntax-entry ?& "." synTable)
    ;; (modify-syntax-entry ?| "." synTable)

  ;; perl style comment: “# ...” 
    ;; (modify-syntax-entry ?# "< b" synTable)
    ;; (modify-syntax-entry ?\n "> b" synTable)
    ;; (modify-syntax-entry ?: "." synTable)

    synTable)
  "Syntax table for `note-mode'.")

(setq note-font-lock-keywords
  `(
    (,note-functions-regexp . font-lock-preprocessor-face)
    (,note-type-regexp . font-lock-type-face)
    (,note-constant-regexp . font-lock-constant-face)
    (,note-event-regexp . font-lock-builtin-face)
    (,note-keywords-regexp . font-lock-keyword-face)
;; note: order above matters. Keywords goes last here because, for example, otherwise the keyword “state” in the function “state_entry” would be highlighted.
))


(defun note-mode ()
;; (define-derived-mode note-mode c-mode "LSL"
  "Major mode for editing LSL (Linden Scripting Language).

Shortcuts             Command Name
\\[comment-dwim]       `comment-dwim'

\\[note-complete-symbol]      `note-complete-symbol'

\\[note-lookup-lsl-ref]     `note-lookup-lsl-ref'

\\[note-lookup-lsl-ref2]    `note-lookup-lsl-ref2'

\\[note-syntax-check]    `note-syntax-check'

\\[note-convert-rgb]     `note-convert-rgb'

\\[note-color-vectors-region]     `note-color-vectors-region'

\\[note-copy-all]          `note-copy-all'

Complete documentation at URL `http://xahlee.org/sl/ls-emacs.html'."
  (interactive)
  (kill-all-local-variables)

  (setq major-mode 'note-mode)
  (setq mode-name "NOTE")
  (set-syntax-table note-mode-syntax-table)
  ;; (use-local-map note-mode-map)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '((note-font-lock-keywords) nil nil))

  ;; (define-key note-mode-map [remap comment-dwim] 'note-comment-dwim)

  (set (make-local-variable 'face-remapping-alist)
       '((default fixed-pitch)))

  ;; clear memory
  (setq note-keywords-regexp nil)
  (setq note-types-regexp nil)
  (setq note-constants-regexp nil)
  (setq note-events-regexp nil)
  (setq note-functions-regexp nil)

  ;; (set (make-local-variable 'face-remapping-alist)
       ;; '((default variable-pitch)))
  ;; (face-remap-set-base '((default variable-pitch :fontset "7x14")))

  (run-mode-hooks 'note-mode-hook))

(provide 'note-mode)

