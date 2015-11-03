(ns balanced)

(defn -traverse [tot openCount]
	(cond
		(< openCount 0) false
    		(empty? tot) (= 0 openCount)
		(= \( (first tot)) (-traverse (rest tot) (inc openCount))
		(= \) (first tot)) (-traverse (rest tot) (dec openCount))
		:else (-traverse (rest tot) openCount) ))
    
    
(defn balanced? [str] (-traverse tot 0))

(defn -traverse [str openCount]
	(cond
		(< openCount 0) false
		(empty? str) (= 0 openCount)
		(= \( (first str)) (-traverse (rest str) (inc openCount))
		(= \) (first str)) (-traverse (rest str) (dec openCount))
		:else (-traverse (rest str) openCount) ))
