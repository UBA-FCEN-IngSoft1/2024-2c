!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'measurements' stamp: 'NR 4/9/2023 22:34:13'!
measureRunningTimeOf: aBlockToMeasure 

	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning
	
	! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'HAW 9/20/2018 09:33:40'!
assertNumberOfActiveCustomersIn: aCustomerBook is: aNumberOfActiveCustomers andSuspendedIs: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveCustomers + aNumberOfSuspendedCustomers equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'NR 4/12/2023 17:03:21'!
should: aBlockThatShouldFail raise: anExceptionType assert: aVerificationBlock

	[aBlockThatShouldFail value.
	self fail]
		on: anExceptionType 
		do: aVerificationBlock 
	
	"Ver should:raise:withExceptionDo: de TestCase..."
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'NR 4/12/2023 16:57:06'!
should: aBlockToMeasure takeLessThan: aTimeLimit
	
	self assert: (self measureRunningTimeOf: aBlockToMeasure) < aTimeLimit
		
	"Solución aceptable algo más operacional:"
	"
	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeLimit.
	"
	
	"Solucion Alternativa 2: "
	"
	|millisecondsRunning|
	
	millisecondsRunning := aBlockToMeasure timeToRun * millisecond.
	
	self assert: millisecondsRunning < aTimeLimit.
	"
	

! !


!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/12/2023 16:57:07'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self 
		should: [customerBook addCustomerNamed: 'John Lennon']
		takeLessThan: 50 * millisecond
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/12/2023 16:57:06'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self 
		should: [customerBook removeCustomerNamed: paulMcCartney]
		takeLessThan: 100 * millisecond

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/12/2023 17:03:21'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self 
		should: [customerBook addCustomerNamed: '']
		raise: Error
		assert: [:anError |  
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/12/2023 17:03:21'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		should: [customerBook removeCustomerNamed: 'Paul McCartney']
		raise: NotFound 
		assert: [:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 9/20/2018 09:33:58'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIn: customerBook is: 0 andSuspendedIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 9/20/2018 09:32:41'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIn: customerBook is: 0 andSuspendedIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/12/2023 17:03:21'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [customerBook suspendCustomerNamed: 'George Harrison']
		raise: CantSuspend 
		assert: [:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/12/2023 17:03:21'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		should: [customerBook suspendCustomerNamed: johnLennon]
		raise: CantSuspend 
		assert: [:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 9/24/2018 02:27:53'!
includesCustomerNamed: aName

	^(active includes: aName) or: [suspended includes: aName]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 9/24/2018 02:27:53'!
isEmpty
	
	^active isEmpty and: [suspended isEmpty]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/23/2020 19:58:09'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/9/2023 22:39:46'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [self signalCustomerNameCannotBeEmpty].
	(self includesCustomerNamed: aName) ifTrue: [self signalCustomerAlreadyExists].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/24/2018 02:27:53'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:53:23'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 18:05:35'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/9/2023 22:41:29'!
removeCustomerNamed: aName 

	^self removeFrom: active lookingFor: aName ifAbsent: 
		[self removeFrom: suspended lookingFor: aName ifAbsent: 
			[^NotFound signal.]]

	"Solucion Alternativa:"
	"^active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ ^ NotFound signal ]]."
	
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/9/2023 22:41:34'!
suspendCustomerNamed: aName 
	
	self removeFrom: active lookingFor: aName  ifAbsent: [^CantSuspend signal].
	
	"Solución Alternativa:"
	"active remove: aName ifAbsent:[^CantSuspend signal]."
				
	suspended add: aName


! !


!CustomerBook methodsFor: 'collections' stamp: 'NR 5/7/2020 03:27:00'!
removeFrom: aCollection lookingFor: aName ifAbsent: aBlockToContinue
 
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aName 
			] 
	].

	^aBlockToContinue value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 5/7/2020 03:44:44'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 5/7/2020 03:44:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
