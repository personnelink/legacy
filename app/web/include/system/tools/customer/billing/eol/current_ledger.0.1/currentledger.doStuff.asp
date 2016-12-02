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
	whichCompanyID = "((ARSummary.Customer)='" & companyg_company_custcode.CustomerCode_custcode & "') AND "
	this_customer = g_company_custcode.CustomerCode
	simcust = "cust=" & g_company_custcode.CustomerCode
else

	break g_company_custcode.CustomerCode
	print "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
end if

simsite = request.QueryString("simulate_site")
if isnumeric(simsite) and userLevelRequired(userLevelPPlusStaff) then

	simsite = cint(simsite)
else
	simsite = company_dsn_site
end if

'show account activity table'
sub showAccountActivity (rsAccountActivity)
	dim lnk_open, lnk_close	, chk_box
	dim running_total, itotal, row_number, invoice_number
	dim row_shade
	row_number = 0
	do while not AccountActivity.eof
		invoice_number = AccountActivity.Fields.Item("Invoice")
		itotal = AccountActivity.Fields.Item("Total")
		running_total = running_total + itotal
		chk_box = "<input type=""checkbox"" name=""ck_boxes"" id=""ck_" &  row_number & """  value=""" & invoice_number & """ onclick=""setPayAmount();"" />" &_
							"<input type=""hidden"" name=""inv_" & invoice_number & """ value=""" & itotal & """/>"


		lnk_open = "<a href=""javascript:;"" onclick=""getInvoice.open('" & row_number & "', '" & invoice_number & "', '" & simsite & "', '" & simcust & "');"">"  
		lnk_close = "</a>"
		if row_number MOD 2	= 0 then
			row_shade = " even"
		else
			row_shade = " odd"
		end if
		
	response.write "<div id=""line_" & row_number & "_detail"" class=""hide" & row_shade & """>&nbsp;<input type=""hidden"" class=""inv_chk"" name=""invoice" & row_number & """ id=""invoice" & row_number &""" value=""" & invoice_number & """></div>"
	Response.write "<table id=""row_" & row_number & "_summary"" class=""account_activity" & row_shade & """><tr>"
		Response.write "<td class='cg'>" & chk_box & "</td>"
		Response.write "<td class='ca' id='row_for_inv_" & invoice_number & "'>" & lnk_open & invoice_number & " +" & lnk_close & "</td>"
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

%>
