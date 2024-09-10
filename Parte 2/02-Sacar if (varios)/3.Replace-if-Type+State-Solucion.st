!classDefinition: #PowerStatus category: '3.Replace-if-Type+State-Solucion'!
Object subclass: #PowerStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State-Solucion'!

!PowerStatus methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:03'!
accelerate: vehicleToMove

	self subclassResponsibility! !


!classDefinition: #PowerOff category: '3.Replace-if-Type+State-Solucion'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State-Solucion'!

!PowerOff methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:08'!
accelerate: vehicleToMove

	vehicleToMove accelerateWhenTurnedOff! !


!classDefinition: #PowerOn category: '3.Replace-if-Type+State-Solucion'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State-Solucion'!

!PowerOn methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:13'!
accelerate: vehicleToMove

	vehicleToMove accelerateWhenTurnedOn! !


!classDefinition: #Vehicle category: '3.Replace-if-Type+State-Solucion'!
Object subclass: #Vehicle
	instanceVariableNames: 'powerStatus speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State-Solucion'!

!Vehicle methodsFor: 'initialization' stamp: 'ARM 9/6/2024 14:55:24'!
initialize

	powerStatus := PowerOff new.
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:52:07'!
accelerate

	powerStatus accelerate: self! !

!Vehicle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:51:44'!
accelerateWhenTurnedOff

	self error: self canNotAccelerateErrorMessage! !

!Vehicle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:53:56'!
accelerateWhenTurnedOn

	self subclassResponsibility! !


!Vehicle methodsFor: 'on/off' stamp: 'ARM 9/6/2024 14:53:26'!
turnOff

	powerStatus := PowerOff new! !

!Vehicle methodsFor: 'on/off' stamp: 'ARM 9/6/2024 14:53:34'!
turnOn

	powerStatus := PowerOn new! !


!Vehicle methodsFor: 'error messages' stamp: 'ARM 9/6/2024 14:52:47'!
canNotAccelerateErrorMessage

	self subclassResponsibility! !


!classDefinition: #Helicopter category: '3.Replace-if-Type+State-Solucion'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State-Solucion'!

!Helicopter methodsFor: 'initialization' stamp: 'ARM 9/6/2024 14:55:45'!
initialize

	super initialize.
	altitude := 0 * meter.! !


!Helicopter methodsFor: 'error messages' stamp: 'ARM 9/6/2024 14:53:01'!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'.! !


!Helicopter methodsFor: 'move' stamp: 'ARM 9/6/2024 14:54:16'!
accelerateWhenTurnedOn

	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter).! !


!classDefinition: #Motorcycle category: '3.Replace-if-Type+State-Solucion'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State-Solucion'!

!Motorcycle methodsFor: 'error messages' stamp: 'ARM 9/6/2024 14:53:08'!
canNotAccelerateErrorMessage

	^'Can not run when turned off'! !


!Motorcycle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:54:27'!
accelerateWhenTurnedOn

	speed := speed + (20 * kilometer / hour).! !
