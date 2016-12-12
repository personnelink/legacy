<!-- #include file='usageReport.classes.asp' -->

<%
'on error resume next 
dim foruser : foruser = trim(request.querystring("for"))

dim CustomerUsage
set CustomerUsage = new cAccountActivity
CustomerUsage.ItemsPerPage = 400
CustomerUsage.Page = CInt(Request.QueryString("Page"))

dim linkInvoice, simcust
simcust = replace(request.QueryString("simulate_customer"), "'", "''")
if len(simcust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
	CustomerUsage.CustomerCode = simcust
	simcust = "cust=" & simcust
elseif (g_company_custcode.NumOfCompanies > 0 and userLevelRequired(userLevelPPlusStaff)) or (g_company_custcode.NumOfCompanies > 0 and userLevelRequired(userLevelSupervisor)) then
	CustomerUsage.CustomerCode = g_company_custcode.CustomerCode
	if global_debug then output_debug("System set CustomerCode:" & g_company_custcode.CustomerCode)	
	simcust = "cust=" & g_company_custcode.CustomerCode
else
	break "Account not associated, please contact 1(877)733-7300 or email accounts@personnel.com"
end if

CustomerUsage.FromDate = request.QueryString("fromDate")
CustomerUsage.ToDate = request.QueryString("toDate")

CustomerUsage.Department = departmentId

dim simsite
simsite = request.QueryString("simulate_site")
if isnumeric(simsite) and userLevelRequired(userLevelPPlusStaff) then
	CustomerUsage.CompanyId = cint(simsite)
else
	CustomerUsage.CompanyId = company_dsn_site
end if

CustomerUsage.LoadAccountActivity

dim PageNavigation
PageNavigation = CustomerUsage.GetPageSelection()

dim TotalHours
set TotalHours = new cTotalHours
TotalHours.LoadSumOf(CustomerUsage)

dim lnk_open
dim lnk_close : lnk_close = "</a>"
dim chk_box
dim getPdf : getPdf = "<span class=""getpdf"">&nbsp;</span>"
dim running_total, itotal
dim row_number : row_number = 0
dim invoice_link
dim invoice_number
dim row_shade

function persist_simulation ()
	dim sCust, sSite, strBuffer
	sCust = request.QueryString("simulate_customer")
	sSite = request.QueryString("simulate_site")
	
	strBuffer = ""
	if len(sCust) > 0 then
		strBuffer = "" &_
			"<input type=""hidden"" name=""simulate_customer"" id=""simulate_customer"" value=""" & sCust & """ />"
	end if

	if len(sSite) > 0 then
		strBuffer = strBuffer &_
			"<input type=""hidden"" name=""simulate_site"" id=""simulate_site"" value=""" & sSite & """ />"
	end if

	persist_simulation = strBuffer
end function
%>
