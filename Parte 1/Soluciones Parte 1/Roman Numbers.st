!classDefinition: #I category: 'Roman Numbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Roman Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Roman Numbers'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next & previous' stamp: 'ARM 3/19/2018 15:37:31'!
next
	^ II.! !

!I class methodsFor: 'next & previous' stamp: 'ARM 3/19/2018 15:30:11'!
previous

	self error: 'El uno es el primer numero natural'! !


!I class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:38:54'!
* multiplier

	^multiplier! !

!I class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:39:00'!
+ adder

	^adder next! !

!I class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:39:08'!
- sustrahend

	self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:39:16'!
/ dividend

	dividend divideByOneAsDivisor! !


!I class methodsFor: 'logic operations' stamp: 'ARM 4/3/2024 18:37:56'!
<= aNumberToCompare

	^true! !


!I class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 18:37:32'!
divideByOneAsDivisor
	
	^self! !

!I class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 18:37:07'!
multiplyByNumberBiggerThanOne: multiplier 

	^multiplier! !

!I class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 18:36:01'!
substractTo: minuend 
	
	^minuend previous! !

!I class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 18:36:05'!
timesThatDivideTo: dividend

	^dividend! !


!I class methodsFor: 'error desciptions' stamp: 'ARM 12/5/2020 23:43:03'!
divisionSiendoLaDiferenciaMasUnoEntre: dividendo y: divisor

	^I! !

!I class methodsFor: 'error desciptions' stamp: 'ARM 4/3/2024 18:33:35'!
negativeNumbersNotSupportedErrorDescription

	^'Negative numbers not supported. Can not make a number minus a bigger numbers.'! !


!classDefinition: #II category: 'Roman Numbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Roman Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Roman Numbers'!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'next & previous' stamp: 'ARM 4/6/2021 15:28:17'!
nameOfNext
	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue:[^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix: 'III'), 'IV'].
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix: 'IV'), 'V'].
	^self name, 'I'! !

!II class methodsFor: 'next & previous' stamp: 'ARM 4/3/2024 18:48:37'!
next

	next := II createChildNamed: self nameOfNext.
	next previous: self.
	
	^next
! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/19/2018 15:38:06'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/19/2018 16:21:49'!
previous: aNumber 
	
	previous := aNumber! !


!II class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:45:58'!
* mutiplier

	^mutiplier multiplyByNumberBiggerThanOne: self! !

!II class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:49:01'!
+ adder

	^self previous + adder next! !

!II class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:35:53'!
- sustraendo

	^sustraendo substractTo: self! !

!II class methodsFor: 'arithmetic operations' stamp: 'ARM 4/3/2024 18:56:44'!
/ divisor

	divisor <= self ifFalse:[self error: self canNotDivideByABiggerNumberErrorDescription].
	divisor = self ifTrue:[^I].
	divisor <= (self - divisor) ifFalse:[^I].
	^I + ((self - divisor) / divisor)! !


!II class methodsFor: 'logic operations' stamp: 'ARM 4/3/2024 19:11:38'!
<= aNumberToCompare 
	aNumberToCompare = I ifTrue: [^false].
	^self previous <= aNumberToCompare previous! !


!II class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 18:45:04'!
divideByOneAsDivisor

	self error: self canNotDivideByABiggerNumberErrorDescription! !

!II class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 19:00:44'!
multiplyByNumberBiggerThanOne: multiplierBiggerThanOne 

	^multiplierBiggerThanOne + (multiplierBiggerThanOne * self previous)! !

!II class methodsFor: 'private arithmetic' stamp: 'ARM 4/3/2024 18:45:20'!
substractTo: sustahend
 
	^sustahend previous - self previous	! !


!II class methodsFor: 'error descrptions' stamp: 'ARM 4/3/2024 18:44:58'!
canNotDivideByABiggerNumberErrorDescription

	^'Can not divide by a bigger number'! !


!II class methodsFor: 'remove all next' stamp: 'ARM 3/20/2018 11:29:48'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'ARM 4/3/2024 19:13:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !


!classDefinition: #III category: 'Roman Numbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Roman Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Roman Numbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'ARM 4/3/2024 19:13:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IV.! !


!classDefinition: #IV category: 'Roman Numbers'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Roman Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Roman Numbers'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'ARM 4/3/2024 19:13:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := nil.! !


!classDefinition: #RomanNumberTest category: 'Roman Numbers'!
DenotativeObject subclass: #RomanNumberTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Roman Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RomanNumberTest class' category: 'Roman Numbers'!
RomanNumberTest class
	instanceVariableNames: ''!

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:04:33'!
test01OnePlusAnAdderIsTheNextOfTheAdder

	Assert that: I + II isEqualTo: II next.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:04:51'!
test02NumbersBiggerThanOneCanBeAdded

	Assert that: II + II isEqualTo: IV.
! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:05:25'!
test03AMinuendMinusOneIsThePreviousOfTheMinuend

	Assert that: II - I isEqualTo: II previous.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:05:42'!
test04NumbersBiggerThanOneCanBeSubstracted

	Assert that: IV - II isEqualTo: II.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:06:07'!
test05SubstractionDoesNotSupportNegativeNumbers

	Assert should: [ I - II ] signal: Error withDescription: I negativeNumbersNotSupportedErrorDescription.
! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:06:43'!
test06MultipingByOneReturnsTheSameNumber

	Assert that: II * I isEqualTo: II.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:07:05'!
test07NumbersBiggerThanOneCanBeMultiplied

	Assert that: II * II isEqualTo: IV.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:07:26'!
test08OneMultipliedByItselfReturnsOne

	Assert that: I * I isEqualTo: I.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:07:55'!
test09NumbersBiggerThanOneCanBeDivided

	Assert that: IV / II isEqualTo: II.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:08:37'!
test10ADivisionByOneReturnsTheDividend

	Assert that: II / I isEqualTo: II.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:08:56'!
test11OneDividedByItselfReturnsOne

	Assert that: I / I isEqualTo: I.! !

!RomanNumberTest class methodsFor: 'tests' stamp: 'ARM 4/3/2024 19:09:45'!
test12CanNotDivideADividendByABiggerDivisor

	Assert should: [ III /  IV ] signal: Error withDescription: II canNotDivideByABiggerNumberErrorDescription.

	Assert should: [ I /  II] signal: Error withDescription: II canNotDivideByABiggerNumberErrorDescription
! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!