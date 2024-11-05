!classDefinition: #Account category: 'Portfolio2-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/26/2019 19:00:30'!
transactionsIsEmpty

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/26/2019 19:00:23'!
visitTransactionsWith: aTransactionVisitor

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:41:02'!
accept: anAccountVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio2-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:40:23'!
named: aName

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio2-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:27:43'!
initializedNamed: aName

	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'name' stamp: 'HAW 5/26/2019 19:26:14'!
name

	^name! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/26/2019 19:01:47'!
transactionsIsEmpty
	
	^accounts allSatisfy: [ :anAccount | anAccount transactionsIsEmpty ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/26/2019 18:47:32'!
visitTransactionsWith: aTransactionVisitor

	accounts do: [ :anAccount | anAccount visitTransactionsWith: aTransactionVisitor ]! !


!Portfolio methodsFor: 'transactions - private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:34:04'!
accept: anAccountVisitor

	anAccountVisitor visitPortfolio: self! !

!Portfolio methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:35:42'!
visitAccountsWith: anAccountVisitor

	accounts do: [ :anAccount | anAccount accept: anAccountVisitor ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:23:13'!
named: aName

	^super new initializedNamed: aName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:32:34'!
named: aName with: anAccount

	^(self named: aName) 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:47:25'!
named: aName with: anAccount with: anotherAccount

	^(self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:53:08'!
new

	^self named: self unnamedPortfolio ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:52:32'!
unnamedPortfolio

	^'Unnamed portfolio'.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:52:18'!
with: anAccount

	^self named: self unnamedPortfolio with: anAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:53:01'!
with: anAccount with: anotherAccount

	^self named: self unnamedPortfolio with: anAccount with: anotherAccount ! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:39:38'!
initializedNamed: aName

	name := aName.
	transactions := OrderedCollection new! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'name' stamp: 'HAW 5/26/2019 19:39:16'!
name

	^name! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/26/2019 18:53:27'!
transactionsIsEmpty
	
	^transactions isEmpty ! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/26/2019 18:18:53'!
visitTransactionsWith: aTransactionVisitor

	transactions do: [ :aTransaction | aTransaction accept: aTransactionVisitor ]! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:36:05'!
accept: anAccountVisitor

	anAccountVisitor visitReceptiveAccount: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:31:42'!
named: aName

	^super new initializedNamed: aName! !

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:40:00'!
new

	^self named: 'unnamed receptive account'! !


!classDefinition: #AccountTransaction category: 'Portfolio2-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:05:10'!
accept: aTransactionVisitor

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'Portfolio2-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:19:21'!
accept: aTransactionVisitor

	aTransactionVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'registration' stamp: 'NR 11/9/2019 16:22:48'!
register: aValue on: account

	| deposit |
	
	deposit := self for: aValue.
	account register: deposit.
		
	^ deposit! !


!classDefinition: #TransferLeg category: 'Portfolio2-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferLeg methodsFor: 'initialization' stamp: 'HAW 5/25/2019 20:02:09'!
initializeAsPartOf: aTransfer 
	
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'value' stamp: 'HAW 5/25/2019 20:03:40'!
value

	^transfer value! !


!TransferLeg methodsFor: 'accessing' stamp: 'HAW 5/26/2019 18:12:15'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio2-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 20:01:58'!
asPartOf: aTransfer 

	^self new initializeAsPartOf: aTransfer ! !


!classDefinition: #TransferDeposit category: 'Portfolio2-Solucion'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferDeposit methodsFor: 'leg' stamp: 'HAW 5/25/2019 20:01:26'!
withdrawLeg
	
	^transfer withdrawLeg ! !


!TransferDeposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 20:01:20'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDeposit methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:25:22'!
accept: aTransactionVisitor

	aTransactionVisitor visitTransferDeposit: self! !


!classDefinition: #TransferWithdraw category: 'Portfolio2-Solucion'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferWithdraw methodsFor: 'leg' stamp: 'HAW 5/25/2019 20:03:27'!
depositLeg

	^transfer depositLeg ! !


!TransferWithdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 20:03:11'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdraw methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:23:16'!
accept: aTransactionVisitor

	aTransactionVisitor visitTransferWithdraw: self! !


!classDefinition: #Withdraw category: 'Portfolio2-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:21:15'!
accept: aTransactionVisitor

	aTransactionVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'registration' stamp: 'HAW 5/26/2019 18:08:21'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountVisitor category: 'Portfolio2-Solucion'!
Object subclass: #AccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountVisitor methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:50:42'!
visitPortfolio: aPortfolio

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:50:54'!
visitReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !


!classDefinition: #PortfolioSummary category: 'Portfolio2-Solucion'!
AccountVisitor subclass: #PortfolioSummary
	instanceVariableNames: 'portfolio lines spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!PortfolioSummary methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:57:04'!
initializeOn: aPortfolio 
	
	portfolio := aPortfolio ! !


!PortfolioSummary methodsFor: 'line management' stamp: 'HAW 5/29/2019 16:03:04'!
addNameOf: anAccount

	self addToLines: anAccount name! !

!PortfolioSummary methodsFor: 'line management' stamp: 'HAW 5/29/2019 16:02:51'!
addToLines: aLine
	
	lines add: spaces, aLine! !

!PortfolioSummary methodsFor: 'line management' stamp: 'HAW 5/29/2019 16:01:41'!
incrementIdentatioWhile: aBlock

	spaces := spaces, '   '.
	aBlock ensure: [ spaces := spaces allButLast: 3 ]! !


!PortfolioSummary methodsFor: 'account visiting' stamp: 'HAW 5/29/2019 16:03:23'!
visitPortfolio: aPortfolio 
	
	self addNameOf: aPortfolio.
	self incrementIdentatioWhile: [
		aPortfolio visitAccountsWith: self.
		self addToLines: 'Balance = ', aPortfolio balance printString ].
	
	! !

!PortfolioSummary methodsFor: 'account visiting' stamp: 'HAW 5/29/2019 16:02:41'!
visitReceptiveAccount: aReceptiveAccount 
	
	| accountSummaryLines |
	
	self addNameOf: aReceptiveAccount.
	accountSummaryLines := (AccountSummary on: aReceptiveAccount) lines.
	self incrementIdentatioWhile: [ accountSummaryLines do: [ :aLine | self addToLines: aLine ]]
	! !


!PortfolioSummary methodsFor: 'evaluating' stamp: 'HAW 5/26/2019 19:57:43'!
lines
	
	lines := OrderedCollection new.
	spaces := ''.
	
	portfolio accept: self.
	
	^lines! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSummary class' category: 'Portfolio2-Solucion'!
PortfolioSummary class
	instanceVariableNames: ''!

!PortfolioSummary class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:56:53'!
on: aPortfolio 
	
	^self new initializeOn: aPortfolio ! !


!classDefinition: #PortfolioTreePrinter category: 'Portfolio2-Solucion'!
AccountVisitor subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio lines spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:24:13'!
initializeOn: aPortfolio 
	
	portfolio := aPortfolio ! !


!PortfolioTreePrinter methodsFor: 'lines' stamp: 'HAW 5/26/2019 19:38:40'!
lines
	
	lines := OrderedCollection new.
	spaces := ''.
	
	portfolio accept: self.
	
	^lines! !


!PortfolioTreePrinter methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:37:47'!
addNameOf: anAccount

	lines add: spaces, anAccount name! !

!PortfolioTreePrinter methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:49:24'!
visitPortfolio: aPortfolio 
	
	self addNameOf: aPortfolio.
	spaces := spaces, '   '.
	aPortfolio visitAccountsWith: self.
	spaces := spaces allButLast: 3! !

!PortfolioTreePrinter methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:37:23'!
visitReceptiveAccount: aReceptiveAccount 
	
	self addNameOf: aReceptiveAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'Portfolio2-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:20:07'!
on: aPortfolio 
	
	^self new initializeOn: aPortfolio ! !


!classDefinition: #TransactionVisitor category: 'Portfolio2-Solucion'!
Object subclass: #TransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:05'!
visitDeposit: aDeposit

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:12'!
visitTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:21'!
visitTransferWithdraw: aTransferWithdraw

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:27'!
visitWithdraw: aWithdraw

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio2-Solucion'!
TransactionVisitor subclass: #AccountSummary
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'HAW 5/26/2019 18:17:08'!
initializeOn: anAccount

	account := anAccount ! !


!AccountSummary methodsFor: 'evaluating' stamp: 'HAW 5/26/2019 18:29:36'!
lines
	
	lines := OrderedCollection new.
	
	account visitTransactionsWith: self.
	lines add: ('Balance = ', account balance printString).
	
	^lines! !


!AccountSummary methodsFor: 'transaction visiting' stamp: 'NR 10/25/2021 08:34:40'!
visitDeposit: aDeposit 
	
	lines add: ('Depósito por ', aDeposit value printString)! !

!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:25:45'!
visitTransferDeposit: aTransferDeposit 
	
	lines add: ('Entrada por transferencia de ', aTransferDeposit value printString)! !

!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:23:38'!
visitTransferWithdraw: aTransferWithdraw 
	
	lines add: ('Salida por transferencia de ', aTransferWithdraw value printString)! !

!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:21:47'!
visitWithdraw: aWithdraw 
	
	lines add: ('Extracción por ', aWithdraw value printString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio2-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 18:16:54'!
on: anAccount
	
	^self new initializeOn: anAccount ! !


!classDefinition: #AccountTransferNet category: 'Portfolio2-Solucion'!
TransactionVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountTransferNet methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:08:10'!
initializeOn: anAccount

	account := anAccount ! !


!AccountTransferNet methodsFor: 'evaluating' stamp: 'HAW 5/26/2019 19:11:58'!
value 

	transferNet := 0.
	
	account visitTransactionsWith: self.
	
	^transferNet! !


!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:12:45'!
visitDeposit: aDeposit 
	
	! !

!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:14:10'!
visitTransferDeposit: aTransferDeposit 
	
	transferNet := transferNet + aTransferDeposit value! !

!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:12:37'!
visitTransferWithdraw: aTransferWithdraw 
	
	transferNet := transferNet - aTransferWithdraw value! !

!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:12:52'!
visitWithdraw: aWithdraw 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: 'Portfolio2-Solucion'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:07:59'!
on: anAccount

	^self new initializeOn: anAccount ! !


!classDefinition: #Transfer category: 'Portfolio2-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Transfer methodsFor: 'value' stamp: 'HAW 5/25/2019 20:03:55'!
value

	^value ! !


!Transfer methodsFor: 'initialization' stamp: 'HAW 5/26/2019 18:05:14'!
initializeFor: anAmount  

	value := anAmount.
	withdrawLeg := TransferWithdraw asPartOf: self.
	depositLeg := TransferDeposit asPartOf: self
	! !


!Transfer methodsFor: 'legs' stamp: 'HAW 5/25/2019 19:50:46'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'HAW 5/25/2019 19:50:39'!
withdrawLeg
	
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 18:05:47'!
for: anAmount  

	^self new initializeFor: anAmount ! !


!Transfer class methodsFor: 'registration' stamp: 'HAW 5/26/2019 18:55:30'!
register: anAmount from: fromAccount to: toAccount

	| transfer |
	
	self assertCanTransfer: anAmount.
	self assertCanTransferFrom: fromAccount to: toAccount.
	
	transfer := self for: anAmount .
	
	fromAccount register: transfer withdrawLeg.
	toAccount register: transfer depositLeg.
	
	^transfer! !


!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:53:15'!
canNotTransferBetweenSameAccountsErrorMessage
	
	^'No se puede transferir entre la misma cuenta'! !

!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:52:55'!
signalCanNotTransferBetweenSameAccount
	
	self error: self canNotTransferBetweenSameAccountsErrorMessage! !

!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:58:43'!
signalTransferValueMustBeStrictlyPositive
	
	self error: self transferValueMustBeStrictlyPositiveErrorMessage! !

!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:58:15'!
transferValueMustBeStrictlyPositiveErrorMessage
	
	^'El valor de la transferencia debe ser estrictramente positivo'! !


!Transfer class methodsFor: 'instance creation pre-conditions' stamp: 'HAW 5/26/2019 18:58:43'!
assertCanTransfer: anAmount

	anAmount strictlyPositive ifFalse: [ self signalTransferValueMustBeStrictlyPositive ]! !

!Transfer class methodsFor: 'instance creation pre-conditions' stamp: 'HAW 5/26/2019 18:52:33'!
assertCanTransferFrom: aFromAccout to: aToAccount

	aFromAccout = aToAccount ifTrue: [ self signalCanNotTransferBetweenSameAccount ]! !
!classDefinition: #AccountSummaryTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:30:47'!
test01AccountSummaryOfAccountWithoutTransactionsShowsBalanceOnly

	| account accountSummary lines |
	
	account := ReceptiveAccount new.
	
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 1 equals: lines size.
	self assert: 'Balance = 0' equals: lines first! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:30:01'!
test02DepositIsShownInAccountSummary

	| account accountSummary lines |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Depósito por 100' equals: lines first.
	self assert: 'Balance = 100' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:31:15'!
test03WithdrawIsShownInAccountSummary

	| account accountSummary lines |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Extracción por 50' equals: lines first.
	self assert: 'Balance = -50' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:43:30'!
test04TransferWithdrawIsShownInAccountSummary

	| fromAccount accountSummary lines toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 20 from: fromAccount to: toAccount.
	
	accountSummary := AccountSummary on: fromAccount.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Salida por transferencia de 20' equals: lines first.
	self assert: 'Balance = -20' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:31:46'!
test05TransferDepositIsShownInAccountSummary

	| fromAccount accountSummary lines toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 30 from: fromAccount to: toAccount.
	
	accountSummary := AccountSummary on: toAccount.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Entrada por transferencia de 30' equals: lines first.
	self assert: 'Balance = 30' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:44:28'!
test06AccountSummaryShowsAllTransactions

	| account accountSummary lines  |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: account.
		
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 3 equals: lines size.
	self assert: 'Depósito por 100' equals: lines first.
	self assert: 'Extracción por 20' equals: lines second.
	self assert: 'Balance = 80' equals: lines third ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:46:47'!
test07AccountSummaryWorksOnPortfolios

	| account accountSummary lines  anotherAccount simplePortfolio |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: anotherAccount.
	simplePortfolio := Portfolio with: account with: anotherAccount.
	
	accountSummary := AccountSummary on: simplePortfolio.
	lines := accountSummary lines.
	
	self assert: 3 equals: lines size.
	self assert: 'Depósito por 100' equals: lines first.
	self assert: 'Extracción por 20' equals: lines second.
	self assert: 'Balance = 80' equals: lines third ! !


!classDefinition: #AccountTransferNetTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #AccountTransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:07:37'!
test01TransferNetOnAccountWithoutTransactionsIsZero

	| account accountTransferNet transferNet |
	
	account := ReceptiveAccount new.
	
	accountTransferNet := AccountTransferNet on: account.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet ! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:09:41'!
test02DepositDoesNotAffectTransferNet

	| account accountTransferNet transferNet |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountTransferNet := AccountTransferNet on: account.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:10:27'!
test03WithdrawDoesNotAffectTransferNet

	| account accountTransferNet transferNet |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	accountTransferNet := AccountTransferNet on: account.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:11:13'!
test04TransferWithdrawSubstractsInTransferNet

	| fromAccount accountTransferNet transferNet toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 20 from: fromAccount to: toAccount.
	
	accountTransferNet := AccountTransferNet on: fromAccount.
	transferNet := accountTransferNet value.
	
	self assert: -20 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:13:53'!
test05TransferDepositAddToTransferNet

	| fromAccount accountTransferNet transferNet toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 30 from: fromAccount to: toAccount.
	
	accountTransferNet := AccountTransferNet on: toAccount.
	transferNet := accountTransferNet value.
	
	self assert: 30 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:15:13'!
test06TransferNetIsCalculatedOnAllTransactions

	| fromAccount accountTransferNet transferNet toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 30 from: fromAccount to: toAccount.
	Transfer register: 50 from: fromAccount to: toAccount.
	
	accountTransferNet := AccountTransferNet on: fromAccount.
	transferNet := accountTransferNet value.
	
	self assert: -80 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:16:48'!
test07TransferNetWorksOnPortfolios

	| account accountTransferNet transferNet  anotherAccount simplePortfolio |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer register: 30 from: account to: anotherAccount.
	Transfer register: 50 from: account to: anotherAccount.
	simplePortfolio := Portfolio with: account with: anotherAccount.
	
	accountTransferNet := AccountTransferNet on: simplePortfolio.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet ! !


!classDefinition: #PortfolioSummaryTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #PortfolioSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:56:25'!
test01ShowsNameAndBalanceForAnEmptyPortfolio

	| lines portfolioName |
	
	portfolioName := 'Portfolio de la familia'.
	lines := (PortfolioSummary on: (Portfolio named: portfolioName)) lines.
	
	self assert: 2 equals: lines size.
	self assert: portfolioName equals: lines first.
	self assert: '   Balance = 0' equals: lines second.
	
	! !

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 15:51:49'!
test02ShowsPortfolioAccountsRecursively

	| lines familyPortfolioName familyPortfolio johnsAccount johnsAccountName angiesAccount angiesAccountName childrenPortfolio childrenPortfolioName myAccount myAccountName expectedSummary |
	
	familyPortfolioName := 'Portfolio de la familia'.
	johnsAccountName := 'Cuenta de Juan'.
	angiesAccountName := 'Cuenta de Angeles'.
	childrenPortfolioName := 'Portfolio de hijos'.
	myAccountName := 'Cuenta Mia'.
	johnsAccount := ReceptiveAccount named: johnsAccountName.
	angiesAccount := ReceptiveAccount named: angiesAccountName.
	childrenPortfolio := Portfolio named: childrenPortfolioName with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: myAccountName.
	familyPortfolio := Portfolio named: familyPortfolioName with: childrenPortfolio with: myAccount.

	Deposit register: 100 on: johnsAccount.
	Withdraw register: 20 on: angiesAccount.
	Transfer register: 50 from: myAccount to: johnsAccount.
	
	lines := (PortfolioSummary on: familyPortfolio) lines.
	
	expectedSummary := { 
'Portfolio de la familia'.
'   Portfolio de hijos'.
'      Cuenta de Juan'.
'         Depósito por 100'.
'         Entrada por transferencia de 50'.
'         Balance = 150'.
'      Cuenta de Angeles'.
'         Extracción por 20'.
'         Balance = -20'.
'      Balance = 130'.
'   Cuenta Mia'.
'      Salida por transferencia de 50'.
'      Balance = -50'.
'   Balance = 80'. }.

	self assert: expectedSummary size equals: lines size.
	1 to: expectedSummary size do: [:index |
		self assert: (expectedSummary at: index) equals: (lines at: index) ]
! !


!classDefinition: #PortfolioTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:32:29'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:32:36'!
test16TransactionsAreEmptyForAnEmptyPortolio

	self assert: Portfolio new transactionsIsEmpty ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:32:40'!
test17TransactionsIsEmptyIsCalculatedRecursevely

	self assert: (Portfolio with: ReceptiveAccount new with: Portfolio new) transactionsIsEmpty ! !


!classDefinition: #PortfolioTreePrinterTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:25:49'!
test01PortolioTreePrinterShowsNameOfPortfolioForAnEmptyPortfolio

	| lines portfolioName |
	
	portfolioName := 'Portfolio de la familia'.
	lines := (PortfolioTreePrinter on: (Portfolio named: portfolioName)) lines.
	
	self assert: 1 equals: lines size.
	self assert: portfolioName equals: lines first
	
	! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:31:11'!
test02PortfolioWithOneAccountShowAccountNameIndented

	| lines portfolioName familyPortfolio johnsAccount johnsAccountName |
	
	portfolioName := 'Portfolio de la familia'.
	johnsAccountName := 'Cuenta de Juan'.
	johnsAccount := ReceptiveAccount named: johnsAccountName.
	familyPortfolio := Portfolio named: portfolioName with: johnsAccount.
	
	lines := (PortfolioTreePrinter on: familyPortfolio) lines.
	
	self assert: 2 equals: lines size.
	self assert: portfolioName equals: lines first.
	self assert: '   ', johnsAccountName equals: lines second	
! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:47:42'!
test03AfterShowingAPortfolioIndentationIsDecremented

	| lines familyPortfolioName familyPortfolio johnsAccount johnsAccountName childrenPortfolio childrenPortfolioName myAccount myAccountName |
	
	familyPortfolioName := 'Portfolio de la familia'.
	johnsAccountName := 'Cuenta de Juan'.
	childrenPortfolioName := 'Portfolio de los hijos'.
	myAccountName := 'Cuenta mia'.
	johnsAccount := ReceptiveAccount named: johnsAccountName.
	childrenPortfolio := Portfolio named: childrenPortfolioName with: johnsAccount.
	myAccount := ReceptiveAccount named: myAccountName.
	familyPortfolio := Portfolio named: familyPortfolioName with: childrenPortfolio with: myAccount.
	
	lines := (PortfolioTreePrinter on: familyPortfolio) lines.
	
	self assert: 4 equals: lines size.
	self assert: familyPortfolioName equals: lines first.
	self assert: '   ', childrenPortfolioName equals: lines second.	
	self assert: '      ', johnsAccountName equals: lines third.
	self assert: '   ', myAccountName equals: lines fourth.
		
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferTest category: 'Portfolio2-Solucion-Tests'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!TransferTest methodsFor: 'test' stamp: 'LL 6/29/2020 16:28:23'!
test01TransferWithdrawsFromOriginAccountAndDepositsIntoDestinationAccount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Transfer register: 100 from: originAccount to: destinationAccount.
	
	self assert: -100 equals: originAccount balance.
	self assert: 100 equals: destinationAccount balance! !

!TransferTest methodsFor: 'test' stamp: 'LL 6/29/2020 16:29:05'!
test02TransferLegsAreRegisteredInAccounts

	| originAccount destinationAccount transfer |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: originAccount to: destinationAccount.
	
	self assert: (originAccount hasRegistered: transfer withdrawLeg).
	self assert: (destinationAccount hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'test' stamp: 'NR 10/25/2021 06:14:23'!
test03LegsHaveSameTransfer

	| transfer |
	
	transfer := Transfer for: 100.
	
	self assert: transfer withdrawLeg transfer equals: transfer depositLeg transfer! !

!TransferTest methodsFor: 'test' stamp: 'HAW 5/26/2019 18:11:17'!
test04CanGoFromDepositLegToWithdrawLeg

	| transfer |
	
	transfer := Transfer for: 100.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'test' stamp: 'NR 10/25/2021 06:14:33'!
test05CanGoFromWithdrawLegToDepositLeg

	| transfer |
		
	transfer := Transfer for: 100.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'test' stamp: 'HAW 5/26/2019 18:50:19'!
test06CanNotTransferBetweenSameAccounts

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [ Transfer register: 100 from: account to: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer canNotTransferBetweenSameAccountsErrorMessage equals: anError messageText.
			self assert: account transactionsIsEmpty ]
	
! !

!TransferTest methodsFor: 'test' stamp: 'LL 6/29/2020 16:30:26'!
test07CanTransferStrictlyPositiveValuesOnly

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	self 
		should: [ Transfer register: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer transferValueMustBeStrictlyPositiveErrorMessage equals: anError messageText.
			self assert: originAccount transactionsIsEmpty. 
			self assert: destinationAccount transactionsIsEmpty ]
	
! !
