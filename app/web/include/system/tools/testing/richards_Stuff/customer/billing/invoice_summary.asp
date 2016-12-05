<%
session("add_css") = "tinyForms.asp.css"
session("required_user_level") = 1024 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/viewaccountactivity.js"></script>
<!-- Created: 12.15.2008 -->
<%

'if len(session("insertInfo")) > 0 then
'	response.write(decorateTop("doneInsertingApp", "marLR10", "Applicants Attachments"))
'	response.write(session("insertInfo"))
'	response.write(decorateBottom())
'	session("insertInfo") = ""
'end if

%>
<%=decorateTop("AccountActivity", "notToShort marLR10", "Account Activity")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="viewAccountActivity.asp" method="post" class="oneHalf left">
  <p>
    <label for="fromDate">From: </label>
	<% fromDate = request.form("fromDate") 
		if len(fromDate & "") = 0 then fromDate = Date() - 90 %>
    <input name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
    <label for="toDate">To: </label>
	<% toDate = request.form("toDate") 
		if len(toDate & "") = 0 then toDate = Date() %>
    <input name="toDate" id="toDate" type="text" value="<%=toDate%>">
  </p>
   <p><div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="javascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></p></form>
  <%
	dim whichCompany, linkInvoice, simcust, simsite

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
			.CommandText = "SELECT HistoryDetail.Billrate, HistoryDetail.Quantity, HistoryDetail.Payrate, WorkCodes.CompRatePerHundred, " &_
				"WorkCodes.BurdenPercentage, HistoryDetail.Customer, HistoryDetail.Invoice, HistoryDetail.InvoiceDate, HistoryDetail.Workcode, " &_
				"Customers.CustomerName, HistoryDetail.Type, WorkCodes.CompClass " &_
				"FROM ((HistoryDetail HistoryDetail " &_
				"LEFT OUTER JOIN HistorySummary HistorySummary ON (HistoryDetail.Customer=HistorySummary.Customer) " &_
				"AND (HistoryDetail.Invoice=HistorySummary.Invoice)) " &_
				"LEFT OUTER JOIN WorkCodes WorkCodes ON HistoryDetail.Workcode=WorkCodes.WorkCode) " &_
				"LEFT OUTER JOIN Customers Customers ON HistorySummary.Customer=Customers.Customer " &_
 				"WHERE  HistoryDetail.Type<>'C' " &_
				"AND (" & whichCompanyID & "((HistoryDetail.WorkDate)>='" & fromDate & "' And (HistoryDetail.WorkDate)<='" & toDate & "'))" &_
 				"ORDER BY HistoryDetail.Customer, HistoryDetail.Invoice"
								
				'"ORDER BY HistoryDetail.WorkDate DESC;"
			.Prepared = true
		End With
		
		'Response.write getAccountActivity_cmd.CommandText
		'Response.End()
		
		Set AccountActivity = getAccountActivity_cmd.Execute	
		
		
		dim field_count, fld
		
		Response.write "<table style='width:45em%'><tr>"
		
		for each fld in AccountActivity.Fields
			field_count = field_count + 1	
			response.write "<th class='alignC nowrap'>" & fld.Name & "</th>"
		next
		response.write "</tr>"
			
		do while not AccountActivity.eof
			Response.write "<tr>"
			for i = 0 to field_count-1
				Response.write "<td class='nowrap'>" & AccountActivity.Fields.Item(i) & "</td>"
			next 
			'Response.write "<td>" & AccountActivity.Fields.Item(1) & "</td>"
			'Response.write "<td>" & AccountActivity.Fields.Item(2) & "</td>"
			'linkInvoice = chr(34) & "/invoices/" & whichCompany &_
		'		"%20Customer=" & AccountActivity("Customer") & "%20Invoice=" & AccountActivity("Invoice") & ".pdf" & chr(34)
		'	Response.write "<td><a href=" & linkInvoice & ">" & AccountActivity("Invoice") & "</a></td>"
		'	Response.write "<td>" & AccountActivity.Fields.Item(4) & "</td>"
		'	Response.write "<td>" & AccountActivity.Fields.Item(5) & "</td>"
		'	Response.write "<td class='alignC'>$" & TwoDecimals(AccountActivity(6)) & "</td>"
		'	Response.write "<td class='alignC'>$" & TwoDecimals(AccountActivity(7)) & "</td>"
		'	Response.write "<td class='alignR'>" & TwoDecimals(AccountActivity(8)) & "</td>"
		'	Response.write "<td class='alignC'>" & AccountActivity(9) & "</td>"
		'	Response.write "<td class='alignR'>$" & TwoDecimals(AccountActivity(10)) & "</td></tr>"
			AccountActivity.MoveNext
			Response.write "</tr>"
		loop
		Response.write "</table>"
		Set AccountActivity = nothing
		Set getAccountActivity_cmd = Nothing
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
