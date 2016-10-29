(in-package :cl-patterns)

;; NOTES: use alexandria:clamp instead of clip

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

(defun wrap (number bottom top)
  "Wraps a number between BOTTOM and TOP, similar to `mod'."
  (+ (mod (- number bottom) (- top bottom)) bottom))

(defun re-intern (symbol &optional (package 'cl-patterns))
  "Interns a symbol from one package into a different package."
  (intern (symbol-name symbol) package))

(defun as-keyword (symbol)
  "Turns a symbol into a keyword."
  (re-intern symbol :keyword))

;; nabbed from https://stackoverflow.com/questions/11067899/is-there-a-generic-method-for-cloning-clos-objects
(defgeneric copy-instance (object &rest initargs &key &allow-other-keys)
  (:documentation "Makes and returns a shallow copy of OBJECT.

  An uninitialized object of the same class as OBJECT is allocated by
  calling ALLOCATE-INSTANCE.  For all slots returned by
  CLASS-SLOTS, the returned object has the
  same slot values and slot-unbound status as OBJECT.

  REINITIALIZE-INSTANCE is called to update the copy with INITARGS.")
  (:method ((object standard-object) &rest initargs &key &allow-other-keys)
    (let* ((class (class-of object))
           (copy (allocate-instance class)))
      (dolist (slot-name (mapcar #'sb-mop:slot-definition-name (sb-mop:class-slots class)))
    (when (slot-boundp object slot-name)
      (setf (slot-value copy slot-name)
        (slot-value object slot-name))))
      (apply #'reinitialize-instance copy initargs))))
