!classDefinition: #Automobil category: #'2.Replace-if-State-Solucion'!
Object subclass: #Automobil
	instanceVariableNames: 'powerStatus speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Solucion'!

!Automobil methodsFor: 'initialization' stamp: 'ARM 9/6/2024 15:00:41'!
initialize

	powerStatus := PowerOff new.
	speed := 0 * kilometer / hour! !


!Automobil methodsFor: 'on/off' stamp: 'ARM 9/6/2024 15:00:41'!
turnOff

	powerStatus := PowerOff new.! !

!Automobil methodsFor: 'on/off' stamp: 'ARM 9/6/2024 15:00:41'!
turnOn

	powerStatus := PowerOn new.! !


!Automobil methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 15:00:41'!
accelerate

	powerStatus accelerate: self.! !

!Automobil methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:41:29'!
accelerateWhenTurnedOff

	self error: 'Can not accelerate when turned off'! !

!Automobil methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:41:16'!
accelerateWhenTurnedOn

	speed := speed + (10 * kilometer / hour)! !


!classDefinition: #PowerStatus category: #'2.Replace-if-State-Solucion'!
Object subclass: #PowerStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Solucion'!

!PowerStatus methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:03'!
accelerate: vehicleToMove

	self subclassResponsibility! !


!classDefinition: #PowerOff category: #'2.Replace-if-State-Solucion'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Solucion'!

!PowerOff methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:08'!
accelerate: vehicleToMove

	vehicleToMove accelerateWhenTurnedOff! !


!classDefinition: #PowerOn category: #'2.Replace-if-State-Solucion'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State-Solucion'!

!PowerOn methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:13'!
accelerate: vehicleToMove

	vehicleToMove accelerateWhenTurnedOn! !
