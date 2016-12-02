<%
dim Customers
set Customers = new cCustomers

dim perspective
	'ability to hide staff features for demo'ing
	'
	perspective = lcase(request.querystring("perspective"))


	dim qscust
	'querystring customerqscust = replace(request.QueryString("customer"), "'", "''")
	if len(qscust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
		Customers.Customer = qscust
		qscust = "customer=" & qscust
	elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelSupervisor)) then
	Customers.Customer = request.querystring("customer")
	qscust = "customer=" & g_company_custcode.CustomerCode
	elseif not userLevelRequired(userLevelScreened) then
		break "Account not associated and or Not Authorized, please contact 1 (877) 733.7300 or email accounts@personnel.com"
	end if

	dim qsSite
	'querystring site
	qsSite = request.QueryString("site")
	if len(qsSite) > 0 then
		if isnumeric(qsSite) and userLevelRequired(userLevelPPlusStaff) then
			Customers.Site = getTempsCompCode(cint(qsSite))
		else
			Customers.Site = company_dsn_site
		end if
	else
		Customers.Site = qsSite
	end if

with Customers
	.ItemsPerPage = 150
	.Page = Request.QueryString("WhichPage")
	.FromDate = Request.QueryString("fromDate")
	.ToDate = Request.QueryString("toDate")
end with


if userLevelRequired(userLevelPPlusStaff) then
	Customers.GetCustomers()
elseif userLevelRequired(userLevelScreened) then
	Customers.GetApplicantCustomers()
end if

'init checked text string blob
const checkedText = "checked=""checked"""

dim phoneApplicant, phoneCustomer, phoneOrder, contactOrder, contactCustomer
dim applicantid, lastnameFirst, maintain_link, resourcelink

function group_header ()
	dim strResponse : strResponse = ""
	dim strPaidColumn : strPayColumn = ""
	dim strBillColumn : strBillColumn = ""
	
	if show_paid then
		strPaidColumn = "<th class=""RegPayRate"">Pay</th>"
	end if
	
	if show_bill then
		strBillColumn = "<th class=""RegBillRate"">Bill</th>"
	end if
	
	strResponse = strResponse &_
			"<table class=""etcdetails"">" &_
			"<tr class=""etcHeader"">" &_
				"<th class=""lastnamefirst"">&nbsp;</th>" &_
				"<th class=""EmployeeNumber"">Empl#</th>" &_
				"<th class=""JobNumber"">Ref#</th>" &_
				"<th class=""WCDescription"">Description</th>" &_
				"<th class=""StartDate"">Started</th>" &_
				"<th class=""PStopDate"">Ending</th>" &_
				"<th class=""WorkCode"">$ Center</th>" &_
				strPaidColumn &_
				strBillColumn &_
				"<th class=""ExpenseSummary"">Expense</th>" &_
				"<th class=""TimeSummary"">Time</th>" &_
				"<th class=""OkayApprove"">Ok</th>" &_
			"</tr></table>"

			'"<th class=""Reference"">Ref#</th>" &_

	group_header = strResponse
end function

function objShowMore(CustomerCode, Status)
		dim strResponse : strResponse = ""
		if Status = "3" or Status = "4" then
			strResponse = strResponse & "" &_
				"<span class=""ShowMore"" " &_
					"id=""ctrlCustomers" & CustomerCode & """ " &_
					"onclick=""customer.getorders('" & CustomerCode & "', '" & Customers.Site & "', 'closed')"">" &_
				"</span>"
		else
		 	 strResponse = strResponse &_
				"<span class=""ShowMore"" " &_
					"id=""ctrlCustomers" & CustomerCode & """ " &_
					"onclick=""customer.getorders('" & CustomerCode & "', '" & Customers.Site & "', 'open')"">" &_
				"</span>"
		end if
		
		objShowMore = strResponse
end function

function objHideCustomer(p_customer, Site)
		dim strResponse : strResponse = ""
			strResponse = strResponse & "" &_
				"<span class=""HideRow"" " &_
					"id=""TimeSummary" & p_customer & """ " &_
					"onclick=""customer.hide('" & p_customer & "', '" & Site & "')"">" &_
				"</span>"
		
		objHideCustomer = strResponse
end function

function orders_div(CustomerCode)
	orders_div = "<div class=""OrdersDiv"" id=""openordersdiv" & CustomerCode & """></div>" &_
				"<div class=""OrdersDiv"" id=""closedordersdiv" & CustomerCode & """></div>"
end function

function orders_div(CustomerCode)
	orders_div = "<div class=""OrdersDiv"" id=""openordersdiv" & CustomerCode & """></div>" &_
				"<div class=""OrdersDiv"" id=""closedordersdiv" & CustomerCode & """></div>"
end function

function custActivity_div(CustomerCode)
	custActivity_div = "<div class=""CustActivityDiv"" id=""custActivityDiv" & CustomerCode & """></div>"
end function

%>
