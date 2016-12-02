<%

class cJobOrder
	private m_Site
	private m_Reference
	private m_JobNumber
	private m_JobStatus
	private m_JobDescription
	private m_Memo
	private m_Department
	private m_OrderDate
	private m_TimeReceived
	private m_Office
	private m_ProposalDate
	private m_CustomerCode
	private m_CustomerName
	private m_NewClient 'boolean yes / no
	private m_Corporation 'boolean, if no then Individual
	private m_CompanyName
	private m_OrderTakenBy
	private m_Telephone
	private m_Fax
	private m_Email
	private m_Orders_Customer
	private m_OrderAddress
	private m_OrderCity
	private m_OrderState
	private m_OrderCounty
	private m_OrderZip
	private m_OrderDirections
	private m_OrderBillingAddress
	private m_BusinessID 'SSN or EIN
	private m_BankReference
	private m_SupplierReference
	private m_CreditChecked
	private m_CreditApproved
	private m_CreditComments
	private m_TypeOfBusiness
	private m_TypeOfEmployee
	private m_HowManyEmployees
	private m_EssentialFunctions 'Duties and Actions
	private m_SkillsRequired
	private m_ToolsUsed
	private m_ToolsRequired
	private m_DressCode
	private m_PhysicalTasks
	private m_SafetyEquipment
	private m_RepetitiveMotion
	private m_WeightLighting
	private m_BondingRequired
	private m_DriversLicenseNeeded
	private m_CDLRequired
	private m_WorkCompRate
	private m_WorkCompCode
	private m_WorkCode1
	private m_WC1Pay
	private m_WC1Bill
	private m_WC1Required
	private m_WorkCode2
	private m_WC2Pay
	private m_WC2Bill
	private m_WC2Required
	private m_WorkCode3
	private m_WC3Pay
	private m_WC3Bill
	private m_WC3Required
	private m_WorkCode4
	private m_WC4Pay
	private m_WC4Bill
	private m_WC4Required
	private m_WorkCode5
	private m_WC5Pay
	private m_WC5Bill
	private m_WC5Required
	private m_OtherPay
	private m_OtherBill
	private m_OtherRequired
	private m_SafetyClothing
	private m_SafetyHardhard
	private m_SafetyEye
	private m_SafetyHearing
	private m_SpecialInstructions
	private m_StartDate
	private m_StopDate
	private m_ReportTo
	private m_WorkHours
	private m_TimeToReport
	private m_LunchInfo
	private m_PayRate
	private m_BillRate
	private m_Multiplier
	private m_CustomerServiceCalls
	
	'temps
	private m_Orders_StartDate
	private m_Orders_OrderDate
	private m_Customers_CustSetupBy
	private m_Customers_CustSetupDate
	private m_Orders_Reference
	private m_Orders_JobNumber
	private m_Orders_JobStatus
	private m_Orders_JobDescription
	private m_Orders_OrderTakenBy
	private m_Customers_CustomerType
	private m_Customers_CustomerName
	private m_Customers_Phone
	private m_Customers_Fax
	private m_Customers_EmailAddress
	private m_Orders_WorkSite1
	private m_Orders_WorkSite2
	private m_Orders_WorkSite3
	private m_Orders_Bill1
	private m_Orders_Bill2
	private m_Orders_Bill3
	private m_Orders_Bill4
	private m_Customers_SuspendService
	private m_Customers_ETimeCardStyle
	private m_CustomerSkillSets_SkillSetName
	private m_Orders_WorkCode1
	private m_Orders_WC1Pay
	private m_Orders_WC1Bill
	private m_Orders_WC1Required
	private m_Orders_WorkCode2
	private m_Orders_WC2Pay
	private m_Orders_WC2Bill
	private m_Orders_WC2Required
	private m_Orders_WorkCode3
	private m_Orders_WC3Pay
	private m_Orders_WC3Bill
	private m_Orders_WC3Required
	private m_Orders_WorkCode4
	private m_Orders_WC4Pay
	private m_Orders_WC4Bill
	private m_Orders_WC4Required
	private m_Orders_WorkCode5
	private m_Orders_WC5Pay
	private m_Orders_WC5Bill
	private m_Orders_WC5Required
	private m_Orders_OtherPay
	private m_Orders_OtherRequired
	private m_Orders_StopDate
	private m_NotesCustomers_Notes
	private m_Orders_RegTimePay
	private m_Orders_OTPay
	private m_Customers_Customer
	private m_Customers_TermsCode
	private m_Customers_Address
	private m_Customers_Cityline
	private m_Customers_Contact
	private m_Customers_DiscountType
	private m_Customers_SalesCode
	private m_Customers_DateLastActive
	private m_Customers_YTDInterest
	private m_Customers_YTDSales
	private m_Customers_Balance
	private m_Customers_PrintStatement
	private m_Customers_InvoiceFormat
	private m_Customers_DefaultOtFactor
	private m_Orders_RegHours
	private m_Customers_ShareAcrossLocations
	private m_Customers_Locality
	private m_Customers_LocationId
	private m_Customers_Taxable
	private m_Customers_SalesTaxExemptNo
	private m_Customers_InvoiceTaxExemptNo
	private m_Customers_CreditLimit
	private m_Orders_OTHours
	private m_Orders_StartTime
	private m_Orders_StopTime
	private m_Orders_PurchaseOrder
	private m_Orders_Subaccount
	private m_Orders_SalesCode
	private m_Orders_AdminFee
	private m_Orders_AdminCode
	private m_Orders_EmpFee
	private m_Orders_EmpCode
	private m_Orders_DiscountPercent
	private m_Orders_DiscountCode
	private m_Orders_DiscountValue
	private m_Orders_DiscountHoursDollars
	private m_Orders_AutoBillrate
	private m_Orders_AutoMethod
	private m_Orders_AutoBillFactor
	private m_Orders_InvoiceFormat
	private m_Orders_PATaxFactor
	private m_Orders_BillShiftDifferentials
	private m_Orders_FlatShiftMarkup
	private m_Orders_RemoveHistory
	private m_Orders_StatusPriorToClose
	private m_Orders_RegTimeBillings
	private m_Orders_OTBillings
	private m_Orders_OtherBill0
	private m_Orders_OtherBill1
	private m_Orders_OtherBill2
	private m_Orders_OtherBill3
	private m_Orders_OtherBill4
	private m_Orders_OtherBill5
	private m_Orders_OtherBill6
	private m_Orders_OtherPay0
	private m_Orders_OtherPay1
	private m_Orders_OtherPay2
	private m_Orders_OtherPay3
	private m_Orders_OtherPay4
	private m_Orders_OtherPay5
	private m_Orders_OtherPay6
	private m_Orders_TaxRate
	private m_Orders_OtherBill
	private m_Orders_Memo
	private m_Orders_DefaultOTBillFactor
	private m_Orders_Locality
	private m_Orders_RecordedBy
	private m_Orders_Dispatcher
	private m_Orders_NextDispatchDate
	private m_Orders_JobChangedBy
	private m_Orders_JobChangedDate
	private m_Orders_SuspendService
	private m_Orders_EmailAddress
	private m_Orders_EmailFormat
	private m_Orders_ReportTo
	private m_Orders_DirectionsParking
	private m_Orders_LocationId
	private m_Orders_IsPrivate
	private m_Orders_ContactId
	private m_Orders_EmailTimeTo
	private m_Orders_IsPerHoursAdminFee
	private m_CustomerRates_RegBill
	private m_OtherOrders_Def1
	private m_OtherOrders_Def2
	private m_OtherOrders_Def3
	private m_OtherOrders_Def4
	private m_OtherOrders_Def5
	private m_OtherOrders_Def6
	private m_OtherOrders_Def7
	private m_OtherOrders_Def8
	private m_OtherOrders_Def9
	private m_OtherOrders_Def10
	private m_OtherOrders_Def11
	private m_OtherOrders_Def12
	private m_CustomerRates_RegPay
	private m_CustomerRates_OtBill
	private m_CustomerRates_Comment
'end temps
	
		
	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		m_Site = p_Site
	end property
	
	public property get Reference()
		Reference = m_Reference
	end property
	public property let Reference(p_Reference)
		m_Reference = p_Reference
	end property
	
	public property get JobNumber()
		JobNumber = m_JobNumber
	end property
	public property let JobNumber(p_JobNumber)
		m_JobNumber  = p_JobNumber
		m_Department = p_JobNumber
	end property

	public property get JobStatus()
		JobStatus = m_JobStatus
	end property
	public property let JobStatus(p_JobStatus)
		m_JobStatus  = p_JobStatus
	end property
	
	public property get JobDescription()
		JobDescription = m_JobDescription
	end property
	public property let JobDescription(p_JobDescription)
		m_JobDescription  = p_JobDescription
	end property

	public property get Memo()
		Memo = m_Memo
	end property
	public property let Memo(p_Memo)
		m_Memo = p_Memo
	end property
	
	public property get Department()
		Department = m_Department
	end property
	public property let Department(p_Department)
		m_Department = p_Department
		m_JobNumber = p_Department
	end property
	
	public property get OrderDate()
		OrderDate = m_OrderDate
	end property
	public property let OrderDate(p_OrderDate)
		m_OrderDate = p_OrderDate
	end property
	
	public property get TimeReceived()
		TimeReceived = m_TimeReceived
	end property
	public property let TimeReceived(p_TimeReceived)
		m_TimeReceived = p_TimeReceived
	end property
	
	public property get Office()
		Office = m_Office
	end property
	public property let Office(p_Office)
		m_Office = p_Office
	end property
		
	public property get ProposalDate()
		ProposalDate = m_ProposalDate
	end property
	public property let ProposalDate(p_ProposalDate)
		m_ProposalDate = p_ProposalDate
	end property
		
		
	public property get CustomerName()
		CustomerName = m_CustomerName
	end property
	public property let CustomerName(p_CustomerName)
		m_CustomerName = p_CustomerName
	end property
		
	public property get NewClient()
		NewClient = m_NewClient
	end property
	public property let NewClient(p_NewClient)
		m_NewClient = p_NewClient 'boolean yes / no
	end property
		
	public property get Corporation ()
		Corporation  = m_Corporation 
	end property
	public property let Corporation (p_Corporation )
		m_Corporation  = p_'boolean, if no then Individual
	end property
		
	public property get CompanyName()
		CompanyName = m_CompanyName
	end property
	public property let CompanyName(p_CompanyName)
		m_CompanyName = p_CompanyName
	end property
		
	public property get OrderTakenBy()
		OrderTakenBy = m_OrderTakenBy
	end property
	public property let OrderTakenBy(p_OrderTakenBy)
		m_OrderTakenBy = p_OrderTakenBy
	end property
		
	public property get Telephone()
		Telephone = m_Telephone
	end property
	public property let Telephone(p_Telephone)
		m_Telephone = p_Telephone
	end property
		
	public property get Fax()
		Fax = m_Fax
	end property
	public property let Fax(p_Fax)
		m_Fax = p_Fax
	end property
		
	public property get Email()
		Email = m_Email
	end property
	public property let Email(p_Email)
		m_Email = p_Email
	end property
		
	public property get OrderAddress()
		OrderAddress = m_OrderAddress
	end property
	public property let OrderAddress(p_OrderAddress)
		m_OrderAddress = p_OrderAddress
	end property
		
	public property get OrderCity()
		OrderCity = m_OrderCity
	end property
	public property let OrderCity(p_OrderCity)
		m_OrderCity = p_OrderCity
	end property
		
	public property get OrderState()
		OrderState = m_OrderState
	end property
	public property let OrderState(p_OrderState)
		m_OrderState = p_OrderState
	end property
		
	public property get OrderCounty()
		OrderCounty = m_OrderCounty
	end property
	public property let OrderCounty(p_OrderCounty)
		m_OrderCounty = p_OrderCounty
	end property
		
	public property get OrderZip()
		OrderZip = m_OrderZip
	end property
	public property let OrderZip(p_OrderZip)
		m_OrderZip = p_OrderZip
	end property
		
	public property get OrderDirections()
		OrderDirections = m_OrderDirections
	end property
	public property let OrderDirections(p_OrderDirections)
		m_OrderDirections = p_OrderDirections
	end property
		
	public property get OrderBillingAddress()
		 OrderBillingAddress= m_OrderBillingAddress
	end property
	public property let OrderBillingAddress(p_OrderBillingAddress)
		m_OrderBillingAddress = p_OrderBillingAddress
	end property
		
	public property get BusinessID()
		BusinessID = m_BusinessID
	end property
	public property let BusinessID(p_BusinessID)
		m_BusinessID = p_BusinessID 'SSN or EIN
	end property
		
	public property get BankReference()
		BankReference = m_BankReference
	end property
	public property let BankReference(p_BankReference)
		m_BankReference = p_BankReference
	end property
		
	public property get SupplierReference()
		SupplierReference = m_SupplierReference
	end property
	public property let SupplierReference(p_SupplierReference)
		m_SupplierReference = p_SupplierReference
	end property
		
	public property get CreditChecked()
		CreditChecked = m_CreditChecked
	end property
	public property let CreditChecked(p_CreditChecked)
		m_CreditChecked = p_CreditChecked
	end property
		
	public property get CreditApproved()
		CreditApproved = m_CreditApproved
	end property
	public property let CreditApproved(p_CreditApproved)
		m_CreditApproved = p_CreditApproved
	end property
		
	public property get CreditComments()
		CreditComments = m_CreditComments
	end property
	public property let CreditComments(p_CreditComments)
		m_CreditComments = p_CreditComments
	end property
		
	public property get TypeOfBusiness()
		TypeOfBusiness = m_TypeOfBusiness
	end property
	public property let TypeOfBusiness(p_TypeOfBusiness)
		m_TypeOfBusiness = p_TypeOfBusiness
	end property
		
	public property get TypeOfEmployee()
		TypeOfEmployee = m_TypeOfEmployee
	end property
	public property let TypeOfEmployee(p_TypeOfEmployee)
		m_TypeOfEmployee = p_TypeOfEmployee
	end property
		
	public property get HowManyEmployees()
		HowManyEmployees = m_HowManyEmployees
	end property
	public property let HowManyEmployees(p_HowManyEmployees)
		m_HowManyEmployees = p_HowManyEmployees
	end property
		
	public property get EssentialFunctions()
		EssentialFunctions = m_EssentialFunctions
	end property
	public property let EssentialFunctions(p_EssentialFunctions)
		m_EssentialFunctions = p_EssentialFunctions 'Duties and Actions
	end property
		
	public property get SkillsRequired()
		SkillsRequired = m_SkillsRequired
	end property
	public property let SkillsRequired(p_SkillsRequired)
		m_SkillsRequired = p_SkillsRequired
	end property
		
	public property get ToolsUsed()
		ToolsUsed = m_ToolsUsed
	end property
	public property let ToolsUsed(p_ToolsUsed)
		m_ToolsUsed = p_ToolsUsed
	end property
		
	public property get ToolsRequired()
		ToolsRequired = m_ToolsRequired
	end property
	public property let ToolsRequired(p_ToolsRequired)
		m_ToolsRequired = p_
	end property
		
	public property get DressCode()
		DressCode = m_DressCode
	end property
	public property let DressCode(p_DressCode)
		m_DressCode = p_DressCode
	end property
		
	public property get PhysicalTasks()
		PhysicalTasks = m_PhysicalTasks
	end property
	public property let PhysicalTasks(p_PhysicalTasks)
		m_PhysicalTasks = p_PhysicalTasks
	end property
		
	public property get SafetyEquipment()
		SafetyEquipment = m_SafetyEquipment
	end property
	public property let SafetyEquipment(p_SafetyEquipment)
		m_SafetyEquipment = p_SafetyEquipment
	end property
		
	public property get WeightLifting()
		WeightLifting = m_WeightLifting
	end property
	public property let WeightLifting(p_WeightLifting)
		m_WeightLifting = p_RepetitiveMotion
	end property
		
	public property get BondingRequired()
		BondingRequired = m_BondingRequired
	end property
	public property let BondingRequired(p_BondingRequired)
		m_BondingRequired = p_BondingRequired
	end property
		
	public property get DriversLicenseNeeded()
		DriversLicenseNeeded = m_DriversLicenseNeeded
	end property
	public property let DriversLicenseNeeded(p_DriversLicenseNeeded)
		m_DriversLicenseNeeded = p_DriversLicenseNeeded
	end property
		
	public property get CDLRequired()
		CDLRequired = m_CDLRequired
	end property
	public property let CDLRequired(p_CDLRequired)
		m_CDLRequired = p_CDLRequired
	end property
		
	public property get WorkCompRate()
		 WorkCompRate= m_WorkCompRate
	end property
	public property let WorkCompRate(p_WorkCompRate)
		m_WorkCompRate = p_WorkCompRate
	end property
		
	public property get WorkCompCode()
		WorkCompCode = m_WorkCompCode
	end property
	public property let WorkCompCode(p_WorkCompCode)
		m_WorkCompCode = p_WorkCompCode
	end property
	public property get WorkCode1()
		WorkCode1 = m_WorkCode1
	end property
	public property let WorkCode1(p_WorkCode1)
		m_WorkCode1 = p_WorkCode1
	end property
	public property get WC1Pay()
		WC1Pay = m_WC1Pay
	end property
	public property let WC1Pay(p_WC1Pay)
		m_WC1Pay = p_WC1Pay
	end property
	public property get WC1Bill()
		WC1Bill = m_WC1Bill
	end property
	public property let WC1Bill(p_WC1Bill)
		m_WC1Bill = p_WC1Bill
	end property
	public property get WC1Required()
		WC1Required = m_WC1Required
	end property
	public property let WC1Required(p_WC1Required)
		m_WC1Required = p_WC1Required
	end property
	public property get WorkCode2()
		WorkCode2 = m_WorkCode2
	end property
	public property let WorkCode2(p_WorkCode2)
		m_WorkCode2 = p_WorkCode2
	end property
	public property get WC2Pay()
		WC2Pay = m_WC2Pay
	end property
	public property let WC2Pay(p_WC2Pay)
		m_WC2Pay = p_WC2Pay
	end property
	public property get WC2Bill()
		WC2Bill = m_WC2Bill
	end property
	public property let WC2Bill(p_WC2Bill)
		m_WC2Bill = p_WC2Bill
	end property
	public property get WC2Required()
		WC2Required = m_WC2Required
	end property
	public property let WC2Required(p_WC2Required)
		m_WC2Required = p_WC2Required
	end property
	public property get WorkCode3()
		WorkCode3 = m_WorkCode3
	end property
	public property let WorkCode3(p_WorkCode3)
		m_WorkCode3 = p_WorkCode3
	end property
		
	public property get WC3Pay()
		WC3Pay = m_WC3Pay
	end property
	public property let WC3Pay(p_WC3Pay)
		m_WC3Pay = p_WC3Pay
	end property
		
	public property get WC3Bill()
		WC3Bill = m_WC3Bill
	end property
	public property let WC3Bill(p_WC3Bill)
		m_WC3Bill = p_WC3Bill
	end property
		
	public property get WC3Required()
		WC3Required = m_WC3Required
	end property
	public property let WC3Required(p_WC3Required)
		m_WC3Required = p_WC3Required
	end property
	public property get WorkCode4()
		WorkCode4 = m_WorkCode4
	end property
	public property let WorkCode4(p_WorkCode4)
		m_WorkCode4 = p_WorkCode4
	end property
		
	public property get WC4Pay()
		WC4Pay = m_WC4Pay
	end property
	public property let WC4Pay(p_WC4Pay)
		m_WC4Pay = p_WC4Pay
	end property
		
	public property get WC4Bill()
		WC4Bill = m_WC4Bill
	end property
	public property let WC4Bill(p_WC4Bill)
		m_WC4Bill = p_WC4Bill
	end property
	public property get WC4Required()
		WC4Required = m_WC4Required
	end property
	public property let WC4Required(p_WC4Required)
		m_WC4Required = p_WC4Required
	end property
	public property get WorkCode5()
		WorkCode5 = m_WorkCode5
	end property
	public property let WorkCode5(p_WorkCode5)
		m_WorkCode5 = p_WorkCode5
	end property
	public property get WC5Pay()
		 WC5Pay= m_WC5Pay
	end property
	public property let WC5Pay(p_WC5Pay)
		m_WC5Pay = p_WC5Pay
	end property

	public property get WC5Bill()
		WC5Bill = m_WC5Bill
	end property
	public property let WC5Bill(p_WC5Bill)
		m_WC5Bill = p_WC5Bill
	end property
	public property get WC5Required()
		WC5Required = m_WC5Required
	end property
	public property let WC5Required(p_WC5Required)
		m_WC5Required = p_WC5Required
	end property
	public property get OtherPay()
		OtherPay = m_OtherPay
	end property
	public property let OtherPay(p_OtherPay)
		m_OtherPay = p_OtherPay
	end property
	public property get OtherBill()
		OtherBill = m_OtherBill
	end property
	public property let OtherBill(p_OtherBill)
		m_OtherBill = p_OtherBill
	end property
	
	public property get OtherRequired()
		OtherRequired = m_OtherRequired
	end property
	public property let OtherRequired(p_OtherRequired)
		m_OtherRequired = p_OtherRequired
	end property
	
	public property get SafetyClothing()
		SafetyClothing = m_SafetyClothing
	end property
	public property let SafetyClothing(p_SafetyClothing)
		m_SafetyClothing = p_SafetyClothing
	end property
		
	public property get SafetyHardhard()
		SafetyHardHat = m_SafetyHardHat
	end property
	public property let SafetyHardHat(p_SafetyHardHat)
		m_SafetyHardHat = p_SafetyHardhard
	end property
		
	public property get SafetyEye()
		SafetyEye = m_SafetyEye
	end property
	public property let SafetyEye(p_SafetyEye)
		m_SafetyEye = p_SafetyEye
	end property
		
	public property get SafetyHearing()
		SafetyHearing = m_SafetyHearing
	end property
	public property let SafetyHearing(p_SafetyHearing)
		m_SafetyHearing = p_SafetyHearing
	end property
		
	public property get SpecialInstructions()
		SpecialInstructions = m_SpecialInstructions
	end property
	public property let SpecialInstructions(p_SpecialInstructions)
		m_SpecialInstructions = p_SpecialInstructions
	end property
		
	public property get StartDate()
		StartDate = m_StartDate
	end property
	public property let StartDate(p_StartDate)
		m_StartDate = p_StartDate
	end property
		
	public property get StopDate()
		StopDate = m_StopDate
	end property
	public property let StopDate(p_StopDate)
		m_StopDate = p_StopDate
	end property
		
	public property get ReportTo()
		ReportTo = m_ReportTo
	end property
	public property let ReportTo(p_ReportTo)
		m_ReportTo = p_ReportTo
	end property
		
	public property get WorkHours()
		WorkHours = m_WorkHours
	end property
	public property let WorkHours(p_WorkHours)
		m_WorkHours = p_WorkHours
	end property
		
	public property get TimeToReport()
		TimeToReport = m_TimeToReport
	end property
	public property let TimeToReport(p_TimeToReport)
		m_TimeToReport = p_TimeToReport
	end property
		
	public property get LunchInfo()
		LunchInfo = m_LunchInfo
	end property
	public property let LunchInfo(p_LunchInfo)
		m_LunchInfo = p_LunchInfo
	end property
		
	public property get PayRate()
		PayRate = m_PayRate
	end property
	public property let PayRate(p_PayRate)
		m_PayRate = p_PayRate
	end property
		
	public property get BillRate()
		BillRate = m_BillRate
	end property
	public property let BillRate(p_BillRate)
		m_BillRate = p_BillRate
	end property
		
	public property get Multiplier()
		Multiplier = m_Multiplier
	end property
	public property let Multiplier(p_Multiplier)
		m_Multiplier = p_Multiplier
	end property
		
	public property get CustomerServiceCalls()
		 CustomerServiceCalls = m_CustomerServiceCalls
	end property
	public property let CustomerServiceCalls(p_CustomerServiceCalls)
		m_CustomerServiceCalls = p_CustomerServiceCalls
	end property
	
	'begin temps
	public property get Orders_StartDate()
		Orders_StartDate = m_Orders_StartDate
	end property
	public property let Orders_StartDate(p_Orders_StartDate)
		m_Orders_StartDate = p_Orders_StartDate
	end property

	public property get Orders_OrderDate()
		Orders_OrderDate = m_Orders_OrderDate
	end property
	public property let Orders_OrderDate(p_Orders_OrderDate)
		m_Orders_OrderDate = p_Orders_OrderDate
	end property

	public property get Customers_CustSetupBy()
		Customers_CustSetupBy = m_Customers_CustSetupBy
	end property
	public property let Customers_CustSetupBy(p_Customers_CustSetupBy)
		m_Customers_CustSetupBy = p_Customers_CustSetupBy
	end property

	public property get Customers_CustSetupDate()
		Customers_CustSetupDate = m_Customers_CustSetupDate
	end property
	public property let Customers_CustSetupDate(p_Customers_CustSetupDate)
		m_Customers_CustSetupDate = p_Customers_CustSetupDate
	end property

	public property get Orders_Reference()
		Orders_Reference = m_Orders_Reference
	end property
	public property let Orders_Reference(p_Orders_Reference)
		m_Orders_Reference = p_Orders_Reference
	end property

	public property get Orders_JobNumber()
		Orders_JobNumber = m_Orders_JobNumber
	end property
	public property let Orders_JobNumber(p_Orders_JobNumber)
		m_Orders_JobNumber = p_Orders_JobNumber
	end property

	public property get Orders_JobStatus()
		Orders_JobStatus = m_Orders_JobStatus
	end property
	public property let Orders_JobStatus(p_Orders_JobStatus)
		m_Orders_JobStatus = p_Orders_JobStatus
	end property

	public property get Orders_JobDescription()
		Orders_JobDescription = m_Orders_JobDescription
	end property
	public property let Orders_JobDescription(p_Orders_JobDescription)
		m_Orders_JobDescription = p_Orders_JobDescription
	end property

	public property get Orders_OrderTakenBy()
		Orders_OrderTakenBy = m_Orders_OrderTakenBy
	end property
	public property let Orders_OrderTakenBy(p_Orders_OrderTakenBy)
		m_Orders_OrderTakenBy = p_Orders_OrderTakenBy
	end property

	public property get Customers_CustomerType()
		Customers_CustomerType = m_Customers_CustomerType
	end property
	public property let Customers_CustomerType(p_Customers_CustomerType)
		m_Customers_CustomerType = p_Customers_CustomerType
	end property

	public property get Customers_CustomerName()
		Customers_CustomerName = m_Customers_CustomerName
	end property
	public property let Customers_CustomerName(p_Customers_CustomerName)
		m_Customers_CustomerName = p_Customers_CustomerName
	end property

	public property get Customers_Phone()
		Customers_Phone = m_Customers_Phone
	end property
	public property let Customers_Phone(p_Customers_Phone)
		m_Customers_Phone = p_Customers_Phone
	end property

	public property get Customers_Fax()
		Customers_Fax = m_Customers_Fax
	end property
	public property let Customers_Fax(p_Customers_Fax)
		m_Customers_Fax = p_Customers_Fax
	end property

	public property get Customers_EmailAddress()
		Customers_EmailAddress = m_Customers_EmailAddress
	end property
	public property let Customers_EmailAddress(p_Customers_EmailAddress)
		m_Customers_EmailAddress = p_Customers_EmailAddress
	end property

	public property get Orders_WorkSite1()
		Orders_WorkSite1 = m_Orders_WorkSite1
	end property
	public property let Orders_WorkSite1(p_Orders_WorkSite1)
		m_Orders_WorkSite1 = p_Orders_WorkSite1
	end property

	public property get Orders_WorkSite2()
		Orders_WorkSite2 = m_Orders_WorkSite2
	end property
	public property let Orders_WorkSite2(p_Orders_WorkSite2)
		m_Orders_WorkSite2 = p_Orders_WorkSite2
	end property

	public property get Orders_WorkSite3()
		Orders_WorkSite3 = m_Orders_WorkSite3
	end property
	public property let Orders_WorkSite3(p_Orders_WorkSite3)
		m_Orders_WorkSite3 = p_Orders_WorkSite3
	end property

	public property get Orders_Bill1()
		Orders_Bill1 = m_Orders_Bill1
	end property
	public property let Orders_Bill1(p_Orders_Bill1)
		m_Orders_Bill1 = p_Orders_Bill1
	end property

	public property get Orders_Bill2()
		Orders_Bill2 = m_Orders_Bill2
	end property
	public property let Orders_Bill2(p_Orders_Bill2)
		m_Orders_Bill2 = p_Orders_Bill2
	end property

	public property get Orders_Bill3()
		Orders_Bill3 = m_Orders_Bill3
	end property
	public property let Orders_Bill3(p_Orders_Bill3)
		m_Orders_Bill3 = p_Orders_Bill3
	end property

	public property get Orders_Bill4()
		Orders_Bill4 = m_Orders_Bill4
	end property
	public property let Orders_Bill4(p_Orders_Bill4)
		m_Orders_Bill4 = p_Orders_Bill4
	end property

	public property get Customers_SuspendService()
		Customers_SuspendService = m_Customers_SuspendService
	end property
	public property let Customers_SuspendService(p_Customers_SuspendService)
		m_Customers_SuspendService = p_Customers_SuspendService
	end property

	public property get Customers_ETimeCardStyle()
		Customers_ETimeCardStyle = m_Customers_ETimeCardStyle
	end property
	public property let Customers_ETimeCardStyle(p_Customers_ETimeCardStyle)
		m_Customers_ETimeCardStyle = p_Customers_ETimeCardStyle
	end property

	public property get CustomerSkillSets_SkillSetName()
		CustomerSkillSets_SkillSetName = m_CustomerSkillSets_SkillSetName
	end property
	public property let CustomerSkillSets_SkillSetName(p_CustomerSkillSets_SkillSetName)
		m_CustomerSkillSets_SkillSetName = p_CustomerSkillSets_SkillSetName
	end property

	public property get Orders_WorkCode1()
		Orders_WorkCode1 = m_Orders_WorkCode1
	end property
	public property let Orders_WorkCode1(p_Orders_WorkCode1)
		m_Orders_WorkCode1 = p_Orders_WorkCode1
	end property

	public property get Orders_WC1Pay()
		Orders_WC1Pay = m_Orders_WC1Pay
	end property
	public property let Orders_WC1Pay(p_Orders_WC1Pay)
		m_Orders_WC1Pay = p_Orders_WC1Pay
	end property

	public property get Orders_WC1Bill()
		Orders_WC1Bill = m_Orders_WC1Bill
	end property
	public property let Orders_WC1Bill(p_Orders_WC1Bill)
		m_Orders_WC1Bill = p_Orders_WC1Bill
	end property

	public property get Orders_WC1Required()
		Orders_WC1Required = m_Orders_WC1Required
	end property
	public property let Orders_WC1Required(p_Orders_WC1Required)
		m_Orders_WC1Required = p_Orders_WC1Required
	end property
	
	public property get Orders_Customer()
		Orders_Customer = m_Orders_Customer
	end property
	public property let Orders_Customer(p_Orders_Customer)
		m_Orders_Customer = p_Orders_Customer
	end property
	
	public property get Orders_WorkCode2()
		Orders_WorkCode2 = m_Orders_WorkCode2
	end property
	public property let Orders_WorkCode2(p_Orders_WorkCode2)
		m_Orders_WorkCode2 = p_Orders_WorkCode2
	end property

	public property get Orders_WC2Pay()
		Orders_WC2Pay = m_Orders_WC2Pay
	end property
	public property let Orders_WC2Pay(p_Orders_WC2Pay)
		m_Orders_WC2Pay = p_Orders_WC2Pay
	end property

	public property get Orders_WC2Bill()
		Orders_WC2Bill = m_Orders_WC2Bill
	end property
	public property let Orders_WC2Bill(p_Orders_WC2Bill)
		m_Orders_WC2Bill = p_Orders_WC2Bill
	end property

	public property get Orders_WC2Required()
		Orders_WC2Required = m_Orders_WC2Required
	end property
	public property let Orders_WC2Required(p_Orders_WC2Required)
		m_Orders_WC2Required = p_Orders_WC2Required
	end property

	public property get Orders_WorkCode3()
		Orders_WorkCode3 = m_Orders_WorkCode3
	end property
	public property let Orders_WorkCode3(p_Orders_WorkCode3)
		m_Orders_WorkCode3 = p_Orders_WorkCode3
	end property

	public property get Orders_WC3Pay()
		Orders_WC3Pay = m_Orders_WC3Pay
	end property
	public property let Orders_WC3Pay(p_Orders_WC3Pay)
		m_Orders_WC3Pay = p_Orders_WC3Pay
	end property

	public property get Orders_WC3Bill()
		Orders_WC3Bill = m_Orders_WC3Bill
	end property
	public property let Orders_WC3Bill(p_Orders_WC3Bill)
		m_Orders_WC3Bill = p_Orders_WC3Bill
	end property

	public property get Orders_WC3Required()
		Orders_WC3Required = m_Orders_WC3Required
	end property
	public property let Orders_WC3Required(p_Orders_WC3Required)
		m_Orders_WC3Required = p_Orders_WC3Required
	end property

	public property get Orders_WorkCode4()
		Orders_WorkCode4 = m_Orders_WorkCode4
	end property
	public property let Orders_WorkCode4(p_Orders_WorkCode4)
		m_Orders_WorkCode4 = p_Orders_WorkCode4
	end property

	public property get Orders_WC4Pay()
		Orders_WC4Pay = m_Orders_WC4Pay
	end property
	public property let Orders_WC4Pay(p_Orders_WC4Pay)
		m_Orders_WC4Pay = p_Orders_WC4Pay
	end property

	public property get Orders_WC4Bill()
		Orders_WC4Bill = m_Orders_WC4Bill
	end property
	public property let Orders_WC4Bill(p_Orders_WC4Bill)
		m_Orders_WC4Bill = p_Orders_WC4Bill
	end property

	public property get Orders_WC4Required()
		Orders_WC4Required = m_Orders_WC4Required
	end property
	public property let Orders_WC4Required(p_Orders_WC4Required)
		m_Orders_WC4Required = p_Orders_WC4Required
	end property

	public property get Orders_WorkCode5()
		Orders_WorkCode5 = m_Orders_WorkCode5
	end property
	public property let Orders_WorkCode5(p_Orders_WorkCode5)
		m_Orders_WorkCode5 = p_Orders_WorkCode5
	end property

	public property get Orders_WC5Pay()
		Orders_WC5Pay = m_Orders_WC5Pay
	end property
	public property let Orders_WC5Pay(p_Orders_WC5Pay)
		m_Orders_WC5Pay = p_Orders_WC5Pay
	end property

	public property get Orders_WC5Bill()
		Orders_WC5Bill = m_Orders_WC5Bill
	end property
	public property let Orders_WC5Bill(p_Orders_WC5Bill)
		m_Orders_WC5Bill = p_Orders_WC5Bill
	end property

	public property get Orders_WC5Required()
		Orders_WC5Required = m_Orders_WC5Required
	end property
	public property let Orders_WC5Required(p_Orders_WC5Required)
		m_Orders_WC5Required = p_Orders_WC5Required
	end property

	public property get Orders_OtherPay()
		Orders_OtherPay = m_Orders_OtherPay
	end property
	public property let Orders_OtherPay(p_Orders_OtherPay)
		m_Orders_OtherPay = p_Orders_OtherPay
	end property

	public property get Orders_OtherRequired()
		Orders_OtherRequired = m_Orders_OtherRequired
	end property
	public property let Orders_OtherRequired(p_Orders_OtherRequired)
		m_Orders_OtherRequired = p_Orders_OtherRequired
	end property

	public property get Orders_StopDate()
		Orders_StopDate = m_Orders_StopDate
	end property
	public property let Orders_StopDate(p_Orders_StopDate)
		m_Orders_StopDate = p_Orders_StopDate
	end property

	public property get NotesCustomers_Notes()
		NotesCustomers_Notes = m_NotesCustomers_Notes
	end property
	public property let NotesCustomers_Notes(p_NotesCustomers_Notes)
		m_NotesCustomers_Notes = p_NotesCustomers_Notes
	end property

	public property get Orders_RegTimePay()
		Orders_RegTimePay = m_Orders_RegTimePay
	end property
	public property let Orders_RegTimePay(p_Orders_RegTimePay)
		m_Orders_RegTimePay = p_Orders_RegTimePay
	end property

	public property get Orders_OTPay()
		Orders_OTPay = m_Orders_OTPay
	end property
	public property let Orders_OTPay(p_Orders_OTPay)
		m_Orders_OTPay = p_Orders_OTPay
	end property

	public property get Customers_Customer()
		Customers_Customer = m_Customers_Customer
	end property
	public property let Customers_Customer(p_Customers_Customer)
		m_Customers_Customer = p_Customers_Customer
	end property

	public property get Customers_TermsCode()
		Customers_TermsCode = m_Customers_TermsCode
	end property
	public property let Customers_TermsCode(p_Customers_TermsCode)
		m_Customers_TermsCode = p_Customers_TermsCode
	end property

	public property get Customers_Address()
		Customers_Address = m_Customers_Address
	end property
	public property let Customers_Address(p_Customers_Address)
		m_Customers_Address = p_Customers_Address
	end property

	public property get Customers_Cityline()
		Customers_Cityline = m_Customers_Cityline
	end property
	public property let Customers_Cityline(p_Customers_Cityline)
		m_Customers_Cityline = p_Customers_Cityline
	end property

	public property get Customers_Contact()
		Customers_Contact = m_Customers_Contact
	end property
	public property let Customers_Contact(p_Customers_Contact)
		m_Customers_Contact = p_Customers_Contact
	end property

	public property get Customers_DiscountType()
		Customers_DiscountType = m_Customers_DiscountType
	end property
	public property let Customers_DiscountType(p_Customers_DiscountType)
		m_Customers_DiscountType = p_Customers_DiscountType
	end property

	public property get Customers_SalesCode()
		Customers_SalesCode = m_Customers_SalesCode
	end property
	public property let Customers_SalesCode(p_Customers_SalesCode)
		m_Customers_SalesCode = p_Customers_SalesCode
	end property

	public property get Customers_DateLastActive()
		Customers_DateLastActive = m_Customers_DateLastActive
	end property
	public property let Customers_DateLastActive(p_Customers_DateLastActive)
		m_Customers_DateLastActive = p_Customers_DateLastActive
	end property

	public property get Customers_YTDInterest()
		Customers_YTDInterest = m_Customers_YTDInterest
	end property
	public property let Customers_YTDInterest(p_Customers_YTDInterest)
		m_Customers_YTDInterest = p_Customers_YTDInterest
	end property

	public property get Customers_YTDSales()
		Customers_YTDSales = m_Customers_YTDSales
	end property
	public property let Customers_YTDSales(p_Customers_YTDSales)
		m_Customers_YTDSales = p_Customers_YTDSales
	end property

	public property get Customers_Balance()
		Customers_Balance = m_Customers_Balance
	end property
	public property let Customers_Balance(p_Customers_Balance)
		m_Customers_Balance = p_Customers_Balance
	end property

	public property get Customers_PrintStatement()
		Customers_PrintStatement = m_Customers_PrintStatement
	end property
	public property let Customers_PrintStatement(p_Customers_PrintStatement)
		m_Customers_PrintStatement = p_Customers_PrintStatement
	end property

	public property get Customers_InvoiceFormat()
		Customers_InvoiceFormat = m_Customers_InvoiceFormat
	end property
	public property let Customers_InvoiceFormat(p_Customers_InvoiceFormat)
		m_Customers_InvoiceFormat = p_Customers_InvoiceFormat
	end property

	public property get Customers_DefaultOtFactor()
		Customers_DefaultOtFactor = m_Customers_DefaultOtFactor
	end property
	public property let Customers_DefaultOtFactor(p_Customers_DefaultOtFactor)
		m_Customers_DefaultOtFactor = p_Customers_DefaultOtFactor
	end property

	public property get Orders_RegHours()
		Orders_RegHours = m_Orders_RegHours
	end property
	public property let Orders_RegHours(p_Orders_RegHours)
		m_Orders_RegHours = p_Orders_RegHours
	end property

	public property get Customers_ShareAcrossLocations()
		Customers_ShareAcrossLocations = m_Customers_ShareAcrossLocations
	end property
	public property let Customers_ShareAcrossLocations(p_Customers_ShareAcrossLocations)
		m_Customers_ShareAcrossLocations = p_Customers_ShareAcrossLocations
	end property

	public property get Customers_Locality()
		Customers_Locality = m_Customers_Locality
	end property
	public property let Customers_Locality(p_Customers_Locality)
		m_Customers_Locality = p_Customers_Locality
	end property

	public property get Customers_LocationId()
		Customers_LocationId = m_Customers_LocationId
	end property
	public property let Customers_LocationId(p_Customers_LocationId)
		m_Customers_LocationId = p_Customers_LocationId
	end property

	public property get Customers_Taxable()
		Customers_Taxable = m_Customers_Taxable
	end property
	public property let Customers_Taxable(p_Customers_Taxable)
		m_Customers_Taxable = p_Customers_Taxable
	end property

	public property get Customers_SalesTaxExemptNo()
		Customers_SalesTaxExemptNo = m_Customers_SalesTaxExemptNo
	end property
	public property let Customers_SalesTaxExemptNo(p_Customers_SalesTaxExemptNo)
		m_Customers_SalesTaxExemptNo = p_Customers_SalesTaxExemptNo
	end property

	public property get Customers_InvoiceTaxExemptNo()
		Customers_InvoiceTaxExemptNo = m_Customers_InvoiceTaxExemptNo
	end property
	public property let Customers_InvoiceTaxExemptNo(p_Customers_InvoiceTaxExemptNo)
		m_Customers_InvoiceTaxExemptNo = p_Customers_InvoiceTaxExemptNo
	end property

	public property get Customers_CreditLimit()
		Customers_CreditLimit = m_Customers_CreditLimit
	end property
	public property let Customers_CreditLimit(p_Customers_CreditLimit)
		m_Customers_CreditLimit = p_Customers_CreditLimit
	end property

	public property get Orders_OTHours()
		Orders_OTHours = m_Orders_OTHours
	end property
	public property let Orders_OTHours(p_Orders_OTHours)
		m_Orders_OTHours = p_Orders_OTHours
	end property

	public property get Orders_StartTime()
		Orders_StartTime = m_Orders_StartTime
	end property
	public property let Orders_StartTime(p_Orders_StartTime)
		m_Orders_StartTime = p_Orders_StartTime
	end property

	public property get Orders_StopTime()
		Orders_StopTime = m_Orders_StopTime
	end property
	public property let Orders_StopTime(p_Orders_StopTime)
		m_Orders_StopTime = p_Orders_StopTime
	end property

	public property get Orders_PurchaseOrder()
		Orders_PurchaseOrder = m_Orders_PurchaseOrder
	end property
	public property let Orders_PurchaseOrder(p_Orders_PurchaseOrder)
		m_Orders_PurchaseOrder = p_Orders_PurchaseOrder
	end property

	public property get Orders_Subaccount()
		Orders_Subaccount = m_Orders_Subaccount
	end property
	public property let Orders_Subaccount(p_Orders_Subaccount)
		m_Orders_Subaccount = p_Orders_Subaccount
	end property

	public property get Orders_SalesCode()
		Orders_SalesCode = m_Orders_SalesCode
	end property
	public property let Orders_SalesCode(p_Orders_SalesCode)
		m_Orders_SalesCode = p_Orders_SalesCode
	end property

	public property get Orders_AdminFee()
		Orders_AdminFee = m_Orders_AdminFee
	end property
	public property let Orders_AdminFee(p_Orders_AdminFee)
		m_Orders_AdminFee = p_Orders_AdminFee
	end property

	public property get Orders_AdminCode()
		Orders_AdminCode = m_Orders_AdminCode
	end property
	public property let Orders_AdminCode(p_Orders_AdminCode)
		m_Orders_AdminCode = p_Orders_AdminCode
	end property

	public property get Orders_EmpFee()
		Orders_EmpFee = m_Orders_EmpFee
	end property
	public property let Orders_EmpFee(p_Orders_EmpFee)
		m_Orders_EmpFee = p_Orders_EmpFee
	end property

	public property get Orders_EmpCode()
		Orders_EmpCode = m_Orders_EmpCode
	end property
	public property let Orders_EmpCode(p_Orders_EmpCode)
		m_Orders_EmpCode = p_Orders_EmpCode
	end property

	public property get Orders_DiscountPercent()
		Orders_DiscountPercent = m_Orders_DiscountPercent
	end property
	public property let Orders_DiscountPercent(p_Orders_DiscountPercent)
		m_Orders_DiscountPercent = p_Orders_DiscountPercent
	end property

	public property get Orders_DiscountCode()
		Orders_DiscountCode = m_Orders_DiscountCode
	end property
	public property let Orders_DiscountCode(p_Orders_DiscountCode)
		m_Orders_DiscountCode = p_Orders_DiscountCode
	end property

	public property get Orders_DiscountValue()
		Orders_DiscountValue = m_Orders_DiscountValue
	end property
	public property let Orders_DiscountValue(p_Orders_DiscountValue)
		m_Orders_DiscountValue = p_Orders_DiscountValue
	end property

	public property get Orders_DiscountHoursDollars()
		Orders_DiscountHoursDollars = m_Orders_DiscountHoursDollars
	end property
	public property let Orders_DiscountHoursDollars(p_Orders_DiscountHoursDollars)
		m_Orders_DiscountHoursDollars = p_Orders_DiscountHoursDollars
	end property

	public property get Orders_AutoBillrate()
		Orders_AutoBillrate = m_Orders_AutoBillrate
	end property
	public property let Orders_AutoBillrate(p_Orders_AutoBillrate)
		m_Orders_AutoBillrate = p_Orders_AutoBillrate
	end property

	public property get Orders_AutoMethod()
		Orders_AutoMethod = m_Orders_AutoMethod
	end property
	public property let Orders_AutoMethod(p_Orders_AutoMethod)
		m_Orders_AutoMethod = p_Orders_AutoMethod
	end property

	public property get Orders_AutoBillFactor()
		Orders_AutoBillFactor = m_Orders_AutoBillFactor
	end property
	public property let Orders_AutoBillFactor(p_Orders_AutoBillFactor)
		m_Orders_AutoBillFactor = p_Orders_AutoBillFactor
	end property

	public property get Orders_InvoiceFormat()
		Orders_InvoiceFormat = m_Orders_InvoiceFormat
	end property
	public property let Orders_InvoiceFormat(p_Orders_InvoiceFormat)
		m_Orders_InvoiceFormat = p_Orders_InvoiceFormat
	end property

	public property get Orders_PATaxFactor()
		Orders_PATaxFactor = m_Orders_PATaxFactor
	end property
	public property let Orders_PATaxFactor(p_Orders_PATaxFactor)
		m_Orders_PATaxFactor = p_Orders_PATaxFactor
	end property

	public property get Orders_BillShiftDifferentials()
		Orders_BillShiftDifferentials = m_Orders_BillShiftDifferentials
	end property
	public property let Orders_BillShiftDifferentials(p_Orders_BillShiftDifferentials)
		m_Orders_BillShiftDifferentials = p_Orders_BillShiftDifferentials
	end property

	public property get Orders_FlatShiftMarkup()
		Orders_FlatShiftMarkup = m_Orders_FlatShiftMarkup
	end property
	public property let Orders_FlatShiftMarkup(p_Orders_FlatShiftMarkup)
		m_Orders_FlatShiftMarkup = p_Orders_FlatShiftMarkup
	end property

	public property get Orders_RemoveHistory()
		Orders_RemoveHistory = m_Orders_RemoveHistory
	end property
	public property let Orders_RemoveHistory(p_Orders_RemoveHistory)
		m_Orders_RemoveHistory = p_Orders_RemoveHistory
	end property

	public property get Orders_StatusPriorToClose()
		Orders_StatusPriorToClose = m_Orders_StatusPriorToClose
	end property
	public property let Orders_StatusPriorToClose(p_Orders_StatusPriorToClose)
		m_Orders_StatusPriorToClose = p_Orders_StatusPriorToClose
	end property

	public property get Orders_RegTimeBillings()
		Orders_RegTimeBillings = m_Orders_RegTimeBillings
	end property
	public property let Orders_RegTimeBillings(p_Orders_RegTimeBillings)
		m_Orders_RegTimeBillings = p_Orders_RegTimeBillings
	end property

	public property get Orders_OTBillings()
		Orders_OTBillings = m_Orders_OTBillings
	end property
	public property let Orders_OTBillings(p_Orders_OTBillings)
		m_Orders_OTBillings = p_Orders_OTBillings
	end property

	public property get Orders_OtherBill0()
		Orders_OtherBill0 = m_Orders_OtherBill0
	end property
	public property let Orders_OtherBill0(p_Orders_OtherBill0)
		m_Orders_OtherBill0 = p_Orders_OtherBill0
	end property

	public property get Orders_OtherBill1()
		Orders_OtherBill1 = m_Orders_OtherBill1
	end property
	public property let Orders_OtherBill1(p_Orders_OtherBill1)
		m_Orders_OtherBill1 = p_Orders_OtherBill1
	end property

	public property get Orders_OtherBill2()
		Orders_OtherBill2 = m_Orders_OtherBill2
	end property
	public property let Orders_OtherBill2(p_Orders_OtherBill2)
		m_Orders_OtherBill2 = p_Orders_OtherBill2
	end property

	public property get Orders_OtherBill3()
		Orders_OtherBill3 = m_Orders_OtherBill3
	end property
	public property let Orders_OtherBill3(p_Orders_OtherBill3)
		m_Orders_OtherBill3 = p_Orders_OtherBill3
	end property

	public property get Orders_OtherBill4()
		Orders_OtherBill4 = m_Orders_OtherBill4
	end property
	public property let Orders_OtherBill4(p_Orders_OtherBill4)
		m_Orders_OtherBill4 = p_Orders_OtherBill4
	end property

	public property get Orders_OtherBill5()
		Orders_OtherBill5 = m_Orders_OtherBill5
	end property
	public property let Orders_OtherBill5(p_Orders_OtherBill5)
		m_Orders_OtherBill5 = p_Orders_OtherBill5
	end property

	public property get Orders_OtherBill6()
		Orders_OtherBill6 = m_Orders_OtherBill6
	end property
	public property let Orders_OtherBill6(p_Orders_OtherBill6)
		m_Orders_OtherBill6 = p_Orders_OtherBill6
	end property

	public property get Orders_OtherPay0()
		Orders_OtherPay0 = m_Orders_OtherPay0
	end property
	public property let Orders_OtherPay0(p_Orders_OtherPay0)
		m_Orders_OtherPay0 = p_Orders_OtherPay0
	end property

	public property get Orders_OtherPay1()
		Orders_OtherPay1 = m_Orders_OtherPay1
	end property
	public property let Orders_OtherPay1(p_Orders_OtherPay1)
		m_Orders_OtherPay1 = p_Orders_OtherPay1
	end property

	public property get Orders_OtherPay2()
		Orders_OtherPay2 = m_Orders_OtherPay2
	end property
	public property let Orders_OtherPay2(p_Orders_OtherPay2)
		m_Orders_OtherPay2 = p_Orders_OtherPay2
	end property

	public property get Orders_OtherPay3()
		Orders_OtherPay3 = m_Orders_OtherPay3
	end property
	public property let Orders_OtherPay3(p_Orders_OtherPay3)
		m_Orders_OtherPay3 = p_Orders_OtherPay3
	end property

	public property get Orders_OtherPay4()
		Orders_OtherPay4 = m_Orders_OtherPay4
	end property
	public property let Orders_OtherPay4(p_Orders_OtherPay4)
		m_Orders_OtherPay4 = p_Orders_OtherPay4
	end property

	public property get Orders_OtherPay5()
		Orders_OtherPay5 = m_Orders_OtherPay5
	end property
	public property let Orders_OtherPay5(p_Orders_OtherPay5)
		m_Orders_OtherPay5 = p_Orders_OtherPay5
	end property

	public property get Orders_OtherPay6()
		Orders_OtherPay6 = m_Orders_OtherPay6
	end property
	public property let Orders_OtherPay6(p_Orders_OtherPay6)
		m_Orders_OtherPay6 = p_Orders_OtherPay6
	end property

	public property get Orders_TaxRate()
		Orders_TaxRate = m_Orders_TaxRate
	end property
	public property let Orders_TaxRate(p_Orders_TaxRate)
		m_Orders_TaxRate = p_Orders_TaxRate
	end property

	public property get Orders_OtherBill()
		Orders_OtherBill = m_Orders_OtherBill
	end property
	public property let Orders_OtherBill(p_Orders_OtherBill)
		m_Orders_OtherBill = p_Orders_OtherBill
	end property

	public property get Orders_Memo()
		Orders_Memo = m_Orders_Memo
	end property
	public property let Orders_Memo(p_Orders_Memo)
		m_Orders_Memo = p_Orders_Memo
	end property

	public property get Orders_DefaultOTBillFactor()
		Orders_DefaultOTBillFactor = m_Orders_DefaultOTBillFactor
	end property
	public property let Orders_DefaultOTBillFactor(p_Orders_DefaultOTBillFactor)
		m_Orders_DefaultOTBillFactor = p_Orders_DefaultOTBillFactor
	end property

	public property get Orders_Locality()
		Orders_Locality = m_Orders_Locality
	end property
	public property let Orders_Locality(p_Orders_Locality)
		m_Orders_Locality = p_Orders_Locality
	end property

	public property get Orders_RecordedBy()
		Orders_RecordedBy = m_Orders_RecordedBy
	end property
	public property let Orders_RecordedBy(p_Orders_RecordedBy)
		m_Orders_RecordedBy = p_Orders_RecordedBy
	end property

	public property get Orders_Dispatcher()
		Orders_Dispatcher = m_Orders_Dispatcher
	end property
	public property let Orders_Dispatcher(p_Orders_Dispatcher)
		m_Orders_Dispatcher = p_Orders_Dispatcher
	end property

	public property get Orders_NextDispatchDate()
		Orders_NextDispatchDate = m_Orders_NextDispatchDate
	end property
	public property let Orders_NextDispatchDate(p_Orders_NextDispatchDate)
		m_Orders_NextDispatchDate = p_Orders_NextDispatchDate
	end property

	public property get Orders_JobChangedBy()
		Orders_JobChangedBy = m_Orders_JobChangedBy
	end property
	public property let Orders_JobChangedBy(p_Orders_JobChangedBy)
		m_Orders_JobChangedBy = p_Orders_JobChangedBy
	end property

	public property get Orders_JobChangedDate()
		Orders_JobChangedDate = m_Orders_JobChangedDate
	end property
	public property let Orders_JobChangedDate(p_Orders_JobChangedDate)
		m_Orders_JobChangedDate = p_Orders_JobChangedDate
	end property

	public property get Orders_SuspendService()
		Orders_SuspendService = m_Orders_SuspendService
	end property
	public property let Orders_SuspendService(p_Orders_SuspendService)
		m_Orders_SuspendService = p_Orders_SuspendService
	end property

	public property get Orders_EmailAddress()
		Orders_EmailAddress = m_Orders_EmailAddress
	end property
	public property let Orders_EmailAddress(p_Orders_EmailAddress)
		m_Orders_EmailAddress = p_Orders_EmailAddress
	end property

	public property get Orders_EmailFormat()
		Orders_EmailFormat = m_Orders_EmailFormat
	end property
	public property let Orders_EmailFormat(p_Orders_EmailFormat)
		m_Orders_EmailFormat = p_Orders_EmailFormat
	end property

	public property get Orders_ReportTo()
		Orders_ReportTo = m_Orders_ReportTo
	end property
	public property let Orders_ReportTo(p_Orders_ReportTo)
		m_Orders_ReportTo = p_Orders_ReportTo
	end property

	public property get Orders_DirectionsParking()
		Orders_DirectionsParking = m_Orders_DirectionsParking
	end property
	public property let Orders_DirectionsParking(p_Orders_DirectionsParking)
		m_Orders_DirectionsParking = p_Orders_DirectionsParking
	end property

	public property get Orders_LocationId()
		Orders_LocationId = m_Orders_LocationId
	end property
	public property let Orders_LocationId(p_Orders_LocationId)
		m_Orders_LocationId = p_Orders_LocationId
	end property

	public property get Orders_IsPrivate()
		Orders_IsPrivate = m_Orders_IsPrivate
	end property
	public property let Orders_IsPrivate(p_Orders_IsPrivate)
		m_Orders_IsPrivate = p_Orders_IsPrivate
	end property

	public property get Orders_ContactId()
		Orders_ContactId = m_Orders_ContactId
	end property
	public property let Orders_ContactId(p_Orders_ContactId)
		m_Orders_ContactId = p_Orders_ContactId
	end property

	public property get Orders_EmailTimeTo()
		Orders_EmailTimeTo = m_Orders_EmailTimeTo
	end property
	public property let Orders_EmailTimeTo(p_Orders_EmailTimeTo)
		m_Orders_EmailTimeTo = p_Orders_EmailTimeTo
	end property

	public property get Orders_IsPerHoursAdminFee()
		Orders_IsPerHoursAdminFee = m_Orders_IsPerHoursAdminFee
	end property
	public property let Orders_IsPerHoursAdminFee(p_Orders_IsPerHoursAdminFee)
		m_Orders_IsPerHoursAdminFee = p_Orders_IsPerHoursAdminFee
	end property

	public property get CustomerRates_RegBill()
		CustomerRates_RegBill = m_CustomerRates_RegBill
	end property
	public property let CustomerRates_RegBill(p_CustomerRates_RegBill)
		m_CustomerRates_RegBill = p_CustomerRates_RegBill
	end property

	public property get OtherOrders_Def1()
		OtherOrders_Def1 = m_OtherOrders_Def1
	end property
	public property let OtherOrders_Def1(p_OtherOrders_Def1)
		m_OtherOrders_Def1 = p_OtherOrders_Def1
	end property

	public property get OtherOrders_Def2()
		OtherOrders_Def2 = m_OtherOrders_Def2
	end property
	public property let OtherOrders_Def2(p_OtherOrders_Def2)
		m_OtherOrders_Def2 = p_OtherOrders_Def2
	end property

	public property get OtherOrders_Def3()
		OtherOrders_Def3 = m_OtherOrders_Def3
	end property
	public property let OtherOrders_Def3(p_OtherOrders_Def3)
		m_OtherOrders_Def3 = p_OtherOrders_Def3
	end property

	public property get OtherOrders_Def4()
		OtherOrders_Def4 = m_OtherOrders_Def4
	end property
	public property let OtherOrders_Def4(p_OtherOrders_Def4)
		m_OtherOrders_Def4 = p_OtherOrders_Def4
	end property

	public property get OtherOrders_Def5()
		OtherOrders_Def5 = m_OtherOrders_Def5
	end property
	public property let OtherOrders_Def5(p_OtherOrders_Def5)
		m_OtherOrders_Def5 = p_OtherOrders_Def5
	end property

	public property get OtherOrders_Def6()
		OtherOrders_Def6 = m_OtherOrders_Def6
	end property
	public property let OtherOrders_Def6(p_OtherOrders_Def6)
		m_OtherOrders_Def6 = p_OtherOrders_Def6
	end property

	public property get OtherOrders_Def7()
		OtherOrders_Def7 = m_OtherOrders_Def7
	end property
	public property let OtherOrders_Def7(p_OtherOrders_Def7)
		m_OtherOrders_Def7 = p_OtherOrders_Def7
	end property

	public property get OtherOrders_Def8()
		OtherOrders_Def8 = m_OtherOrders_Def8
	end property
	public property let OtherOrders_Def8(p_OtherOrders_Def8)
		m_OtherOrders_Def8 = p_OtherOrders_Def8
	end property

	public property get OtherOrders_Def9()
		OtherOrders_Def9 = m_OtherOrders_Def9
	end property
	public property let OtherOrders_Def9(p_OtherOrders_Def9)
		m_OtherOrders_Def9 = p_OtherOrders_Def9
	end property

	public property get OtherOrders_Def10()
		OtherOrders_Def10 = m_OtherOrders_Def10
	end property
	public property let OtherOrders_Def10(p_OtherOrders_Def10)
		m_OtherOrders_Def10 = p_OtherOrders_Def10
	end property

	public property get OtherOrders_Def11()
		OtherOrders_Def11 = m_OtherOrders_Def11
	end property
	public property let OtherOrders_Def11(p_OtherOrders_Def11)
		m_OtherOrders_Def11 = p_OtherOrders_Def11
	end property

	public property get OtherOrders_Def12()
		OtherOrders_Def12 = m_OtherOrders_Def12
	end property
	public property let OtherOrders_Def12(p_OtherOrders_Def12)
		m_OtherOrders_Def12 = p_OtherOrders_Def12
	end property

	public property get CustomerRates_RegPay()
		CustomerRates_RegPay = m_CustomerRates_RegPay
	end property
	public property let CustomerRates_RegPay(p_CustomerRates_RegPay)
		m_CustomerRates_RegPay = p_CustomerRates_RegPay
	end property

	public property get CustomerRates_OtBill()
		CustomerRates_OtBill = m_CustomerRates_OtBill
	end property
	public property let CustomerRates_OtBill(p_CustomerRates_OtBill)
		m_CustomerRates_OtBill = p_CustomerRates_OtBill
	end property

	public property get CustomerRates_Comment()
		CustomerRates_Comment = m_CustomerRates_Comment
	end property
	public property let CustomerRates_Comment(p_CustomerRates_Comment)
		m_CustomerRates_Comment = p_CustomerRates_Comment
	end property

	
	'end temps
	
	
	REM Site
	REM Reference
	Rem JobNumber
	REM Department
	REM JobDescription
	REM OrderDate 'startdate
	REM TimeReceived 'orderdate
	REM TakenBy 'customerSetupBy
	REM Office 'reverse site
	REM ProposalDate 'define
	REM CustomerCode
	REM NewClient 'boolean yes / no 'use customer type
	REM Corporation 'use regEx to determine base on ein or ssn pattern
	REM CompanyName
	REM OrderTakenBy 'use takenby
	REM Telephone
	REM Fax
	REM Email
	REM OrderAddress 'worksite1
	REM OrderCity 'worksite 2
	REM OrderState 'worksite 2
	REM OrderCounty 'worksite 2
	REM OrderZip 'worksite 2
	REM OrderDirections 'directionstoworksite
	REM OrderBillingAddress 'define - bill1 - 4
	REM BusinessID 'SSN or EIN 'salestaxememptno or invoivetaxexmptno
	REM BankReference 'define
	REM SupplierReference 'define
	REM CreditChecked 'define, using "SuspendService" for now
	REM CreditApproved 'creditlimit available, can infer "checked and approved" from that possibly
	REM CreditComments 'define
	REM TypeOfBusiness
	REM TypeOfEmployee 'use skillsetname from 'customerskillsets' table
	REM HowManyEmployees
	REM EssentialFunctions 'Duties and Actions
	REM SkillsRequired 'seperate class
	REM ToolsUsed 'seperate class
	REM ToolsRequired 'seperate class
	REM DressCode 'define
	REM PhysicalTasks 'define
	REM SafetyEquipment 'seperate class
	REM RepetitiveMotion 'define
	REM WeightLighting 'define
	REM BondingRequired 'define
	REM DriversLicenseNeeded 'define
	REM CDLRequired 'define
	REM WorkCompRate
	REM WorkCompCode
	REM SafetyClothing 'in equipment
	REM SafetyHardhard
	REM SafetyEye
	REM SafetyHearing
	REM SpecialInstructions 'define
	REM StartDate
	REM EndDate
	REM ReportTo
	REM WorkHours ' stoptime - starttime
	REM TimeToReport 'starttime
	REM LunchInfo 'define
	REM PayRate 'CustomerRates.RegPay
	REM BillRate 'CustomerRates.RegBill
	REM Multiplier 'define
	REM CustomerServiceCalls 'define
	
		'#############  Public Functions ##############
		
		public function LoadJobOrder()
			dim strSQL
			
			
			
			strSQL = "" &_
				"SELECT Orders.StartDate, Orders.OrderDate, Customers.CustSetupBy, Customers.CustSetupDate, " &_
				"Orders.Reference, Orders.JobNumber, Orders.JobStatus, Orders.JobDescription, Orders.OrderTakenBy, " &_
				"Customers.CustomerType, Customers.CustomerName, Customers.Phone, Customers.Fax, Customers.EmailAddress, " &_
				"Orders.WorkSite1, Orders.WorkSite2, Orders.WorkSite3, Orders.Bill1, Orders.Bill2, Orders.Bill3, " &_
				"Orders.Bill4, Customers.SuspendService, Customers.ETimeCardStyle, CustomerSkillSets.SkillSetName, " &_
				"Orders.WorkCode1, Orders.WC1Pay, Orders.WC1Bill, Orders.WC1Required, Orders.WorkCode2, Orders.WC2Pay, 	" &_
				"Orders.WC2Bill, Orders.WC2Required, Orders.WorkCode3, Orders.WC3Pay, Orders.WC3Bill, Orders.WC3Required, " &_
				"Orders.WorkCode4, Orders.WC4Pay, 	Orders.WC4Bill, Orders.WC4Required, Orders.WorkCode5, Orders.WC5Pay, " &_
				"Orders.WC5Bill, Orders.WC5Required, Orders.OtherPay, 	Orders.OtherRequired, Orders.StopDate, NotesCustomers.Notes, " &_
				"Orders.RegTimePay, Orders.OTPay, Customers.Customer, Customers.TermsCode, Customers.Address, " &_
				"Customers.Cityline, Customers.Contact, Customers.DiscountType, Customers.SalesCode, Customers.DateLastActive, " &_
				"Customers.YTDInterest, Customers.YTDSales, Customers.Balance, Customers.PrintStatement, Customers.InvoiceFormat, " &_
				"Customers.DefaultOtFactor, 	Orders.RegHours, Customers.ShareAcrossLocations, Customers.Locality, " &_
				"Customers.LocationId, 	Customers.Taxable, Customers.SalesTaxExemptNo, Customers.InvoiceTaxExemptNo, " &_
				"Customers.CreditLimit, Customers.YTDInterest, 	Orders.OTHours, Orders.StartTime, Orders.StopTime, " &_
				"Orders.PurchaseOrder, Orders.Subaccount, Orders.SalesCode, Orders.AdminFee, Orders.AdminCode, " &_
				"Orders.EmpFee, Orders.EmpCode, Orders.DiscountPercent, Orders.DiscountCode, Orders.DiscountValue, " &_
				"Orders.DiscountHoursDollars,  Orders.AutoBillrate, Orders.AutoMethod, Orders.AutoBillFactor, " &_
				"Orders.InvoiceFormat, Orders.PATaxFactor, Orders.BillShiftDifferentials,  Orders.FlatShiftMarkup, " &_
				"Orders.RemoveHistory, Orders.StatusPriorToClose, Orders.RegTimeBillings, Orders.OTBillings, " &_
				"Orders.OtherBill0, Orders.OtherBill1, Orders.OtherBill2, Orders.OtherBill3, Orders.OtherBill4, " &_
				"Orders.OtherBill5, Orders.OtherBill6, Orders.OtherPay0, Orders.OtherPay1, Orders.OtherPay2, Orders.OtherPay3, " &_
				"Orders.OtherPay4, Orders.OtherPay5, Orders.OtherPay6, Orders.TaxRate, " &_
				"Orders.OtherBill, Orders.Memo, Orders.DefaultOTBillFactor, Orders.Locality, Orders.RecordedBy, " &_
				"Orders.Dispatcher, Orders.NextDispatchDate, Orders.Reference, Orders.JobChangedBy, Orders.JobChangedDate, Orders.SuspendService, " &_
				"Orders.EmailAddress, Orders.EmailFormat, Orders.ReportTo, Orders.DirectionsParking, Orders.LocationId, Orders.IsPrivate, " &_
				"Orders.ContactId, Orders.EmailTimeTo, Orders.IsPerHoursAdminFee, CustomerRates.RegBill, " &_
				"OtherOrders.Def1, OtherOrders.Def2, OtherOrders.Def3, OtherOrders.Def4, OtherOrders.Def5, OtherOrders.Def6, " &_
				"OtherOrders.Def7, OtherOrders.Def8, OtherOrders.Def9, OtherOrders.Def10, OtherOrders.Def11, OtherOrders.Def12, " &_
				"CustomerRates.RegPay, CustomerRates.OtBill, CustomerRates.Comment " &_
				"FROM OtherOrders " &_
				"RIGHT JOIN (((CustomerRates " &_
				"LEFT JOIN WorkCodes ON CustomerRates.WorkCode = WorkCodes.WorkCode) " &_
				"RIGHT JOIN (NotesCustomers RIGHT JOIN ((CustomerContacts " &_
				"RIGHT JOIN Customers ON CustomerContacts.Customer = Customers.Customer) " &_
				"LEFT JOIN CustomerSkillSets ON Customers.Customer = CustomerSkillSets.Customer) " &_
				"ON NotesCustomers.Customer = Customers.Customer) " &_
				"ON CustomerRates.Customer = Customers.Customer) " &_
				"RIGHT JOIN (NotesOrders RIGHT JOIN (((OrderEquipment " &_
				"RIGHT JOIN Orders ON OrderEquipment.Reference = Orders.Reference) " &_
				"LEFT JOIN OrderSkillSets ON Orders.Reference = OrderSkillSets.Reference) " &_
				"LEFT JOIN Equipment ON OrderEquipment.Id = Equipment.Id) " &_
				"ON NotesOrders.Reference = Orders.Reference) " &_
				"ON Customers.Customer = Orders.Customer) ON OtherOrders.Reference = Orders.Reference " &_
				"WHERE (Orders.Reference=" & me.Reference & ") AND (Orders.JobNumber=" & me.JobNumber & ");"

				
			REM "SELECT Orders.StartDate, Orders.OrderDate, Customers.CustSetupBy, Orders.Customer AS CustomerCode, Customers.CustSetupDate, " &_
				REM "Orders.Reference, Orders.JobNumber, Orders.JobStatus, Orders.JobDescription, Orders.Memo, " &_
				REM "Orders.OrderTakenBy, Orders.Customer, Customers.CustomerType, Customers.SalesTaxExemptNo, " &_
				REM "Customers.CustomerName, Customers.Phone, Customers.Fax, Customers.EmailAddress, Orders.WorkSite1, " &_
				REM "Orders.WorkSite2, Orders.WorkSite3, Orders.DirectionsParking, Orders.Bill1, Orders.Bill2, Orders.Bill3, " &_
				REM "Orders.Bill4, Customers.SalesTaxExemptNo, Customers.InvoiceTaxExemptNo, Customers.SuspendService, " &_
				REM "Customers.ETimeCardStyle, CustomerSkillSets.SkillSetName, Orders.WorkCode1, Orders.WC1Pay, " &_
				REM "Orders.WC1Bill, Orders.WC1Required, Orders.WorkCode2, Orders.WC2Pay, Orders.WC2Bill, Orders.WC2Required, " &_
				REM "Orders.WorkCode3, Orders.WC3Pay, Orders.WC3Bill, Orders.WC3Required, Orders.WorkCode4, Orders.WC4Pay, " &_
				REM "Orders.WC4Bill, Orders.WC4Required, Orders.WorkCode5, Orders.WC5Pay, Orders.WC5Bill, Orders.WC5Required, " &_
				REM "Orders.OtherPay, Orders.OtherBill, Orders.OtherRequired, Orders.StartDate, Orders.StopDate, Orders.ReportTo, " &_
				REM "Orders.RegTimePay, Orders.OTPay, Orders.RegHours, Orders.OTHours, Orders.StartTime, Orders.StopTime, " &_
				REM "CustomerRates.RegBill, CustomerRates.RegPay, CustomerRates.OtBill, CustomerRates.Comment " &_
				REM "FROM (CustomerRates LEFT JOIN WorkCodes ON CustomerRates.WorkCode = WorkCodes.WorkCode) " &_
				REM "RIGHT JOIN (NotesOrders RIGHT JOIN (NotesCustomers RIGHT JOIN (((OrderEquipment " &_
				REM "RIGHT JOIN (((CustomerContacts RIGHT JOIN Customers ON CustomerContacts.Customer = Customers.Customer) " &_
				REM "LEFT JOIN CustomerSkillSets ON Customers.Customer = CustomerSkillSets.Customer) " &_
				REM "RIGHT JOIN Orders ON Customers.Customer = Orders.Customer) ON OrderEquipment.Reference = Orders.Reference) " &_
				REM "LEFT JOIN OrderSkillSets ON Orders.Reference = OrderSkillSets.Reference) " &_
				REM "LEFT JOIN Equipment ON OrderEquipment.Id = Equipment.Id) ON NotesCustomers.Customer = Customers.Customer) " &_
				REM "ON NotesOrders.Reference = Orders.Reference) ON CustomerRates.Customer = Customers.Customer " &_
				REM "WHERE (Orders.Reference=" & me.Reference & ") AND (Orders.JobNumber=" & me.JobNumber & ");"
				

			LoadJobOrder = LoadData (strSQL)
		end function
		
		public function GetClosedOrders()

			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1 & "", "" & Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer  like """ & me.Customer & """) AND (Orders.JobStatus=2 OR Orders.JobStatus = 4);"
	
			'GetClosedOrders = LoadData (strSQL)
		end function

		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			'p_RS.PageSize = m_ItemsPerPage
			p_RS.PageSize = 1
			dim m_PageCount
			m_PageCount = p_RS.PageCount
			
			dim m_Page
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisOrderTab, id
			if not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page ) then
				with me
					.CustomerName         = p_RS.fields("CustomerName").Value 'Customer
					.JobStatus            = p_RS.fields("JobStatus").Value
					.JobNumber            = p_RS.fields("JobNumber").Value
					.Reference            = p_RS.fields("Reference").Value
					.JobDescription       = p_RS.fields("JobDescription").Value
					.Memo                 = p_RS.fields("Memo").Value
					.OrderDate            = p_RS.fields("OrderDate").value  'startdate
					'.TimeReceived         = p_RS.fields("TimeReceived").value  'orderdate
					.Office               = getCompCode(me.site) 'reverse site
					'.ProposalDate         = p_RS.fields("ProposalDate").value 'define
					'.CustomerCode         = p_RS.fields("CustomerCode").value 
					'.NewClient            = p_RS.fields("NewClient").value  'boolean yes / no 'use customer type
					'.Corporation          = p_RS.fields("Corporation").value 'use regEx to determine base on ein or ssn pattern
					'.CompanyName          = p_RS.fields("CompanyName").value 
					.OrderTakenBy         = p_RS.fields("OrderTakenBy").value 'use takenby
					'.Telephone            = p_RS.fields("Telephone").value 
					.Fax                  = p_RS.fields("Fax").value 
					'.Email                = p_RS.fields("Email").value 
					'.OrderAddress         = p_RS.fields("OrderAddress").value  'worksite1
					'.OrderCity            = p_RS.fields("OrderCity").value  'worksite 2
					'.OrderState           = p_RS.fields("OrderState").value  'worksite 2
					'.OrderCounty          = p_RS.fields("OrderCounty").value 'worksite 2
					'.OrderZip             = p_RS.fields("OrderZip").value  'worksite 2
					'.OrderDirections      = p_RS.fields("OrderDirections").value  'directionstoworksite
					'.OrderBillingAddress  = p_RS.fields("OrderBillingAddress").value 'define - bill1 - 4
					'.BusinessID           = p_RS.fields("BusinessID").value  'SSN or EIN 'salestaxememptno or invoivetaxexmptno
					'.BankReference        = p_RS.fields("BankReference").value 'define
					'.SupplierReference    = p_RS.fields("SupplierReference").value  'define
					'.CreditChecked        = p_RS.fields("CreditChecked").value  'define, using "SuspendService" for now
					'.CreditApproved       = p_RS.fields("CreditApproved").value 'creditlimit available, can infer "checked and approved" from that possibly
					'.CreditComments       = p_RS.fields("CreditComments").value 'define
					'.TypeOfBusiness       = p_RS.fields("TypeOfBusiness").value 
					'.TypeOfEmployee       = p_RS.fields("TypeOfEmployee").value  'use skillsetname from 'customerskillsets' table
					'.HowManyEmployees     = p_RS.fields("HowManyEmployees").value 
					'.EssentialFunctions   = p_RS.fields("EssentialFunctions").value  'Duties and Actions
					'.SkillsRequired       = p_RS.fields("SkillsRequired").value  'seperate class
					'.ToolsUsed            = p_RS.fields("ToolsUsed").value  'seperate class
					'.ToolsRequired        = p_RS.fields("ToolsRequired").value  'seperate class
					'.DressCode            = p_RS.fields("DressCode").value  'define
					'.PhysicalTasks        = p_RS.fields("PhysicalTasks").value  'define
					'.SafetyEquipment      = p_RS.fields("SafetyEquipment").value  'seperate class
					'.RepetitiveMotion     = p_RS.fields("RepetitiveMotion").value  'define
					'.WeightLighting       = p_RS.fields("WeightLighting").value  'define
					'.BondingRequired      = p_RS.fields("BondingRequired").value  'define
					'.DriversLicenseNeeded = p_RS.fields("DriversLicenseNeeded").value 'define
					'.CDLRequired          = p_RS.fields("CDLRequired").value  'define
					.WorkCode1 = p_RS.fields("WorkCode1").value
					.WC1Pay = p_RS.fields("WC1Pay").value
					.WC1Bill = p_RS.fields("WC1Bill").value
					.WC1Required = p_RS.fields("WC1Required").value
					.WorkCode2 = p_RS.fields("WorkCode2").value
					.WC2Pay = p_RS.fields("WC2Pay").value
					.WC2Bill = p_RS.fields("WC2Bill").value
					.WC2Required = p_RS.fields("WC2Required").value
					.WorkCode3 = p_RS.fields("WorkCode3").value
					.WC3Pay = p_RS.fields("WC3Pay").value
					.WC3Bill = p_RS.fields("WC3Bill").value
					.WC3Required = p_RS.fields("WC3Required").value
					.WorkCode4 = p_RS.fields("WorkCode4").value
					.WC4Pay = p_RS.fields("WC4Pay").value
					.WC4Bill = p_RS.fields("WC4Bill").value
					.WC4Required = p_RS.fields("WC4Required").value
					.WorkCode5 = p_RS.fields("WorkCode5").value
					.WC5Pay = p_RS.fields("WC5Pay").value
					.WC5Bill = p_RS.fields("WC5Bill").value
					.WC5Required = p_RS.fields("WC5Required").value
					.OtherPay = p_RS.fields("OtherPay").value
					.OtherBill = p_RS.fields("OtherBill").value
					.OtherRequired = p_RS.fields("OtherRequired").value
					.Orders_StartDate       = p_RS.fields("StartDate").value 'Orders_StartDate
					.Orders_OrderDate       = p_RS.fields("OrderDate").value 'Orders_OrderDate
					.Customers_CustSetupBy       = p_RS.fields("CustSetupBy").value 'Customers_CustSetupBy
					.Orders_Customer       = p_RS.fields("Customer").value 'Orders_Customer
					.Customers_CustSetupDate       = p_RS.fields("CustSetupDate").value 'Customers_CustSetupDate
					.Orders_Reference       = p_RS.fields("Reference").value 'Orders_Reference
					.Orders_JobNumber       = p_RS.fields("JobNumber").value 'Orders_JobNumber
					.Orders_JobStatus       = p_RS.fields("JobStatus").value 'Orders_JobStatus
					.Orders_JobDescription       = p_RS.fields("JobDescription").value 'Orders_JobDescription
					.Orders_Memo       = p_RS.fields("Memo").value 'Orders_Memo
					.Orders_OrderTakenBy       = p_RS.fields("OrderTakenBy").value 'Orders_OrderTakenBy
					.Orders_Customer       = p_RS.fields("Customer").value 'Orders_Customer
					.Customers_CustomerType       = p_RS.fields("CustomerType").value 'Customers_CustomerType
					.Customers_SalesTaxExemptNo       = p_RS.fields("SalesTaxExemptNo").value 'Customers_SalesTaxExemptNo
					.Customers_CustomerName       = p_RS.fields("CustomerName").value 'Customers_CustomerName
					.Customers_Phone       = p_RS.fields("Phone").value 'Customers_Phone
					.Customers_Fax       = p_RS.fields("Fax").value 'Customers_Fax
					.Customers_EmailAddress       = p_RS.fields("EmailAddress").value 'Customers_EmailAddress
					.Orders_WorkSite1       = p_RS.fields("WorkSite1").value 'Orders_WorkSite1
					.Orders_WorkSite2       = p_RS.fields("WorkSite2").value 'Orders_WorkSite2
					.Orders_WorkSite3       = p_RS.fields("WorkSite3").value 'Orders_WorkSite3
					.Orders_DirectionsParking       = p_RS.fields("DirectionsParking").value 'Orders_DirectionsParking
					.Orders_Bill1       = p_RS.fields("Bill1").value 'Orders_Bill1
					.Orders_Bill2       = p_RS.fields("Bill2").value 'Orders_Bill2
					.Orders_Bill3       = p_RS.fields("Bill3").value 'Orders_Bill3
					.Orders_Bill4       = p_RS.fields("Bill4").value 'Orders_Bill4
					.Customers_SalesTaxExemptNo       = p_RS.fields("SalesTaxExemptNo").value 'Customers_SalesTaxExemptNo
					.Customers_InvoiceTaxExemptNo       = p_RS.fields("InvoiceTaxExemptNo").value 'Customers_InvoiceTaxExemptNo
					.Customers_SuspendService       = p_RS.fields("SuspendService").value 'Customers_SuspendService
					.Customers_ETimeCardStyle       = p_RS.fields("ETimeCardStyle").value 'Customers_ETimeCardStyle
					.CustomerSkillSets_SkillSetName       = p_RS.fields("SkillSetName").value 'CustomerSkillSets_SkillSetName
					.Orders_WorkCode1       = p_RS.fields("WorkCode1").value 'Orders_WorkCode1
					.Orders_WC1Pay       = p_RS.fields("WC1Pay").value 'Orders_WC1Pay
					.Orders_WC1Bill       = p_RS.fields("WC1Bill").value 'Orders_WC1Bill
					.Orders_WC1Required       = p_RS.fields("WC1Required").value 'Orders_WC1Required
					.Orders_WorkCode2       = p_RS.fields("WorkCode2").value 'Orders_WorkCode2
					.Orders_WC2Pay       = p_RS.fields("WC2Pay").value 'Orders_WC2Pay
					.Orders_WC2Bill       = p_RS.fields("WC2Bill").value 'Orders_WC2Bill
					.Orders_WC2Required       = p_RS.fields("WC2Required").value 'Orders_WC2Required
					.Orders_WorkCode3       = p_RS.fields("WorkCode3").value 'Orders_WorkCode3
					.Orders_WC3Pay       = p_RS.fields("WC3Pay").value 'Orders_WC3Pay
					.Orders_WC3Bill       = p_RS.fields("WC3Bill").value 'Orders_WC3Bill
					.Orders_WC3Required       = p_RS.fields("WC3Required").value 'Orders_WC3Required
					.Orders_WorkCode4       = p_RS.fields("WorkCode4").value 'Orders_WorkCode4
					.Orders_WC4Pay       = p_RS.fields("WC4Pay").value 'Orders_WC4Pay
					.Orders_WC4Bill       = p_RS.fields("WC4Bill").value 'Orders_WC4Bill
					.Orders_WC4Required       = p_RS.fields("WC4Required").value 'Orders_WC4Required
					.Orders_WorkCode5       = p_RS.fields("WorkCode5").value 'Orders_WorkCode5
					.Orders_WC5Pay       = p_RS.fields("WC5Pay").value 'Orders_WC5Pay
					.Orders_WC5Bill       = p_RS.fields("WC5Bill").value 'Orders_WC5Bill
					.Orders_WC5Required       = p_RS.fields("WC5Required").value 'Orders_WC5Required
					.Orders_OtherPay       = p_RS.fields("OtherPay").value 'Orders_OtherPay
					.Orders_OtherBill       = p_RS.fields("OtherBill").value 'Orders_OtherBill
					.Orders_OtherRequired       = p_RS.fields("OtherRequired").value 'Orders_OtherRequired
					.Orders_StartDate       = p_RS.fields("StartDate").value 'Orders_StartDate
					.Orders_StopDate       = p_RS.fields("StopDate").value 'Orders_StopDate
					.Orders_ReportTo       = p_RS.fields("ReportTo").value 'Orders_ReportTo
					.Orders_RegTimePay       = p_RS.fields("RegTimePay").value 'Orders_RegTimePay
					.Orders_OTPay       = p_RS.fields("OTPay").value 'Orders_OTPay
					.Orders_RegHours       = p_RS.fields("RegHours").value 'Orders_RegHours
					.Orders_OTHours       = p_RS.fields("OTHours").value 'Orders_OTHours
					.Orders_StartTime       = p_RS.fields("StartTime").value 'Orders_StartTime
					.Orders_StopTime       = p_RS.fields("StopTime").value 'Orders_StopTime
					.CustomerRates_RegBill       = p_RS.fields("RegBill").value 'CustomerRates_RegBill
					.CustomerRates_RegPay       = p_RS.fields("RegPay").value 'CustomerRates_RegPay
					.CustomerRates_OtBill       = p_RS.fields("OtBill").value 'CustomerRates_OtBill
					.CustomerRates_Comment       = p_RS.fields("Comment").value 'CustomerRates_Comment	
					.OtherOrders_Def1       = p_RS.fields("Def1").value 'OtherOrders_Def1
					.OtherOrders_Def2       = p_RS.fields("Def2").value 'OtherOrders_Def2
					.OtherOrders_Def3       = p_RS.fields("Def3").value 'OtherOrders_Def3
					.OtherOrders_Def4       = p_RS.fields("Def4").value 'OtherOrders_Def4
					.OtherOrders_Def5       = p_RS.fields("Def5").value 'OtherOrders_Def5
					.OtherOrders_Def6       = p_RS.fields("Def6").value 'OtherOrders_Def6
					.OtherOrders_Def7       = p_RS.fields("Def7").value 'OtherOrders_Def7
					.OtherOrders_Def8       = p_RS.fields("Def8").value 'OtherOrders_Def8
					.OtherOrders_Def9       = p_RS.fields("Def9").value 'OtherOrders_Def9
					.OtherOrders_Def10       = p_RS.fields("Def10").value 'OtherOrders_Def10
					.OtherOrders_Def11       = p_RS.fields("Def11").value 'OtherOrders_Def11
					.OtherOrders_Def12       = p_RS.fields("Def12").value 'OtherOrders_Def12


					
					'.WorkCompRate         = p_RS.fields("WorkCompRate").value 
					'.WorkCompCode         = p_RS.fields("WorkCompCode").value 
					'.SafetyClothing       = p_RS.fields("SafetyClothing").value 'in equipment 
					'.SafetyHardhard       = p_RS.fields("SafetyHardhard").value 
					'.SafetyEye            = p_RS.fields("SafetyEye").value 
					'.SafetyHearing        = p_RS.fields("SafetyHearing").value 
					'.SpecialInstructions  = p_RS.fields("SpecialInstructions").value 'define 
					.StartDate            = p_RS.fields("StartDate").value 
					.StopDate              = p_RS.fields("StopDate").value 
					.ReportTo             = p_RS.fields("ReportTo").value 
					'.WorkHours            = p_RS.fields("WorkHours").value  ' stoptime - starttime
					'.TimeToReport         = p_RS.fields("TimeToReport").value  'starttime
					'.LunchInfo            = p_RS.fields("LunchInfo").value  'define
					'.PayRate              = p_RS.fields("PayRate").value  'CustomerRates.RegPay
					'.BillRate             = p_RS.fields("BillRate").value  'CustomerRates.RegBill
					'.Multiplier           = p_RS.fields("Multiplier").value  'define
					'.CustomerServiceCalls = p_RS.fields("CustomerServiceCalls").value  'define

				end with
			end if
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			if isnumeric(me.Site) then
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			else
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getCompanyNumber(me.Site)))
			end if
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function


	'######################### Private Functions
	
	
end class

class cPlacement
	private m_StartDate
	private m_EndDate
	private m_EmployeeName
	private m_Telephone
	private m_PayRate
	private m_WeeklyServiceCalls
	
	public property get StartDate()
		StartDate  = m_StartDate
	end property
	public property let StartDate(p_StartDate)
		m_StartDate = p_StartDate
	end property
	
	public property get EndDate()
		 EndDate = m_EndDate
	end property
	public property let EndDate(p_EndDate)
		m_EndDate = p_EndDate
	end property
	
	public property get EmployeeName()
		EmployeeName  = m_EmployeeName
	end property
	public property let EmployeeName(p_EmployeeName)
		m_EmployeeName = p_EmployeeName
	end property
	
	public property get Telephone()
		Telephone  = m_Telephone
	end property
	public property let Telephone(p_Telephone)
		m_Telephone = p_Telephone
	end property
	
	public property get PayRate()
		PayRate  = m_PayRate
	end property
	public property let PayRate(p_PayRate)
		m_PayRate = p_PayRate
	end property
	
	public property get WeeklyServiceCalls()
		WeeklyServiceCalls  = m_WeeklyServiceCalls
	end property
	public property let WeeklyServiceCalls(p_WeeklyServiceCalls)
		m_WeeklyServiceCalls = p_WeeklyServiceCalls
	end property
	
end class


class cOrders
	'Private, class member variable
	private m_Orders
	private m_Site
	private m_Customer
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Orders = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Orders = Nothing
	End Sub

	'Read the current placements
	Public Property Get Orders()
		Set Orders = m_Orders
	End Property

	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		if len(p_Site) = 0 then
			p_Site = request.form("whichCompany")
			if len(p_Site) = 0 then
				p_Site = company_dsn_site
				if len(p_Site) = 0 then
					p_Site = session("location")
				end if
			end if
		end if
		m_Site = p_Site
	end property

	public property get Customer()
		Customer = m_Customer
	end property
	public property let Customer(p_Customer)
		m_Customer = Replace(p_Customer, "'", "''")
	end property

	public property get Order()
		Order = m_Order
	end property
	public property let Order(p_Order)
		if len(p_Order) = 0 then
			p_Order = request.form("whichOrder")
		end if
		m_Order = p_Order
	end property

	public property get Applicant()
		Applicant = m_Applicant
	end property
	public property let Applicant(p_Applicant)
		if len(p_Applicant) = 0 then
			p_Applicant = request.form("whichApplicant")
		end if
		m_Applicant = p_Applicant
	end property

	public property get FromDate()
		FromDate = m_FromDate
	end property
	public property let FromDate(p_FromDate)
		if isDate(p_FromDate) = false then 
			p_FromDate = request.form("fromDate") 
			if isDate(p_FromDate) = false then
				p_FromDate = CStr(Date() - 4)
			end if
		end if
		m_FromDate = p_FromDate
	end property

	public property get ToDate()
		ToDate = m_ToDate
	end property
	public property let ToDate(p_ToDate)
		if isDate(p_ToDate) = false then 
			p_ToDate = request.form("toDate") 
			if isDate(p_ToDate) = false then
				toDate = CStr(Date() + 1)
			end if
		end if
		m_ToDate = p_ToDate
	end property

	Public Property get NumberOfPages()
		NumberOfPages = m_NumberOfPages
	end property'set page size

	Public Property let NumberOfPages(p_NumberOfPages)
		m_NumberOfPages = p_NumberOfPages
	end property

	'Items Per Page
	Public Property get ItemsPerPage()
		ItemsPerPage = m_ItemsPerPage
	end property

	Public Property let ItemsPerPage(p_ItemsPerPage)
		m_ItemsPerPage = p_ItemsPerPage
	end property

	'Read the current Customers
	Public Property get PageCount()
		PageCount = m_PageCount
	End Property

	Public Property let PageCount(p_PageCount)
		m_PageCount = p_PageCount
	End Property

	'Page Number

	public property get Page()
		Page = m_Page
	end property

	public property let Page(p_Page)
		p_Page = Trim(Replace(p_Page, ",", ""))
		if len(p_Page) = 0 then
			p_Page = request.form("WhichPage")
			if len(p_Page) = 0 then
				p_Page = 1 'default
			end if
		end if
		
		select case vartype(p_Page)
		case 8 'string, convert
			if isnumeric(p_Page) then
				m_Page = cint(p_Page) 'verified number, set page
			else
				m_Page = 1 'initialize variable anyway
			end if
		case 2, 3, 4, 5
			m_Page = cint(p_Page)
		case else
			m_Page = 1
		end select

	end property

	'#############  Public Functions ##############
		
		public function GetOpenOrders()
		
			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.Reference, Orders.JobNumber, Orders.JobStatus, Orders.JobDescription " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer=""" & me.Customer & """) AND (Orders.JobStatus<2 OR Orders.JobStatus = 3);"
				
			GetOpenOrders = LoadData (strSQL)
		end function
		
		public function GetClosedOrders()

			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1 & "", "" & Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer=""" & me.Customer & """) AND (Orders.JobStatus=2 OR Orders.JobStatus = 4);"
	
			'GetClosedOrders = LoadData (strSQL)
		end function

		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
			
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisOrder
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisOrder = New cOrderTab
				with thisOrder
					.Site           = Me.Site
					.CustomerCode   = p_RS.fields("Customer").Value 'Customer
					.JobStatus      = p_RS.fields("JobStatus").Value
					.CustomerDept   = p_RS.fields("CustomerDept").Value
					.Reference      = p_RS.fields("Reference").Value
					.JobDescription = p_RS.fields("JobDescription").Value
					.WorkSite       = p_RS.fields("WorkSite").Value
					.WorkSitePhone  = p_RS.fields("WorkSitePhone").Value
					.OrderDate      = p_RS.fields("OrderDate").Value
					.StartDate      = p_RS.fields("StartDate").Value
					.StopDate       = p_RS.fields("StopDate").Value
					.EmailAddress   = p_RS.fields("EmailAddress").Value
					.EmailFormat    = p_RS.fields("EmailFormat").Value
				end with
				m_Orders.Add thisOrder.Reference, thisOrder
				p_RS.movenext
			loop
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			if isnumeric(me.Site) then
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			else
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getCompanyNumber(me.Site)))
			end if
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class

class cOrderTabs
	'Private, class member variable
	private m_OrderTabs
	private m_Site
	private m_Customer
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_OrderTabs = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_OrderTabs = Nothing
	End Sub

	'Read the current placements
	Public Property Get Orders()
		Set Orders = m_OrderTabs
	End Property

	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		if len(p_Site) = 0 then
			p_Site = request.form("whichCompany")
			if len(p_Site) = 0 then
				p_Site = company_dsn_site
				if len(p_Site) = 0 then
					p_Site = session("location")
				end if
			end if
		end if
		m_Site = p_Site
	end property

	public property get Customer()
		Customer = m_Customer
	end property
	public property let Customer(p_Customer)
		m_Customer = Replace(p_Customer, "'", "''")
	end property

	public property get Order()
		Order = m_Order
	end property
	public property let Order(p_Order)
		if len(p_Order) = 0 then
			p_Order = request.form("whichOrder")
		end if
		m_Order = p_Order
	end property

	public property get Applicant()
		Applicant = m_Applicant
	end property
	public property let Applicant(p_Applicant)
		if len(p_Applicant) = 0 then
			p_Applicant = request.form("whichApplicant")
		end if
		m_Applicant = p_Applicant
	end property

	public property get FromDate()
		FromDate = m_FromDate
	end property
	public property let FromDate(p_FromDate)
		if isDate(p_FromDate) = false then 
			p_FromDate = request.form("fromDate") 
			if isDate(p_FromDate) = false then
				p_FromDate = CStr(Date() - 4)
			end if
		end if
		m_FromDate = p_FromDate
	end property

	public property get ToDate()
		ToDate = m_ToDate
	end property
	public property let ToDate(p_ToDate)
		if isDate(p_ToDate) = false then 
			p_ToDate = request.form("toDate") 
			if isDate(p_ToDate) = false then
				toDate = CStr(Date() + 1)
			end if
		end if
		m_ToDate = p_ToDate
	end property

	Public Property get NumberOfPages()
		NumberOfPages = m_NumberOfPages
	end property'set page size

	Public Property let NumberOfPages(p_NumberOfPages)
		m_NumberOfPages = p_NumberOfPages
	end property

	'Items Per Page
	Public Property get ItemsPerPage()
		ItemsPerPage = m_ItemsPerPage
	end property

	Public Property let ItemsPerPage(p_ItemsPerPage)
		m_ItemsPerPage = p_ItemsPerPage
	end property

	'Read the current Customers
	Public Property get PageCount()
		PageCount = m_PageCount
	End Property

	Public Property let PageCount(p_PageCount)
		m_PageCount = p_PageCount
	End Property

	'Page Number

	public property get Page()
		Page = m_Page
	end property

	public property let Page(p_Page)
		p_Page = Trim(Replace(p_Page, ",", ""))
		if len(p_Page) = 0 then
			p_Page = request.form("WhichPage")
			if len(p_Page) = 0 then
				p_Page = 1 'default
			end if
		end if
		
		select case vartype(p_Page)
		case 8 'string, convert
			if isnumeric(p_Page) then
				m_Page = cint(p_Page) 'verified number, set page
			else
				m_Page = 1 'initialize variable anyway
			end if
		case 2, 3, 4, 5
			m_Page = cint(p_Page)
		case else
			m_Page = 1
		end select

	end property

	'#############  Public Functions ##############
		
		public function GetOpenOrders()
			dim strWhere
			if len(me.Customer) = 0 then
				strWhere = "WHERE (Orders.JobStatus<2 OR Orders.JobStatus = 3)"
			else
				strWhere = "WHERE (Orders.Customer=""" & me.Customer & """) AND (Orders.JobStatus<2 OR Orders.JobStatus = 3)"
			end if
		
			dim strSql
			strSql = "" &_
				"SELECT Orders.StartDate, Orders.OrderDate, Customers.CustomerName, Orders.Customer, " &_
				"Orders.Reference, Orders.JobNumber, Orders.JobStatus, Orders.JobDescription " &_
				"FROM Customers INNER JOIN Orders ON Customers.Customer = Orders.Customer  " &_
				strWhere &_
				"ORDER By CustomerName, JobDescription, StartDate, OrderDate;"

			GetOpenOrders = LoadData (strSQL)
		end function
		
		public function GetClosedOrders()

			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1 & "", "" & Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders WITH (NOLOCK) " &_
				"WHERE (Orders.Customer  like """ & me.Customer & """) AND (Orders.JobStatus=2 OR Orders.JobStatus = 4);"
	
			'GetClosedOrders = LoadData (strSQL)
		end function

		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
			
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisOrderTab, id
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisOrderTab = New cOrderTab
				with thisOrderTab
					id = id + 1
					.id             = id
					.Site           = Me.Site
					.CustomerCode   = p_RS.fields("Customer").Value 'Customer
					.CustomerName   = p_RS.fields("CustomerName").Value 'Customer
					.JobStatus      = p_RS.fields("JobStatus").Value
					.CustomerDept   = p_RS.fields("JobNumber").Value
					.Reference      = p_RS.fields("Reference").Value
					.JobDescription = p_RS.fields("JobDescription").Value
				end with
				m_OrderTabs.Add thisOrderTab.id, thisOrderTab
				p_RS.movenext
			loop
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			if isnumeric(me.Site) then
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			else
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getCompanyNumber(me.Site)))
			end if
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class

class cOrderTab
	private m_id
	private m_Site
	private m_CustomerName
	private m_CustomerCode
	private m_JobStatus
	private m_CustomerDept 'm_JobNumber
	private m_Reference
	private m_JobDescription

	public property get id()
		id = m_id 
	end property
	public property let id(p_id)
		m_id = p_id 
	end property

	public property get Site ()
		Site = m_Site
	end property
	public property let Site(p_Site)
		m_Site = p_Site
	end property

	public property get CustomerName ()
		CustomerName = m_CustomerName
	end property
	public property let CustomerName(p_CustomerName)
		m_CustomerName = p_CustomerName
	end property

	public property get CustomerCode ()
		CustomerCode = m_CustomerCode
	end property
	public property let CustomerCode(p_CustomerCode)
		m_CustomerCode = p_CustomerCode
	end property

	public property get JobStatus()
		JobStatus = m_JobStatus
	end property
	public property let JobStatus(p_JobStatus)
		m_JobStatus = p_JobStatus
	end property

	public property get CustomerDept() 'JobNumber
		CustomerDept = m_CustomerDept
	end property

	public property let CustomerDept(p_CustomerDept)
		m_CustomerDept = p_CustomerDept
	end property

	public property get Reference()
		Reference = m_Reference
	end property

	public property let Reference(p_Reference)
		m_Reference = p_Reference
	end property

	public property get JobDescription()
		JobDescription = m_JobDescription
	end property

	public property let JobDescription(p_JobDescription)
		m_JobDescription = p_JobDescription
	end property

end class 

%>