<%
dim fromDate, toDate
fromDate = request.form("fromDate") 
if len(fromDate & "") = 0 then fromDate = Date() - 90 
toDate = request.form("toDate") 
if len(toDate & "") = 0 then toDate = Date()

dim whichCompany, linkInvoice, simcust, simsite, this_customer
simcust = replace(request.QueryString("simulate_customer"), "'", "''")
if len(simcust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
	whichCompanyID = "((ARSummary.Customer)='" & simcust & "') AND "
	this_customer = simcust
	simcust = "cust=" & simcust
elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelManager)) then
	whichCompanyID = "((ARSummary.Customer)='" & g_company_custcode.CustomerCode & "') AND "
	this_customer = g_company_custcode.CustomerCode
	simcust = "cust=" & g_company_custcode.CustomerCode
else
	break g_company_custcode.CustomerCode
	print "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
end if

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
	
	'break rsSimCustId.commandtext
	
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

dim strProcessPayment
strProcessPayment = request.form("process_action")
if strProcessPayment = "send" then
	process_payment
end if

'show account activity table'
sub showAccountActivity ()
	dim lnk_open
	dim lnk_close : lnk_close = "</a>"
	dim chk_box
	dim getPdf : getPdf = "<span class=""getpdf"">&nbsp;</span>"
	dim running_total, itotal
	dim row_number : row_number = row_number = 0
	dim invoice_link
	dim invoice_number
	dim row_shade
	
	do while not AccountActivity.eof
		invoice_number = AccountActivity.Fields.Item("Invoice")
		invoice_link = "<a href=""/include/system/services/sendPDF.asp?" &_
			"site=" & simsite & "&" &_
			"customer=" & this_customer & "&" &_
			"id=" & invoice_number & "&" &_
			"cat=inv"" class=""invlink"">" & invoice_number & "</a>"
				
		itotal = AccountActivity.Fields.Item("Total")
		running_total = running_total + itotal
		chk_box = "<input type=""checkbox"" name=""ck_boxes"" id=""ck_" &  row_number & """  value=""" & invoice_number & """ onclick=""setPayAmount();"" />" &_
							"<input type=""hidden"" name=""inv_" & invoice_number & """ value=""" & itotal & """/>"


		lnk_open = "<a href=""javascript:;"" onclick=""getInvoice.open('" & row_number & "', '" & invoice_number & "', '" & simsite & "', '" & simcust & "');"">"  
		
		if row_number MOD 2	= 0 then
			row_shade = " even"
		else
			row_shade = " odd"
		end if
		
	response.write "<div id=""line_" & row_number & "_detail"" class=""hide" & row_shade & """>&nbsp;<input type=""hidden"" class=""inv_chk"" name=""invoice" & row_number & """ id=""invoice" & row_number &""" value=""" & invoice_number & """></div>"
	Response.write "<table id=""row_" & row_number & "_summary"" class=""account_activity" & row_shade & """><tr>"
		Response.write "<td class='cg'>" & chk_box & "</td>"
		Response.write "<td class='ch' id='row_for_inv_" & invoice_number & "'>" & lnk_open & "<span class=""plusexpand"">&nbsp;</span>" & lnk_close & "</td>"
		Response.write "<td class='ca'>"& invoice_link & "</td>"
		Response.write "<td class='cb'>" & AccountActivity.Fields.Item("InvoiceDate") & "</td>"
		Response.write "<td class='cc'>" & AccountActivity.Fields.Item("Description") & "</td>"
		Response.write "<td class='cd'>" & AccountActivity.Fields.Item("Document") & "</td>"
		Response.write "<td class='ce'>$" & TwoDecimals(itotal) & "</td>"
		Response.write "<td class='cf'>$" & TwoDecimals(running_total) & "</td>"
		Response.write "</tr></table>" &_
			"<table class=""account_activity"">"
			
		row_number = row_number + 1
		AccountActivity.MoveNext
	loop

	Response.write "<tr>"
	Response.write "<td colspan='4'></td>"
	Response.write "<td class='cd'>TOTAL</td>"
	Response.write "<td class='cf'>$" & TwoDecimals(running_total) & "</td>"
	Response.write "</tr></table>" &_
	"<table class=""account_activity"">"

	Response.write "</table></div>"
	
	Response.write "<input type=""hidden"" name=""how_many_invoices"" id=""how_many_invoices"" value=""" & row_number & """>"

end sub

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
	
	if len(simcust) > 0 then
		'Break "here"
		'break simcust & " " & simsite & " " & thisConnection
		companyId = 86
	end if
	
	with rsPendingPayments
		.activeconnection = MySql


		
		.commandtext = "select account, docnum, amount, submitted " &_
			"from tbl_payments " &_
			"where companyid=" & companyId
			
	end with
	
	dim getPayments
	set getPayments = rsPendingPayments.execute()
		
	dim strPayments
	do while not getPayments.eof
		strPayments = strPayments &_
			"<span><img>A payment is pending on account ending *" & right(getPayments("account"), 3) &_
					" [document or reference number: " & getPayments("docnum") & "] <br />The payment is for $" & TwoDecimals(getPayments("amount")) & " and was submitted " &_
					getPayments("submitted") & ".</span>" &_
		getPayments.movenext
	loop
	checkPendingPayments = strPayments
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
