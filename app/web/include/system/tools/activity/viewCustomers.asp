<% session("add_css") = "tinyForms.asp.css" %>
<% session("window_page_title") = "Maintain Customers - Personnel Plus" %>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then

dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 365) 
end if

toDate = Request.QueryString("toDate") 
if isDate(toDate) = false then 
	toDate = request.form("toDate") 
	if isDate(toDate) = false then toDate = CStr(Date() + 1)
end if

dim likeName
likeName = Replace(Request.QueryString("likeName"), "'", "''")
if len(likeName) = 0 then 
	likeName = request.form("likeName") 
end if

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

%>

<%=decorateTop("AccountActivity", "marLRB10", "Customers")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="viewCustomers.asp" method="get" />
<table id="formOptions"><tr><td>
      <label style="float:left; clear:left" for="fromDate">From </label>
      <input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
</td><td>
	<label for="toDate" style="float:left; clear:left">To </label>
	<input name="toDate" id="toDate" type="text" value="<%=toDate%>">
</td><td>
	
<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>
<tr><td colspan=3>
      <label style="float:left; clear:left" for="likeName">Search</label>
      <input  style="float:left; clear:left" name="likeName" id="likeName" type="text" value="<%=likeName%>">
</td></tr>
</td></tr>
<tr><td colspan=3><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%>
</td></tr>
</table>

</form>
  <%
	dim linkInvoice, inIDA, inPER, inBUR, inBOI, inAtLeastOne, inSystem, notInSystem, rowEmphasis
	dim ModifiedTime, InsertedTime, Updated
	
	dim strManageLnk
	
	'whichCompany = "IDA"
	'if len(whichCompanyID & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & whichCompanyID & "') AND "
	'end if
	
	'if len(whichCompany & "") > 0 then
		'Select Case whichCompany
		'Case "IDA"
			'thisConnection = TempsPlus(IDA)
		'End Select
		dim sSearchString
		if len(likeName) > 0 then
			sSearchString = "([CustomerName] LIKE '%" & likeName & "%') AND "
		end if
		
		'fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		'toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1

		SQL = "SELECT Customers.Customer, Customers.CustomerName, Customers.Balance, Customers.Cityline, Customers.DateLastActive, Customers.EmailAddress " &_
			"FROM Customers "  &_
			"WHERE " & sSearchString & "DateLastActive>='" & fromDate &_
			"' AND DateLastActive<='" & toDate & "' " &_
			"ORDER BY DateLastActive DESC;"

		Set Customers = Server.CreateObject ("ADODB.RecordSet")
		Customers.CursorLocation = 3 ' adUseClient
		Customers.Open SQL, dsnLessTemps(getTempsDSN(whichCompany))
		
		dim addressLine, userAddressId, lnkName
		'Database.Open MySql
		
		nPage = CInt(Request.QueryString("Page"))
		nItemsPerPage = 50
		Customers.PageSize = nItemsPerPage
		nPageCount = Customers.PageCount

		if nPage < 1 Or nPage > nPageCount then
			nPage = 1
		end if
		
		'Deprecated? 2010.05.17
		'
		'rsQuery = request.serverVariables("QUERY_STRING")
		'queryPageNumber = Request.QueryString("Page")
		'if queryPageNumber then
		'	rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
		'end if
		
		qryOptions = "&fromDate=" & fromDate &_
			"&toDate=" & toDate
		
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""/include/system/tools/activity/viewCustomers.asp?Page=1&" & qryOptions & """>First</A>"
		For i = 1 to nPageCount
			response.write "<A HREF=""/include/system/tools/activity/viewCustomers.asp?Page="& i & qryOptions & """>&nbsp;"
			if i = nPage then
				response.write "<span style=""color:red"">" & i & "</span>"
			Else
				response.write i
			end if
			response.write "&nbsp;</A>"
		Next
		response.write "<A HREF=""/include/system/tools/activity/viewCustomers.asp?Page=" & nPageCount & qryOptions & """>Last</A>"
		response.write("</div>")
	
		' Position recordset to the correct page
		if Not Customers.eof then Customers.AbsolutePage = nPage
		
		Response.write "<div id='appResults'><table class='onlineApps'><tr>" &_
			"<th class=''>Number</th>" &_
			"<th class=''>Customer</th>" &_
			"<th class=''>Balance</th>" &_
			"<th class=''>Location</th>" &_
			"<th class='appDate'>Last Active</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Customers.eof then response.write "No Items found."


dim Customer
dim CustomerName
dim Balance
dim Cityline
dim DateLastActive

do while not ( Customers.Eof Or Customers.AbsolutePage <> nPage )
	
		if Customers.eof then
			Customers.Close
			' Clean up
			' Do the no results HTML here
			response.write "No Items found."
				' Done
			Response.End 
		end if

		
			Customer = Customers.Fields.Item("Customer")
			Balance = "$" & TwoDecimals(Customers.Fields.Item("Balance")) & "&nbsp;"
			CustomerName = Customers.Fields.Item("CustomerName")
			Cityline = Customers.Fields.Item("CityLine")
			DateLastActive = Customers.Fields.Item("DateLastActive")

			strManageLnk = "/include/system/tools/manage/customer/?where=" & whichCompany & "&cust=" & CStr(Customer)
			if i > 0 then
				ShadeData = "FFFFFF"
				i = 0
			Else
				ShadeData = "EFF5FA"
				i = 1
			end if
			
			
			form_link = "<a href='" & strManageLnk & "&amp;action=review'>"
			email = Customers.fields.item("EmailAddress")
			if len(email) > 0 then
				lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & email & Chr(34) & "><img src=" &_
					Chr(34) & emailLink & Chr(34) & "></a>" & form_link & CustomerName
			Else
				lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
					form_link & CustomerName
			end if

			'if Applications("submitted") = "n" then rowEmphasis = rowEmphasis & " notSubmitted"
			Response.write  "<tr style='background-color:#" & ShadeData & "'>" &_
							"<td class='" & rowEmphasis & "'>" & form_link & Customer & "</a></td>" &_
							"<td class='" & rowEmphasis & "'>" & lnkName & "</a></td>" &_
							"<td class='alignR " & rowEmphasis & "'>" & form_link & Balance & "</a></td>" &_
							"<td class='" & rowEmphasis & "'>" & form_link & CityLine & "</a></td>" &_
							"<td class='appDate" & rowEmphasis & "'>" & form_link & DateLastActive & "</a></td></tr>"
			
			Customers.MoveNext
			
		loop
		Response.write "</table></div>"
		Set Applications = nothing
		'Set getApplications_cmd = Nothing
		'Database.Close
	'end if

End if 
response.write "<div id=""topPageRecords"" class=""navPageRecords"">"
response.write "<A HREF=""/include/system/tools/activity/viewCustomers.asp?Page=1" & qryOptions & """>First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""/include/system/tools/activity/viewCustomers.asp?Page="& i & qryOptions & """>&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
	Next
response.write "<A HREF=""/include/system/tools/activity/viewCustomers.asp?Page=" & nPageCount & qryOptions & """>Last</A>"
response.write("</div></div>") %>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
