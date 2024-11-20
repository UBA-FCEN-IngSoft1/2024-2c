!classDefinition: #PersistentSet category: #CustomerImporter!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: #CustomerImporter!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #CustomerImportTest category: #CustomerImporter!
TestCase subclass: #CustomerImportTest
	instanceVariableNames: 'system erpSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!CustomerImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 6/1/2022 09:36:40'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 6/1/2022 19:09:20'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutPartyErrorDescription

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!CustomerImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 19:30:50'!
assertCustomerWithIdentification: anIdentification hasFirstName: aFirstName lastName: aLastName

	| importedCustomer  |

	importedCustomer := system customerIdentifiedAs: anIdentification.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdentification equals: importedCustomer identification.

	^importedCustomer

	! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 18:03:45'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerIdentifiedAs: (PartyIdentification type: 'D' number: '22333444').
	self assert: importedCustomer isAddressesEmpty
	! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 19:31:32'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentification: (PartyIdentification type: 'C' number: '23-25666777-9') hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 19:31:32'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentification: (PartyIdentification type: 'D' number: '22333444') hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!CustomerImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:15:52'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!CustomerImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 6/2/2022 14:49:32'!
setUp

	erpSystem := Environment current createErpSystem.
	system := erpSystem customerSystem.
	erpSystem start.
	erpSystem beginTransaction.
! !

!CustomerImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 6/2/2022 14:49:43'!
tearDown

	erpSystem commit.
	erpSystem stop
	! !


!classDefinition: #CustomerSystemTest category: #CustomerImporter!
TestCase subclass: #CustomerSystemTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystemTest methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 19:44:31'!
test01SignalsErrorWhenCustomerIsNotFound

	| system |
	
	system := Environment current createErpSystem.
	system start;beginTransaction.
	
	[ self 
		should: [ system customerSystem customerIdentifiedAs: (PartyIdentification type: '1' number: 'a') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CustomerSystem customerNotFoundErrorDescription ] 
		ensure: [ system commit; stop ]! !


!classDefinition: #PartyIdentificationTest category: #CustomerImporter!
TestCase subclass: #PartyIdentificationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:39:22'!
test01IdentificationAreEqualWhenTypeAndNumberAreEquals

	self assert: (PartyIdentification type: 'a' number: '1') equals: (PartyIdentification type: 'a' number: '1')! !

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:40:19'!
test02IdentificationAreDifferentWithDifferentType

	self deny: (PartyIdentification type: 'a' number: '1') = (PartyIdentification type: 'b' number: '1')! !

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:40:31'!
test03IdentificationAreDifferentWithDifferentNumber

	self deny: (PartyIdentification type: 'a' number: '1') = (PartyIdentification type: 'a' number: '2')! !

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:41:09'!
test04HashIsEqualWhenIdentificationAreEqual

	self assert: (PartyIdentification type: 'a' number: '1') hash equals: (PartyIdentification type: 'a' number: '1') hash! !

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:42:21'!
test05CannotCreateIdentificationWithEmptyType

	self 
		should: [ PartyIdentification type: ' ' number: '1' ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PartyIdentification invalidTypeErrorDescription! !

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:45:16'!
test06CannotCreateIdentificationWithEmptyNumber

	self
		should: [ PartyIdentification type: 'D' number: ' ' ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PartyIdentification invalidNumberErrorDescription! !

!PartyIdentificationTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:47:06'!
test07TypeAndNumberAreTrimmed

	self assert: (PartyIdentification type: ' a ' number: ' 1 ') equals: (PartyIdentification type: 'a' number: '1')! !


!classDefinition: #SupplierImporterTest category: #CustomerImporter!
TestCase subclass: #SupplierImporterTest
	instanceVariableNames: 'system erpSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:40:48'!
test01ImportsProviderRecordCorreclty

	| importedSupplier |
	
	SupplierImporter valueFrom: self oneSuplier into: system.
	
	self assert: 1 equals: system numberOfSuppliers.
	
	importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
	self assert: (importedSupplier isNamed: 'Supplier1').
	self assert: importedSupplier isCustomersEmpty.
	self assert: importedSupplier isAddressesEmpty.
! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:40:52'!
test02CannotImportRecordThatStartsWithSAndMore

	self 
		should: [ SupplierImporter valueFrom: self invalidSupplierRecordType into: system ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SupplierImporter invalidRecordTypeErrorDescription equals: anError messageText.
			self assert: 0 equals: system numberOfSuppliers ]
! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:40:56'!
test03CannotImportSupplierWithLessThanFourFields

	self 
		should: [ SupplierImporter valueFrom: self supplierRecordWithThreeFields into: system ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SupplierImporter invalidSupplierRecordErrorDescription equals: anError messageText.
			self assert: 0 equals: system numberOfSuppliers ]
! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:40:59'!
test04CannotImportSupplierWithMoreThanFourFields

	self 
		should: [ SupplierImporter valueFrom: self supplierRecordWithFiveFields into: system ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SupplierImporter invalidSupplierRecordErrorDescription equals: anError messageText.
			self assert: 0 equals: system numberOfSuppliers ]
! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:03'!
test05CanImportSupplierAddress

	| importedSupplier |
	
	SupplierImporter valueFrom: self supplierWithAddress into: system.
	
	importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
	
	self assertAddressOf: importedSupplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs' ! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:06'!
test06DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneSupplierWithoutAddress ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:11'!
test07CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: SupplierImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneSupplierWithoutAddress ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:15'!
test08CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: SupplierImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneSupplierWithoutAddress ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:17:03'!
test09CanImportNewCustomer

	| importedSupplier importedCustomer supplierCustomer customerIdentification |
	
	SupplierImporter valueFrom: self supplierWithNewCustomer into: system.
	
	importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
	customerIdentification := PartyIdentification type: 'D' number: '22333444'.
	supplierCustomer := importedSupplier customerIdentifiedAs: customerIdentification.
	importedCustomer := self assertCustomerWithIdentification: customerIdentification hasFirstName: 'Pepe' lastName: 'Sanchez'.
	
	self assert: supplierCustomer equals: importedCustomer.
	
	 
	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:22'!
test10CanNotImportNewCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self newCustomerRecordWithLessThanFiveFields
		messageText: SupplierImporter invalidNewCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:26'!
test11CanNotImportNewCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self newCustomerRecordWithMoreThanFiveFields
		messageText: SupplierImporter invalidNewCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:30'!
test12CanNotImportNewCustomerWithNCAndMore

	self
		shouldFailImporting: self invalidNewCustomerRecordType
		messageText: SupplierImporter invalidRecordTypeErrorDescription 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:12:48'!
test13CanImportExistingCustomer

	| importedSupplier supplierCustomer existingCustomer customerIdentification |
	
	customerIdentification := PartyIdentification type: 'D' number: '22333444'.
	existingCustomer := Customer 
		firstName: 'Pepe'
		lastName: 'Sanchez'
		identifiedAs: customerIdentification.
	
	system customerSystem add: existingCustomer.
	
	SupplierImporter valueFrom: self supplierWithExistingCustomer into: system.
	
	importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
	supplierCustomer := importedSupplier customerIdentifiedAs: customerIdentification.
	
	self assert: supplierCustomer equals: existingCustomer .
	
	 
	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:36'!
test14CanNotImportExistingCustomerRecordWithLessThanThreeFields

	self
		shouldFailImporting: self existingCustomerRecordWithLessThanThreeFields
		messageText: SupplierImporter invalidExistingCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:41'!
test15CanNotImportExistingCustomerRecordWithMoreThanThreeFields

	self
		shouldFailImporting: self existingCustomerRecordWithMoreThanThreeFields
		messageText: SupplierImporter invalidExistingCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:45'!
test16CanNotImportExistingCustomerWithECAndMore

	self
		shouldFailImporting: self invalidExistingCustomerRecordType
		messageText: SupplierImporter invalidRecordTypeErrorDescription 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 10:41:50'!
test17CannotImportExistingCustomerThatDoesNotExists

	self
		shouldFailImporting: self supplierWithExistingCustomer
		messageText: SupplierImporter customerDoesNotExistsErrorDescription 
		asserting: [ self assertNoCustomerWasImported ]
 
	! !

!SupplierImporterTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 17:31:15'!
test18CannotImportNewCustomerThatAlreadyExists

	| importedSupplier existingCustomer |
	
	existingCustomer := Customer 
		firstName: 'Pepe'
		lastName: 'Sanchez'
		identifiedAs: (PartyIdentification type: 'D' number: '22333444').
	
	system customerSystem add: existingCustomer.

	self
		shouldFailImporting: self supplierWithNewCustomer 
		messageText: SupplierImporter customerAlreadyExistsErrorDescription 
		asserting: [
			importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
			self assert: importedSupplier isCustomersEmpty.]! !


!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
existingCustomerRecordWithLessThanThreeFields
	
	^ReadStream on: 'S,Supplier1,D,123
EC,D'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
existingCustomerRecordWithMoreThanThreeFields
	
	^ReadStream on: 'S,Supplier1,D,123
EC,D,22333444,x'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
invalidAddressRecordStartData

	^ReadStream on: 'S,Supplier1,D,123
AA,San Martin,3322,Olivos,1636,BsAs'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
invalidExistingCustomerRecordType
	
	^ReadStream on: 'S,Supplier1,D,123
ECx,D,22333444'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
invalidNewCustomerRecordType
	
	^ReadStream on: 'S,Supplier1,D,123
NCx,Pepe,Sanchez,D,1122'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
invalidSupplierRecordType

	^ReadStream on: 'SA,Supplier1,D,123'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
newCustomerRecordWithLessThanFiveFields
	
	^ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
newCustomerRecordWithMoreThanFiveFields
	
	
	^ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D,1212,x'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
oneSuplier
	
	^ReadStream on: 'S,Supplier1,D,123'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
supplierRecordWithFiveFields
	
	^ReadStream on: 'S,Supplier1,D,123,x'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
supplierRecordWithThreeFields
	
	^ReadStream on: 'S,Supplier1,D'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
supplierWithAddress
	
	^ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
supplierWithExistingCustomer
	
	^ReadStream on: 'S,Supplier1,D,123
EC,D,22333444'! !

!SupplierImporterTest methodsFor: 'test data' stamp: 'HAW 6/3/2022 10:35:59'!
supplierWithNewCustomer
	
	^ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'! !


!SupplierImporterTest methodsFor: 'address record' stamp: 'HAW 6/3/2022 10:35:59'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636'! !

!SupplierImporterTest methodsFor: 'address record' stamp: 'HAW 6/3/2022 10:35:59'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs,x'! !


!SupplierImporterTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 10:35:59'!
assertAddressOf: importedSupplier at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedSupplier addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!SupplierImporterTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 19:14:49'!
assertCustomerWithIdentification: anIdentification hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerIdentifiedAs: anIdentification.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdentification equals: importedCustomer identification.

	^importedCustomer

	! !

!SupplierImporterTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 10:35:59'!
assertImportedOneSupplierWithoutAddress

	| importedSupplier |

	self assert: 1 equals: system numberOfSuppliers.
	importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
	self assert: importedSupplier isAddressesEmpty
	! !

!SupplierImporterTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 10:35:59'!
assertNoCustomerWasImported
	
	| importedSupplier |

	self assert: 1 equals: system numberOfSuppliers.
	importedSupplier := system supplierIdentifiedAs: 'D' number: '123'.
	
	self assert: importedSupplier isCustomersEmpty.
	self assert: 0 equals: system customerSystem numberOfCustomers 
	! !

!SupplierImporterTest methodsFor: 'assertions' stamp: 'HAW 6/3/2022 10:35:59'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ SupplierImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!SupplierImporterTest methodsFor: 'setUp/tearDown' stamp: 'HAW 6/3/2022 10:35:59'!
setUp

	erpSystem := Environment current createErpSystem.
	erpSystem start; beginTransaction.
	
	system := erpSystem supplierSystem! !

!SupplierImporterTest methodsFor: 'setUp/tearDown' stamp: 'HAW 6/3/2022 10:35:59'!
tearDown

	erpSystem commit; stop! !


!classDefinition: #SupplierTest category: #CustomerImporter!
TestCase subclass: #SupplierTest
	instanceVariableNames: 'system erpSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:34:57'!
test01IsNamedReturnsTrueForSameName

	| supplier |
	
	supplier := Supplier named: 'Pepe' identifiedAs: (PartyIdentification type: 'D' number: '1122').
	
	self assert: (supplier isNamed: 'Pepe')! !

!SupplierTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:35:03'!
test02IsNamedReturnsFalseForDifferentName

	| supplier |
	
	supplier := Supplier named: 'Pepe' identifiedAs: (PartyIdentification type: 'D' number: '1122').
	
	self deny: (supplier isNamed: 'Juan')! !

!SupplierTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:35:07'!
test03IsIdentifedAsReturnsTrueWithSameTypeAndNumber

	| supplier |
	
	supplier := Supplier named: 'Pepe' identifiedAs: (PartyIdentification type: 'D' number: '1122').
	
	self assert: (supplier isIdentifiedAs: (PartyIdentification type: 'D' number: '1122')).! !

!SupplierTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:44:40'!
test04IsIdentifiedAsReturnsFalseForDifferentType

	| supplier |
	
	supplier := Supplier named: 'Pepe' identifiedAs: (PartyIdentification type: 'D' number: '1122').
	
	self deny: (supplier isIdentifiedAs: (PartyIdentification type: 'a' number: '1122')).! !

!SupplierTest methodsFor: 'tests' stamp: 'HAW 6/3/2022 19:35:19'!
test05IsIdentifiedAsReturnsFalseForDifferentNumber

	| supplier |
	
	supplier := Supplier named: 'Pepe' identifiedAs: (PartyIdentification type: 'D' number: '1122').
	
	self deny: (supplier isIdentifiedAs: (PartyIdentification type: 'D' number: '112')).! !


!classDefinition: #Address category: #CustomerImporter!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !


!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !


!Address methodsFor: 'initialization' stamp: 'HAW 11/27/2023 16:29:53'!
initializeAtStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: #CustomerImporter!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'HAW 11/27/2023 16:29:45'!
atStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	^self new initializeAtStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


!classDefinition: #CSVImporter category: #CustomerImporter!
Object subclass: #CSVImporter
	instanceVariableNames: 'readStream line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'evaluating' stamp: 'HAW 11/27/2023 16:20:13'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:20:55'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:21:04'!
createRecord

	record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:20:26'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:20:49'!
importNotEmptyRecord

	self subclassResponsibility ! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:20:40'!
importRecord

	self assertRecordNotEmpty.

	self importNotEmptyRecord! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:24:16'!
signalInvalidRecordType

	^ self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: #CustomerImporter!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'error messages' stamp: 'HAW 11/27/2023 16:55:35'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #PartyImporter category: #CustomerImporter!
CSVImporter subclass: #PartyImporter
	instanceVariableNames: 'importedParty system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartyImporter methodsFor: 'address' stamp: 'HAW 6/1/2022 19:09:55'!
assertPartyWasImported

	^ importedParty ifNil: [ self error: self class canNotImportAddressWithoutPartyErrorDescription ]! !

!PartyImporter methodsFor: 'address' stamp: 'HAW 6/1/2022 19:04:30'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!PartyImporter methodsFor: 'address' stamp: 'HAW 11/27/2023 16:28:56'!
importAddress

	| newAddress |

	self assertPartyWasImported.
	self assertValidAddressRecord.

	newAddress := Address 
		atStreetName: record second
		streetNumber: record third asNumber 
		town: record fourth
		zipCode: record fifth asNumber
		province: record sixth.
	
	importedParty addAddress: newAddress.
! !

!PartyImporter methodsFor: 'address' stamp: 'HAW 6/1/2022 19:04:38'!
isAddressRecord

	^ record first = 'A'! !


!PartyImporter methodsFor: 'initialization' stamp: 'HAW 6/1/2022 19:09:34'!
initializeFrom: aReadStream into: aSystem

	readStream := aReadStream.
	system := aSystem ! !


!PartyImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 09:48:48'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self signalInvalidCustomerRecord ]! !

!PartyImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 17:32:03'!
createCustomer

	| customer |
	
	self assertValidCustomerRecord.
	
	customer := Customer 
		firstName: record second
		lastName: record third
		identifiedAs: (PartyIdentification type: record fourth number: record fifth).
	
	^customer ! !

!PartyImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 09:53:19'!
signalInvalidCustomerRecord

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PartyImporter class' category: #CustomerImporter!
PartyImporter class
	instanceVariableNames: ''!

!PartyImporter class methodsFor: 'error messages' stamp: 'HAW 6/1/2022 19:09:20'!
canNotImportAddressWithoutPartyErrorDescription

	^'Cannot import address without customer'! !

!PartyImporter class methodsFor: 'error messages' stamp: 'HAW 6/1/2022 19:03:49'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !


!PartyImporter class methodsFor: 'importing' stamp: 'HAW 6/1/2022 19:09:04'!
valueFrom: aReadStream into: aSystem

	^(self from: aReadStream into: aSystem) value! !


!PartyImporter class methodsFor: 'instance creation' stamp: 'HAW 6/1/2022 19:08:55'!
from: aReadStream into: aSystem

	^self new initializeFrom: aReadStream into: aSystem! !


!classDefinition: #CustomerImporter category: #CustomerImporter!
PartyImporter subclass: #CustomerImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 6/1/2022 19:27:08'!
importCustomer

	importedParty := self createCustomer.
	system add: importedParty! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 09:53:03'!
signalInvalidCustomerRecord

	^ self error: self class invalidCustomerRecordErrorDescription! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:23:40'!
importNotEmptyRecord

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self signalInvalidRecordType! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: #CustomerImporter!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #SupplierImporter category: #CustomerImporter!
PartyImporter subclass: #SupplierImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'evaluating - private' stamp: 'HAW 11/27/2023 16:22:24'!
importNotEmptyRecord
	
	self isSupplierRecord ifTrue: [ ^self importSupplierRecord ].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	self isNewCustomerRecord ifTrue: [ ^self importNewCustomerRecord ].
	self isExistingCustomerRecord ifTrue: [ ^self importExistingCustomerRecord ].
	
	self signalInvalidRecordType	
! !


!SupplierImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 17:56:44'!
assertValidNewExistingCustomerRecord

	^ record size ~= 3 ifTrue: [ self error: self class invalidExistingCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 17:59:30'!
importExistingCustomerRecord
	
	| existingCustomer |
	
	self assertValidNewExistingCustomerRecord.
	
	existingCustomer := system 
		customerIdentifiedAs: (PartyIdentification type: record second number: record third)
		ifNone: [ self error: self class customerDoesNotExistsErrorDescription ].
	importedParty addCustomer: existingCustomer.! !

!SupplierImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 17:59:52'!
importNewCustomerRecord
	
	| customer |
	
	customer := self createCustomer.
	
	system customerSystem 
		customerIdentifiedAs: customer identification
		ifNone: [ 
			importedParty addCustomer: customer.
			^system customerSystem add: customer ].
		
	self error: self class customerAlreadyExistsErrorDescription ! !

!SupplierImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 10:00:33'!
isExistingCustomerRecord
	
	^record first = 'EC'! !

!SupplierImporter methodsFor: 'customer' stamp: 'HAW 6/1/2022 19:24:43'!
isNewCustomerRecord
	
	^record first = 'NC'! !

!SupplierImporter methodsFor: 'customer' stamp: 'HAW 6/3/2022 09:52:35'!
signalInvalidCustomerRecord

	^ self error: self class invalidNewCustomerRecordErrorDescription! !


!SupplierImporter methodsFor: 'supplier' stamp: 'HAW 6/1/2022 19:12:29'!
assertValidSupplierRecord

	^ record size ~= 4 ifTrue: [ self error: self class invalidSupplierRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'supplier' stamp: 'HAW 6/3/2022 17:49:29'!
importSupplierRecord

	self assertValidSupplierRecord.
	
	importedParty := Supplier named: record second identifiedAs: (PartyIdentification type: record third number: record fourth).
	system add: importedParty! !

!SupplierImporter methodsFor: 'supplier' stamp: 'HAW 6/1/2022 19:11:11'!
isSupplierRecord

	^ record first = 'S'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: #CustomerImporter!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 10:30:47'!
customerAlreadyExistsErrorDescription
	
	^'Customer already exists'! !

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 10:15:08'!
customerDoesNotExistsErrorDescription
	
	^'Customer does not exists'! !

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 10:09:29'!
invalidExistingCustomerRecordErrorDescription
	
	^'Invalid existing customer record'! !

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 09:47:46'!
invalidNewCustomerRecordErrorDescription
	
	^'Invalid new customer record'! !

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'HAW 6/1/2022 10:27:03'!
invalidSupplierRecordErrorDescription
	
	^'Supplier record must have four fields'! !


!classDefinition: #DataBaseSession category: #CustomerImporter!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: #CustomerImporter!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: #CustomerImporter!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'system creation' stamp: 'HAW 6/2/2022 14:58:03'!
createErpSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: #CustomerImporter!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/27/2023 16:13:55'!
environmentVariable

	^ Smalltalk at: self environmentKey ifAbsent: [self error: 'No environment is configured' ].! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: #CustomerImporter!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'system creation' stamp: 'HAW 6/2/2022 14:31:36'!
createErpSystem
	
	^TransientErpSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: #CustomerImporter!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!DevelopmentEnvironment class methodsFor: 'class initialization' stamp: 'HAW 11/27/2023 16:14:07'!
initialize

	super initialize.
	self makeCurrent ! !


!classDefinition: #IntegrationEnvironment category: #CustomerImporter!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'system creation' stamp: 'HAW 6/2/2022 14:40:46'!
createErpSystem
	
	^PersistentErpSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: #CustomerImporter!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #Party category: #CustomerImporter!
Object subclass: #Party
	instanceVariableNames: 'id addresses identification'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'addresses' stamp: 'HAW 6/1/2022 12:45:38'!
addAddress: anAddress

	addresses add: anAddress ! !

!Party methodsFor: 'addresses' stamp: 'HAW 6/1/2022 12:45:43'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Party methodsFor: 'addresses' stamp: 'HAW 6/1/2022 12:45:28'!
addresses

	^ addresses! !

!Party methodsFor: 'addresses' stamp: 'HAW 6/1/2022 12:45:48'!
isAddressesEmpty

	^addresses isEmpty ! !


!Party methodsFor: 'initialization' stamp: 'HAW 6/1/2022 12:46:19'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Party methodsFor: 'identification' stamp: 'HAW 6/3/2022 17:59:59'!
identification
	
	^identification! !

!Party methodsFor: 'identification' stamp: 'HAW 6/3/2022 17:33:35'!
isIdentifiedAs: anIdentification

	^identification = anIdentification ! !


!classDefinition: #Customer category: #CustomerImporter!
Party subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !


!Customer methodsFor: 'initialization' stamp: 'HAW 6/3/2022 17:33:35'!
initializeFirstName: aFirstName lastName: aLastName identifiedAs: aPartyIdentification 
	
	firstName := aFirstName.
	lastName := aLastName.
	identification := aPartyIdentification.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #CustomerImporter!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'HAW 6/3/2022 17:30:11'!
firstName: aFirstName lastName: aLastName identifiedAs: aPartyIdentification 
	
	^self new initializeFirstName: aFirstName lastName: aLastName identifiedAs: aPartyIdentification ! !


!classDefinition: #Supplier category: #CustomerImporter!
Party subclass: #Supplier
	instanceVariableNames: 'name customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'as yet unclassified' stamp: 'HAW 6/2/2022 14:19:03'!
addCustomer: aCustomer 
	
	customers add: aCustomer ! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 19:07:36'!
customerIdentifiedAs: anIdentification
	
	^customers detect: [ :aCustomer | aCustomer isIdentifiedAs: anIdentification ]! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'HAW 6/1/2022 12:48:24'!
isCustomersEmpty
	
	^true! !

!Supplier methodsFor: 'as yet unclassified' stamp: 'HAW 6/1/2022 09:53:07'!
isNamed: aName

	^name = aName ! !


!Supplier methodsFor: 'initialization' stamp: 'HAW 6/3/2022 17:35:41'!
initializedNamed: aName identifiedAs: anIdentification
	
	name := aName.
	identification := anIdentification.
	
	customers := OrderedCollection new
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supplier class' category: #CustomerImporter!
Supplier class
	instanceVariableNames: ''!

!Supplier class methodsFor: 'instance creation' stamp: 'HAW 6/3/2022 17:48:48'!
named: aName identifiedAs: anIdentification
	
	^self new initializedNamed: aName identifiedAs: anIdentification ! !


!classDefinition: #PartyIdentification category: #CustomerImporter!
Object subclass: #PartyIdentification
	instanceVariableNames: 'type number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartyIdentification methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 10:50:07'!
number
	
	^number! !

!PartyIdentification methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 10:50:01'!
type
	
	^type! !


!PartyIdentification methodsFor: 'initialization' stamp: 'HAW 6/3/2022 10:45:59'!
initializeType: aType number: aNumber

	type := aType.
	number := aNumber ! !


!PartyIdentification methodsFor: 'equals' stamp: 'HAW 6/3/2022 19:38:21'!
= anObject

	^(anObject isKindOf: self class)
		and: [ type = anObject type 
		and: [ number = anObject number ]]! !

!PartyIdentification methodsFor: 'equals' stamp: 'HAW 6/3/2022 10:46:54'!
hash

	^type hash bitXor: number hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PartyIdentification class' category: #CustomerImporter!
PartyIdentification class
	instanceVariableNames: ''!

!PartyIdentification class methodsFor: 'instance creation' stamp: 'HAW 6/3/2022 19:47:19'!
type: aType number: aNumber

	| trimmedType trimmedNumber |
	
	trimmedType := aType withBlanksTrimmed.
	self assertIsValidType: trimmedType.
	trimmedNumber := aNumber withBlanksTrimmed.
	self assertIsValidNumber: trimmedNumber.
	
	^self new initializeType: trimmedType number: trimmedNumber 
! !


!PartyIdentification class methodsFor: 'error description' stamp: 'HAW 6/3/2022 19:45:40'!
invalidNumberErrorDescription
	
	^'Number cannot be empty'! !

!PartyIdentification class methodsFor: 'error description' stamp: 'HAW 6/3/2022 19:42:43'!
invalidTypeErrorDescription
	
	^'Type cannot be empty'! !


!PartyIdentification class methodsFor: 'assertions' stamp: 'HAW 6/3/2022 19:46:40'!
assertIsValidNumber: aNumber

	aNumber isEmpty ifTrue: [ self error: self invalidNumberErrorDescription ]! !

!PartyIdentification class methodsFor: 'assertions' stamp: 'HAW 6/3/2022 19:44:11'!
assertIsValidType: aType

	aType isEmpty ifTrue: [self error: self invalidTypeErrorDescription ]! !


!classDefinition: #System category: #CustomerImporter!
Object subclass: #System
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!System methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:41:11'!
start
	
	self subclassResponsibility ! !

!System methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:41:15'!
stop
	
	self subclassResponsibility ! !


!classDefinition: #RootSystem category: #CustomerImporter!
System subclass: #RootSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!RootSystem methodsFor: 'transactions' stamp: 'HAW 6/2/2022 15:41:43'!
beginTransaction

	self subclassResponsibility ! !

!RootSystem methodsFor: 'transactions' stamp: 'HAW 6/2/2022 15:41:47'!
commit

	self subclassResponsibility ! !


!classDefinition: #ErpSystem category: #CustomerImporter!
RootSystem subclass: #ErpSystem
	instanceVariableNames: 'customerSystem supplierSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:13:26'!
start

	customerSystem start.
	supplierSystem start! !

!ErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:13:30'!
stop

	customerSystem stop .
	supplierSystem stop! !


!ErpSystem methodsFor: 'subsystems' stamp: 'HAW 6/2/2022 15:13:09'!
customerSystem
	
	^customerSystem! !

!ErpSystem methodsFor: 'subsystems' stamp: 'HAW 6/2/2022 15:13:13'!
supplierSystem
	
	^supplierSystem! !


!classDefinition: #PersistentErpSystem category: #CustomerImporter!
ErpSystem subclass: #PersistentErpSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentErpSystem methodsFor: 'session' stamp: 'HAW 6/2/2022 14:50:21'!
session
	
	^session! !


!PersistentErpSystem methodsFor: 'transactions' stamp: 'HAW 6/2/2022 14:48:09'!
beginTransaction
	
	session beginTransaction ! !

!PersistentErpSystem methodsFor: 'transactions' stamp: 'HAW 6/2/2022 14:48:32'!
commit
	
	session commit ! !


!PersistentErpSystem methodsFor: 'initialization' stamp: 'HAW 6/2/2022 14:41:40'!
initialize

	customerSystem := PersistentCustomerSystem asSubsystemOf: self.
	supplierSystem := PersistentSupplierSystem asSubsystemOf: self.! !


!PersistentErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 11/14/2023 09:23:52'!
start
	
	session := DataBaseSession for: (Array with: Address with: Customer with: Supplier).
	super start! !

!PersistentErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:24:49'!
stop
	
	super stop.
	session close.
	! !


!classDefinition: #TransientErpSystem category: #CustomerImporter!
ErpSystem subclass: #TransientErpSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientErpSystem methodsFor: 'transactions' stamp: 'HAW 6/2/2022 14:55:43'!
beginTransaction

	! !

!TransientErpSystem methodsFor: 'transactions' stamp: 'HAW 6/2/2022 14:55:55'!
commit

	! !


!TransientErpSystem methodsFor: 'initialization' stamp: 'HAW 6/2/2022 14:33:13'!
initialize

	customerSystem := TransientCustomerSystem asSubsystemOf: self.
	supplierSystem := TransientSupplierSystem asSubsystemOf: self.! !


!classDefinition: #SubSystem category: #CustomerImporter!
System subclass: #SubSystem
	instanceVariableNames: 'parentSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SubSystem methodsFor: 'initialization' stamp: 'HAW 6/2/2022 15:38:26'!
initializeAsSubsystemOf: aParentSystem 
	
	parentSystem := aParentSystem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SubSystem class' category: #CustomerImporter!
SubSystem class
	instanceVariableNames: ''!

!SubSystem class methodsFor: 'instance creation' stamp: 'HAW 6/2/2022 15:38:35'!
asSubsystemOf: aParentSystem 
	
	^self new initializeAsSubsystemOf: aParentSystem ! !


!classDefinition: #CustomerSystem category: #CustomerImporter!
SubSystem subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 6/3/2022 18:01:56'!
customerIdentifiedAs: anIdentification

	^self customerIdentifiedAs: anIdentification ifNone: [ self error: self class customerNotFoundErrorDescription ]! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 6/3/2022 19:04:16'!
customerIdentifiedAs: anIdentification ifNone: noneBlock

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerSystem class' category: #CustomerImporter!
CustomerSystem class
	instanceVariableNames: ''!

!CustomerSystem class methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2022 10:27:38'!
customerNotFoundErrorDescription
	
	^'Customer not found'! !


!classDefinition: #PersistentCustomerSystem category: #CustomerImporter!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'session' stamp: 'HAW 6/2/2022 14:50:14'!
session
	
	^parentSystem session! !


!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 6/2/2022 14:46:21'!
add: aCustomer

	^self session persist: aCustomer ! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 6/3/2022 17:53:44'!
customerIdentifiedAs: anIdentification ifNone: noneBlock

	| foundCustomers |
	
	foundCustomers := self session
		select: [ :aCustomer | aCustomer isIdentifiedAs: anIdentification. ]
		ofType: Customer.
		
	^foundCustomers isEmpty 
		ifTrue: [ noneBlock value ]
		ifFalse: [ foundCustomers anyOne ]! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 6/2/2022 14:46:41'!
numberOfCustomers

	^(self session selectAllOfType: Customer) size! !


!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 14:44:00'!
start

	! !

!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 14:46:51'!
stop

	! !


!classDefinition: #TransientCustomerSystem category: #CustomerImporter!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:21:06'!
start

	customers := OrderedCollection new! !

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:23:17'!
stop

	customers := nil! !


!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:32'!
add: aCustomer

	customers add: aCustomer ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 6/3/2022 17:58:19'!
customerIdentifiedAs: anIdentification ifNone: noneBlock

	^customers detect: [ :aCustomer | aCustomer isIdentifiedAs: anIdentification ] ifNone: noneBlock ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!classDefinition: #SupplierSystem category: #CustomerImporter!
SubSystem subclass: #SupplierSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/2/2022 15:34:21'!
add: aSupplier

	self subclassResponsibility ! !

!SupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/2/2022 15:34:28'!
numberOfSuppliers

	self subclassResponsibility ! !

!SupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/2/2022 15:34:44'!
supplierIdentifiedAs: anIdType number: anIdNumber 

	self subclassResponsibility ! !


!SupplierSystem methodsFor: 'customers' stamp: 'HAW 6/3/2022 18:59:31'!
customerIdentifiedAs: anIdentification 
	
	^self customerSystem customerIdentifiedAs: anIdentification ! !

!SupplierSystem methodsFor: 'customers' stamp: 'HAW 6/3/2022 17:57:31'!
customerIdentifiedAs: anIdentification ifNone: noneBlock

	^self customerSystem customerIdentifiedAs: anIdentification ifNone: noneBlock
! !

!SupplierSystem methodsFor: 'customers' stamp: 'HAW 6/2/2022 15:30:25'!
customerSystem
	
	^parentSystem customerSystem ! !


!classDefinition: #PersistentSupplierSystem category: #CustomerImporter!
SupplierSystem subclass: #PersistentSupplierSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSupplierSystem methodsFor: 'session' stamp: 'HAW 6/2/2022 14:51:05'!
session
	
	^parentSystem session! !


!PersistentSupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/2/2022 15:34:11'!
add: aSupplier 
	
	self session persist: aSupplier ! !

!PersistentSupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/2/2022 14:51:40'!
numberOfSuppliers
	
	^(self session selectAllOfType: Supplier) size  ! !

!PersistentSupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/3/2022 17:51:50'!
supplierIdentifiedAs: anIdType number: anIdNumber 
	
	^(self session select: [ :aSupplier | aSupplier isIdentifiedAs: (PartyIdentification type: anIdType number: anIdNumber). ] ofType: Supplier) anyOne ! !


!PersistentSupplierSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:31:50'!
start! !

!PersistentSupplierSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 15:31:52'!
stop! !


!classDefinition: #TransientSupplierSystem category: #CustomerImporter!
SupplierSystem subclass: #TransientSupplierSystem
	instanceVariableNames: 'suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientSupplierSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 14:34:37'!
start
	
	suppliers := OrderedCollection new! !

!TransientSupplierSystem methodsFor: 'system lifecycle' stamp: 'HAW 6/2/2022 14:34:59'!
stop
	
	suppliers := nil! !


!TransientSupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/2/2022 15:34:11'!
add: aSupplier

	suppliers add: aSupplier ! !

!TransientSupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/1/2022 10:00:25'!
numberOfSuppliers
	
	^suppliers size! !

!TransientSupplierSystem methodsFor: 'suppliers' stamp: 'HAW 6/3/2022 17:51:50'!
supplierIdentifiedAs: idType number: idNumber 
	
	^suppliers detect: [ :aSupplier | aSupplier isIdentifiedAs: (PartyIdentification type: idType number: idNumber). ]! !

DevelopmentEnvironment initialize!