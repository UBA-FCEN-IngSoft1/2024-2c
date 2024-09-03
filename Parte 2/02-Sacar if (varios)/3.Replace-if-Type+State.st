!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'state type speed altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'ARM 4/29/2024 11:05:09'!
initializeWithType: typeToTake

	state := #Off.
	type := typeToTake.
	speed := 0 * kilometer / hour.
	altitude := 0 * meter! !


!Vehicle methodsFor: 'move' stamp: 'ARM 4/29/2024 11:05:56'!
accelerate

	state = #Off ifTrue:[self error: self canNotAccelerateErrorMessage].

	type = #Helicopter
		ifTrue:[speed := speed + (10 * kilometer / hour).
			altitude := altitude + (5 * meter)].
		
	type = #Motorcycle
		ifTrue:[speed := speed + (20 * kilometer / hour)].! !


!Vehicle methodsFor: 'on/off' stamp: 'ARM 4/29/2024 11:06:32'!
turnOff

	state := #Off! !

!Vehicle methodsFor: 'on/off' stamp: 'ARM 4/29/2024 11:06:23'!
turnOn

	state := #On! !


!Vehicle methodsFor: 'error messages' stamp: 'ARM 4/29/2024 11:08:20'!
canNotAccelerateErrorMessage

	type = #Helicopter ifTrue:[^'Can not fly when turned off'].
	type = #Motorcycle ifTrue:[^'Can not run when turned off'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
helicopter

	^self new initializeWithType: #Helicopter! !

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
motorcycle

	^self new initializeWithType: #Motorcycle! !
