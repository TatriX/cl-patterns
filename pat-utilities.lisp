(in-package :cl-patterns)

;; NOTES: use alexandria:clamp instead of clip

;; glue

(defun output (&rest strings)
  "Concatenates and prints strings."
  (fresh-line)
  (format t "~{~A~}~%" (remove-if #'null strings))
  (finish-output))

(defun repeat (item num)
  "Returns a list containing 'num' items. If 'item' is a function, return a list of 'num' of the result of that function."
  (when (> num 0)
    (cons (if (eq 'function (type-of item))
              (funcall item)
              item)
          (repeat item (- num 1)))))

;; (defun re-intern (symbol &optional (package 'cl-patterns))
;;   "Interns a symbol from one package into a different package."
;;   (intern (symbol-name symbol) package))

(defun as-keyword (symbol)
  "Turns a symbol into a keyword."
  (alexandria:ensure-symbol symbol :keyword))

(defun gete (list key)
  "Get a list of the value of KEY for each element in LIST."
  (mapcar (lambda (event)
            (unless (null event)
              (get-event-value event key)))
          list))

(define-method-combination pattern () ;; same as standard, but :around methods are called in reverse order, from least to most specific.
  ((around (:around))
   (before (:before))
   (primary () :required t)
   (after (:after)))
  (flet ((call-methods (methods)
           (mapcar #'(lambda (method)
                       `(call-method ,method))
                   methods)))
    (let ((form (if (or before after (rest primary))
                    `(multiple-value-prog1
                         (progn ,@(call-methods before)
                                (call-method ,(first primary)
                                             ,(rest primary)))
                       ,@(call-methods (reverse after)))
                    `(call-method ,(first primary)))))
      (if around
          (let ((around (reverse around)))
            `(call-method ,(first around)
                          (,@(rest around)
                             (make-method ,form))))
          form))))

;; math stuff

(defun wrap (number bottom top)
  "Wraps a number between BOTTOM and TOP, similar to `mod'."
  (+ (mod (- number bottom) (- top bottom)) bottom))

(defun random-range (low high)
  (let ((rval (- high low)))
    (+ low
       (random (if (integerp rval)
                   (1+ rval)
                   rval)))))
