!classDefinition: #VehicleTests category: #'4.Replace-if-Strategy-Solucion'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:27'!
electricMotorcycle

	^ Motorcycle withEngine: ElectricEngine new andSpeedLimiter: (SpeedLimiter limit: 70 * kilometer / hour)! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:14:10'!
gasolineMotorcycle

	^ Motorcycle withEngine: GasolineEngine new andSpeedLimiter: (SpeedLimiter limit: 130 * kilometer / hour)! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:55'!
helicopter

	^ Helicopter withEngine: JetFueledEngine new andSpeedLimiter: (SpeedLimiter limit: 500 * kilometer / hour)! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:27'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := self electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:55'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := self helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:27'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := self electricMotorcycle.
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:14:10'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := self gasolineMotorcycle.
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:55'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := self helicopter.
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:55'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := self helicopter.
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:27'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := self electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:14:10'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := self gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 19:13:55'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := self helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !


!classDefinition: #Engine category: #'4.Replace-if-Strategy-Solucion'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!Engine methodsFor: 'torque' stamp: 'NR 9/7/2024 07:07:35'!
acceleration: currentSpeed

	self subclassResponsibility ! !


!classDefinition: #ElectricEngine category: #'4.Replace-if-Strategy-Solucion'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!ElectricEngine methodsFor: 'torque' stamp: 'NR 9/7/2024 08:48:18'!
acceleration: currentSpeed

	^ (currentSpeed + (5 * kilometer / hour)) * 2! !


!classDefinition: #GasolineEngine category: #'4.Replace-if-Strategy-Solucion'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!GasolineEngine methodsFor: 'torque' stamp: 'NR 9/7/2024 07:20:10'!
acceleration: currentSpeed

	^ 10 * kilometer / hour! !


!classDefinition: #JetFueledEngine category: #'4.Replace-if-Strategy-Solucion'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!JetFueledEngine methodsFor: 'torque' stamp: 'NR 9/7/2024 08:10:22'!
acceleration: currentSpeed

	^ ((currentSpeed amount + 1) ^ 2) * kilometer / hour! !


!classDefinition: #PowerStatus category: #'4.Replace-if-Strategy-Solucion'!
Object subclass: #PowerStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!PowerStatus methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:03'!
accelerate: vehicleToMove

	self subclassResponsibility! !


!classDefinition: #PowerOff category: #'4.Replace-if-Strategy-Solucion'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!PowerOff methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:08'!
accelerate: vehicleToMove

	vehicleToMove accelerateWhenTurnedOff! !


!classDefinition: #PowerOn category: #'4.Replace-if-Strategy-Solucion'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!PowerOn methodsFor: 'accelerate' stamp: 'ARM 9/6/2024 14:51:13'!
accelerate: vehicleToMove

	vehicleToMove accelerateWhenTurnedOn! !


!classDefinition: #SpeedLimiter category: #'4.Replace-if-Strategy-Solucion'!
Object subclass: #SpeedLimiter
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!SpeedLimiter methodsFor: 'initialization' stamp: 'NR 9/6/2024 16:25:39'!
initializeWithLimit: aSpeedLimit

	limit := aSpeedLimit! !


!SpeedLimiter methodsFor: 'limit' stamp: 'NR 9/7/2024 07:33:10'!
limit: aSpeed
	
	^ aSpeed min: limit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpeedLimiter class' category: #'4.Replace-if-Strategy-Solucion'!
SpeedLimiter class
	instanceVariableNames: ''!

!SpeedLimiter class methodsFor: 'instance creation' stamp: 'NR 9/6/2024 16:24:47'!
limit: aSpeedLimit

	^ self new initializeWithLimit: aSpeedLimit ! !


!classDefinition: #Vehicle category: #'4.Replace-if-Strategy-Solucion'!
Object subclass: #Vehicle
	instanceVariableNames: 'powerStatus speed engine speedLimiter'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!Vehicle methodsFor: 'initialization' stamp: 'NR 9/7/2024 07:21:07'!
initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter

	powerStatus := PowerOff new.
	speed := 0 * kilometer / hour.
	engine := anEngine.
	speedLimiter := aSpeedLimiter! !

!Vehicle methodsFor: 'initialization' stamp: 'NR 9/7/2024 08:26:13'!
initializeWithType: typeToTake engineType: anEngineType andSurroundings: surroundings

	state := #Off.
	type := typeToTake.
	engineType := anEngineType.
	where := surroundings.
	speed := 0 * kilometer / hour.
	altitude := 0 * meter! !


!Vehicle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:52:07'!
accelerate

	powerStatus accelerate: self! !

!Vehicle methodsFor: 'move' stamp: 'ARM 9/6/2024 14:51:44'!
accelerateWhenTurnedOff

	self error: self canNotAccelerateErrorMessage! !

!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 07:29:39'!
accelerateWhenTurnedOn

	speed := speedLimiter limit: (speed + (engine acceleration: speed))! !

!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 18:58:08'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Vehicle methodsFor: 'on/off' stamp: 'NR 9/7/2024 07:37:27'!
turnOff

	powerStatus := PowerOff new.
	speed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'ARM 9/6/2024 14:53:34'!
turnOn

	powerStatus := PowerOn new! !


!Vehicle methodsFor: 'error messages' stamp: 'ARM 9/6/2024 14:52:47'!
canNotAccelerateErrorMessage

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-Strategy-Solucion'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'NR 9/7/2024 08:53:59'!
electricMotorcycle

	^ self new initializeWithType: #Motorcycle engineType: #ElectricEngine andSurroundings: #city

! !

!Vehicle class methodsFor: 'instance creation' stamp: 'NR 9/7/2024 08:53:55'!
gasolineMotorcycle

	^ self new initializeWithType: #Motorcycle engineType: #GasolineEngine andSurroundings: #openRoad! !

!Vehicle class methodsFor: 'instance creation' stamp: 'NR 9/7/2024 08:54:07'!
helicopter

	^ self new initializeWithType: #Helicopter engineType: #JetFueledEngine andSurroundings: #skies! !


!Vehicle class methodsFor: 'nil' stamp: 'NR 9/7/2024 07:21:07'!
withEngine: anEngine andSpeedLimiter: aSpeedLimiter

	^ self new initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter
	! !


!classDefinition: #Helicopter category: #'4.Replace-if-Strategy-Solucion'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!Helicopter methodsFor: 'initialization' stamp: 'NR 9/7/2024 08:05:46'!
initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter 

	super initializeWithEngine: anEngine andSpeedLimiter: aSpeedLimiter.
	altitude := 0 * meter! !


!Helicopter methodsFor: 'error messages' stamp: 'NR 9/7/2024 08:05:42'!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'! !


!Helicopter methodsFor: 'move' stamp: 'NR 9/7/2024 19:10:17'!
accelerateWhenTurnedOn

	super accelerateWhenTurnedOn.
	altitude := altitude + (5 * meter)! !

!Helicopter methodsFor: 'move' stamp: 'NR 9/7/2024 18:59:11'!
altitudeAt: anAltitude

	^ altitude = anAltitude! !


!classDefinition: #Motorcycle category: #'4.Replace-if-Strategy-Solucion'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy-Solucion'!

!Motorcycle methodsFor: 'error messages' stamp: 'ARM 9/6/2024 14:53:08'!
canNotAccelerateErrorMessage

	^'Can not run when turned off'! !
