<% session("add_css") = "tinyForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then
%>
<%=decorateTop("AccountActivity", "notToShort marLR10", "Account Activity")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewTransactions" name="whoseHereForm" action="../../../tools/activity/whoseHere.asp" method="post">
		<!-- Search Results Modeling Goes Here -->
</form>
  <%
	dim whichCompany, linkInvoice

	whichCompany = "IDA"
	if len(whichCompany & "") > 0 then
		Select Case whichCompany
		Case "IDA"
			thisConnection = TempsPlus(IDA)
		End Select
		
		Set getAccountActivity_cmd = Server.CreateObject ("ADODB.Command")
		With getAccountActivity_cmd
			.ActiveConnection = thisConnection
			.CommandText = "SELECT HistoryDetail.WorkDate, HistoryDetail.InvoiceDate, HistoryDetail.Invoice, HistoryDetail.Description, WorkCodes.Description, " &_
				"HistoryDetail.Type, HistoryDetail.Payrate, HistoryDetail.Billrate, HistoryDetail.Customer " &_
				"FROM (Applicants INNER JOIN HistoryDetail ON Applicants.ApplicantID = HistoryDetail.AppId) INNER JOIN WorkCodes ON HistoryDetail.Workcode = " &_
				"WorkCodes.WorkCode " &_
				"ORDER BY HistoryDetail.WorkDate DESC;"
			.Prepared = true
		End With
		
		Set AccountActivity = getAccountActivity_cmd.Execute	
		Response.write "<table style='width:100%'><tr><th>Work Date</th><th>Invoice Date</th><th>Invoice</th><th>Description</th><th>Cost Center</th><th>Type</th><th>Pay Rate</th><th>Bill Rate</th></tr>"
		do while not AccountActivity.eof
			Response.write "<tr><td>" & AccountActivity("WorkDate") & "</td>"
			Response.write "<td>" & AccountActivity("InvoiceDate") & "</td>"
			linkInvoice = chr(34) & "https://www.personnelinc.com/invoices/" & whichCompany &_
				"%20Customer=" & AccountActivity("Customer") & "%20Invoice=" & AccountActivity("Invoice") & ".pdf" & chr(34)
			Response.write "<td><a href=" & linkInvoice & ">" & AccountActivity("Invoice") & "</a></td>"
			Response.write "<td>" & AccountActivity.Fields.Item(3) & "</td>"
			Response.write "<td>" & AccountActivity.Fields.Item(4) & "</td>"
			Response.write "<td>" & AccountActivity("Type") & "</td>"
			Response.write "<td>$" & TwoDecimals(AccountActivity("Payrate")) & "</td>"
			Response.write "<td>$" & TwoDecimals(AccountActivity("Billrate")) & "</td></tr>"
			AccountActivity.MoveNext
		loop
		Response.write "</table>"
		Set AccountActivity = nothing
	end if
End if %>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
