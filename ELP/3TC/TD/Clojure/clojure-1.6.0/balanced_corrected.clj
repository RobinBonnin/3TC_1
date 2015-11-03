(ns balanced)

(defn -traverse [str openCount]
	(cond
		(< openCount 0) false
		(empty? str) (= 0 openCount)
		(= \( (first str)) (-traverse (rest str) (inc openCount))
		(= \) (first str)) (-traverse (rest str) (dec openCount))
		:else (-traverse (rest str) openCount) ))
		
(defn balanced? [str] (-traverse str 0))


(balanced? "(())")
; true

(balanced? "")
; true

(balanced? ")(")
; false

(balanced? "(()")
; fals
