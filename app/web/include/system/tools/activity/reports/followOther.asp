<%
session("add_css") = "reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Placement Follow Up Status")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
<%whichCompany = request.form("whichCompany")%>
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
</form>
  <%
	dim whichCompany

	whichCompany = request.form("whichCompany")
	if len(whichCompany & "") > 0 then
		thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Appointments.AppDate, Customers.CustomerName, Appointments.Comment, Dispositions.Disposition, ApptTypes.ApptType, " &_
				"Appointments.AssignedTo " &_
				"FROM (ApptTypes INNER JOIN " &_
				"(((Appointments INNER JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"INNER JOIN Customers ON Appointments.Customer = Customers.Customer) " &_
				"INNER JOIN Orders ON Appointments.Reference = Orders.Reference) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) " &_
				"INNER JOIN Dispositions ON Appointments.DispTypeCode = Dispositions.DispTypeCode " &_
				"WHERE ((ApptTypes.ApptTypeCode)=4)) " &_
				"ORDER BY Appointments.AppDate DESC;"
			.Open sqlCommandText, thisConnection
		End With
		
	dim nPage, nItemsPerPage, nPageCount
	nPage = CInt(Request.QueryString("Page"))
	nItemsPerPage = 50
	WhoseHere.PageSize = nItemsPerPage
	nPageCount = WhoseHere.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
	
	rsQuery = request.serverVariables("QUERY_STRING")
	queryPageNumber = Request.QueryString("Page")
	if queryPageNumber then
		rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
	end if

	response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
	response.write "<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & "&" & rsQuery & """>First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & "&" & rsQuery & """>&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
	Next
	response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount & "&whichCompany=" & whichCompany & "&" & rsQuery & """>Last</A>"
	response.write("</div>")

	' Position recordset to the correct page
	if not WhoereHere.eof then WhoseHere.AbsolutePage = nPage

		
		tableHeader = "<table style='width:100%'><tr>" &_
			"<th>Date</th>" &_
			"<th>Company</th>" &_
			"<th>What</th>" &_
			"<th>Status</th>" &_
			"<th>Owner</th>" &_
			"</tr>"
	
		Response.write tableHeader
		do while not WhoseHere.eof
				
			tableRecord = "<tr>" &_
				"<td>" & WhoseHere("AppDate") & "</td>" &_
				"<td>" & WhoseHere("CustomerName") & "</td>" &_
				"<td>" & WhoseHere("Comment") & "</td>" &_
				"<td>" & WhoseHere("Disposition") & "</td>" &_
				"<td>" & WhoseHere("AssignedTo") & "</td>" &_
			"</tr>"

			Response.write tableRecord
			WhoseHere.MoveNext
		loop
		Response.write "</table>"
		Set WhoseHere = nothing
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & """>First</A>"
		For i = 1 to nPageCount
			response.write "<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & """>&nbsp;"
			if i = nPage then
				response.write "<span style=""color:red"">" & i & "</span>"
			Else
				response.write i
			end if
			response.write "&nbsp;</A>"
		Next
		response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount & "&whichCompany=" & whichCompany & """>Last</A>"
		response.write("</div></div>")
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
