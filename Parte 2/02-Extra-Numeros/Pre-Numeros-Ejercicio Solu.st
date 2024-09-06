!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'setup' stamp: 'NR 9/24/2020 02:50:52'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two.
	! !


!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:07'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:17'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:51:13'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:37'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 23:05:42'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:57:14'!
* aMultiplier 

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:57:00'!
+ anAdder 
	
	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 23:00:35'!
negated

	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/8/2019 23:00:04'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'NR 9/8/2019 23:00:14'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'NR 9/8/2019 23:00:22'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 17:02:08'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'initialization' stamp: 'NR 9/8/2019 22:32:50'!
initializeWith: aValue
	
	value := aValue! !


!Entero methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:58:12'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:42:34'!
hash

	^value hash.
	! !


!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:54:29'!
* aMultiplier 
	
	^self class with: value * aMultiplier integerValue
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:55:15'!
+ anAdder 
	
	^self class with: value + anAdder integerValue 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:56:37'!
// aDivisor 

	 ^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:52:04'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 23:07:58'!
negated
	
	^self * (self class with: -1)
	! !


!Entero methodsFor: 'printing' stamp: 'NR 9/8/2019 22:29:40'!
printOn: aStream
	
	 aStream print: value.
	! !


!Entero methodsFor: 'value' stamp: 'NR 9/8/2019 22:39:05'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'NR 9/8/2019 22:36:29'!
isNegative

	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'NR 9/8/2019 22:37:27'!
isOne
	
	^value = 1
! !

!Entero methodsFor: 'testing' stamp: 'NR 9/8/2019 22:38:23'!
isZero
	
	^value = 0
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'as yet unclassified' stamp: 'NR 9/8/2019 22:32:02'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'accessing' stamp: 'NR 9/8/2019 22:39:29'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'NR 9/8/2019 22:40:00'!
numerator

	^numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'NR 9/8/2019 22:33:11'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:58:37'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:43:08'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/8/2019 22:36:50'!
isNegative

	^denominator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'NR 9/8/2019 22:37:42'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'NR 9/8/2019 22:38:37'!
isZero

	^false! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 23:03:16'!
* aMultiplier 
		
	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 22:55:40'!
+ anAdder 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^ self class with: newNumerator over: newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 23:08:35'!
negated
	
	 ^self class with: numerator * (Entero with: -1) over: denominator .! !


!Fraccion methodsFor: 'printing' stamp: 'NR 9/8/2019 22:30:07'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'as yet unclassified' stamp: 'NR 9/8/2019 23:10:10'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
