(ns quil-sketches.gen-art.19-wave-clock
  (:require [quil.core :refer :all]
            [quil.helpers.seqs :refer [cycle-between seq->stream steps]]
            [quil.helpers.calc :refer [mul-add]]))

(defn mk-lines-stream
  []
  (let [half-width   (/ (width) 2)
        half-height  (/ (height) 2)
        radius-steps (steps (random 10) 0.05)
        angle-steps  (steps (random 10) 0.05)
        x-steps      (steps (random 10) 1)
        x-noises     (map noise x-steps)
        y-steps      (steps (random 100) 0.09)
        y-noises     (map noise y-steps)
        angle-noises (map noise angle-steps)
        angle-noises (mul-add angle-noises PI -3)
        angles       (steps (+ (/ PI 2)) angle-noises)
        angles       (map #(mod % 380) angles)
        rads         (map radians angles)
        center-xs    (mul-add x-noises 100 (- half-width 50))
        center-ys    (mul-add y-noises 100 (- half-height 50))
        radii        (map noise radius-steps)
        radii        (mul-add radii 550 1)
        cos-rads     (map sin rads)
        sin-rads     (map cos rads)
        opp-rads     (map #(+ PI %) rads)
        cos-opp-rads (map sin opp-rads)
        sin-opp-rads (map cos opp-rads)
        x1s          (mul-add cos-rads radii center-ys)
        y1s          (mul-add sin-rads radii center-ys)
        x2s          (mul-add cos-opp-rads radii center-ys)
        y2s          (mul-add sin-opp-rads radii center-xs)
        lines        (map list x1s y1s x2s y2s)]
    (seq->stream lines)))

(defn mk-cols-stream
  []
  (let [stroke-cols (cycle-between 0 255)]
    (seq->stream stroke-cols)))

(defn setup []
  (smooth)
  (frame-rate 30)
  (background 5)
  (no-fill)
  (stroke-weight 0.9)
  (set-state! :lines-str (mk-lines-stream)
              :cols-str (mk-cols-stream)))

(defn draw []
  (let [lines-str (state :lines-str)
        cols-str  (state :cols-str)
        line-args (lines-str)
        col       (cols-str)]
    (stroke  255 col 255 col);;or (stroke col 255 255 col) or (stroke 255 255 col col)
    (apply line line-args)))

(defsketch gen-art-19
  :title "Waves"
  :setup setup
  :draw draw
  :size [1300 750])

(defn -main [& args])
