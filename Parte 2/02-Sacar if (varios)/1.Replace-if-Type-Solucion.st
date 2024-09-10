!classDefinition: #Vehicle category: '1.Replace-if-Type-Solucion'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type-Solucion'!

!Vehicle methodsFor: 'initialization' stamp: 'ARM 9/6/2024 14:32:46'!
initialize

	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:33:02'!
accelerate

	self subclassResponsibility! !


!classDefinition: #Helicopter category: '1.Replace-if-Type-Solucion'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type-Solucion'!

!Helicopter methodsFor: 'move' stamp: 'ARM 9/6/2024 14:33:45'!
accelerate

	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter).! !


!Helicopter methodsFor: 'initialization' stamp: 'ARM 9/6/2024 14:34:34'!
initialize

	super initialize.
	altitude := 0 * meter.! !


!classDefinition: #Motorcycle category: '1.Replace-if-Type-Solucion'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type-Solucion'!

!Motorcycle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:33:32'!
accelerate

	speed := speed + (20 * kilometer / hour)! !
