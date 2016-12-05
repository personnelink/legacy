<%
session("required_user_level") = 1024 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

	dim which_invoice, strWhichInvoice
	strWhichInvoice = request.QueryString("inv")
	if isnumeric(strWhichInvoice) then
		which_invoice = cdbl(strWhichInvoice)
	end if
	
	dim which_row, strWhichRow
	strWhichRow = request.QueryString("row")
	if isnumeric(strWhichRow) then
		which_row = cdbl(strWhichRow)
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
	
	dim qsBuffer
	qsBuffer = request.QueryString("simulate_site")
	if isnumeric(qsBuffer) and len(qsBuffer) > 0 then
		simsite = cint(qsBuffer)
	else
		simsite = -1
	end if
	
	if company_dsn_site > -1 or simsite <> "" then
		
		if simsite > 0 then
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
		
		dim row_shade
		if which_row MOD 2	= 0 then
			row_shade = " rEven"
		else
			row_shade = " rOdd"
		end if

		
		Set AccountActivity = getAccountActivity_cmd.Execute	
		Response.write "<table class=""inv_detail " & row_shade & """><tr>" &_
			"<th class='ba'>Work Date</th>" &_
			"<th class='bb'>Cost Center</th>" &_
			"<th class='bc'>Description</th>" &_
			"<th class='bd'>Qty</th>" &_
			"<th class='be'>Type</th>" &_
			"<th class='bg'>Bill</th>" &_
			"<th class='bh'>Total</th></tr>"
		
		dim invTotalHours : invTotalHours = 0
		dim invTotalDollars : invTotalDollars = 0
		dim dblBillrate : dblBillrate = 0
		dim dblQuantity : dblQuantity = 0
		
		do while not AccountActivity.eof
			dblQuantity = cdbl(AccountActivity.Fields.Item("Quantity"))
			dblBillrate = cdbl(AccountActivity.Fields.Item("Billrate"))
			invTotalDollars = invTotalDollars + (dblBillrate * dblQuantity)
			invTotalHours = invTotalHours + dblQuantity
			
			'detail record
			Response.write "" &_
				"<tr class=""" & row_shade & """>" &_
					"<td class=""ba"">" & AccountActivity.Fields.Item("WorkDate") & "</td>" &_
					"<td class=""bb"">" & AccountActivity.Fields.Item("WCDescript") & "</td>" &_
					"<td class=""bc"">" &  AccountActivity.Fields.Item("Description") & "</td>" &_
					"<td class=""bd"">" & TwoDecimals(dblQuantity) & "</td>" &_
					"<td class=""be"">" & AccountActivity.Fields.Item("Type") & "</td>" &_
					"<td class=""bg"">$" & TwoDecimals(dblBillrate) & "</td>" &_
					"<td class=""bh"">$" & TwoDecimals(dblBillrate * dblQuantity) & "</td>" &_
				"</tr>"
	
			AccountActivity.MoveNext
		loop
		
		'totals record
		Response.write "" &_
			"<tr>" &_
				"<td></td>" &_
				"<td></td>" &_
				"<td class=""tQty"">Total Hours:&nbsp;</td>" &_
				"<th class=""tQty"">" & TwoDecimals(invTotalHours) & "</td>" &_
				"<td colspan=""2"" class=""tDollars"">Sub-Total:&nbsp;</td>" &_
				"<th class=""tDollars"">$" & TwoDecimals(invTotalDollars) & "</td>" &_
			"</tr>"
		
		Response.write "</table>"
		Set AccountActivity = nothing
		Set getAccountActivity_cmd = Nothing
	end if
	
	response.write "<!-- [split] -->" & which_row
	
	session("no_header") = false
%>


