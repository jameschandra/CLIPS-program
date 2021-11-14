;;
;;  Breast Cancer Detection Expert System
;;  Copyright (C) 2021 Dionisius Darryl Hermansyah, James Chandra, Nathaniel Jason
;;

;; Template definition for breast
(deftemplate breast "Template holding the characteristics of a breast."

	;;; Name of breast profile
	(multislot name (type STRING) (default ?NONE))
	
	;;; Type of breast profile (cancerous or no-evidence-of-disease)
	(multislot type (type SYMBOL) (default ?NONE)
		(allowed-symbols cancerous healthy)
	)

	;;; Worst area of breast, optional field
	(slot worst_area (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)

	;;; Worst radius of breast, optional field
	(slot worst_radius (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)

	;;; Worst texture of breast, optional field
	(slot worst_texture (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)

	;;; Worst perimeter of breast, optional field
	(slot worst_perimeter (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)
	
	;;; Worst concave points of breast, optional field
	(slot worst_concave_points (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)

	;;; Mean radius of breast, optional field
	(slot mean_radius (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)
	
	;;; Mean texture of breast, optional field
	(slot mean_texture (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)
	
	;;; Mean smoothness of breast, optional field
	(slot mean_smoothness (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)
	
	;;; Mean concave points of breast, required field
	(slot mean_concave_points (type SYMBOL) (default ?NONE)
		(allowed-symbols <= > undef)
	)
	
	;;; Radius Error, optional field
	(slot radius_error (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)

	;;; Perimeter Error, optional field
	(slot perimeter_error (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)

	;;; Concave Points Error, optional field
	(slot concave_points_error (type SYMBOL) (default undef)
		(allowed-symbols <= > undef)
	)
)

(deffacts breast-database "Adding breast types to the facts"
	;;; cancer 1
	(breast (name "Cancer One")
			(type cancerous)
			(worst_radius <=)
			(worst_texture <=)
			(mean_concave_points <=)
			(radius_error <=)
	)
	
	;;; cancer 2
	(breast (name "Cancer Two")
			(type cancerous)
			(worst_area <=)
			(worst_radius <=)
			(mean_texture >)
			(mean_concave_points <=)
			(radius_error <=)
	)
	
	;;; cancer 3
	(breast (name "Cancer Three")
			(type cancerous)
			(worst_area >)
			(worst_radius <=)
			(worst_texture >)
			(mean_radius <=)
			(mean_texture >)
			(mean_concave_points <=)
			(radius_error <=)
			(concave_points_error <=)
	)
	
	;;; cancer 4 
	(breast (name "Cancer Four")
			(type cancerous)
			(worst_area >)
			(worst_radius <=)
			(worst_texture >)
			(mean_radius >)
			(mean_concave_points <=)
			(radius_error <=)
			(concave_points_error <=)
	)
	
	;;; cancer 5
	(breast (name "Cancer Five")
			(type cancerous)
			(worst_radius <=)
			(mean_smoothness <=)
			(mean_concave_points <=)
			(radius_error >)
	)
	
	;;; cancer 6
	(breast (name "Cancer Six")
			(type cancerous)
			(worst_radius >)
			(mean_texture <=)
			(mean_concave_points <=)
	)
	
	;;; cancer 7
	(breast (name "Cancer Seven")
			(type cancerous)
			(worst_radius >)
			(mean_texture >)
			(mean_concave_points <=)
			(concave_points_error >)
	)
	
	;;; cancer 8
	(breast (name "Cancer Eight")
			(type cancerous)
			(worst_texture <=)
			(worst_perimeter <=)
			(worst_concave_points <=)
			(mean_concave_points >)
	)
	
	;;; cancer 9 
	(breast (name "Cancer Nine")
			(type cancerous)
			(worst_texture >)
			(worst_perimeter <=)
			(mean_radius >)
			(mean_concave_points >)
			(perimeter_error <=)
			(concave_points_error >)
	)
	
	;;; healthy 1
	(breast (name "healthy One")
			(type healthy)
			(worst_area >)
			(worst_radius <=)
			(worst_texture >)
			(mean_radius <=)
			(mean_texture <=)
			(mean_concave_points <=)
			(radius_error <=)
			(concave_points_error <=)
	)

	;;; healthy 2
	(breast (name "healthy Two")
			(type healthy)
			(worst_radius <=)
			(mean_smoothness >)
			(mean_concave_points <=)
			(radius_error >)
	)

	;;; healthy 3
	(breast (name "healthy Three")
			(type healthy)
			(worst_radius >)
			(mean_texture >)
			(mean_concave_points <=)
			(concave_points_error <=)
	)
	
	;;; healthy 4
	(breast (name "healthy Four")
			(type healthy)
			(worst_texture <=)
			(worst_perimeter <=)
			(worst_concave_points >)
			(mean_concave_points >)			
	)
	
	;;; healthy 5
	(breast (name "healthy Five")
			(type healthy)
			(worst_texture >)
			(worst_perimeter <=)
			(mean_radius <=)
			(mean_concave_points >)
			(perimeter_error <=)
	)

	;;; healthy 6 
	(breast (name "healthy Six")
			(type healthy)
			(worst_texture >)
			(worst_perimeter <=)
			(mean_concave_points >)
			(perimeter_error >)
	)

	;;; healthy 7
	(breast (name "healthy Seven")
			(type healthy)
			(worst_perimeter >)
			(mean_concave_points >)
	)	
)


;;; A global variable that holds the number of avaliable animals.
(defglobal ?*counter* = 16)


;;; The variable above is being modified with this function each time we exclude an animal from
;;; the possible solutions. (minusOne) decreases the global counter by one.
(deffunction minusOne ()
	(bind ?*counter* (- ?*counter* 1))
)

;;; This function is used for every question made to the user.
;;; The question that is printed to the user is broken into three arguments (?qBEG ?qMID ?qEND) for flexibility, as we may need to include a printable in the middle.
;;; The argument $?allowed-values is a list that holds the allowed values that the program accepts.
;;; If the user enters a non-acceptable value, the program asks the question again until the answer is valid.
(deffunction ask-question (?q)
	(printout t ?q)
	(bind ?answer (read))
?answer)

;;; ======================================================
;;; Initial question to see if the breast wanted is cancerous or not
(defrule initialQuestion-ValMeanConcavePoints
	?x <- (initial-fact)
	=>
	(retract ?x)
	(bind ?val_mean_concave_points (ask-question "### Mean concave points? ### "))
	(assert (ValMeanConcavePoints ?val_mean_concave_points))
)

;;; 
(defrule filterBy-MeanConcavePoints
	(declare (salience 10))
	(ValMeanConcavePoints ?val_mean_concave_points)
	?breast <- (breast (mean_concave_points ?mean_concave_points))
	=>
	(if (<= ?val_mean_concave_points 0.05)
		then (if (eq ?mean_concave_points >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_mean_concave_points 0.05)
			then (if (eq ?mean_concave_points <=) then (retract ?breast) (minusOne))
	)
)

;;;
(defrule intermediary-MeanConcavePoints
	(ValMeanConcavePoints ?val_mean_concave_points)
	=>
	(if (<= ?val_mean_concave_points 0.05)
		then (assert (ask worst_radius 16.83))
	)
	(if (> ?val_mean_concave_points 0.05)
		then (assert (ask worst_perimeter 114.45))
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-WorstRadius
	?q <- (ask worst_radius ?ans)
	=>	
	(bind ?val_worst_radius (ask-question "### Worst radius? ### "))
	(assert (ValWorstRadius ?val_worst_radius))
)

;;; 
(defrule filterBy-WorstRadius
	(declare (salience 10))
	(ValWorstRadius ?val_worst_radius)
	?breast <- (breast (worst_radius ?worst_radius))
	?q <- (ask worst_radius ?ans)
	=>
	(if (<= ?val_worst_radius ?ans)
		then (if (eq ?worst_radius >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_worst_radius ?ans)
			then (if (eq ?worst_radius <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-WorstRadius
	(ValWorstRadius ?val_worst_radius)
	?q <- (ask worst_radius ?ans)
	=>
	(retract ?q)
	(if (<= ?val_worst_radius ?ans)
		then (assert (ask radius_error 0.63))
	)
	(if (> ?val_worst_radius ?ans)
		then (assert (ask mean_texture 16.19))
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-WorstPerimeter
	?q <- (ask worst_perimeter ?ans)
	=>
	(bind ?val_worst_perimeter (ask-question "### Worst perimeter? ### "))
	(assert (ValWorstPerimeter ?val_worst_perimeter))
)

;;; 
(defrule filterBy-WorstPerimeter
	(declare (salience 10))
	(ValWorstPerimeter ?val_worst_perimeter)
	?breast <- (breast (worst_perimeter ?worst_perimeter))
	?q <- (ask worst_perimeter ?ans)
	=>
	(if (<= ?val_worst_perimeter ?ans)
		then (if (eq ?worst_perimeter >) then (retract ?breast) (minusOne))
	)
)

;;;
(defrule intermediary-WorstPerimeter
	(ValWorstPerimeter ?val_worst_perimeter)
	?q <- (ask worst_perimeter ?ans)
	=>
	(retract ?q)
	(if (<= ?val_worst_perimeter ?ans)
		then (assert (ask worst_texture 25.65))
	)
	(if (> ?val_worst_perimeter ?ans)
		then (assert (found true))
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-MeanTexture
	?q <- (ask mean_texture ?ans)
	=>
	(bind ?val_mean_texture (ask-question "### Mean texture? ### "))
	(assert (ValMeanTexture ?val_mean_texture))
)

;;; 
(defrule filterBy-MeanTexture
	(declare (salience 10))
	(ValMeanTexture ?val_mean_texture)
	?breast <- (breast (mean_texture ?mean_texture))
	?q <- (ask mean_texture ?ans)
	=>
	(if (<= ?val_mean_texture ?ans)
		then (if (eq ?mean_texture >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_mean_texture ?ans)
			then (if (eq ?mean_texture <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-MeanTexture
	(ValMeanTexture ?val_mean_texture)
	?q <- (ask mean_texture ?ans)
	=>
	(retract ?q)
	(if (eq ?ans 16.19)
		then 
			(if (<= ?val_mean_texture ?ans)
				then (assert (found true))				
			)
			(if (> ?val_mean_texture ?ans)
				then (assert (ask concave_points_error 0.01))
			)
	)
	(if (eq ?ans 28.79)
		then (assert (found true))				
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-RadiusError
	?q <- (ask radius_error ?ans)
	=>	
	(bind ?val_radius_error (ask-question "### Radius Error? ### "))
	(assert (ValRadiusError ?val_radius_error))
)

;;; 
(defrule filterBy-RadiusError
	(declare (salience 10))
	(ValRadiusError ?val_radius_error)
	?breast <- (breast (radius_error ?radius_error))
	?q <- (ask radius_error ?ans)
	=>
	(if (<= ?val_radius_error ?ans)
		then (if (eq ?radius_error >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_radius_error ?ans)
			then (if (eq ?radius_error <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-RadiusError
	(ValRadiusError ?val_radius_error)
	?q <- (ask radius_error ?ans)
	=>
	(retract ?q)
	(if (<= ?val_radius_error ?ans)
		then (assert (ask worst_texture	30.15))
	)
	(if (> ?val_radius_error ?ans)
		then (assert (ask mean_smoothness 0.09))
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-WorstTexture
	?q <- (ask worst_texture ?ans)
	=>	
	(bind ?val_worst_texture (ask-question "### Worst Texture? ### "))
	(assert (ValWorstTexture ?val_worst_texture))
)

;;; 
(defrule filterBy-WorstTexture
	(declare (salience 10))
	(ValWorstTexture ?val_worst_texture)
	?breast <- (breast (worst_texture ?worst_texture))
	?q <- (ask worst_texture ?ans)
	=>
	(if (<= ?val_worst_texture ?ans)
		then (if (eq ?worst_texture >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_worst_texture ?ans)
			then (if (eq ?worst_texture <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-WorstTexture
	(ValWorstTexture ?val_worst_texture)
	?q <- (ask worst_texture ?ans)
	=>
	(retract ?q)
	(if (eq ?ans 25.65)
		then
			(if (<= ?val_worst_texture ?ans)
				then (assert (ask worst_concave_points 0.17))
			)
			(if (> ?val_worst_texture ?ans)
				then (assert (ask perimeter_error 1.56))
			)
	)
	(if (eq ?ans 30.15) 
		then 
			(if (<= ?val_worst_texture ?ans)
				then (assert (found true))
			)
			(if (> ?val_worst_texture ?ans)
				then (assert (ask worst_area 641.60))
			)
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-MeanSmoothness
	?q <- (ask mean_smoothness ?ans)
	=>	
	(bind ?val_mean_smoothness (ask-question "### Mean Smoothness? ### "))
	(assert (ValMeanSmoothness ?val_mean_smoothness))
)

;;; 
(defrule filterBy-MeanSmoothness
	(declare (salience 10))
	(ValMeanSmoothness ?val_mean_smoothness)
	?breast <- (breast (mean_smoothness ?mean_smoothness))
	?q <- (ask mean_smoothness ?ans)
	=>
	(if (<= ?val_mean_smoothness ?ans)
		then (if (eq ?mean_smoothness >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_mean_smoothness ?ans)
			then (if (eq ?mean_smoothness <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-MeanSmoothness
	(ValMeanSmoothness ?val_mean_smoothness)
	?q <- (ask mean_smoothness ?ans)
	=>
	(retract ?q)
	(assert(found true))
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-WorstArea
	?q <- (ask worst_area ?ans)
	=>	
	(bind ?val_worst_area (ask-question "### Worst Area? ### "))
	(assert (ValWorstArea ?val_worst_area))
)

;;; 
(defrule filterBy-WorstArea
	(declare (salience 10))
	(ValWorstArea ?val_worst_area)
	?breast <- (breast (worst_area ?worst_area))
	?q <- (ask worst_area ?ans)
	=>
	(if (<= ?val_worst_area ?ans)
		then (if (eq ?worst_area >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_worst_area ?ans)
			then (if (eq ?worst_area <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-WorstArea
	(ValWorstArea ?val_worst_area)
	?q <- (ask worst_area ?ans)
	=>
	(retract ?q)
	(if (<= ?val_worst_area ?ans)
		then (assert(found true))
	)
	(if (> ?val_worst_area ?ans)
		then (assert (ask mean_radius 13.45))
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-MeanRadius
	?q <- (ask mean_radius ?ans)
	=>	
	(bind ?val_mean_radius (ask-question "### Mean radius? ### "))
	(assert (ValMeanRadius ?val_mean_radius))
)

;;; 
(defrule filterBy-MeanRadius
	(declare (salience 10))
	(ValMeanRadius ?val_mean_radius)
	?breast <- (breast (mean_radius ?mean_radius))
	?q <- (ask mean_radius ?ans)
	=>
	(if (<= ?val_mean_radius ?ans)
		then (if (eq ?mean_radius >) then (retract ?breast) (minusOne))
	) else (
		if (> ?val_mean_radius ?ans)
			then (if (eq ?mean_radius <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-MeanRadius
	(ValMeanRadius ?val_mean_radius)
	?q <- (ask mean_radius ?ans)
	=>
	(retract ?q)
	(if (eq ?*counter* 1)
		then (assert(found true))
	) 
	(if (neq ?*counter* 1)
		then
			(if (<= ?val_mean_radius ?ans)
				then (assert (ask mean_texture 28.79))
			)
			(if (> ?val_mean_radius ?ans)
				then (assert(found true))
			)
	)
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-ConcavePointsError
	?q <- (ask concave_points_error ?ans)
	=>
	(bind ?val_concave_points_error (ask-question "### Concave points error? ### "))
	(assert (ValConcavePointsError ?val_concave_points_error))
)

;;; 
(defrule filterBy-ConcavePointsError
	(declare (salience 10))
	(ValConcavePointsError ?val_concave_points_error)
	?breast <- (breast (concave_points_error ?concave_points_error))
	?q <- (ask concave_points_error ?ans)
	=>
	(if (<= ?val_concave_points_error ?ans)
		then (if (eq ?concave_points_error >) then (retract ?breast) (minusOne))
	) 
	(if (> ?val_concave_points_error ?ans)
		then (if (eq ?concave_points_error <=) then (retract ?breast) (minusOne)) 
	)
)

;;;
(defrule intermediary-ConcavePointsError
	(ValConcavePointsError ?val_concave_points_error)
	?q <- (ask concave_points_error ?ans)
	=>
	(retract ?q)
	(assert (found true))
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-WorstConcavePoints
	?q <- (ask worst_concave_points ?ans)
	=>
	(bind ?val_worst_concave_points (ask-question "### Worst concave points? ### "))
	(assert (ValWorstConcavePoints ?val_worst_concave_points))
)

;;; 
(defrule filterBy-WorstConcavePoints
	(declare (salience 10))
	(ValWorstConcavePoints ?val_worst_concave_points)
	?breast <- (breast (worst_concave_points ?worst_concave_points))
	?q <- (ask worst_concave_points ?ans)
	=>
	(if (<= ?val_worst_concave_points ?ans)
		then (if (eq ?worst_concave_points >) then (retract ?breast) (minusOne))
	)
)

;;;
(defrule intermediary-WorstConcavePoints
	(ValWorstConcavePoints ?val_worst_concave_points)
	?q <- (ask worst_concave_points ?ans)
	=>
	(retract ?q)
	(assert (found true))
)
;;; ======================================================


;;; ======================================================
;;;
(defrule ask-PerimeterError
	?q <- (ask perimeter_error ?ans)
	=>
	(bind ?val_perimeter_error (ask-question "### Perimeter Error? ### "))
	(assert (ValPerimeterError ?val_perimeter_error))
)

;;; 
(defrule filterBy-PerimeterError
	(declare (salience 10))
	(ValPerimeterError ?val_perimeter_error)
	?breast <- (breast (perimeter_error ?perimeter_error))
	?q <- (ask perimeter_error ?ans)
	=>
	(if (<= ?val_perimeter_error ?ans)
		then (if (eq ?perimeter_error >) then (retract ?breast) (minusOne))
	)
)

;;;
(defrule intermediary-PerimeterError
	(ValPerimeterError ?val_perimeter_error)
	?q <- (ask perimeter_error ?ans)
	=>
	(retract ?q)
	(if (<= ?val_perimeter_error ?ans)
		then (assert (ask mean_radius 13.34))
	)
	(if (> ?val_perimeter_error ?ans)
		then (assert (found true))
	)
)
;;; ======================================================

;;; 
(defrule matchFound
	?f <- (found true)
	?breast <- (breast (type ?t))
	=>
	(retract ?f ?breast)
	(printout t "*********************" crlf)
	(printout t "* Your breast is " ?t "!" crlf)
	(printout t "*********************" crlf)
)
