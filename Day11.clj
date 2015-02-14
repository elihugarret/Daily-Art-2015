(ns archaeo
  (:require [quil.core :refer :all]
            [quil.helpers.drawing :refer [line-join-points]]
            [quil.helpers.seqs :refer [range-incl steps]]
            [quil.helpers.calc :refer [mul-add]]))


(defn setup []
  (background 0)
  (stroke-weight 0.53)
  (smooth)
  (dotimes [_ 200]
    (let [radius      50
          cent-x      350
          cent-y      350
          start-angle (rand 2720)
          end-angle   (+ 1440 (rand 1440))
          angle-step  (+ 3.45 (rand 9))
          rad-noise   (steps (rand 15) 0.7)
          rad-noise   (map #(* 15 (noise %)) rad-noise)
          rads        (map radians (range-incl start-angle end-angle angle-step))
          radii       (steps 22 1)
          radii       (map (fn [rad noise] (+ rad noise -55)) radii rad-noise)
          xs          (map (fn [rad radius] (mul-add (tan rad) radius cent-x)) rads radii)
          ys          (map (fn [rad radius] (mul-add (cos rad) radius cent-y)) rads radii)
          line-args   (line-join-points xs ys)]
      (stroke (rand 25) (rand 220) (rand 200) (rand 255))
      (dorun (map #(apply line %) line-args)))))

(defsketch spiral
  :title "arch"
  :setup setup
  :size [1280 800])

(defn -main [& args])
