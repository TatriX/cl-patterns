(defpackage #:cl-patterns
  (:use #:cl
        #:alexandria
        #:mutility)
  (:export

   ;;; utility.lisp

   #:*cl-patterns-temporary-directory*

   #:*event*
   #:*clock*

   #:multi-channel-funcall
   #:next-beat-for-quant
   #:rerange

   #:tempo
   #:beat
   #:quant
   #:play-quant
   #:end-quant
   #:rest-p
   #:play
   #:launch
   #:stop
   #:end
   #:playing-p
   #:loop-p
   #:play-or-stop
   #:play-or-end
   #:render

   ;;; conversions.lisp

   #:amp-db
   #:db-amp

   #:dur-time
   #:time-dur

   #:midinote-freq
   #:freq-midinote
   #:freq-octave
   #:midinote-octave
   #:midinote-degree
   #:freq-degree
   #:note-midinote
   #:midinote-note
   #:note-freq
   #:freq-note
   #:degree-note
   #:note-degree
   #:degree-midinote
   #:degree-freq
   #:ratio-midi
   #:midi-ratio
   #:freq-rate
   #:rate-freq
   #:midinote-rate
   #:rate-midinote

   #:midi-truncate-clamp
   #:bipolar-1-to-midi
   #:unipolar-1-to-midi
   #:frequency-to-midi

   ;;; scales.lisp

   #:*note-names*
   #:note-number
   #:note-name
   #:scale-midinotes

   #:define-scale
   #:all-scales
   #:scale
   #:scale-name
   #:scale-notes
   #:scale-tuning

   #:define-tuning
   #:all-tunings
   #:tuning
   #:tuning-name
   #:tuning-pitches
   #:tuning-octave-ratio

   #:load-scala-scale

   #:define-chord
   #:all-chords
   #:chord
   #:chord-name
   #:chord-scale
   #:chord-indexes
   #:chord-notes
   #:chord-midinotes

   ;;; event.lisp

   #:event
   #:event-p
   #:combine-events
   #:copy-event
   #:split-event-by-lists
   #:combine-events-via-lists
   #:event-plist
   #:event-equal
   #:every-event-equal
   #:events-differing-keys
   #:events-lists-differing-keys

   #:event-value
   #:e
   #:remove-event-value

   #:instrument

   #:amp
   #:db

   #:pan

   #:dur
   #:legato
   #:sustain
   #:delta

   #:freq
   #:midinote
   #:rate

   ;;; patterns.lisp

   #:defpattern
   #:*max-pattern-yield-length*

   #:pattern
   #:pattern-p
   #:pstream-p
   #:as-pstream
   #:pattern-as-pstream
   #:all-patterns
   #:peek
   #:peek-n
   #:peek-upto-n
   #:next
   #:next-n
   #:next-upto-n
   #:pattern-metadata
   #:pstream
   #:pstream-elt
   #:pstream-elt-future
   #:parent-pattern
   #:parent-pbind
   #:pstream-count
   #:bsubseq

   #:pbind
   #:pb
   #:pmono

   ;; pattern classes defined with `defpattern' are automatically exported.

   #:pf

   #:find-pdef
   #:all-pdefs
   #:pdef-key
   #:pdef-pattern
   #:pdef-pstream
   #:pdef-task

   #:pseries*
   #:pgeom*

   #:p+
   #:p-
   #:p*
   #:p/

   #:ppc

   ;;; bjorklund.lisp

   #:bjorklund

   ;;; cycles.lisp

   ;;; tracker.lisp

   #:pt

   ;;; eseq.lisp

   #:eseq
   #:eseq-p
   #:eseq-events
   #:eseq-length
   #:eseq-add
   #:eseq-remove
   #:as-eseq

   ;;; backend.lisp

   #:register-backend
   #:all-backends
   #:enabled-backends
   #:enable-backend
   #:disable-backend
   #:start-backend
   #:stop-backend

   ;;; clock.lisp

   #:*performance-mode*
   #:*performance-errors*

   #:task-pattern
   #:pattern-tasks
   #:playing-pdefs

   #:make-clock
   #:clock-tasks
   #:clock-process
   #:clock-loop
   #:start-clock-loop))
