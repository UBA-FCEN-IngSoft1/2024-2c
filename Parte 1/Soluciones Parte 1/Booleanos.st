!classDefinition: #BooleanosTest category: #Booleanos!
DenotativeObject subclass: #BooleanosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooleanosTest class' category: #Booleanos!
BooleanosTest class
	instanceVariableNames: ''!

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 19:39:46'!
test01NegacionDeVerdaderoEsFalso

	Assert that: Verdadero no isEqualTo: Falso! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 19:49:39'!
test02NegacionDeFalsoEsVerdadero

	Assert that: Falso no isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:00:38'!
test03VerdaderoYFalsoEsFalso

	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:03:54'!
test04VerdaderoYVerdaderoEsVerdadero

	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:06:19'!
test05FalsoYVerdaderoEsFalso

	Assert that: (Falso y: Verdadero) isEqualTo: Falso! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:15:58'!
test06FalsoOVerdaderoEsVerdadero

	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:21:45'!
test07VerdaderoOFalsoEsVerdadero

	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:32:47'!
test08VerdaderoSiVerdaderoEvaluaClosure

	| resultado |

	resultado := #NoEvalúa.
	
	Verdadero siVerdadero: [resultado := #Evalúa].

	Assert that: resultado isEqualTo: #Evalúa! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 3/26/2018 20:38:07'!
test09VerdaderoSiFalsoNoEvaluaClosure

	| resultado |

	resultado := #NoEvalúa.
	
	Verdadero siFalso: [resultado := #Evalúa].

	Assert that: resultado isEqualTo: #NoEvalúa! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 4/3/2024 18:14:09'!
test10FalsoSiFalsoEvaluaClosure

	Falso siFalso: [^self].

	Assert fail! !

!BooleanosTest class methodsFor: 'test' stamp: 'ARM 4/3/2024 18:13:56'!
test11FalsoSiVerdaderoNoEvaluaClosure

	Falso siVerdadero: [Assert fail].! !


!classDefinition: #Falso category: #Booleanos!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Booleanos!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'operaciones lógicas' stamp: 'ARM 4/3/2024 18:03:31'!
no

	^Verdadero! !

!Falso class methodsFor: 'operaciones lógicas' stamp: 'ARM 4/3/2024 18:01:51'!
o: unBooleano

	^unBooleano! !

!Falso class methodsFor: 'operaciones lógicas' stamp: 'ARM 3/26/2018 20:12:19'!
y: unBooleano

	^self! !


!Falso class methodsFor: 'condicionales' stamp: 'ARM 4/3/2024 18:01:27'!
siFalso: unaAccionARealizar 
	unaAccionARealizar value! !

!Falso class methodsFor: 'condicionales' stamp: 'ARM 4/3/2024 18:01:37'!
siVerdadero: unaAcciónAIngnorar 
	! !


!classDefinition: #Verdadero category: #Booleanos!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Booleanos!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'operaciones lógicas' stamp: 'ARM 4/3/2024 18:03:27'!
no

	^Falso! !

!Verdadero class methodsFor: 'operaciones lógicas' stamp: 'ARM 4/3/2024 18:02:01'!
o: unBooleano

	^self! !

!Verdadero class methodsFor: 'operaciones lógicas' stamp: 'ARM 4/3/2024 18:02:14'!
y: unBooleano
 
	^unBooleano! !


!Verdadero class methodsFor: 'condicionales' stamp: 'ARM 4/3/2024 18:03:17'!
siFalso: unaAcciónAIgnorar! !

!Verdadero class methodsFor: 'condicionales' stamp: 'ARM 4/3/2024 18:03:09'!
siVerdadero: unaAcciónAEvaluar

	unaAcciónAEvaluar value! !
