!classDefinition: #TestDePerforación category: 'ISW1-Perforaciones-Solucion'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 9/13/2024 14:48:59'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:05'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:09'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:45'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 9/13/2024 14:36:37'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 9/13/2024 15:04:52'!
test10NoPuedeDarGolpeEnAusenciaDeMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: excavadora sinMecha.].! !


!classDefinition: #AusenciaDeMecha category: 'ISW1-Perforaciones-Solucion'!
Object subclass: #AusenciaDeMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!AusenciaDeMecha methodsFor: 'accesing - flags' stamp: 'ARM 9/13/2024 15:39:14'!
esAusenciaDeMecha
	^true! !


!AusenciaDeMecha methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:04:36'!
darGolpeCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroSinMecha! !


!classDefinition: #CapaDeSuelo category: 'ISW1-Perforaciones-Solucion'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 9/13/2024 15:22:05'!
= unaCapaDeSuelo

	^unaCapaDeSuelo class = self class! !


!CapaDeSuelo methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:27:11'!
darGolpeCon: unaPerforadora 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-Perforaciones-Solucion'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'ARM 9/13/2024 15:18:03'!
arenoso

	^CapaArenosa new! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'ARM 9/13/2024 15:08:57'!
concretoConResistencia: resistencia 

	^CapaDeConcreto new initializeConcretoConResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'ARM 9/13/2024 15:18:08'!
tierra

	^CapaDeTierra new! !


!classDefinition: #CapaArenosa category: 'ISW1-Perforaciones-Solucion'!
CapaDeSuelo subclass: #CapaArenosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!CapaArenosa methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:12:35'!
darGolpeCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloArenoso! !


!classDefinition: #CapaDeConcreto category: 'ISW1-Perforaciones-Solucion'!
CapaDeSuelo subclass: #CapaDeConcreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!CapaDeConcreto methodsFor: 'comparing' stamp: 'ARM 9/13/2024 15:21:46'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [resistencia = unaCapaDeSuelo resistencia]! !


!CapaDeConcreto methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:14:44'!
darGolpeCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeConcreto! !


!CapaDeConcreto methodsFor: 'initialization' stamp: 'ARM 9/13/2024 15:18:43'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.! !


!CapaDeConcreto methodsFor: 'accessing' stamp: 'ARM 9/13/2024 15:20:01'!
resistencia

	^ resistencia.! !


!CapaDeConcreto methodsFor: 'bajar resistencia' stamp: 'ARM 9/13/2024 15:22:19'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeConcreto methodsFor: 'bajar resistencia' stamp: 'ARM 9/13/2024 15:22:34'!
sinResistencia
	^resistencia = 0! !


!classDefinition: #CapaDeTierra category: 'ISW1-Perforaciones-Solucion'!
CapaDeSuelo subclass: #CapaDeTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!CapaDeTierra methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:13:41'!
darGolpeCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeTierra! !


!classDefinition: #Mecha category: 'ISW1-Perforaciones-Solucion'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!Mecha methodsFor: 'condicion' stamp: 'ARM 9/13/2024 15:36:16'!
estaRota

	^false! !


!Mecha methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:57:34'!
darGolpeCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroConMecha! !

!Mecha methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:25:56'!
golpearEnSueloArenosoCon: unaPerforadora 

	self subclassResponsibility! !

!Mecha methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:26:08'!
golpearEnSueloDeConcretoCon: unaPerforadora 

	self subclassResponsibility! !

!Mecha methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:26:26'!
golpearEnSueloDeTierraCon: unaPerforadora 

	self subclassResponsibility! !


!classDefinition: #Diamante category: 'ISW1-Perforaciones-Solucion'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!Diamante methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:37:09'!
golpearEnSueloArenosoCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloArenosoConMechaDiamante ! !

!Diamante methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:50:18'!
golpearEnSueloDeConcretoCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeConcretoConMechaDiamante ! !

!Diamante methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:46:09'!
golpearEnSueloDeTierraCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeTierraConMechaDiamante! !


!classDefinition: #MechaRota category: 'ISW1-Perforaciones-Solucion'!
Mecha subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!MechaRota methodsFor: 'condicion' stamp: 'ARM 9/13/2024 15:36:36'!
estaRota

	^true! !


!classDefinition: #Soft category: 'ISW1-Perforaciones-Solucion'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!Soft methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:30:51'!
golpearEnSueloArenosoCon: aPerforadora 
	aPerforadora darGolpeDeTaladroEnSueloArenosoConMechaSoft! !

!Soft methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:49:30'!
golpearEnSueloDeConcretoCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeConcretoConMechaSoft! !

!Soft methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:44:47'!
golpearEnSueloDeTierraCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeTierraConMechaSoft ! !


!classDefinition: #Widia category: 'ISW1-Perforaciones-Solucion'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!Widia methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:35:48'!
golpearEnSueloArenosoCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloArenosoConMechaWidia! !

!Widia methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:49:51'!
golpearEnSueloDeConcretoCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeConcretoConMechaWidia ! !

!Widia methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:45:45'!
golpearEnSueloDeTierraCon: unaPerforadora 
	unaPerforadora darGolpeDeTaladroEnSueloDeTierraConMechaWidia ! !


!classDefinition: #Perforadora category: 'ISW1-Perforaciones-Solucion'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones-Solucion'!

!Perforadora methodsFor: 'perforar-arenoso' stamp: 'ARM 9/13/2024 15:13:11'!
darGolpeDeTaladroEnSueloArenoso
	mechaPuesta golpearEnSueloArenosoCon: self! !

!Perforadora methodsFor: 'perforar-arenoso' stamp: 'ARM 9/13/2024 15:35:04'!
darGolpeDeTaladroEnSueloArenosoConMechaDiamante

	mechaPuesta := MechaRota new. self error: 'Se rompió'! !

!Perforadora methodsFor: 'perforar-arenoso' stamp: 'ARM 9/13/2024 14:25:01'!
darGolpeDeTaladroEnSueloArenosoConMechaSoft

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'perforar-arenoso' stamp: 'ARM 9/13/2024 14:25:39'!
darGolpeDeTaladroEnSueloArenosoConMechaWidia

	^ self pasarAProximaCapa! !


!Perforadora methodsFor: 'perforar-concreto' stamp: 'ARM 9/13/2024 15:15:03'!
darGolpeDeTaladroEnSueloDeConcreto
	mechaPuesta golpearEnSueloDeConcretoCon: self! !

!Perforadora methodsFor: 'perforar-concreto' stamp: 'ARM 9/13/2024 15:38:06'!
darGolpeDeTaladroEnSueloDeConcretoConMechaDiamante

	vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
	capasDeSueloDebajo first sinResistencia ifTrue: [ self transformarCapaEnArenoso]! !

!Perforadora methodsFor: 'perforar-concreto' stamp: 'ARM 9/13/2024 15:34:55'!
darGolpeDeTaladroEnSueloDeConcretoConMechaSoft

	mechaPuesta := MechaRota new. self error: 'Se rompió'! !

!Perforadora methodsFor: 'perforar-concreto' stamp: 'ARM 9/13/2024 15:34:46'!
darGolpeDeTaladroEnSueloDeConcretoConMechaWidia

	^ vecesQueGolpeoCapaActual = 3 ifTrue: [ mechaPuesta := MechaRota new. self error: 'Se rompió' ]! !


!Perforadora methodsFor: 'perforar-tierra' stamp: 'ARM 9/13/2024 15:14:08'!
darGolpeDeTaladroEnSueloDeTierra
	mechaPuesta golpearEnSueloDeTierraCon: self! !

!Perforadora methodsFor: 'perforar-tierra' stamp: 'ARM 9/13/2024 14:41:37'!
darGolpeDeTaladroEnSueloDeTierraConMechaDiamante

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'perforar-tierra' stamp: 'ARM 9/13/2024 14:38:53'!
darGolpeDeTaladroEnSueloDeTierraConMechaSoft

	^ self! !

!Perforadora methodsFor: 'perforar-tierra' stamp: 'ARM 9/13/2024 14:40:58'!
darGolpeDeTaladroEnSueloDeTierraConMechaWidia

	^ vecesQueGolpeoCapaActual = 2 ifTrue: [ self transformarCapaEnArenoso ]! !


!Perforadora methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:57:06'!
darGolpeDeTaladro
		
	mechaPuesta darGolpeCon: self! !

!Perforadora methodsFor: 'perforar' stamp: 'ARM 9/13/2024 15:11:51'!
darGolpeDeTaladroConMecha

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.

	self capaDeSueloInmediata darGolpeCon: self! !

!Perforadora methodsFor: 'perforar' stamp: 'ARM 9/13/2024 14:56:12'!
darGolpeDeTaladroSinMecha

	^ self error: 'No puede perforar'! !


!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 9/3/2024 16:45:24'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self].! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'initialization' stamp: 'ARM 9/13/2024 14:55:29'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	mechaPuesta := AusenciaDeMecha new! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 9/13/2024 15:36:52'!
conMechaRota

	^mechaPuesta estaRota ! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 9/13/2024 15:39:14'!
sinMecha

	^mechaPuesta esAusenciaDeMecha! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'ARM 9/13/2024 14:28:18'!
ponerMechaDiamante
	mechaPuesta := Diamante new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'ARM 9/13/2024 14:28:12'!
ponerMechaSoft
	mechaPuesta := Soft new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'ARM 9/13/2024 14:28:06'!
ponerMechaWidia
	mechaPuesta := Widia new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-Perforaciones-Solucion'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
