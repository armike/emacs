;; pdi-ani.el -- PDI ANI/PeRCS utilities programs
;;
;; Copyright (c) 2008
;;
;; Original Author: Stuart T. Tett
;; PDI/DreamWorks Animation
;;

;;;;;;;;;;;;;;;
;; PeRCS
;;;;;;;;;;;;;;;

(defun pdi-prc-checkout (flags)
	"Check out the current buffer from PeRCS."
	(interactive "sFlags: ")
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat (concat a-percs-command-dir "/prc_checkout ") flags) pdi-file)))
	(if buffer-read-only
			(toggle-read-only)
		(nil))
	(message "File checked out from PeRCS."))

(defun pdi-prc-checkin (comment)
	"Check the current buffer into PeRCS."
	(interactive "sComment: ")
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat (concat a-percs-command-dir "/prc_checkin ") pdi-file) (concat " -comment " comment))))
	(if buffer-read-only
			(nil)
		(toggle-read-only))
	(message "File checked into PeRCS."))

(defun pdi-prc-revert ()
	"Revert the current buffer in PeRCS."
	(interactive)
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat a-percs-command-dir "/prc_release ") pdi-file)))
	(if buffer-read-only
			(nil)
		(toggle-read-only))
	(revert-buffer t t t)
	(message "File reverted in PeRCS."))

(defun pdi-prc-add ()
	"Add the current buffer to PeRCS."
	(interactive)
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat a-percs-command-dir "/prc_add ") pdi-file)))
	(message "File added to PeRCS."))

(defun pdi-prc-update ()
	"Update the current buffer in the shadow tree from PeRCS"
	(interactive)
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat a-percs-command-dir "/prc_update ") pdi-file)))
	(message "File updated in shadow tree."))

(defun pdi-prc-changes ()
	"Show the changes for the current buffer in PeRCS (i.e., compact version of history)"
	(interactive)
	(let* ((pdi-file (buffer-file-name)))
			(shell-command (concat (concat a-percs-command-dir "/prc_changes ") pdi-file) "PeRCS Changes")))

(defun pdi-prc-diff (vers)
	"Check out the current buffer from PeRCS."
	(interactive "nVersion: ")
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat (concat a-percs-command-dir "/prc_diff -vers ") vers) pdi-file)))
	(message "Running prc_diff."))

(global-set-key "\M-po" 'pdi-prc-checkout)
(global-set-key "\M-pi" 'pdi-prc-checkin)
(global-set-key "\M-pa" 'pdi-prc-add)
(global-set-key "\M-pr" 'pdi-prc-revert)
(global-set-key "\M-pu" 'pdi-prc-update)
(global-set-key "\M-pc" 'pdi-prc-changes)
(global-set-key "\M-pd" 'pdi-prc-diff)

;; PeRCS menu
(define-key global-map [menu-bar percs-menu]
       (cons "PeRCS" (make-sparse-keymap "PeRCS")))
(define-key global-map
	[menu-bar percs-menu prc-revert]
	'("Revert" . pdi-prc-revert))
(define-key global-map
	[menu-bar percs-menu prc-update]
	'("Update" . pdi-prc-update))
(define-key global-map
	[menu-bar percs-menu prc-changes]
	'("Changes" . pdi-prc-changes))
(define-key global-map
	[menu-bar percs-menu prc-diff]
	'("Diff" . pdi-prc-diff))
(define-key global-map
	[menu-bar percs-menu prc-add]
	'("Add" . pdi-prc-add))
(define-key global-map
	[menu-bar percs-menu prc-check-in]
	'("Check In" . pdi-prc-check-in))
(define-key global-map
	[menu-bar percs-menu prc-check-out]
	'("Check Out" . pdi-prc-check-out))

;;;;;;;;;;;;;;;;;;;
;; ANI DIRECTORIES
;;;;;;;;;;;;;;;;;;;

(defun find-a-shot-dir ()
	(interactive)
	(find-file a-shot-dir))

(defun find-a-shot-data-dir ()
	(interactive)
	(find-file a-shot-data-dir))

(defun find-a-shot-tmp-dir ()
	(interactive)
	(find-file a-shot-tmp-dir))

;; Find any directory based on ANI variable
(defun find-ani-dir (dir)
	(interactive "vANI Directory: ")
	(find-file (symbol-value (symbol-value 'dir)))) ;; e.g., value of dir is a-shot-dir and value of that is "/studio/mad2/.../.."

;; Insert an ANI variable in the buffer
;; Useful when you can't rembember the variable
;; Since emacs has TAB completion
;; Ex: a-shot-dir => ${a_shot_dir}
(defun insert-ani-var (ani)
	(interactive "vANI Variable Lookup: ")
	(insert (replace-regexp-in-string "-" "_" (format "${%S}" ani))))

(global-set-key "\C-c\C-s" 'find-a-shot-dir)
(global-set-key "\C-c\C-d" 'find-a-shot-data-dir)
(global-set-key "\C-c\C-t" 'find-a-shot-tmp-dir)
(global-set-key "\C-c\C-f" 'find-ani-dir)
(global-set-key "\C-ca" 'insert-ani-var)

;;;;;;;;;;;;;
;; PDI Tools
;;;;;;;;;;;;;

(defun adb-spread ()
	"Open the current buffer in adb_spread."
	(interactive)
	(let* ((pdi-file (buffer-file-name)))
		(shell-command (concat (concat a-command-dir "/adb_spread ") pdi-file)))
	(message "File opened in adb_spread."))

(global-set-key "\C-co" 'adb-spread)

;; PDI Menu
(define-key global-map [menu-bar pdi-menu]
	(cons "PDI" (make-sparse-keymap "PDI")))
(define-key global-map
	[menu-bar pdi-menu open-a-shot-dir]
	'("Shot Directory" . find-a-shot-dir))
(define-key global-map
	[menu-bar pdi-menu open-a-shot-data-dir]
	'("Data Directory" . find-a-shot-data-dir))
(define-key global-map
	[menu-bar pdi-menu open-a-shot-tmp-dir]
	'("Temp Directory" . find-a-shot-tmp-dir))
(define-key global-map
	[menu-bar pdi-menu open-ani-dir]
	'("ANI Directory" . find-ani-dir))
(define-key global-map
	[menu-bar pdi-menu print-ani-var]
	'("Insert ANI variable" . insert-ani-var))


;;;;;;;;;;;;;;
;; Provide It
;;;;;;;;;;;;;;

(provide 'pdi-ani)


;; Idea for building adb GUI into emacs
;; adb_cheat -type camera standard | grep "^[ \t]*attr" | sed "s/^[ \t]*attr/camera/g"