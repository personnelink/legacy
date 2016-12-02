<!-- #include file='currentledger.class.asp' -->
<%

dim AccountActivity
set AccountActivity = new cAccountActivity
AccountActivity.ItemsPerPage = 100
AccountActivity.Page = CInt(Request.QueryString("Page"))

AccountActivity.FromDate = request.form("fromDate") 
AccountActivity.ToDate   = request.form("toDate")


dim whichCompany, linkInvoice, simcust, simsite, this_customer
simcust = replace(request.QueryString("simulate_customer"), "'", "''")
if len(simcust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
	whichCompanyID = "((ARSummary.Customer)='" & simcust & "') AND "
	this_customer = simcust
	simcust = "cust=" & simcust
elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelSupervisor)) then
	whichCompanyID = "((ARSummary.Customer)='" & g_company_custcode.CustomerCode & "') AND "
	this_customer = g_company_custcode.CustomerCode
	simcust = "cust=" & g_company_custcode.CustomerCode
else
	break "Account not associated, please contact 1(877)733-7300 or email accounts@personnel.com"
	print "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
end if

AccountActivity.CustomerCode = this_customer
AccountActivity.Department = departmentId

if len(simcust) > 0 then
	dim intIdStart, intIdLenth
	intIdStart = instr(simcust, "cust=") + 5
	intIdLenth = (len(simcust) - intIdStart) + 1
	'Break intIdStart & " " & intIdStop & " " & mid(simcust, intIdStart, intIdLenth)
	
	dim rsSimCustId 'get simulated customer's id
	set rsSimCustId = server.createobject("ADODB.Command")
	with rsSimCustId
		.activeconnection = MySql
		.commandtext = "select companyid " &_
			"from tbl_companies " &_
			"where Customer=""" & mid(simcust, intIdStart, intIdLenth) & """;"
	end with
	
	'print rsSimCustId.commandtext
	
	dim getSimCompanyId
	set getSimCompanyId = rsSimCustId.execute()
	if not getSimCompanyId.eof then
		companyId = getSimCompanyId("companyId")
	end if
	
	set rsSimCustId = nothing
	set getSimCompanyId = nothing
end if

simsite = request.QueryString("simulate_site")
if isnumeric(simsite) and userLevelRequired(userLevelPPlusStaff) then
	simsite = cint(simsite)
else
	simsite = company_dsn_site
end if

AccountActivity.CompanyId = simsite

dim strProcessPayment
strProcessPayment = request.form("process_action")
if strProcessPayment = "send" then
	process_payment
end if

AccountActivity.LoadAccountActivity

dim PageNavigation
PageNavigation = AccountActivity.GetPageSelection()

dim lnk_open
dim lnk_close : lnk_close = "</a>"
dim chk_box
dim getPdf : getPdf = "<span class=""getpdf"">&nbsp;</span>"
dim running_total, itotal
dim row_number : row_number = 0
dim invoice_link
dim invoice_number
dim row_shade

function getAccountBalance(thisConnection)
		set getAccntBalance_cmd = Server.CreateObject("ADODB.Command")
			with getAccntBalance_cmd
				.ActiveConnection = thisConnection
				'.CommandText = "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
				.CommandText = "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer " &_
					"FROM ARActivity " &_
					"WHERE ARActivity.Customer=""" & ucase(this_customer) & """;"
				'break getAccntBalance_cmd.CommandText
				.Prepared = true
			end with
			'break getAccntBalance_cmd.CommandText
			set AccountBalance = getAccntBalance_cmd.Execute
			
			if not AccountBalance.eof then
				getAccountBalance = "  $" & TwoDecimals(AccountBalance("Balance")}
			else
				getAccountBalance = "  <i>Unavailable ... </i>"
			end if
end function

function checkPendingPayments()
	dim rsPendingPayments 'pending payment
	set rsPendingPayments = server.createobject("ADODB.Command")
	
	' if len(simcust) > 0 then
	
		' print "here"
		' 'Break "here"
		' 'break simcust & " " & simsite & " " & thisConnection
		' companyId = 86
	' end if
	
	with rsPendingPayments
		.activeconnection = MySql


		
		.commandtext = "select account, docnum, amount, submitted " &_
			"from tbl_payments " &_
			"where companyid=" & companyId
			
	end with

	dim getPayments
	set getPayments = rsPendingPayments.execute()
	
	dim afterPaymentsNote
	if not getPayments.eof then
		afterPaymentsNote = "<br><i><span class=""smaller"">* Please allow up to 48 hours (1-2 business days) for processing.</span>"
	end if
	
	dim strPayments
	do while not getPayments.eof
		strPayments = strPayments &_
			"<span><img>A payment is pending on account ending *" & right(getPayments("account"), 3) &_
					" [document or reference number: " & getPayments("docnum") & "] <br />The payment is for $" & TwoDecimals(getPayments("amount")) & " and was submitted " &_
					getPayments("submitted") & "."
		getPayments.movenext
	loop
	checkPendingPayments = strPayments & afterPaymentsNote
end function

sub process_payment ()
	dim intRouting, intAccount, strDocnum, intAmount
	intRouting = request.form("routing")
	intAccount = request.form("account")
	strDocnum = request.form("docnum")
	intAmount = replace(replace(request.form("amount"), "$", ""), ",", "")

	''break intRouting & " : " & intAccount & " : " & strDocnum & " : " & intAmount
	dim rsPaymentInfo
	set rsPaymentInfo = server.CreateObject("ADODB.Command")
	with rsPaymentInfo
		.ActiveConnection = MySql
		.CommandText = "INSERT INTO tbl_payments (companyid, userid, routing, account, docnum, amount, status) " &_
			" VALUES ('" &_
			companyId & "', '" &_
			user_id & "', '" &_
			intRouting & "', '" &_
			intAccount & "', '" &_
			strDocnum & "', '" &_
			intAmount & "', -1" &_
			");SELECT last_insert_id()"
	end with
	
	dim doPayment
	set doPayment = rsPaymentInfo.Execute().nextrecordset
	dim ref_number
	ref_number = cdbl(doPayment(0))


	if request.form("remember_how") = "remember" then
		rsPaymentInfo.CommandText = "INSERT INTO tbl_paymethods (companyid, userid, routing, account) " &_
			" VALUES ('" &_
			companyId & "', '" &_
			user_id & "', '" &_
			intRouting & "', '" &_
			intAccount & "')"
		doPayment = rsPaymentInfo.Execute()
	end if

	rsPaymentInfo.CommandText = "Select subject, body From email_templates Where template='paymentsent'"
	Set doPayment = rsPaymentInfo.Execute()
	
	if not doPayment.eof then
		msgSubject = doPayment("subject")
	
		msgBody = Replace(doPayment("body"), "%name%", 	user_firstname & " " & user_lastname)
		msgBody = Replace(msgBody, "%ref_number%", ref_number)
		msgBody = Replace(msgBody, "%amount%", "$" & twoDecimals(intAmount))

		'Determine destination
		dim deliveryLocation
		rsPaymentInfo.CommandText = "Select email From list_zips Where zip='" & user_zip & "'"
		Set doPayment = rsPaymentInfo.Execute()
		if Not doPayment.eof then
			deliveryLocation = doPayment("email")
		else
			deliveryLocation = "twin@personnel.com"
		end if
		
		if Err.Number = 0 then
			Call SendEmailwBCC (user_email, deliveryLocation, system_email, msgSubject, msgBody, "")
		else
			Call SendEmail ("debug@personnel.com", system_email, "Debug: " & Err.Number & " : " & msgSubject, msgBody, "")
		end if
	end if
	
end sub


%>
