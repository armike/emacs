;; author: maross
;; Created: 2009-06-25
;; Quickly get revisions of various types and compare them.

(defun get-cvs-revision (filename) 
  "Return the string of the first revision found"
  (interactive)
  (shell-command (format "cvsvers %s" filename))
  (let ((result (file-expand-wildcards (concat filename ".~v_*~"))))
    (if result
        (car result)
      nil)))

(defun get-auto-save-file (filename) 
  "Return the string of the first revision found"
  (interactive)
  (let ((result (file-expand-wildcards (format "#%s#" filename))))
    (if result
        (car result)
      nil)))

;; (defun get-other-buffer (buffer-2)
;;   (interactive)
;;   (message (format "buffer: %s" buffer-2))
;;   (cond
;;    ((eq (length buffer-2) 0)
;;     (setq buffer-2 (buffer-name (cadr (buffer-list))))
;;    ((< (length buffer-2) 3)
;;     (setq buffer-2 (format "hourly.%s" buffer-2)))
;;   )
;;   (let ((result
;;          (replace-regexp-in-string "maross"
;;                                    (format "maross/.snapshot/%s" snapshot)
;;                                    (file-truename filename))))
;;     (if (file-exists-p result)
;;         result
;;       nil)))
 

(defun get-percs-revision (filename version)
  (interactive)
  
  (let* ((cmd (if (string= version "")
                  (format "maross_pget %s" filename)
                (format "maross_pget %s -vers %s" filename version)))
         (command-result (shell-command-to-string cmd))
         (percs-file (format-maross-pget-output command-result))
         (tmp-percs-file (make-temp-file percs-file)))
    (message (format "percs-file: %s" percs-file))
    (rename-file percs-file tmp-percs-file t)
    tmp-percs-file))

(defun format-maross-pget-output (s)
  (replace-regexp-in-string "\n" "" (replace-regexp-in-string "\\(.* --> \\)" "" s)))

                            
(defun get-snapshot-revision (filename snapshot)
  "Return the string of the first revision found"
  (interactive)
  (message (format "snapshot: %s" snapshot))
  (cond
   ((eq (length snapshot) 0)
    (setq snapshot "hourly.1"))
   ((< (length snapshot) 3)
    (setq snapshot (format "hourly.%s" snapshot)))
  )
  (let ((result
         (replace-regexp-in-string "maross"
                                   (format "maross/.snapshot/%s" snapshot)
                                   (file-truename filename))))
    (if (file-exists-p result)
        result
      nil)))

(defun compare-with-revision (buffer get-revision-func)
  (interactive)
  (let* ((tmp-buffer (get-buffer-tmp-file buffer))
         (revision (funcall get-revision-func buffer))
         (diff-cmd (format "xxdiff '%s' %s &"
                           revision tmp-buffer tmp-buffer)))
    (message diff-cmd)
    (if revision
        (progn
          (shell-command diff-cmd))
      (message (format "No revision found with %s %s"
                       get-revision-func buffer)))))

(defun compare-buffer-with-auto-save-file (buffer)
  (interactive "b")
    (compare-with-revision buffer #'get-auto-save-file))

(defun compare-buffer-with-cvs-revision (buffer) 
  (interactive "b")
    (compare-with-revision buffer #'get-cvs-revision))

(defun compare-buffer-with-file (buffer)
  (interactive "b")
    (compare-with-revision buffer (lambda (filename) filename)))

(defun compare-buffer-with-snapshot (snapshot) 
  (interactive "sSnapshot revision: ")
    (compare-with-revision (buffer-name)
                           (lambda (filename)
                             (get-snapshot-revision filename snapshot))))

(defun compare-buffer-with-percs-revision (version) 
  (interactive "sPercs revision (negatives okay): ")
  (compare-with-revision (buffer-name)
                         (lambda (filename)
                           (get-percs-revision filename version)))
    )

(defun compare-buffer-strip (str)
  "Strip leading and tailing whitespace from str."
  (let ((s (if (symbolp str) (symbol-name str) str)))
    (replace-regexp-in-string "\\(^[[:space:]\\n\n]*\\|[[:space:]\\n\n]*$\\)" "" s)))

(compare-buffer-strip "asasfasf\n")

;; (defun compare-buffer-with-buffer (this-buffer) 
;;   (interactive "sBuffer name: ")
;;     (compare-with-revision (buffer-name)
;;                            (lambda (filename)
;;                              (get-other-buffer filename))))


;; warning: write-region actually only writes the region from the current
;; buffer, this will need to change later.
(defun get-buffer-tmp-file (buffer)
  (interactive)
  (let ((temp-file (make-temp-file buffer)))
    (write-region 1 (+ 1 (buffer-size (get-buffer buffer))) temp-file)
    temp-file))

;; Suggested bindings
;; (global-set-key (kbd "C-S-v") 'compare-buffer-with-cvs-revision)
;; (global-set-key (kbd "C-S-a") 'compare-buffer-with-auto-save-file)
;; (global-set-key (kbd "C-S-b") 'compare-buffer-with-file)
;; (global-set-key (kbd "C-S-M-p") 'compare-buffer-with-percs-revision)

; (get-buffer-tmp-file (buffer-name))
; (buffer-size)

(provide 'revision-grabber)
