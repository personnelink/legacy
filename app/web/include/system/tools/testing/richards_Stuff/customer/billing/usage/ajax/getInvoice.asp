<%
session("required_user_level") = 256 'userLevelSupervisor
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
	
	dim simcust, this_site
	simcust = replace(request.QueryString("simulate_customer"), "'", "''")
	if len(simcust & "") > 0 then
		whichCompanyID = "((HistoryDetail.Customer)='" & simcust & "') AND "
	elseif len(g_company_custcode.SqlWhereString & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & company_custcode & "') AND "
		g_company_custcode.SqlWhereAttribute = "HistoryDetail.Customer"
		whichCompanyID = "(" & g_company_custcode.SqlWhereString & ") AND "
	end if
	
	dim qsBuffer
	qsBuffer = request.QueryString("site")
	if isnumeric(qsBuffer) and len(qsBuffer) > 0 then
		this_site = cint(qsBuffer)
	else
		this_site = company_dsn_site
	end if
	
	if this_site <> company_dsn_site and user_level < userLevelPPlusStaff then
		'site miss match and not pplus staff... possible hacking attempt; end service
		response.end
	end if

	
	if this_site > -1 then
		thisConnection = dsnLessTemps(this_site)

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
		
		response.write "<table class=""inv_detail " & row_shade & """><tr>" &_
			"<th class='ba smaller'>Work Date</th>" &_
			"<th class='bb smaller'>Cost Center</th>" &_
			"<th class='bc smaller'>Description</th>" &_
			"<th class='bd smaller'>Qty</th>" &_
			"<th class='be smaller'>Type</th>" &_
			"<th class='bg smaller'>Bill</th>"
			
		if g_Company_show_paid then	response.write "<th class='bf smaller'>Paid</th>"
			
		response.write "" &_
			"<th class='bh smaller'>Total</th></tr>"
		
		dim invTotalHours : invTotalHours = 0
		dim invTotalDollars : invTotalDollars = 0
		dim dblBillrate : dblBillrate = 0
		dim dblPayrate : dblPayrate = 0
		dim dblQuantity : dblQuantity = 0
		
		do while not AccountActivity.eof
			dblQuantity = cdbl(AccountActivity.Fields.Item("Quantity"))
			dblBillrate = cdbl(AccountActivity.Fields.Item("Billrate"))
			dblPayrate = cdbl(AccountActivity.Fields.Item("Payrate"))
			invTotalDollars = invTotalDollars + ((dblBillrate * dblQuantity))
			invTotalHours = invTotalHours + dblQuantity
			
			'detail record
			Response.write "" &_
				"<tr class=""" & row_shade & """>" &_
					"<td class=""ba"">" & AccountActivity.Fields.Item("WorkDate") & "</td>" &_
					"<td class=""bb"">" & AccountActivity.Fields.Item("WCDescript") & "</td>" &_
					"<td class=""bc"">" &  AccountActivity.Fields.Item("Description") & "</td>" &_
					"<td class=""bd"">" & TwoDecimals(dblQuantity) & "</td>" &_
					"<td class=""be"">" & AccountActivity.Fields.Item("Type") & "</td>" &_
					"<td class=""bg"">$" & TwoDecimals(dblBillrate) & "</td>"
					
					if g_Company_show_paid then	response.write "<td class=""bf"">$" & TwoDecimals(dblPayrate * dblQuantity) & "</td>"
					
			response.write "" &_	
					"<td class=""bh"">$" & TwoDecimals(dblBillrate * dblQuantity) & "</td>" &_
				"</tr>"
	
			AccountActivity.MoveNext
		loop
		
		dim numOfCols
		if g_Company_show_paid then
			numOfCols = 3
		else
			numOfCols = 2
		end if
		
		'totals record
		Response.write "" &_
			"<tr>" &_
				"<td></td>" &_
				"<td></td>" &_
				"<td class=""tQty"">Total Hours:&nbsp;</td>" &_
				"<th class=""tQty"">" & TwoDecimals(invTotalHours) & "</td>" &_
				"<td colspan=""" & numOfCols & """ class=""tDollars"">Sub-Total:&nbsp;</td>" &_
				"<th class=""tDollars"">$" & TwoDecimals(invTotalDollars+0.005) & "</td>" &_
			"</tr>"
		
		Response.write "</table>"
		Set AccountActivity = nothing
		Set getAccountActivity_cmd = Nothing
	end if
	
	response.write "<!-- [split] -->" & which_row
	
	session("no_header") = false
%>


