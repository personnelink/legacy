<%
session("required_user_level") = 1024 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

'some introductions ...
dim which_invoice
which_invoice = request.QueryString("inv")
if isnumeric(which_invoice) then
	which_invoice = cdbl(which_invoice)
end if

dim simcust, simsite
simcust = replace(request.QueryString("simulate_customer"), "'", "''")
if len(simcust & "") > 0 then
	whichCompanyID = "((HistoryDetail.Customer)='" & simcust & "') AND "
elseif len(g_company_custcode.CustomerCode & "") > 0 then
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

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim whichOrder
whichOrder = Request.QueryString("whichOrder")
if len(whichOrder) = 0 then
	whichOrder = request.form("whichOrder")
end if

dim whichApplicant
whichApplicant = Request.QueryString("whichApplicant")
if len(whichApplicant) = 0 then
	whichApplicant = request.form("whichApplicant")
end if

dim thisCustomer
thisCustomer = Request.QueryString("WhichCustomer")
thisCustomer = Replace(thisCustomer, "'", "''")

'figure out what stuff is being requested
select case request.querystring("whatstuff")
case "joborder"
	getJobOrders

end select


sub getJobOrders
	dim strDisplayText

	if len(whichCompany & "") > 0 then
		Select Case whichCompany
		Case "BUR"
			thisConnection = dsnLessTemps(BUR)
		Case "PER"
			thisConnection = dsnLessTemps(PER)
		Case "BOI"
			thisConnection = dsnLessTemps(BOI)
		End Select
		
		Set WhichOrder = Server.CreateObject("ADODB.RecordSet")
		sqlWhichOrder = "SELECT DISTINCT Orders.Customer, Orders.JobDescription, Orders.Reference FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
			"AND (Customers.Customer = Orders.Customer)) " &_
			"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference WHERE (((Orders.JobStatus)=3)) " &_
			"ORDER BY Orders.JobDescription;"
		
		WhichOrder.CursorLocation = 3 ' adUseClient
		WhichOrder.Open sqlWhichOrder, thisConnection
		
		dim CurrentOrder
		response.write "<div id=""topPageRecordsByOrder"" class=""altNavPageRecords navPageRecords"">Job Orders: " &_
			"<input name=""WhichOrder"" id=""WhichOrder"" type=""hidden"">" &_
			
			"<br>"

			CurrentOrder = "@ALL"
			response.write "<A HREF=""#"" onclick=""act_refresh('" & CurrentOrder & "')"">&nbsp;"
			if thisCustomer = CurrentOrder then
				response.write "<span style=""color:red"">" & CurrentOrder & "</span>"
			Else
				response.write CurrentOrder
			end if
			response.write "&nbsp;</A>"
			
		do while not WhichOrder.Eof
			CurrentOrder = WhichOrder("Reference")

			strDisplayText = Replace(WhichOrder("JobDescription"), "&", "&amp;")
			strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
			
			response.write "<A HREF=""#"" onclick=""act_refresh('" & CurrentOrder & "')"">&nbsp;"
			if thisOrder = CurrentOrder then
				response.write "<span style=""color:red"">" & strDisplayText & "</span>"
			Else
				response.write strDisplayText
			end if
			response.write "&nbsp;</A>"
			WhichOrder.MoveNext
	
			linkNumber = linkNumber + 1
			if linkNumber > 10 and Not WhichOrder.Eof then
				linkNumber = 0
				response.write "<br>"
			end if
		loop
		response.write("</div>")

		WhichOrder.Close
		Set WhichOrder = Nothing

	end if
end sub



%>


