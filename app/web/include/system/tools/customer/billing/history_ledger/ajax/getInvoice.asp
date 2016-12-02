<%
session("required_user_level") = 1024 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

	dim which_invoice
	which_invoice = request.QueryString("inv")
	if isnumeric(which_invoice) then
		which_invoice = cdbl(which_invoice)
	end if
	
	dim simcust, simsite
	simcust = replace(request.QueryString("simulate_customer"), "'", "''")
	if len(simcust & "") > 0 then
		whichCompanyID = "((HistoryDetail.Customer)='" & simcust & "') AND "
	elseif len(g_company_custcode.SqlWhereString & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & company_custcode & "') AND "
		g_company_custcode.SqlWhereAttribute = "HistoryDetail.Customer"
		whichCompanyID = "(" & g_company_custcode.SqlWhereString & ") AND "
	end if
	
	simsite = request.QueryString("simulate_site")
	if isnumeric(simsite) then
		simsite = cint(simsite)
	else
		simsite = ""
	end if
	
	if company_dsn_site > -1 or simsite <> "" then
		
		if simsite <> "" then
			thisConnection = dsnLessTemps(simsite)
		else
			thisConnection = dsnLessTemps(company_dsn_site)
		end if

		Set getAccountActivity_cmd = Server.CreateObject ("ADODB.Command")
		With getAccountActivity_cmd
			.ActiveConnection = thisConnection
			.CommandText = "SELECT HistoryDetail.WorkDate, " &_
				"WorkCodes.Description AS WCDescript, HistoryDetail.Workcode, HistoryDetail.Description, HistoryDetail.Type, " &_
				"HistoryDetail.Quantity, HistoryDetail.Payrate, HistoryDetail.Billrate, HistoryDetail.AppId " &_
				"FROM HistoryDetail INNER JOIN WorkCodes ON HistoryDetail.Workcode = WorkCodes.WorkCode " &_
				"WHERE HistoryDetail.Invoice=" & which_invoice & ";"
			.Prepared = true
		End With
		
		'break getAccountActivity_cmd.CommandText
		
		Set AccountActivity = getAccountActivity_cmd.Execute	
		Response.write "<table class=""inv_detail""><tr>" &_
			"<th class='ba'>Work Date</th>" &_
			"<th class='bb'>Work Code</th>" &_
			"<th class='bc'>Description</th>" &_
			"<th class='bd'>Qty</th>" &_
			"<th class='be'>Typ</th>" &_
			"<th class='bg'>Bill</th>" &_
			"<th class='bh'>Total</th></tr>"
			
		do while not AccountActivity.eof
			Response.write "<tr><td class=""ba"">" & AccountActivity.Fields.Item("WorkDate") & "</td>"
			Response.write "<td class=""bb"">" & AccountActivity.Fields.Item("WCDescript") & "</td>"
			Response.write "<td class=""bc"">" &  AccountActivity.Fields.Item("Description") & "</td>"
			Response.write "<td class=""bd"">" & TwoDecimals(AccountActivity.Fields.Item("Quantity")) & "</td>"
			Response.write "<td class=""be"">" & AccountActivity.Fields.Item("Type") & "</td>"
			'Response.write "<td class=""bf"">$" & TwoDecimals(AccountActivity.Fields.Item("Payrate")) & "</td>"
			Response.write "<td class=""bg"">$" & TwoDecimals(AccountActivity.Fields.Item("Billrate")) & "</td>"
			Response.write "<td class=""bh"">$" & TwoDecimals(cint(AccountActivity.Fields.Item("Billrate"))* cint(AccountActivity.Fields.Item("Quantity"))) & "</td>"
			Response.write "</tr>"
			AccountActivity.MoveNext
		loop
		Response.write "</table>"
		Set AccountActivity = nothing
		Set getAccountActivity_cmd = Nothing
	end if
	
	session("no_header") = false
%>


