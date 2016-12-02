<%
session("add_css") = "reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

 %>
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Marketing Activities")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
</form>
  <%
	if len(whichCompany & "") > 0 then
		thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Appointments.AppDate, Customers.Customer, Customers.CustomerName, Appointments.AssignedTo, " &_
				"Appointments.EnteredBy, ApptTypes.ApptType, Appointments.Comment, Appointments.Entered, Dispositions.Disposition " &_
				"FROM Dispositions INNER JOIN (ApptTypes RIGHT JOIN (Customers RIGHT JOIN Appointments ON Customers.Customer = " &_
				"Appointments.Customer) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) ON Dispositions.DispTypeCode = " &_
				"Appointments.DispTypeCode " &_
				"WHERE (((ApptTypes.ApptTypeCode)=14) OR ((ApptTypes.ApptTypeCode)=5)) " &_
				"ORDER BY Appointments.AppDate DESC;"
			.Open sqlCommandText, thisConnection
		End With
		
	dim nPage, nItemsPerPage, nPageCount
	nPage = CInt(Request.QueryString("Page"))
	nItemsPerPage = 20
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
	response.write("</div>")

	' Position recordset to the correct page
	if not WhoseHere.eof then WhoseHere.AbsolutePage = nPage

		tableHeader = "<table class='generalTable' style='width:100%'><tr>" &_
			"<th class=""dateAndTime"">Date & Time</th>" &_
			"<th class=""customer"">Customer</th>" &_
			"<th class=""reason"">Reason</th>" &_
			"<th class=""""></th>" &_
			"<th class=""user"">Entered By</th>" &_
			"</tr><tr>" &_
			"<th></th>" &_
			"<th colspan=""3""></th>" &_
			"<th></th>" &_
			"</tr>"
	
		dim CommentBlob
		do while not (WhoseHere.eof Or WhoseHere.AbsolutePage <> nPage)

			if WhoseHere.eof then
				WhoseHere.Close
				' Clean up
				' Do the no results HTML here
				response.write "No Items found."
					' Done
				Response.End 
			end if

			CommentBlob = WhoseHere("Comment")
			
			if len(CommentBlob) = 0 then
				CommentBlob = "{none}"
			end if

			tableRecord = "<tr>" &_
				"<td>" & WhoseHere("AppDate") & "</td>" &_
				"<td>" & WhoseHere("Customer") & " : " & WhoseHere("CustomerName") & "</td>" &_
				"<td>" & WhoseHere("ApptType") & "</td>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("EnteredBy") & "</td>" &_
			"</tr>"
			
			tableRecord = tableRecord & "<tr>" &_
			"<th></th>" &_
			"<th></th>" &_
			"<th>Status</th>" &_
			"<th></th>" &_
			"<th>Assigned To</th>" &_
			"</tr><tr>" &_
				"<td></td>" &_
				"<td>" & "</td>" &_
				"<td colspan=""2"">" & WhoseHere("Disposition") & "</td>" &_
				"<td>" & WhoseHere("AssignedTo") & "</td>" &_
			"</tr><tr>" &_
			"<td colspan=""5"">" & CommentBlob & "</td>" &_
			"</tr>"
			Response.write tableHeader
			Response.write tableRecord
			Response.write "</table>"
			WhoseHere.MoveNext
		loop
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
		response.write("</div>")
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
