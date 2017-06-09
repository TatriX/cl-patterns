(in-package :cl-patterns)

(defmacro at (time &body body)
  `(sc:at ,time ,@body))

(defun release (node)
  (sc:release node))

(defun get-synth-args-list (synth)
  (or (mapcar #'car (getf sc::*synthdef-metadata* synth))
      (mapcar #'alexandria:make-keyword
              (remove-if (lambda (symbol)
                           (or
                            (position symbol (list '&key 'sc::end-f))
                            (consp symbol)))
                         (swank-backend:arglist (fdefinition (alexandria:ensure-symbol synth))))))) ;; FIX: need to officially require swank-backend

(defun play-sc (item &optional pstream) ;; FIX: move the params stuff into its own function
  (unless (eq (get-event-value item :type) :rest)
    (let* ((inst (instrument item))
           (synth-params (get-synth-args-list inst))
           (time (+ (or (raw-get-event-value item :latency) *latency*) (or (raw-get-event-value item :unix-time-at-start) (sc:now))))
           (params (if synth-params ;; make the parameters list for sc:synth.
                       (alexandria:flatten
                        (remove-if #'null
                                   (loop :for sparam :in synth-params
                                      :collect (let ((val (get-event-value item sparam)))
                                                 (when val
                                                   (cons sparam (if (eq :gate sparam)
                                                                    1
                                                                    val)))))))
                       (copy-list (event-plist item))))
           (params (mapcar (lambda (list-item) ;; replace buffers in the parameters list with their buffer numbers.
                             (if (typep list-item 'sc::buffer)
                                 (sc:bufnum list-item)
                                 list-item))
                           params)))
      (if (and (eq (get-event-value item :type) :mono)
               (not (null pstream)))
          (let ((node (at time
                        (if (and (not (null (slot-value pstream 'nodes))))
                            (apply #'sc:ctrl (car (slot-value pstream 'nodes)) params)
                            (sc:synth inst params)))))
            (if (< (legato item) 1)
                (at (+ time (dur-time (sustain item)))
                  (setf (slot-value pstream 'nodes) (list))
                  (release node))
                (setf (slot-value pstream 'nodes) (list node))))
          (let ((node (at time
                        (sc:synth inst params))))
            (when (sc:has-gate-p node)
              (at (+ time (dur-time (sustain item)))
                (release node))))))))

(setf *event-output-function* 'play-sc)