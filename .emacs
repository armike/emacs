;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings that vary by location
;; ------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun maross-system-type ()
  (cond
  ((member-string system-type '("gnu" "gnu/linux")) "unix")
  ((member-string system-type '("windows-nt" "cygwin" "ms-dos")) "windows")
  ((member-string system-type '("darwin")) "darwin") ;; gnu-darwin, OSX
  (t "unix")))

(defun member-string (target L)
  (member-custom target L #'string=))

(defun member-custom (target L predicate)
  (cond ((funcall predicate (car L) target) L)
        ((equal (length L) 0) nil)                    
        (t (member-custom target (cdr L) predicate))))

(defvar maross-narrow-font
  "7x14"
  ;; "-outline-Lucida Console-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1"

)
  

(defvar maross-default-frame-height
  78 ;; heat
  ;; 78 ;; turtle
  ;; ;; moose
  )

(defvar maross-home
  "~maross/" ;; heat
  ;; "c:/" ;; turtle, moose
)

(defun home (p)
  (format "%s%s" maross-home p))

(defun maross-set-default-vars ()
  (let 
      ((host (downcase (system-name)))
       (system-type-simple (maross-system-type)))

    ;; system sype
    (cond 
     ((string= system-type-simple "windows")
      (progn 
        (setq maross-home "c:/")
        (setq maross-default-font 
              "-outline-Lucida Console-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1")
        (setq maross-narrow-font
              "-outline-Lucida Console-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1")
        ))
     ((string=  system-type-simple "unix")
      (progn
        (setq maross-home "~maross/")
        (setq maross-narrow-font "7x14")
        (setq maross-default-font
              "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-14")
        )))
    ;; system name
    (cond
     ((string= host "moose")
      (setq maross-default-frame-height 81)))))

(maross-set-default-vars)

(defvar maross-emacs-dir (home ".emacs.d/site-lisp/"))

(defun emacs-dir (p)
  (format "%s%s" maross-emacs-dir p))

;; common default fonts
;; --------------------
;; "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-14"
;; "-outline-Lucida Console-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1"

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(ecb-auto-expand-tag-tree (quote all))
 '(ecb-layout-name "left9")
 '(ecb-layout-window-sizes (quote (("left8" (0.32432432432432434 . 0.2875) (0.32432432432432434 . 0.2375) (0.32432432432432434 . 0.3) (0.32432432432432434 . 0.1625)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote ("~maross/work/" "~maross/bin/")))
 '(ecb-tree-truncate-lines (quote (ecb-directories-buffer-name ecb-sources-buffer-name ecb-methods-buffer-name ecb-history-buffer-name ecb-analyse-buffer-name)))
 '(frame-background-mode (quote dark))
 '(global-font-lock-mode t nil (font-lock))
 '(load-home-init-file t t)
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))
  
(setq maross-modeline-face-list 
      (if (string= (maross-system-type) "windows")
          '(:background "#404040" :foreground "#eeeeee" :box nil :slant normal :weight normal :width normal)
        '(:background "#404040" :foreground "#eeeeee" :box nil :slant normal :weight normal :height 103 :width normal :foundry "misc" :family "fixed")
        ))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 `(fixed-pitch ((t (:font ,maross-narrow-font))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "chocolate1" :slant italic))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :slant italic))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "Cyan3" :weight bold))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :weight bold))))
 '(font-lock-type-face ((t (:foreground "PaleGreen"))))
 '(highlight ((t (:background "goldenrod4"))))
 '(hl-line ((t (:inherit highlight :background "#303545"))))
 `(mode-line ((t ,maross-modeline-face-list)))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "#215880"))))
 '(secondary-selection ((((class color) (min-colors 88) (background dark)) (:background "#305550"))))
 '(show-paren-match ((((class color) (background dark)) (:background "steelblue3"))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "White")))))

(set-background-color "black")
(global-hl-line-mode t)

;; common default fonts
;; --------------------
;; "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-14"
;; "-outline-Lucida Console-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1"
(setq default-frame-alist
     `((top . 0) 
       ;;(left . 0)
       (width . 80) 
       (height . ,maross-default-frame-height)
       (cursor-color . "red")
       (cursor-type . box)
       (foreground-color . "white")
       (background-color . "black")
       (font . ,maross-default-font)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Other Settings
;; -------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun maross-cycle-font ()
  "Change font in current frame.
When called repeatedly, cycle thru a predefined set of fonts.
Warning: expected to work for Windows only. May not work in other OS."
  (interactive)
  (if (not (eq last-command this-command))
      (progn
        (set-frame-parameter nil 'font maross-default-font)
        (put this-command 'state "2"))
    (cond
     ((string= (get this-command 'state) "1")
      (set-frame-parameter nil 'font maross-default-font) (put this-command 'state "2"))
     ((string= (get this-command 'state) "2" )
      (set-frame-parameter nil 'font maross-narrow-font) (put this-command 'state "1"))
     ) ) )


(set-face-background 'default "black")
(set-face-foreground 'default "white")

;; (set-scroll-bar-mode 'right)

;; indent everything by four spaces.
(setq standard-indent 4)
(setq c-basic-offset 4)
(setq-default py-indent-offset 4)
(setq-default indent-tabs-mode nil)
(setq csh-indent 4)

;; Set the title frame to display the buffer name
(setq frame-title-format "%b")

;; enable column number in the bottom status bar
(column-number-mode 1)

; interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)

;; replace system beep with screen flashing
(setq visible-bell t)

(setq inhibit-splash-screen t)

(setq initial-scratch-message nil)
;; for when you have a mouse wheel...
;;    (mwheel-install)
(setq require-final-newline nil)

;; set the font to something less clunky
;; (set-default-font "7x14")
;; (set-default-font "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-14")

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
;; (define-key query-replace-map [return] 'act)
;; (define-key query-replace-map [?\C-m] 'act)

;; toggle tool-bar-mode
(tool-bar-mode 0)

(setq load-path (cons maross-emacs-dir load-path))

(print load-path)

;; (require 'ido)
;;(ido-mode t)
;;(ido-mode nil)
(ido-mode 'buffer)
;; (ido-mode 'find-file) ;;omg agggh


(add-to-list 'load-path (emacs-dir "color-theme-6.6.0"))

(setq browse-url-generic-program (executable-find "firefox")
      browse-url-browser-function 'browse-url-generic)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc features
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'menu-bar+)
;; (require 'replace+)
(require 'highlight)
(define-key ctl-x-map [(?y)] 'hlt-highlight)
(global-set-key (kbd "C-'") 'maross-highlight-cur-regexp)
(global-set-key (kbd "C-\"") 'hlt-unhighlight-region)
(global-set-key (kbd "C-x C-y") 'maross-highlight-regexp)
(global-set-key (kbd "C-x C-S-y") 'hlt-unhighlight-region)
(define-key ctl-x-map [(down-mouse-3)] 'hlt-highlighter)
(define-key ctl-x-map [(S-down-mouse-3)] 'hlt-eraser)

(global-set-key (kbd "C-p") 'hlt-previous-highlight)
(global-set-key (kbd "C-n")  'hlt-next-highlight)

;; highlight the word clicked on, navigate with the mouse wheel
(global-set-key [(C-S-mouse-1)] 'maross-small-occur-current-word)
(global-set-key [(C-S-double-mouse-1)] 'maross-jump-with-mouse)
(global-set-key [(C-S-mouse-2)] 'maross-jump-with-mouse)
(global-set-key [(C-S-mouse-3)] 'delete-other-windows)
(global-set-key [(C-S-double-mouse-3)] 'maross-unhilight-all)
(global-set-key [(C-S-mouse-4)] 'hlt-previous-highlight)
(global-set-key [(C-S-mouse-5)] 'hlt-next-highlight)


(fset 'maross-jump-macro
   [?\M-x ?m ?a ?r ?o ?s ?s ?- ?j ?u ?m ?p return return])



(defun maross-jump-with-mouse (start-event)
  "Hilight the word clicked on everywhere in the buffer and jump
   to the definition if defined."

  (interactive "e")
  (let*
      ((start-posn (event-start start-event))
       (start-point (posn-point start-posn)))
    (goto-char start-point)
    (execute-kbd-macro [?\M-x ?m ?a ?r ?o ?s ?s ?- ?j ?u ?m ?p return return])
    (maross-pulse-momentary-highlight-line-or-region)))


(defun maross-unhilight-all ()
  "Unhilite anything hilited and remove other windows"
  (interactive)
  (progn 
    (hlt-unhighlight-region) 
    (delete-other-windows)))

(defun maross-small-occur-current-word (start-event)
  "Hilight the word clicked on everywhere in the buffer."
  (interactive "e")
  (let*
      ((start-posn (event-start start-event))
       (start-point (posn-point start-posn)))
    (goto-char start-point)
    (hlt-unhighlight-region)
    (maross-small-occur (maross-region-or-thing))))

(defun maross-split-window-for-buffer (potential-buffer-name)
  "Split the current buffer if potential-buffer-name is not currently visible"
  (interactive)
  (if (get-buffer-window potential-buffer-name)
      nil
    (progn
      (delete-other-windows)
      (split-window-vertically))))

(defun maross-small-occur (regex &optional no-highlight) 
  "Run occur for the given regex and highlight the regex in the current buffer"
  (interactive)
  (let
      ((current-window (selected-window)))
    (if no-highlight nil 
      (maross-highlight-regexp regex))
    (push-mark)  
    ;; explicitly split the buffer (ECB acts up sometimes)
    (maross-split-window-for-buffer "*Occur*")
    (occur regex)
    (select-window (get-buffer-window "*Occur*"))
    (set-buffer "*Occur*")
    (setf truncate-lines t)
    (let* 
        ((buf-lines (count-lines 1 (point-max)))
         (num-lines (if (> buf-lines 29)
                        25 (+ 4 buf-lines))))
      (set-window-height num-lines)
      (select-window current-window))))

(defun maross-highlight-cur-regexp ()
  "Hilight the regex currently underneath the point"
  (interactive)
  (let ((original-point (point))
        (regex (format "%s" (maross-region-or-thing))))
    (goto-char 0)
    (hlt-highlight-regexp-to-end regex)
    (goto-char original-point)))

(defun maross-highlight-regexp (regexp &optional face msg-p mouse-p nth)
  "Hihglight a regular expression throughout the entire buffer, instead of
   everywhere past the mark like hlt does by default."
  (interactive
   (list (read-string "Regexp to highlight for entire buffer: " nil
                      (if (and (boundp 'hi-lock-mode) hi-lock-mode)
                          'hi-lock-regexp-history
                        'regexp-history)
                      hlt-last-regexp)
         nil 'msg-p current-prefix-arg))
  (let ((original-point (point)))
    (goto-char 0)
    (hlt-highlight-regexp-to-end regexp face msg-p mouse-p nth)
    (goto-char original-point)))

(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-auto-start 3) ;; start completion when entered 3 characters
;; (define-key ac-complete-mode-map (kbd  "C-/") 'ac-complete)
(global-set-key (kbd "C-/") 'ac-start)

;; (require 'column-marker)
;; Highlight column 80 in foo mode.
;;(add-hook 'lisp-mode-hook (lambda () (interactive) (column-marker-1 80)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; linum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'linum)
(if (eq window-system 'x)
    (set-face-attribute
     'linum nil
      ;; :font "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-14")
     :font "7x13"))

(defun maross-toggle-linum-mode ()
  (interactive)
  (let ((linum-width
         (length (number-to-string (count-lines (point-min) (point-max)))))
        (frame-name
         (window-frame (get-buffer-window (buffer-name))))
        (linum-mode-was-on linum-mode))
    (if linum-mode-was-on
        (progn
          (set-frame-width
           frame-name
           (- (frame-width frame-name) linum-width))
          (linum-mode 0))
      (progn
        (set-frame-width frame-name (+ (frame-width frame-name) linum-width))
        (linum-mode 1)))
    ;; If we're close to 80, assume the user wants an 80 column buffer
    (let ((new-frame-width (frame-width frame-name)))
      (if (and (< 70 new-frame-width) (< new-frame-width 90))
          (if linum-mode-was-on
              (set-frame-width frame-name 80)
            (set-frame-width frame-name (+ 80 linum-width)))))))

;; (add-hook 'linum-before-numbering-hook)

(defun count-line-maross ())
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pyflakes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                       'flymake-create-temp-with-folder-structure)) 
           (local-file (file-relative-name 
                        temp-file 
                        (file-name-directory buffer-file-name)))) 
      (list (home "bin/maross_pyflakes") (list temp-file))))

  (add-to-list 'flymake-allowed-file-name-masks 
               '("\\.py\\'" flymake-pyflakes-init))) 

(add-hook 'find-file-hook 'flymake-find-file-hook)


 (defun my-flymake-show-help ()
   (when (get-char-property (point) 'flymake-overlay)
     (let ((help (get-char-property (point) 'help-echo)))
       (if help (message "%s" help)))))

 (add-hook 'post-command-hook 'my-flymake-show-help)

  ;; flymake
  (defun my-flymake-show-next-error()
    (interactive)
    (flymake-goto-next-error)
    )

  ;; flymake
  (defun my-flymake-show-prev-error()
    (interactive)
    (flymake-goto-prev-error)
    )

  (global-set-key (kbd "C-S-n") 'my-flymake-show-next-error)
  (global-set-key (kbd "C-S-p") 'my-flymake-show-prev-error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'anything-config)
(require 'pdi-ani)
(require 'pager)

(require 'revision-grabber)
(global-set-key (kbd "C-S-v") 'compare-buffer-with-cvs-revision)
(global-set-key (kbd "C-S-a") 'compare-buffer-with-auto-save-file)
(global-set-key (kbd "C-S-b") 'compare-buffer-with-file) 
(global-set-key (kbd "C-S-r") 'compare-buffer-with-snapshot)
(global-set-key (kbd "C-S-M-p") 'compare-buffer-with-percs-revision)

(require 'comment-uncomment-line-or-region)
(global-set-key [f6] 'comment-uncomment-line-or-region)
;; (global-set-key "\C-f" 'comment-uncomment-line-or-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Face settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'color-theme)
;; (defun color-theme-maross-dark ()
;;   "dark color theme created by maross, Oct. 2009."
;;   (interactive)
;;   (color-theme-install
;;     '(color-theme-maross-dark
;;        ((foreground-color . "#ffffff")
;;          (background-color . "black") 
;;          (background-mode . dark))
;;        (bold ((t (:bold t))))
;;        (bold-italic ((t (:italic t :bold t))))
;;        (default ((t (nil))))
       
;; ;       (font-lock-builtin-face ((t (:italic t :foreground "#a96da0"))))
;;        ;; (font-lock-comment-face ((t (:foreground "#40a040"))))
;; ;       (font-lock-comment-delimiter-face ((t (:foreground "#666666"))))
;; ;       (font-lock-constant-face ((t (:bold t :foreground "#197b6e"))))
;;        ;; (font-lock-doc-string-face ((t (:foreground "#55ee55"))))
;; ;       (font-lock-doc-face ((t (:foreground "gray"))))
;; ;       (font-lock-reference-face ((t (:foreground "white"))))
;;        ;; (font-lock-function-name-face ((t (:foreground "#35a0ff"))))
;;        ;; (font-lock-keyword-face ((t (:bold t :foreground "#22ffff"))))
;; ;       (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
;;        ;; (font-lock-string-face ((t (:foreground "#22ee22"))))
;; ;       (font-lock-type-face ((t (:bold t :foreground "#364498"))))
;; ;       (font-lock-variable-name-face ((t (:foreground "#7685de"))))
;; ;       (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
;; ;                                     :foreground "yellow"))))
;; ;       (hl-line ((t (:background "#112233"))))
;; ;       (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
;;        (region ((t (:foreground nil :background "#282828"))))
;; ;       (show-paren-match-face ((t (:bold t :foreground "#ffffff" 
;; ;                                    :background "#050505"))))
;; ))) ;; go-here 


;; (defun color-theme-djcb-dark ()
;;   "dark color theme created by djcb, Jan. 2009."
;;   (interactive)
;;   (color-theme-install
;;     '(color-theme-djcb-dark
;;        ((foreground-color . "#a9eadf")
;;          (background-color . "black") 
;;          (background-mode . dark))
;;        (bold ((t (:bold t))))
;;        (bold-italic ((t (:italic t :bold t))))
;;        (default ((t (nil))))
       
;;        (font-lock-builtin-face ((t (:italic t :foreground "#a96da0"))))
;;        (font-lock-comment-face ((t (:italic t :foreground "#bbbbbb"))))
;;        (font-lock-comment-delimiter-face ((t (:foreground "#666666"))))
;;        (font-lock-constant-face ((t (:bold t :foreground "#197b6e"))))
;;        (font-lock-doc-string-face ((t (:foreground "#3041c4"))))
;;        (font-lock-doc-face ((t (:foreground "gray"))))
;;        (font-lock-reference-face ((t (:foreground "white"))))
;;        (font-lock-function-name-face ((t (:foreground "#356da0"))))
;;        (font-lock-keyword-face ((t (:bold t :foreground "#bcf0f1"))))
;;        (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
;;        (font-lock-string-face ((t (:foreground "#ffffff"))))
;;        (font-lock-type-face ((t (:bold t :foreground "#364498"))))
;;        (font-lock-variable-name-face ((t (:foreground "#7685de"))))
;;        (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
;;                                      :foreground "yellow"))))
;;        (hl-line ((t (:background "#112233"))))
;;        (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
;;        (region ((t (:foreground nil :background "#555555"))))
;;        (show-paren-match-face ((t (:bold t :foreground "#ffffff" 
;;                                     :background "#050505")))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tabbar face setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'tabbar)
(set-face-attribute
 'tabbar-default-face nil
 :background "gray60")
(set-face-attribute
 'tabbar-unselected-face nil
 :background "gray85"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected-face nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button-face nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator-face nil
 :height 0.7)

(defun tabbar-buffer-groups-one-group (b) 
  (cond
   ((char-equal ?* (aref (buffer-name buffer) 0))
    '("Common"))
   (t
    '("All"))))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups-one-group)

(dolist (func '(tabbar-mode tabbar-forward-tab
                            tabbar-forward-group
                            tabbar-backward-tab
                            tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))

(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
         ,on-no-prefix
       ,on-prefix)))
(tabbar-mode t)
(define-key global-map [C-S-left] 'tabbar-backward)
(define-key global-map [C-S-right] 'tabbar-forward)



;; for non X sessions
(global-set-key (kbd "M-o 6 d") 'tabbar-backward)
(global-set-key (kbd "M-o 6 c") 'tabbar-forward)

(global-set-key [f9] 'maross-cycle-font)
(global-set-key [f8] 'maross-toggle-linum-mode)


(defun maross-org-mode-hook ()
  (interactive)
  (maross-fixed-pitch-mode t)
  (define-key org-mode-map [C-S-left] 'tabbar-backward)
  (define-key org-mode-map [C-S-right] 'tabbar-forward)
)

(add-hook 'org-mode-hook 'maross-org-mode-hook)

(defun maross-grep-mode-hook ()
  (interactive)
  (maross-fixed-pitch-mode t)
  ;; (define-key org-mode-map [C-S-left] 'tabbar-backward)
  ;; (define-key org-mode-map [C-S-right] 'tabbar-forward)
)

(add-hook 'grep-mode-hook 'maross-grep-mode-hook)

(defun maross-occur-mode-hook ()
  (interactive)
  (maross-fixed-pitch-mode t)
  ;; (define-key org-mode-map [C-S-left] 'tabbar-backward)
  ;; (define-key org-mode-map [C-S-right] 'tabbar-forward)
)

(add-hook 'occur-mode-hook 'maross-occur-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python mode fiddling
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  (require 'python)
;; (require 'python-mode) ;; use python-mode.el instead of default python.el
;; (define-key python-mode-map (kbd "C-c f") 'python-describe-symbol)
;;(define-key py-mode-map (kbd "C-c c-f") 'python-describe-symbol)
;;(define-key py-mode-map (kbd "C-c f")   'python-describe-symbol)

;; (defun py-newline-and-indent ()
;;   "Strives to act like the Emacs `newline-and-indent'.
;; This is just `strives to' because correct indentation can't be computed
;; from scratch for Python code.  In general, deletes the whitespace before
;; point, inserts a newline, and takes an educated guess as to how you want
;; the new line indented."
;;   (interactive)
;;   (let ((ci (current-indentation)))
;;     (if (< ci (current-column))		; if point beyond indentation
;; 	(newline-and-indent)
;;       else try to act like newline-and-indent "normally" acts
;;       (beginning-of-line)
;;       (insert-char ?\n 1)
;;       (move-to-column ci))))
;; (define-key python-mode-map (kbd "RET") 'py-newline-and-indent)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CEDET
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (emacs-dir "cedet-1.0pre6/common/"))

(defun no-cedet-p ()
    (or (equal argi "-no_cedet")
        (equal argi "-nc")))

(add-to-list 'command-line-functions 'no-cedet-p)
(if (or 
     (member "-no_cedet" command-line-args)
     (member "-nc" command-line-args))
    nil
  (progn
    (load-file (emacs-dir "cedet-1.0pre6/common/cedet.el"))
    (global-ede-mode 1)                      ; Enable the Project management system
    (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
    (global-srecode-minor-mode 1)            ; Enable template insertion menu
    (global-semantic-tag-folding-mode 1)
    (global-semantic-highlight-edits-mode 1)
    (global-semantic-highlight-func-mode 1)))
    ;; (global-semantic-decoration-mode 1) ;; ew

(defun find-definition (arg)
    "Jump to the definition of the symbol, type or function at point.
  With prefix arg, find in other window."
    (interactive "P")
    (let* ((tag (or (semantic-idle-summary-current-symbol-info-context)
                    (semantic-idle-summary-current-symbol-info-brutish)
                    (error "No known tag at point")))
           (pos (or (semantic-tag-start tag)
                    (error "Tag definition not found")))
           (file (semantic-tag-file-name tag)))
      (if file
          (if arg (find-file-other-window file) (find-file file))
        (if arg (switch-to-buffer-other-window (current-buffer))))
      (push-mark)
      (goto-char pos)
      (end-of-line)))  

(defun maross-jump ()
  (interactive)
  (let* ((tag-string (maross-region-or-thing))
         (tag (semantic-complete-read-tag-project
               "Symbol: " nil tag-string)))
    (when (semantic-tag-p tag)
      (push-mark)
      (goto-char (semantic-tag-start tag))
      (semantic-momentary-highlight-tag tag)
      (working-message "%S: %s "
                       (semantic-tag-class tag)
                       (semantic-tag-name  tag)))))

(defun maross-grep ()
  (interactive)
  (progn
    (grep-compute-defaults)
    (let* ((word (maross-region-or-thing))
           (filename (buffer-name))
           (cmd (read-from-minibuffer "Run grep (like this): "
                                      (format "grep -nH %s %s"
                                              word filename)
                                      nil nil 'grep-history nil)))
      (grep cmd))))

(defun maross-occur ()
  (interactive)
  (progn
    (let* ((word (read-from-minibuffer "List lines matching regexp: "
                                     (maross-region-or-thing) nil nil 'occur-history nil)))
      (maross-small-occur word))))

(defun maross-timestamp ()
  "Insert a basic timestamp"
  (interactive)
  (insert (format-time-string "** %Y-%m-%d - %H:%M :: %B %e, %Y %l:%M %p **\n")))

(defun maross-timestamp-todo ()
  "Insert a timestamp formatted for org mode."
  (interactive)
  (insert (format-time-string "* %Y-%m-%d - %H:%M :: %B %e, %Y %l:%M %p *\n")))

(defun maross-region-or-thing (&optional thing-type)
  (let ((thing-type (if thing-type thing-type 'symbol)))
    (if (and transient-mark-mode mark-active)
        (buffer-substring-no-properties (region-beginning) (region-end))
      (thing-at-point thing-type))))


(defun sats (stringArrayName)
  (interactive "sStringArray: ")
  (insert (format "stringArrayToString($%s, \" \")" stringArrayName)))

(defun satsp (stringArrayName)
  (interactive "sStringArray: ")
  (insert (format "print(\"$%s: \" + stringArrayToString($%s, \" \") + \"\\n\");"
                  stringArrayName stringArrayName)))

(defun mel-append (arrayName)
  (interactive "sArray To Append To: ")
  (insert (format "$%s[size($%s)] = " arrayName arrayName)))

(defun mel-for (arrayName)
  (interactive "sArray to iterate: ")
  (let (
        (start (point)))
    (insert
     (format 
      "int $i;\nint $%sSize = size($%s);\nfor($i=0; $i<$%sSize;$i++){\n\n}"
      arrayName arrayName arrayName))
    (indent-region start (point))))
  


(defun varp (varName)
  (interactive "sVariable Name: ")
  (insert (format "print(\"$%s: \" + string($%s) + \"\\n\");" varName varName)))


(defun maross-pyflakes ()
  (interactive)
  (shell-command (format "maross_pyflakes %s" (file-truename (buffer-name)))))

;; alias for maross-pyflakes
(fset 'pyfl 'maross-pyflakes)

(global-set-key (kbd "C-.") 'maross-jump)
(global-set-key (kbd "C-S-g") 'maross-grep)
(global-set-key (kbd "C-S-o") 'maross-occur)
(global-set-key (kbd "C-:") 'maross-timestamp-todo)
(global-set-key (kbd "C-M-;") 'maross-timestamp)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ECB
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(which-func-mode t)


(defun start-ecb ()
  (interactive)

  (load-file (emacs-dir "cedet-1.0pre6/common/cedet.el"))
  (global-ede-mode 1)                  ; Enable the Project management system
  (semantic-load-enable-code-helpers)  ; Enable prototype help and smart completion 
  (global-srecode-minor-mode 1)        ; Enable template insertion menu

  (add-to-list 'load-path (emacs-dir "ecb-2.40"))
  (require 'ecb)
  (setq ecb-tip-of-the-day nil)
  (ecb-activate)
  (set-face-attribute
   'ecb-default-general-face nil
   :font maross-narrow-font)
  (if (< (window-width) 80)
      (set-window-width-80))
  (global-set-key [f12] 'ecb-toggle-ecb-windows)
  )

(defun ecb-toggler ()
  (interactive)
  (ecb-toggle-ecb-windows)
  (let* ((window (get-lru-window))
         (frame (window-frame window )))
    (if (< (window-width window) 81)
        (let ()
          (message (format "%d" (window-width window)))
          (set-frame-width frame 100))
      (let ()
        (message (format "%d" (window-width window)))
        (message "false")
        (set-frame-width frame 80))
      )))

(global-set-key [f12] 'start-ecb)
(global-set-key [f11] 'set-window-width-80)
(global-set-key [f10] 'maross-toggle-frame-width)
(setq last-frame-width 120)

(defun maross-toggle-frame-width ()
  (interactive)
  (let ((frame-name (window-frame (get-buffer-window (buffer-name)))))
    (let ((linum-mode-was-on linum-mode))
      (if linum-mode-was-on (maross-toggle-linum-mode) nil)      
      (if (not (eq (frame-width) 80))
          (let ()
            (setq last-frame-width (frame-width))
            (set-frame-width frame-name 80))
        (set-frame-width frame-name last-frame-width))
      (if linum-mode-was-on (maross-toggle-linum-mode) nil))))
      
(add-to-list 'auto-mode-alist '("\\.adb$" . perl-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mel Mode
;; --------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\notes.txt$" . note-mode))
(add-to-list 'auto-mode-alist '("\\.adb$" . adb-mode))
(add-to-list 'auto-mode-alist '("\\.dep$" . adb-mode))
(add-to-list 'auto-mode-alist '("\\.mel$" . mel-mode))
(add-to-list 'auto-mode-alist '("\\.ma$" . mel-mode))
(add-to-list 'auto-mode-alist '("\\todo.txt$" . org-mode))
;;(setq auto-mode-alist (cons '("\\.ma\\'" . mel-mode) auto-mode-alist))
(autoload 'mel-mode "mel-mode" nil t)

(setq mel-mode-document-base "/rel/third_party/maya/2009.2.7_64/docs/")

;; "/usr/home/htdocs/technology/documentation/software/maya/manuals/2008/Maya2008/en_US/"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Macros
;; ------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'studiofy-prints
   [?\C-\M-% ?p ?r ?i ?n ?t ?  ?\\ ?( ?. ?+ ?\\ ?) return ?s ?t ?u ?d ?i ?o ?. ?i ?o ?. ?w ?r ?i ?t ?e ?( ?\\ ?1 ?) return ?y ?\C-x])

(fset 'string-wrap
 [home ?$ ?e ?x ?p ?r ?  ?+ ?= ?  ?" end ?\\ ?n ?" ?\; down home])

(fset 'umike
 "/data/anim/local/up/umikeross/cue/")

(defun rev ()
  ;; quickly revert the current buffer, maintaining linum-mode
  (interactive)
  (let ((linum-mode-was-on linum-mode))
    (revert-buffer (current-buffer) :noconfim=t)
    ;; reapply linum mode if it was enabled.
    (if linum-mode-was-on (maross-toggle-linum-mode) nil)
    ))

;; kills a character
;; (fset 'flag-spacer
;;   [return ?\C-  left ?\C-w ?\C-\M-% ?- ?[ ?^ ?0 ?- ?9 ?] return ?\C-y ?- return ?!])

(fset 'flag-spacer
 [return ?\C-  up ?\C-w ?\M-% ?- return ?\C-y ?- return ?!])

(fset '*scratch*
 [?\C-x ?\C-f home ?\C-k ?~ ?/ ?d ?a ?t ?a ?/ ?n ?o ?t ?e ?s ?/ ?s ?c ?r ?a ?t ?c ?h ?. ?t ?x ?t return])

(fset 'scratch
 [?\C-x ?\C-f home ?\C-k ?e ?: ?/ ?d ?a ?t ?a ?/ ?n ?o ?t ?e ?s ?/ ?s ?c ?r ?a ?t ?c ?h ?. ?t ?x ?t return])

(fset 'tab-killer
   [C-home ?\M-% tab return ?  ?  ?  ?  return ?!])


(fset 'py-comment-header
   [?\C-u ?7 ?0 ?# tab return ?# tab return ?# tab return ?\C-u ?7 ?0 ?#])

(fset 'quotify
   [C-right C-left ?\" ?\C-s ?, ?\C-m left ?\" C-right C-left])

(fset 'kill-line-backwards
      [?\C-  home ?\C-w])

(fset 'python-shift-right-remark
   [?\M-x ?p ?y ?t ?h ?o ?n ?- ?s ?h ?i ?f ?t ?- ?r ?i ?g ?h ?t return ?\C-x ?\C-x ?\C-x ?\C-x])

(fset 'python-shift-left-remark
   [?\M-x ?p ?y ?t ?h ?o ?n ?- ?s ?h ?i ?f ?t ?- ?l ?e ?f ?t return ?\C-x ?\C-x ?\C-x ?\C-x])

(fset 'big-comment-line [?\C-u ?8 ?0 ?# return ?\C-u ?8 ?0 ?# return ])
(global-set-key (kbd "C-#") 'big-comment-line)

(fset 'big-equals-line [?\C-u ?7 ?0 ?= return ])
(global-set-key (kbd "C-=") 'big-equals-line)

(fset 'add-note 
   [?\C-y return ?\C-# return])

(defun pdb-line ()
  (interactive)
  (indent-for-tab-command)
  (insert "import pdb; pdb.set_trace()"))

(fset 'spacer
   [?\M-% ?\C-q ?\C-j return ?  return ?!])
;; (global-set-key (kbd "") 'spacer)

(defun shebang-tcsh ()
  (interactive)
  (let ((current-position (point))
        (shebang "#!/usr/local/bin/tcsh\n"))
    (goto-char 1)
    (insert shebang)
    (goto-char (+ current-position (length shebang)))
    (shell-script-mode)))

(fset 'tcsh-shebang 'shebang-tcsh)

(fset 'shebang-py
   [?# ?! ?/ ?u ?s ?r ?/ ?l ?o ?c ?a ?l ?/ ?b ?i ?n ?/ ?p ?y ?t ?h ?o ?n
       return])

;; (fset 'eval-emacs
;;    [?\C-x ?\C-f ?~ ?/ ?. ?e ?m ?a ?c ?s return ?\M-x ?e ?v ?a ?l ?- ?b ?u ?f ?f ?e ?r return])

(fset 'camel-casify
   [?\C-s ?_ ?\C-m right ?  left left ?\M-u right backspace left backspace])

(defun maross-camel-casify ()
  (interactive)
  (search-forward "_")
  (let 
      ((char (upcase (char-to-string (char-after)))))
    (backward-delete-char 1)
    (delete-char 1)
    (insert char)))
  
(global-set-key (kbd "C-S-u") 'maross-camel-casify)

(fset 'rpdb-line
   "import rpdb2; rpdb2.start_embedded_debugger('a')")

(fset 'winpdb-line
   "import rpdb2; rpdb2.start_embedded_debugger('a')")

(defun eval-emacs ()
  (interactive)
  (let ((dot-emacs-buffer (get-buffer ".emacs")))
    (find-file (home ".emacs"))
    (eval-buffer)))

(fset 'make-macro
   [?\M-x ?i ?n ?s ?e ?r ?t ?- ?k ?b ?d ?- ?m ?a ?c ?r ?o return return ?\C-r ?s ?e ?t ?q ?\C-m C-delete ?f ?s ?e ?t right ?' ?m ?a ?c ?r ?o ?- ?n ?a ?m ?e ?  ?\C-k down end return ?( ?g ?l ?o ?b ?a ?l ?- ?s ?e ?t ?- ?k ?e ?y ?  ?( ?k ?b ?d ?  ?\" ?C ?- ?. ?\" ?) ?  ?' ?m ?a ?c ?r ?o ?- ?n ?a ?m ?e ?) ])
;; (global-set-key (kbd "C-.") 'make-macro)


(defun set-window-width (target-width) 
  (interactive)
  (enlarge-window-horizontally
   (- target-width (window-width))))

(defun set-window-height (target-height) 
  (interactive)
  (enlarge-window
   (- target-height (window-height))))


(defun set-window-width-80 ()
  (interactive)
  (set-window-width 80))


(defun maross-lazy-make ()
  (interactive)
  (maross-split-window-for-buffer "*compilation*")
  (compile "make")
  (let ((current-window (selected-window))
        (compilation-window (get-buffer-window "*compilation*")))
    (select-window compilation-window)
    (set-window-height 10)
    (end-of-buffer)
    (select-window current-window)))
  

(defun maross-kill-buffer ()
  (interactive)
  (let
      ((last-displayed-buffer (last-buffer)))
    (ido-kill-buffer)
    (display-buffer last-displayed-buffer)))
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keys
;; ----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'iedit)
(define-key global-map (kbd "C-;") 'iedit-mode)

(global-set-key "\M-g" 'goto-line)
(global-set-key [pause] 'goto-line)

 ;; C-z usually backgrounds emacs, not shell procs, such a pain
(global-set-key "\C-z" 'undo)
(global-set-key "\C-v" 'yank)
(global-set-key "\C-j" 'jump-to-register)

;; M instead of C because to avoid RSI :|
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-5") 'make-frame-command)

;;(global-set-key "\M-p" 'studiofy-prints)
(global-set-key "\C-o" 'other-window)
;;(global-set-key (kbd "M-RET") 'newline)
;;(global-set-key (kbd "RET") 'indent-new-comment-line)
;; (global-set-key (kbd "RET") 'newline)
(global-set-key "\C-b" 'switch-to-buffer)
(global-set-key (kbd "C-,") 'quotify)
(global-set-key (kbd "C-S-k") 'kill-line-backwards)
(global-set-key (kbd "C-<") 'python-shift-left-remark)
(global-set-key (kbd "C->") 'python-shift-right-remark)
(global-set-key "\M-n" 'add-note)
(global-set-key (kbd "C-c C-g") 'comment-or-uncomment-region)
(global-set-key (kbd "C-S-m") 'maross-lazy-make)
(global-set-key (kbd "C-M-e") 'eval-emacs)
(global-set-key (kbd "C-S-e") 'eval-emacs) 
(global-set-key (kbd "M-RET") 'indent-new-comment-line)

 ;; no more friggin minimizing
(global-set-key (kbd "C-x C-z") nil)
;; ido buffer mode
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (global-set-key (kbd "C-f") 'comment-or-uncomment-region)
(global-set-key (kbd "M-]") 'enlarge-window-horizontally)
(global-set-key (kbd "M-[") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-]") 'set-window-width-80)

(global-set-key [f5] 'query-replace)

;; flip the i-search modes
;; (global-set-key (kbd "C-s") 'isearch-forward-regexp) 
;; (global-set-key (kbd "C-r") 'isearch-backward-regexp)
;; (global-set-key (kbd "C-M-s") 'isearch-forward) 
;; (global-set-key (kbd "C-M-r") 'isearch-backward)

;; quicker switching window
(global-set-key [S-left] 'windmove-left)          ; move to left windnow
(global-set-key [S-right] 'windmove-right)        ; move to right window
(global-set-key [S-up] 'windmove-up)              ; move to upper window
(global-set-key [S-down] 'windmove-down)          ; move to downer window

;; Stolen from Stuart Tett's .emacs

;; ;; Pageup/Pagedown will now return to the same place
(require 'pager)
(global-set-key [prior] 'pager-page-up)
(global-set-key [next] 'pager-page-down)


;; Bind F5 to call last keyboard macro
;; (global-set-key [f5] 'call-last-kbd-macro)

;; ;; MOVING LINES
(require 'smooth-scrolling)

(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)

(defun move-line (&optional n)
  "Move current line N (1) lines up/down leaving point in place."
  (interactive "p")
  (when (null n) 
    (setq n 1)) 
  (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (beginning-of-line)
    (forward-char col)))

(defun move-line-up (n)
  "Moves current line N (1) lines up leaving point in place."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Moves current line N (1) lines down leaving point in place."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


;; (defun python-shift-left-remark (start end)
;;   (interactive "r")
;;   (python-shift-left start end)
;;   (exchange-point-and-mark)
;;   (exchange-point-and-mark))


;; (defun python-shift-right-remark (start end)
;;   (interactive "r")
;;   (python-shift-right start end)
;;   (let ((omark (point)))
;;     (goto-char (mark t))
;;     (set-mark (point))
;;     (goto-char omark)))

;(setq default-frame-alist
;    '((top . 0) (left . 0)
;      (width . 110) (height . 87)
;      ;;(cursor-color . "red")
;      ;;(cursor-type . box)
;      ;;(foreground-color . "white")
;      ;;(background-color . "black")
;      (font . "7x14")))

;; (setq auto-mode-alist (cons '("\\.mel\\'" . c-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.ma\\'" . c-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.s\\'" . c-mode) auto-mode-alist))

;; to grab a windows font, evaluate the following, then call
;; insert-x-style-font
;;
;; (if (eq window-system 'w32)        ; emacs 20 & up
;;    (defun insert-x-style-font()
;;      "Insert a string in the X format which describes a font the
;;user can select from the Windows font selector."
;;      (interactive)
;;      (insert (prin1-to-string (w32-select-font)))))


;; (shell-pushd-regexp

;(setq shell-pushd-regexp "cd")
;; (setq shell-popd-regexp "\\(po\\|popdir\\)")

;; (setq shell-pushd-regexp "\\(cd\\|pd\\|pushd\\)")

;; (setq csh-indent default-tab-width)


;; (set-clipboard-coding-system (quote x-ctext-unix))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; .tcsh junk

;;-----------------------------------.emacs-----------------------------------
;;;; --------------------------------------------------


;; (setenv "SHELL" "tcsh.exe")
;; (setq w32-quote-process-args t)   ; Emacs 20
;; (setq shell-command-switch "-cf")

;; ;;;; Set up the shell for the shell mode
;; (defun my-shell-mode-hook ()
;;   (interactive)
;;   (setq shell-completion-fignore '("~" "#" "%" ".class"))
;;   (setq comint-completion-addsuffix '("/" . " "))
;;   (setq completion-ignored-extensions '(".o" ".elc" "~" ".bin" ".bak"
;; ".obj" ".map" ".dvi" ".toc" ".log" ".aux" ".a" ".ln" ".lof" ".blg"
;; ".bbl" ".glo" ".idx" ".lot" ".fmt" ".class"))
;; )

;; (setq shell-mode-hook nil)
;; (add-hook 'shell-mode-hook 'my-shell-mode-hook)


(put 'scroll-left 'disabled nil)

(defun toggle-truncate-lines ()
"Toggle the variable truncate-lines between true and false"
(interactive)
  (if (eq truncate-lines 't)
    (set-variable 'truncate-lines nil)
    (set-variable 'truncate-lines 't)
   )
 )
(global-set-key [f7] 'toggle-truncate-lines)

(defun make-backup-file-name (file) (concat (home "bkp/emacs/") (file-name-nondirectory file)))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)



;; --------------------------------- TEST junk

;;; Final version: while
(defun count-words-buffer2 ()
  "Count all the words in the buffer"
  (interactive)
  (count-words-region (point-min) (point-max) )
)

(defun multiply-by-seven (number)
  "Multiply NUMBER by seven."
  (* 7 number))

(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;(defun listify-region (beginning end)
;  "Turn the region into a comma separated list of quoted words"
;  (interactive "r")
;  (message "listifying...")
;  (while (and (< (point) end)
;
;              (re-search-forward "
  

;; Count the words in the entire document
(defun count-words-buffer ()
  "Count all the words in the buffer"
  (interactive)
  (count-words-region (point-min) (point-max) )
)

(fset 'pycreate
   [?\C-x ?i ?~ ?/ ?d ?a ?t ?a ?/ ?t ?e ?m ?p ?l ?a ?t ?e ?. ?p ?y return])

;; load custom simple adb mode woohoo woohoo
(require 'adb-mode)
(require 'note-mode)
(require 'marlog-mode)
(require 'face-list)



(defun scroll-down-keep-cursor () 
   ;; Scroll the text one line down while keeping the cursor 
   (interactive) 
   (scroll-down 1)) 

(defun scroll-up-keep-cursor () 
   ;; Scroll the text one line up while keeping the cursor 
   (interactive) 
   (scroll-up 1)) 

;; Bind the functions to the /-key and the *-key (on the numeric keypad) with:

(global-set-key [C-M-up] 'scroll-down-keep-cursor) 
(global-set-key [C-M-down] 'scroll-up-keep-cursor)
(global-set-key (kbd "C-S-SPC") 'pop-to-mark-command)


;; cursor modes
;; 

; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
(setq djcb-read-only-color       "green")
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type

(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "yellow")
(setq djcb-normal-cursor-type    'bar)

(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."

  (cond
    (buffer-read-only
      (set-cursor-color djcb-read-only-color)
      (setq cursor-type djcb-read-only-cursor-type))
    (overwrite-mode
      (set-cursor-color djcb-overwrite-color)
      (setq cursor-type djcb-overwrite-cursor-type))
    (t 
      (set-cursor-color djcb-normal-color)
      (setq cursor-type djcb-normal-cursor-type))))

(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)

;; copy/kill without selecting
;; 

(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
  "Copied line") (list (line-beginning-position) (line-beginning-position
  2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))

(defun chmod-buffer-file ()
  (interactive)
  (let ((file (buffer-file-name)))
    (chmod file (read-file-modes))))

(defun maross-proc-occur ()
  (interactive)
  (maross-small-occur "global proc" t))

(global-set-key (kbd "M-p") 'maross-proc-occur)

;; (defun maross-proc-frame ()
;;   (interactive)
;;   (let*
;;       ((cur-buffer (current-buffer))
;;        (cur-frame-name
;;         (window-frame (get-buffer-window cur-buffer)))
;;        (new-frame-name "Proc-List")
;;        (new-frame
;;         (make-frame `((name . ,new-frame-name)))))
;;     (select-frame new-frame)
;;     (occur "global proc")
;;     (select-window (get-buffer-window "*Occur*"))
;;     (delete-other-windows)
;;     ))

(fset 'maross-proc-print
   [?\C-s ?g ?l ?o ?b ?a ?l ?  ?p ?r ?o ?c ?\C-m ?\C-s ?\( left ?\C-  ?\C-r ?  right ?\M-w ?\C-s ?\{ end return tab ?p ?r ?i ?n ?t ?\( ?\" ?p ?r ?o ?c ?P ?r ?i ?n ?t ?: ?\S- ?\C-y ?\\ ?n ?\" ?\) ?\;])

(global-set-key (kbd "C-c p") 'maross-proc-print)


;; set mode line face.
(require 'face-remap)

(defun maross-fixed-pitch-mode (&optional arg)
  "fixed-pitch default-face mode.
An interface to `buffer-face-mode' which uses the `fixed-pitch' face.
Besides the choice of face, it is the same as `buffer-face-mode'."
  (interactive (list (or current-prefix-arg 'toggle)))
  (buffer-face-mode-invoke 'fixed-pitch arg (interactive-p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; etom 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; don't forget to run in maya:
;; commandPort -eo -n ":2222";
;; 
(require 'etom)
(require 'pulse)

(if (string= (maross-system-type) "windows")
    (progn 
      (setq pulse-delay 0.01)
      (setq pulse-iterations 5)))

;; (load-file (emacs-dir "cedet-1.0pre6/common/pulse.el"))


(defun maross-comint-mode-hook ()
  ;; (setq comint-prompt-read-only nil)
  ;; (setq etom-prompt-regexp "^> *$")
  (add-hook 'comint-preoutput-filter-functions
            'maross-etom-preoutput-filter-function)
  (maross-fixed-pitch-mode)
  (maross-etom-bind-keys)
  )

(defun maross-etom-bind-keys ()
  (interactive)
  (local-set-key [\C-return] 'maross-etom-send-region-or-line))

(add-hook 'mel-mode-hook 'maross-etom-bind-keys)
(add-hook 'python-mode-hook 'maross-etom-bind-keys)

(defun maross-pulse-eval-last-sexp ()
  (interactive)
  (save-excursion
    (backward-sexp)
    (mark-sexp)
    (maross-pulse-momentary-highlight-line-or-region)
    (eval-region)))

(defun replace-regexps-in-string (regexps str) 
  "Given a list of (regexp . replacement) pairs, replace all of them in str
  in the order given "
  (while regexps
    (setq str (replace-regexp-in-string (caar regexps) (cdar regexps) str))
    (setq regexps (cdr regexps)))
  str)

(defun maross-etom-preoutput-filter-function (str)
  (interactive)
  (let ((match-replace-pairs 
         '(("(:2222)\s*: " . "")
           ("(:2222)\s*" . "")
           ("\n\n\0" . "\n")
           ("\0" . "")
           ("// WARNING: unknown result type" . "")
           ("/home/maross/work/toolset/modeling/third_party/maya/script/mod_parts"
            . "<w_mod_parts>")
           ("/home/maross/work/toolset/modeling/third_party/maya/script"
            . "<script>")
           ("c:/bin/maya/mod_parts" . "<m_mod_parts>")
           )))
    (replace-regexps-in-string match-replace-pairs str)))

(defun maross-etom-send-region-or-line ()
  (interactive)
  (let* ((start-end (maross-stripped-line-or-region-start-end))
         (start (car start-end))
         (end (cdr start-end))
         (transient-mark-mode-state transient-mark-mode)
         (aspython (string= major-mode "python-mode")))
    (maross-pulse-region start end)
    (etom-send-region start end aspython)))

;; TODO: these could be refactored to a general "do in buffer"
(defun maross-other-window-do (action &optional buf-name) 
  (interactive)
  (if (not (or buf-name (< 1 (length (window-list)))))
      "No other buffer available")
  (let* ((buf-name (or buf-name (window-buffer (cadr (window-list)))))
         (other-buf (get-buffer buf-name)))
    (if (not other-buf)
        (message "Buffer currently does not exists")
      (let ((current-win (selected-window))
            (other-win (get-buffer-window buf-name)))
        (if other-win
            (progn
              (select-window other-win)
              (funcall action)
              (select-window current-win)))))))

(defun maross-other-window-down ()
  "Step down once in the other buffer"
  (interactive)
  (maross-other-window-do #'scroll-up-keep-cursor))

(defun maross-other-window-up ()
  "Scroll uponce in the other buffer"
  (interactive)
  (maross-other-window-do #'scroll-down-keep-cursor))

(defun maross-other-window-beginning-of-buffer ()
  "Go to the start of the other window"
  (interactive)
  (maross-other-window-do #'beginning-of-buffer))

(defun maross-other-window-end-of-buffer ()
  "Go to the end of the other buffer"
  (interactive)
  (maross-other-window-do #'end-of-buffer))

(defun maross-other-window-page-down ()
  (interactive)
  (maross-other-window-do #'pager-page-down))

(defun maross-other-window-page-up ()
  (interactive)
  (maross-other-window-do #'pager-page-up))



(global-set-key [\C-\M-\S-down] 'maross-other-window-down)
(global-set-key [\C-\M-\S-up] 'maross-other-window-up)
(global-set-key [\C-\M-\S-home] 'maross-other-window-beginning-of-buffer)
(global-set-key [\C-\M-\S-end] 'maross-other-window-end-of-buffer)
(global-set-key [\C-\M-\S-next] 'maross-other-window-page-down)
(global-set-key [\C-\M-\S-prior] 'maross-other-window-page-up)


(defun maross-etom-goto-maya-top ()
  "Go to the top of the maya buffer without leaving cursor there."
  (interactive)
  (maross-other-window-do #'beginning-of-buffer "*Maya*" ))

(defun maross-etom-goto-maya-bottom ()
  "Go to the top of the maya buffer without leaving cursor there."
  (interactive)
  (maross-other-window-do #'end-of-buffer "*Maya*" ))


(defun maross-pulse-region (&optional start end)
  (if (not (and start end))
      (progn
        (setq (start region-beginning))
        (setq (end region-end))))
  (let* ((transient-mark-mode-state transient-mark-mode)
         (semantic-highlight-edits-mode-state semantic-highlight-edits-mode))
    (transient-mark-mode nil)
    (semantic-highlight-edits-mode nil)
    (pulse-momentary-highlight-region start end)
    (transient-mark-mode transient-mark-mode-state)
    (semantic-highlight-edits-mode)))
  

(defun maross-pulse-momentary-highlight-line-or-region ()
  (let* ((start-end (maross-line-or-region-start-end))
         (start (car start-end))
         (end (cdr start-end))
         (transient-mark-mode-state transient-mark-mode))
    (transient-mark-mode nil)
    (pulse-momentary-highlight-region start end)
    (transient-mark-mode transient-mark-mode-state)))


(defun maross-line-or-region-start-end ()
  (interactive)
  (if (use-region-p)
        (cons (region-beginning) (region-end))
      (cons (line-beginning-position) (line-end-position))))

(defun maross-stripped-line-or-region-start-end ()
  (interactive)
  (let ((start nil)
        (end nil))
    (if (use-region-p)
        (progn
          (setq start (region-beginning))
          (setq end (region-end)))
      (progn
        (setq start (line-beginning-position))
        (setq end (line-end-position))))
    (setq start (re-search-forward-non-whitespace start))
    (setq end (re-search-backward-non-whitespace end))
  (cons start end)))

(defun re-search-forward-non-whitespace (&optional position)
  (interactive)
  (if (not position) (setq position (point)))
  (save-excursion
    (goto-char position)
    (- (re-search-forward "[^\n \t]") 1)))

(defun re-search-backward-non-whitespace (&optional position)
  (interactive)
  (if (not position) (setq position (point)))
  (save-excursion
    (goto-char position)
    (+ 1(re-search-backward "[^ \n\t]"))))


(defun maross-etom-init ()
  (interactive)
  (find-file (emacs-dir "emacs-script-editor.py"))
  (find-file (emacs-dir "emacs-script-editor.mel"))
  (etom-connect))

(defun maross-etom-reconnect ()
  (interactive)
  (etom-disconnect)
  (etom-connect))

(global-set-key (kbd "C-S-M-s") 'maross-etom-init)
(global-set-key (kbd "C-S-M-x") 'maross-etom-reconnect)

(add-hook 'comint-mode-hook 'maross-comint-mode-hook)

(defun maross-org-to-wiki (&optional str) 
  (interactive)
  (let* ((original (if str str
                   (maross-region-or-thing 'paragraph)))
         (result original)
         (result (replace-regexp-in-string "^\\*\\*\\*\\*\\*\\* " "h6. " result))
         (result (replace-regexp-in-string "^\\*\\*\\*\\*\\* " "h5. " result))
         (result (replace-regexp-in-string "^\\*\\*\\*\\* " "h4. " result))
         (result (replace-regexp-in-string "^\\*\\*\\* " "h3. " result))
         (result (replace-regexp-in-string "^\\*\\* " "h2. " result))
         (result (replace-regexp-in-string "^\\* " "h1. " result))
         )
    ;; (message result)
    result))

(defun maross-org-to-wiki-save (&optional str)
  (interactive)
  (let* ((original (if str str
                     (maross-region-or-thing 'paragraph)))
         (result (maross-org-to-wiki original))
         (start (point)))
    (insert result)
    (kill-region start (+ start (length result)))))
    
(defadvice eval-last-sexp (before eval-last-sexp-pulse-advice)
  (save-excursion
    (backward-sexp)
    (mark-sexp)
    (maross-pulse-momentary-highlight-line-or-region)))

(ad-activate 'eval-last-sexp)

(defun maross-emacs-lisp-mode-hook ()
  (interactive)
  (local-set-key [\C-return] 'eval-last-sexp))

(add-hook 'emacs-lisp-mode-hook 'maross-emacs-lisp-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ahk mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ahk-mode)
(setq ahk-syntax-directory "c:/Program files/AutoHotkey/Extras/Editors/Syntax/")
(add-to-list 'auto-mode-alist '("\\.ahk$" . ahk-mode))
(autoload 'ahk-mode "ahk-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (add-to-list 'load-path
                  (emacs-dir "yasnippet-0.6.1c"))
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory (emacs-dir "yasnippet-0.6.1c/snippets"))
