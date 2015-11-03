(defn check []
  (let [p1 odd? p2 even?]
    (let [always-true (either p1 p2)]
      (println (always-true 1))
      (println (always-true 2)) )))

(check)

