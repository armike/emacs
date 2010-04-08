;;; comment-uncomment-line-or-region.el --- comments or
;;; uncomments current line or region according to
;;; state before.

;; Version: 1.0

;; Copyright (C) 2006  Andreas Roehler

;; Author: Andreas Roehler <[EMAIL PROTECTED]>
;; Keywords: comment uncomment

;; This file is free software; you can redistribute it
;; and/or modify it under the terms of the GNU General Public License 
;; as published by the Free Software Foundation; either version 2, 
;; or (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Tries to be a quick commenting/uncommenting
;; facility, as it respects region - active-mark and
;; transient-mark-mode - but doesn't depend on them. If
;; on a line, wanting to comment or uncomment them,
;; you don't have to care if transient-mark-mode is on.

;; Should you intend to comment/uncomment more lines,
;; it also works that way: just keep the key pressed.

;; The region is respected and worked on nonetheless if
;; transient-mark-mode is active

;; Given a numeric arg of 1 it copies line or region
;; first, so you get the text commented and uncommented
;; likewise

;;; Code:

;; (global-set-key (kbd "<M-kp-6>") 'comment-uncomment-line-or-region)

(defun comment-uncomment-line-or-region (&optional arg)
  "comments or uncomments a line according to state before. 
With key pressed, continues with next line. 
With arg copies and reinserts last line."
  (interactive "*P")
  (comment-normalize-vars)
  (let* ((arg (if arg (prefix-numeric-value arg) 0))
         (start (if (and mark-active transient-mark-mode)
                    (region-beginning)
                  (line-beginning-position)))
         (end (if (and mark-active transient-mark-mode)
                  (region-end)
                (line-end-position)))
         (line-to-comment-or-uncomment (buffer-substring-no-properties
                                        (or
                                         start (line-beginning-position))
                                        (or end
                                            (line-end-position)))))
    (cond ((eq 1 arg) ;; comment and reinsert
           (comment-or-uncomment-region start end)
;;          (indent-according-to-mode) 
           (end-of-line)
           (newline)
           (insert line-to-comment-or-uncomment)
;;          (indent-according-to-mode)
)
          ((< 1 arg) ;; comment as many lines are given
           (while (<= 1 (prefix-numeric-value arg))
             (comment-or-uncomment-region (line-beginning-position) 
(line-end-position))
;;            (indent-according-to-mode) 
             (end-of-line)
             (forward-line 1) 
;;             (indent-according-to-mode)
             (setq arg (1- arg))))
          ((and start end)
           (comment-or-uncomment-region start end)
;;          (indent-according-to-mode)
           (if (eobp)
               (progn (newline)
;;                     (indent-according-to-mode)
)
             (progn
               (forward-line 1)
;;              (indent-according-to-mode)
)))
          (t ;; just one line
           (progn (comment-or-uncomment-region (line-beginning-position) 
(line-end-position))
;;                 (indent-according-to-mode)
                  (if (eobp)
                      (progn (newline)
;;                            (indent-according-to-mode)
                             )
                    (progn
                      (forward-line 1)
;;                     (indent-according-to-mode)
                      )))))))

(provide 'comment-uncomment-line-or-region)
;;; comment-uncomment-line-or-region.el ends here
