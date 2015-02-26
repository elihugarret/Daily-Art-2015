(ns cool
  (:require [quil.core :refer :all]))

(defn draw-line
  [h]
  (stroke  155 (- 55 h) 289 h)
  (no-fill)
  (ellipse 650 (* (tan h) PI) (- (width) h)  h)
  (stroke 25 h 255 h)
  (no-fill)
  (ellipse 650 (+ (noise h) 16) (- (width)  h) (* h PI (cos h) h)))

(defn setup []
  (background 0)
  (smooth)
  (stroke-weight 1)
  ;;(stroke-cap :square)
  (let [line-heights (range 88 (- (height) 2) 5)]
    (dorun (map draw-line line-heights))))

(defsketch example-4
  :title "Lines"
  :setup setup
  :size [1290 780])

(defn -main [& args])
