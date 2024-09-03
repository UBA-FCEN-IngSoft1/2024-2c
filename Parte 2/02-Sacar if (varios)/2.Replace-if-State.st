!classDefinition: #Automobil category: '2.Replace-if-State'!
Object subclass: #Automobil
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobil methodsFor: 'initialization' stamp: 'ARM 4/29/2024 10:57:09'!
initialize

	state := #Off.
	speed := 0 * kilometer / hour! !


!Automobil methodsFor: 'move' stamp: 'ARM 4/29/2024 10:54:56'!
accelerate

	state = #Off ifTrue:[self error: 'Can not accelerate when turned off'].
	state = #On ifTrue:[speed := speed + (10 * kilometer / hour)].! !

!Automobil methodsFor: 'move' stamp: 'ARM 4/29/2024 10:51:37'!
turnOn

	state := #On! !
