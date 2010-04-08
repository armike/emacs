(message (buffer-name)) ;; buffer name string
(current-buffer) ;; buffer object


(point-min)      ;; minimum admissable location for the mark
(point-max)      ;; maximum admissable location for the mark
(point)          ;; location of the point
(buffer-size)    

(switch-to-buffer "*scratch*")    ;; switch active and displayed buffer
(set-buffer "*scratch*")          ;; switch active buffer, not displayed

(defun foo (args)
  (+ 1 1))

(message "takes format flags! :D %s %.2f %d" "string flag (%f)" 12.3456 1)

(set 'a-test-variable "set evaluates both arguments before setting arg1 = arg2")
(setq a-test-variable "this is a test variable")

(message a-test-variable)

(message (string 40))

;; (interactive (<code>Messge))
(defun testt (buffer start end)
  "Append something to buffer"
  (interactive "bAppend to buffer: \nr")
  (let ((something "something as a string")
        (something-else "something else as a string"))
    (if (string< something something-else)
        "something is shorter"
        "something else is  shorter")))

(test-func (buffer-name) 10 20)

(length "sfdfdfdfs")

;; save=excursion preserves the point and mark

(help)

(bufferp (current-buffer))
