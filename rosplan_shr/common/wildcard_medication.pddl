;; wildcard verb ACTION
;; wildcard object OBJECT

;; wildcard before TRUE / FALSE ;; will process by PDDL generator
;; wildcard before action B_ACTION ;; process by PDDL generator 
;; wildcard before action  object B_OBJECT ;; process by PDDL generator 

;; wildcard after TRUE / FALSE ;; will process by PDDL generator
;; wildcard after success action AS_ACTION ;; process by PDDL generator 
;; wildcard after success object AS_OBJECT ;; process by PDDL generator 

;; wildcard after TRUE / FALSE ;; will process by PDDL generator
;; wildcard after fail action AF_ACTION ;; process by PDDL generator 
;; wildcard after fail object AF_OBJECT ;; process by PDDL generator 

(define (domain shr_conditional_wildcard_medication)

(:requirements :strips :typing :disjunctive-preconditions)

(:types
	object       medication_bottle
	as_object    bottle_msg
	af_object    medication_not_find
)

(:predicates
	(ACTION_OBJECT_AVAIL ?ob - object)            	        (is_off ?ss)
	                                                        (is_safe_when_on ?ss)
	(ACTION_OBJECT_FAIL ?ob - object)
	(ACTION_OBJECT_SUCC ?ob - object)

	(AS_ACTION_OBJECT_AVAIL ?ob - as_object)
	(AF_ACTION_OBJECT_AVAIL ?ob - af_object)
)

;; Do action and check result success
(:action ACTION_success                         find 
	:parameters (?ob - object)                  
	:precondition (ACTION_OBJECT_AVAIL ?ob)      
															(is_off ?ss)
	                                                        (is_safe_when_on ?ss)
	:observe (ACTION_OBJECT_SUCC ?ob)
)

;; Do action and check result fail
(:action ACTION_fail
	:parameters (?ob - object)
	:precondition (ACTION_OBJECT_AVAIL ?ob)
	:observe (ACTION_OBJECT_FAIL ?ob)
)

;; enable AS_ACTION if success
(:action ENABLE_AS_ACTION
	:parameters (?ob - object, ?asob - as_object)
	:precondition (ACTION_OBJECT_SUCC ?ob)
	:effect (AS_ACTION_OBJECT_AVAIL ?as_ob) 
)

;; enable AF_ACTION if fail
(:action ENABLE_AF_ACTION
	:parameters (?ob - object, ?afob - af_object)
	:precondition (ACTION_OBJECT_FAIL ?ob)
	:effect (AF_ACTION_OBJECT_AVAIL ?af_ob) 
)
)