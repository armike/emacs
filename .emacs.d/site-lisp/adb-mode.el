;; define several class of keywords
(defvar adb-keywords
  '("class" "include")
  "ADB keywords.")

(defvar adb-types
  '("data" "object" "model" "camera")
  "ADB types.")

(defvar adb-constants
  '()
  "ADB constants.")

(defvar adb-events
  '()
  ".")

(defvar adb-functions
  '()
  "ADB functions.")

;; create the regex string for each class of keywords
(defvar adb-keywords-regexp (regexp-opt adb-keywords 'words))
(defvar adb-type-regexp (regexp-opt adb-types 'words))
(defvar adb-event-regexp "\\([_A-Za-z]*\\.\\)")
(defvar adb-constant-regexp "\\(: ?[_a-zA-Z]*\\)")
;(regexp-opt adb-constants 'words))
(defvar adb-functions-regexp "\\(^\\w+\\)")

;; clear unneeded memory
(setq adb-keywords nil)
(setq adb-types nil)
(setq adb-constants nil)
(setq adb-events nil)
(setq adb-functions nil)

(define-derived-mode perl-mode fundamental-mode
  (setq font-lock-defaults '(adb-keywords))
  (setq mode-name "adb-mode")
)

;; the command to comment/uncomment text
(defun adb-comment-dwim (arg)
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
(defvar adb-mode-syntax-table
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
  "Syntax table for `adb-mode'.")

(setq adb-font-lock-keywords
  `(
    (,adb-event-regexp . font-lock-builtin-face)
    (,adb-constant-regexp . font-lock-constant-face)
    (,adb-functions-regexp . font-lock-preprocessor-face)
    (,adb-type-regexp . font-lock-type-face)
    (,adb-keywords-regexp . font-lock-keyword-face)
;; note: order above matters. Keywords goes last here because, for example, otherwise the keyword “state” in the function “state_entry” would be highlighted.
))


(defun adb-mode ()
;; (define-derived-mode adb-mode c-mode "LSL"
  "Major mode for editing LSL (Linden Scripting Language).

Shortcuts             Command Name
\\[comment-dwim]       `comment-dwim'

\\[adb-complete-symbol]      `adb-complete-symbol'

\\[adb-lookup-lsl-ref]     `adb-lookup-lsl-ref'

\\[adb-lookup-lsl-ref2]    `adb-lookup-lsl-ref2'

\\[adb-syntax-check]    `adb-syntax-check'

\\[adb-convert-rgb]     `adb-convert-rgb'

\\[adb-color-vectors-region]     `adb-color-vectors-region'

\\[adb-copy-all]          `adb-copy-all'

Complete documentation at URL `http://xahlee.org/sl/ls-emacs.html'."
  (interactive)
  (kill-all-local-variables)

  (setq major-mode 'adb-mode)
  (setq mode-name "ADB")
  (set-syntax-table adb-mode-syntax-table)
  ;; (use-local-map adb-mode-map)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '((adb-font-lock-keywords) nil nil))

  ;; (define-key adb-mode-map [remap comment-dwim] 'adb-comment-dwim)


  ;; clear memory
  (setq adb-keywords-regexp nil)
  (setq adb-types-regexp nil)
  (setq adb-constants-regexp nil)
  (setq adb-events-regexp nil)
  (setq adb-functions-regexp nil)



  ;; if emacs 23, turn on linum-mode
  (when
      (and
       (fboundp 'linum-mode)
       (>= emacs-major-version 23)
       (>= emacs-minor-version 1)
       )
    ;; (setq linum-format #'(lambda (n) (format "%3d" (1- n)))) ;; make it start at 0 to be compatible with inworld editor. Prob with this is that it sticks. Need to revert it back when out of adb-mode.
    (linum-mode 1)
    )

  (set (make-local-variable 'face-remapping-alist)
       '((default fixed-pitch)))
       ;; '((default mono-pitch))); :height 1.0)))
  ;; (face-remap-add-relative 'default :height 2.0)
  (set-default-font "7x14")

  (run-mode-hooks 'adb-mode-hook))

(provide 'adb-mode)
