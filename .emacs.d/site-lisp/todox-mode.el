;; define several class of keywords
(defvar marlog-keywords
  '("class" "include")
  "MARLOG keywords.")

(defvar marlog-types
  '("data" "object" "operator" "model" "camera")
  "MARLOG types.")

(defvar marlog-constants
  '()
  "MARLOG constants.")

(defvar marlog-events
  '( ":")
  ".")

(defvar marlog-functions
  '()
  "MARLOG functions.")

;; create the regex string for each class of keywords
(defvar marlog-keywords-regexp (regexp-opt marlog-keywords 'words))
(defvar marlog-type-regexp (regexp-opt marlog-types 'words))
(defvar marlog-constant-regexp (regexp-opt marlog-constants 'words))
(defvar marlog-event-regexp "\\(:[_\\s\\w]*\\\)")
(defvar marlog-functions-regexp "a");"(^\\* .* \\*$)")

;; clear unneeded memory
(setq marlog-keywords nil)
(setq marlog-types nil)
(setq marlog-constants nil)
(setq marlog-events nil)
(setq marlog-functions nil)

(define-derived-mode perl-mode fundamental-mode
  (setq font-lock-defaults '(marlog-keywords))
  (setq mode-name "marlog-mode")
)

;; the command to comment/uncomment text
(defun marlog-comment-dwim (arg)
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
(defvar marlog-mode-syntax-table
  (let ((synTable (make-syntax-table)))
    (modify-syntax-entry ?\/ ". 12b" synTable)
    (modify-syntax-entry ?\n "> b" synTable)

    ;; (modify-syntax-entry ?= "." synTable)
    ;; (modify-syntax-entry ?< "." synTable)
    ;; (modify-syntax-entry ?> "." synTable)
    ;; (modify-syntax-entry ?+ "." synTable)
    ;; (modify-syntax-entry ?- "." synTable)
    ;; (modify-syntax-entry ?* "." synTable)
    ;; (modify-syntax-entry ?& "." synTable)
    ;; (modify-syntax-entry ?| "." synTable)

  ;; perl style comment: “# ...” 
    (modify-syntax-entry ?# "< b" synTable)
    (modify-syntax-entry ?\n "> b" synTable)
    (modify-syntax-entry ?: "." synTable)

    synTable)
  "Syntax table for `marlog-mode'.")

(setq marlog-font-lock-keywords
  `(
    (,marlog-functions-regexp . font-lock-preprocessor-face)
    (,marlog-type-regexp . font-lock-type-face)
    (,marlog-constant-regexp . font-lock-constant-face)
    (,marlog-event-regexp . font-lock-builtin-face)
    (,marlog-keywords-regexp . font-lock-keyword-face)
;; note: order above matters. Keywords goes last here because, for example, otherwise the keyword “state” in the function “state_entry” would be highlighted.
))


(defun marlog-mode ()
;; (define-derived-mode marlog-mode c-mode "LSL"
  "Major mode for editing LSL (Linden Scripting Language).

Shortcuts             Command Name
\\[comment-dwim]       `comment-dwim'

\\[marlog-complete-symbol]      `marlog-complete-symbol'

\\[marlog-lookup-lsl-ref]     `marlog-lookup-lsl-ref'

\\[marlog-lookup-lsl-ref2]    `marlog-lookup-lsl-ref2'

\\[marlog-syntax-check]    `marlog-syntax-check'

\\[marlog-convert-rgb]     `marlog-convert-rgb'

\\[marlog-color-vectors-region]     `marlog-color-vectors-region'

\\[marlog-copy-all]          `marlog-copy-all'

Complete documentation at URL `http://xahlee.org/sl/ls-emacs.html'."
  (interactive)
  (kill-all-local-variables)

  (setq major-mode 'marlog-mode)
  (setq mode-name "MARLOG")
  (set-syntax-table marlog-mode-syntax-table)
  ;; (use-local-map marlog-mode-map)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '((marlog-font-lock-keywords) nil nil))

  ;; (define-key marlog-mode-map [remap comment-dwim] 'marlog-comment-dwim)


  ;; clear memory
  (setq marlog-keywords-regexp nil)
  (setq marlog-types-regexp nil)
  (setq marlog-constants-regexp nil)
  (setq marlog-events-regexp nil)
  (setq marlog-functions-regexp nil)



  ;; if emacs 23, turn on linum-mode
  (when
      (and
       (fboundp 'linum-mode)
       (>= emacs-major-version 23)
       (>= emacs-minor-version 1)
       )
    ;; (setq linum-format #'(lambda (n) (format "%3d" (1- n)))) ;; make it start at 0 to be compatible with inworld editor. Prob with this is that it sticks. Need to revert it back when out of marlog-mode.
    (linum-mode 1)
    )

  ;; (set (make-local-variable 'face-remapping-alist)
       ;; '((default variable-pitch)))
  ;; (face-remap-set-base '((default variable-pitch :fontset "7x14")))

  (run-mode-hooks 'marlog-mode-hook))

(provide 'marlog-mode)

