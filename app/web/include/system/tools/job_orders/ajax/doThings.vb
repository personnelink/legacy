<%Option Explicit%>
<%
session("required_user_level") = 2048 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/job_orders/jobOrder.classes.vb' -->
<!-- #INCLUDE file='doLookUpCustomer.asp' -->

<%
'-----------------------------------------------------------------
' parameters:
'	do     = view
'	id     = customer code
'	site   = temps site id
'	status = job order status
'
'-----------------------------------------------------------------
'flag to toggle using querystring or form post data
dim use_qs
if request.querystring("use_qs") = "1" then
	use_qs = true
else
	use_qs = false
end if

dim applicantid
applicantid = getParameter("applicantid")

dim jobref
jobref = getParameter("jobref")

dim dept
dept = getParameter("dept")

dim siteid
siteid = getParameter("site")

dim customerid, customer
customerid = getParameter("customer")
customer = customerid

dim tempsCode
if isnumeric(siteid) then
	tempsCode = getTempsCompCode(siteid)
elseif len(siteid) = 3 then
	tempsCode = siteid
end if

dim placementid
placementid = getParameter("id")


'retrieve site id and make sure it's numeric
dim g_strSite
dim qsSite : qsSite = getParameter("site")
	if not isnumeric(qsSite) then
		g_strSite = getSiteNumber(qsSite)
	else
		g_strSite = qsSite
	end if


REM dim updatename
	REM set updatename = new cTempsAttribute
	REM with updatename
		REM .site = siteid
		REM .table = "Orders"
		REM .element = "JobChangedBy"
		REM .newvalue = "Squirly"
		REM .whereclause = "Reference=320"
		REM .update()
	REM end with
	REM set updatename = nothing
	
	
	
dim which_method
which_method = getParameter("do")
select case which_method
	case "getordertabs"
		getOrderTabs
	case "lookupcustomer"
		doCustomerLookup
	case "getjoborder"
		doGetJobOrder
	case "saveorderinfo"
		doSaveOrderInfo
	case else
		break "[here]: " & which_method
end select

function doSaveOrderInfo()

	dim orderkey, ordervalue
		set update_orders = new cTempsAttribute
		with update_orders
			.site = siteid
			.table = "Orders"
			.element = replace(getParameter("element"), """", """""")
			.newvalue = replace(getParameter("value"), """", """""")
			.whereclause = "(Reference=" & jobref & ") AND (JobNumber=" & dept & ")"
			.update()
		end with
		set update_orders = nothing
		
		'add activity tracking here
	
end function


function doGetJobOrder()

	dim joborder
	set joborder = new cJobOrder
	with joborder
		.Site = siteid
		.Reference = jobref
		.JobNumber = dept
		.LoadJobOrder()
	end with

	response.write "" &_
		"&Site=" & joborder.Site &_
		"&Reference=" & joborder.Reference &_
		"&JobNumber=" & joborder.JobNumber &_
		"&Department=" & joborder.Department &_
		"&JobDescription=" & joborder.JobDescription &_
		"&OrderDate=" & joborder.OrderDate &_
		"&TimeReceived=" & joborder.TimeReceived &_
		"&CustomerName = " & joborder.CustomerName &_
		"&JobStatus = " & joborder.JobStatus &_
		"&JobStatus = " & joborder.JobStatus &_
		"&JobNumber = " & joborder.JobNumber &_
		"&Reference = " & joborder.Reference &_
		"&JobDescription = " & joborder.JobDescription &_
		"&Memo = " & joborder.Memo &_
		"&OrderDate = " & joborder.OrderDate &_
		"&Office = " & joborder.site &_
		"&OrderTakenBy = " & joborder.OrderTakenBy &_
		"&Fax = " & joborder.Fax &_
		"&WorkCode1 = " & joborder.WorkCode1 &_
		"&WC1Pay = " & joborder.WC1Pay &_
		"&WC1Bill = " & joborder.WC1Bill &_
		"&WC1Required = " & joborder.WC1Required &_
		"&WorkCode2 = " & joborder.WorkCode2 &_
		"&WC2Pay = " & joborder.WC2Pay &_
		"&WC2Bill = " & joborder.WC2Bill &_
		"&WC2Required = " & joborder.WC2Required &_
		"&WorkCode3 = " & joborder.WorkCode3 &_
		"&WC3Pay = " & joborder.WC3Pay &_
		"&WC3Bill = " & joborder.WC3Bill &_
		"&WC3Required = " & joborder.WC3Required &_
		"&WorkCode4 = " & joborder.WorkCode4 &_
		"&WC4Pay = " & joborder.WC4Pay &_
		"&WC4Bill = " & joborder.WC4Bill &_
		"&WC4Required = " & joborder.WC4Required &_
		"&WorkCode5 = " & joborder.WorkCode5 &_
		"&WC5Pay = " & joborder.WC5Pay &_
		"&WC5Bill = " & joborder.WC5Bill &_
		"&WC5Required = " & joborder.WC5Required &_
		"&OtherPay = " & joborder.OtherPay &_
		"&OtherBill = " & joborder.OtherBill &_
		"&OtherRequired = " & joborder.OtherRequired &_
		"&Orders_StartDate = " & joborder.Orders_StartDate &_
		"&Orders_OrderDate = " & joborder.Orders_OrderDate &_
		"&Customers_CustSetupBy = " & joborder.Customers_CustSetupBy &_
		"&Orders_Customer = " & joborder.Orders_Customer &_
		"&Customers_CustSetupDate = " & joborder.Customers_CustSetupDate &_
		"&Orders_Reference = " & joborder.Orders_Reference &_
		"&Orders_JobNumber = " & joborder.Orders_JobNumber &_
		"&Orders_JobStatus = " & joborder.Orders_JobStatus &_
		"&Orders_JobDescription = " & joborder.Orders_JobDescription &_
		"&Orders_Memo = " & joborder.Orders_Memo &_
		"&Orders_OrderTakenBy = " & joborder.Orders_OrderTakenBy &_
		"&Orders_Customer = " & joborder.Orders_Customer &_
		"&Customers_CustomerType = " & joborder.Customers_CustomerType &_
		"&Customers_SalesTaxExemptNo = " & joborder.Customers_SalesTaxExemptNo &_
		"&Customers_CustomerName = " & joborder.Customers_CustomerName &_
		"&Customers_Phone = " & joborder.Customers_Phone &_
		"&Customers_Fax = " & joborder.Customers_Fax &_
		"&Customers_EmailAddress = " & joborder.Customers_EmailAddress &_
		"&Orders_WorkSite1 = " & joborder.Orders_WorkSite1 &_
		"&Orders_WorkSite2 = " & joborder.Orders_WorkSite2 &_
		"&Orders_WorkSite3 = " & joborder.Orders_WorkSite3 &_
		"&Orders_DirectionsParking = " & joborder.Orders_DirectionsParking &_
		"&Orders_Bill1 = " & joborder.Orders_Bill1 &_
		"&Orders_Bill2 = " & joborder.Orders_Bill2 &_
		"&Orders_Bill3 = " & joborder.Orders_Bill3 &_
		"&Orders_Bill4 = " & joborder.Orders_Bill4 &_
		"&Customers_SalesTaxExemptNo = " & joborder.Customers_SalesTaxExemptNo &_
		"&Customers_InvoiceTaxExemptNo = " & joborder.Customers_InvoiceTaxExemptNo &_
		"&Customers_SuspendService = " & joborder.Customers_SuspendService &_
		"&Customers_ETimeCardStyle = " & joborder.Customers_ETimeCardStyle &_
		"&CustomerSkillSets_SkillSetName = " & joborder.CustomerSkillSets_SkillSetName &_
		"&Orders_WorkCode1 = " & joborder.Orders_WorkCode1 &_
		"&Orders_WC1Pay = " & joborder.Orders_WC1Pay &_
		"&Orders_WC1Bill = " & joborder.Orders_WC1Bill &_
		"&Orders_WC1Required = " & joborder.Orders_WC1Required &_
		"&Orders_WorkCode2 = " & joborder.Orders_WorkCode2 &_
		"&Orders_WC2Pay = " & joborder.Orders_WC2Pay &_
		"&Orders_WC2Bill = " & joborder.Orders_WC2Bill &_
		"&Orders_WC2Required = " & joborder.Orders_WC2Required &_
		"&Orders_WorkCode3 = " & joborder.Orders_WorkCode3 &_
		"&Orders_WC3Pay = " & joborder.Orders_WC3Pay &_
		"&Orders_WC3Bill = " & joborder.Orders_WC3Bill &_
		"&Orders_WC3Required = " & joborder.Orders_WC3Required &_
		"&Orders_WorkCode4 = " & joborder.Orders_WorkCode4 &_
		"&Orders_WC4Pay = " & joborder.Orders_WC4Pay &_
		"&Orders_WC4Bill = " & joborder.Orders_WC4Bill &_
		"&Orders_WC4Required = " & joborder.Orders_WC4Required &_
		"&Orders_WorkCode5 = " & joborder.Orders_WorkCode5 &_
		"&Orders_WC5Pay = " & joborder.Orders_WC5Pay &_
		"&Orders_WC5Bill = " & joborder.Orders_WC5Bill &_
		"&Orders_WC5Required = " & joborder.Orders_WC5Required &_
		"&Orders_OtherPay = " & joborder.Orders_OtherPay &_
		"&Orders_OtherBill = " & joborder.Orders_OtherBill &_
		"&Orders_OtherRequired = " & joborder.Orders_OtherRequired &_
		"&Orders_StartDate = " & joborder.Orders_StartDate &_
		"&Orders_StopDate = " & joborder.Orders_StopDate &_
		"&Orders_ReportTo = " & joborder.Orders_ReportTo &_
		"&Orders_RegTimePay = " & joborder.Orders_RegTimePay &_
		"&Orders_OTPay = " & joborder.Orders_OTPay &_
		"&Orders_RegHours = " & joborder.Orders_RegHours &_
		"&Orders_OTHours = " & joborder.Orders_OTHours &_
		"&Orders_StartTime = " & joborder.Orders_StartTime &_
		"&Orders_StopTime = " & joborder.Orders_StopTime &_
		"&CustomerRates_RegBill = " & joborder.CustomerRates_RegBill &_
		"&CustomerRates_RegPay = " & joborder.CustomerRates_RegPay &_
		"&CustomerRates_OtBill = " & joborder.CustomerRates_OtBill &_
		"&CustomerRates_Comment = " & joborder.CustomerRates_Comment &_
		"&StartDate = " & joborder.StartDate &_
		"&StopDate = " & joborder.StopDate &_
		"&ReportTo = " & joborder.ReportTo &_
		"&OtherOrders_Def1 = " & joborder.OtherOrders_Def1 &_
		"&OtherOrders_Def2 = " & joborder.OtherOrders_Def2 &_
		"&OtherOrders_Def3 = " & joborder.OtherOrders_Def3 &_
		"&OtherOrders_Def4 = " & joborder.OtherOrders_Def4 &_
		"&OtherOrders_Def5 = " & joborder.OtherOrders_Def5 &_
		"&OtherOrders_Def6 = " & joborder.OtherOrders_Def6 &_
		"&OtherOrders_Def7 = " & joborder.OtherOrders_Def7 &_
		"&OtherOrders_Def8 = " & joborder.OtherOrders_Def8 &_
		"&OtherOrders_Def9 = " & joborder.OtherOrders_Def9 &_
		"&OtherOrders_Def10 = " & joborder.OtherOrders_Def10 &_
		"&OtherOrders_Def11 = " & joborder.OtherOrders_Def11 &_
		"&OtherOrders_Def12 = " & joborder.OtherOrders_Def12		
		
		
		


		'.TimeReceived    = p_RS.fields("TimeReceived").value  'orderdate
		'.ProposalDate         = p_RS.fields("ProposalDate").value 'define
		'.CustomerCode         = p_RS.fields("CustomerCode").value 
		'.NewClient            = p_RS.fields("NewClient").value  'boolean yes / no 'use customer type
		'.Corporation          = p_RS.fields("Corporation").value 'use regEx to determine base on ein or ssn pattern
		'.CompanyName          = p_RS.fields("CompanyName").value 
		'.Telephone            = p_RS.fields("Telephone").value 
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
		'.WorkCompRate         = p_RS.fields("WorkCompRate").value 
		'.WorkCompCode         = p_RS.fields("WorkCompCode").value 
		'.SafetyClothing       = p_RS.fields("SafetyClothing").value 'in equipment 
		'.SafetyHardhard       = p_RS.fields("SafetyHardhard").value 
		'.SafetyEye            = p_RS.fields("SafetyEye").value 
		'.SafetyHearing        = p_RS.fields("SafetyHearing").value 
		'.SpecialInstructions  = p_RS.fields("SpecialInstructions").value 'define 


		
	
end function

function getOrderTabs
	
	dim JobOrderTabs
	set JobOrderTabs = new cOrderTabs

	dim perspective
	'ability to hide staff features for demo'ing
	'
	perspective = lcase(request.querystring("perspective"))

		REM dim cust
		REM 'querystring customer
		REM cust = replace(getParameter("customer"), "'", "''")
		REM if len(cust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
			REM JobOrderTabs.Customer = cust
			REM cust = "customer=" & cust

		REM REM elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and 		userLevelRequired(userLevelSupervisor)) then
			REM JobOrderTabs.Customer = getParameter("id")
		REM cust = "customer=" & g_company_custcode.CustomerCode
			REM else
			REM break "Account not associated and or Not Authorized, please contact 1 (877) 733-7300 or email accounts@personnel.com"
		REM end if

		dim qsSite
		'querystring site
		qsSite = request.form("site")
		if len(qsSite) = 0 then	qsSite = request.querystring("site")
			
			
		if len(qsSite) > 0 then
			if userLevelRequired(userLevelPPlusStaff) then
				if isnumeric(qsSite) then
					JobOrderTabs.Site = getTempsCompCode(cint(qsSite))
				else
					JobOrderTabs.Site = getTempsCompCode(getCompanyNumber(qsSite))
				end if
			else
				JobOrderTabs.Site = company_dsn_site
			end if
		else
			JobOrderTabs.Site = qsSite
		end if
		
	with JobOrderTabs
		.ItemsPerPage = 150
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
	end with

	' if getParameter("status") = "closed" then
		' JobOrderTabs.GetClosedOrders()
	' else
		JobOrderTabs.GetOpenOrders()
	' end if

	dim OrderTab, htmlTab

	for each OrderTab in JobOrderTabs.Orders.Items


		REM <!--
			REM private m_Site
			REM private m_CustomerCode
			REM private m_JobStatus
			REM private m_CustomerDept 'm_JobNumber
			REM private m_Reference
			REM private m_JobDescription		
		REM -->

		response.write "" &_
			"<div class=""tab"" id=""tab_" & OrderTab.Reference & "_" & OrderTab.CustomerDept & """>" &_
				"<input type=""radio"" id=""tab-" & OrderTab.id & """ name=""tab-group-" & OrderTab.id & """>" &_
				"<label for=""tab-" & OrderTab.id & """ onclick=""job.load('" & OrderTab.Site & "','" & OrderTab.Reference & "', '" & OrderTab.CustomerDept & "');"">" &_
				"<em><span class=""cname"">" & OrderTab.CustomerName & "</span></em>" &_
				"<span class=""dept"">dept:" & OrderTab.CustomerDept & ", jo:" & OrderTab.Reference & "</span><span class=""job"">" & OrderTab.JobDescription & "</span>" &_
				"</label>" &_
			"</div>"

	next


	
end function

function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function


%>
