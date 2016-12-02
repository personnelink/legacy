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
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Placement Follow Up Status")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
</form>
  <%
	if len(whichCompany & "") > 0 then
		thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
				
		'Set getDailySignIn_cmd = Server.CreateObject ("ADODB.Command")
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")

		With WhoseHere
			'.ActiveConnection = thisConnection
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
				"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.EnteredBy, " &_
				"Dispositions.Disposition, ApptTypes.ApptType, Appointments.AssignedTo " &_
				"FROM (ApptTypes INNER JOIN " &_
				"(((Appointments INNER JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"INNER JOIN Customers ON Appointments.Customer = Customers.Customer) " &_
				"INNER JOIN Orders ON Appointments.Reference = Orders.Reference) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) " &_
				"INNER JOIN Dispositions ON Appointments.DispTypeCode = Dispositions.DispTypeCode " &_
				"WHERE (((ApptTypes.ApptTypeCode)=0) OR ((ApptTypes.ApptTypeCode)=4) OR ((ApptTypes.ApptTypeCode)=6)) " &_
				"ORDER BY Appointments.AppDate DESC;"
			'.Prepared = true
			'response.write sqlCommandText
			'Response.End()
			.Open sqlCommandText, thisConnection
		End With
		'Set WhoseHere = getDailySignIn_cmd.Execute	
		
		
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

		tableHeader = "<table class='placementTbl' style='width:100%'><tr>" &_
				"<th class=""dateAndTime"">Date & Time</th>" &_
				"<th class=""customer"">Applicant</th>" &_
				"<th class=""reason"">Reason</th>" &_
				"<th class=""""></th>" &_
				"<th class=""user"">Entered By</th>" &_
			"</tr><tr>" &_
				"<th></th>" &_
				"<th colspan=""3""></th>" &_
				"<th></th>" &_
			"</tr>"
		
		
		dim phoneApplicant, phoneCustomer, phoneOrder, contactOrder, contactCustomer
		dim applicantid, lastnameFirst, maintain_link, resourcelink
		
		resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"
		
		do while not ( WhoseHere.Eof Or WhoseHere.AbsolutePage <> nPage )
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

			phoneApplicant = WhoseHere("TelePhone")
			phoneCustomer = WhoseHere("Phone")
			phoneOrder = WhoseHere("WorkSite3")

			applicantid = WhoseHere("ApplicantID")
			lastnameFirst = WhoseHere("LastnameFirst")
			maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>" &_
				applicantid & " : " & lastnameFirst
				
			tableRecord = "<tr>" &_
				"<td>" & WhoseHere("AppDate") & "</td>" &_
			"<td>" & maintain_link & "</td>" &_
			 "<td>" & WhoseHere("ApptType") & "</td>" &_
			"<td></td>" &_
			"<td>" & WhoseHere("EnteredBy") & "</td>" &_
			"</tr><tr>" &_
				"<th></th>" &_
				"<td>" & FormatPhone(phoneApplicant) & "</td>" &_
				"<td></td>" &_
				"<td></td>" &_
				"<td></td>" &_
			"</tr><tr>" &_
				"<th>Customer</th>" &_
				"<th>Job Order</th>" &_
				"<th>Status</th>" &_
				"<th></th>" &_
				"<th>Assigned To</th>" &_
			"</tr><tr>" &_
				"<td>" & WhoseHere("Customer") & " : " & WhoseHere("CustomerName") & "</td>" &_
				"<td>" & WhoseHere("Reference") & " : " & WhoseHere("JobDescription") & "</td>" &_
				"<td colspan=""2"">" & WhoseHere("Disposition") & "</td>" &_
				"<td>" & WhoseHere("AssignedTo") & "</td>" &_
			"</tr><tr>" &_
				"<td>" & WhoseHere("Contact") & " : " & FormatPhone(phoneCustomer) & "</td>" &_
				"<td>" & WhoseHere("JobSupervisor") & " : " & FormatPhone(phoneOrder) & "</td>" &_
			"</tr><tr><td colspan=""5"">&nbsp;</td>" &_
			"</tr><tr>" &_
				"<td colspan=""4""><b>Memo</b> : " & CommentBlob & "</td>" &_
			"</tr>"
			
			Response.write tableHeader
			Response.write tableRecord
			Response.write "</table>"




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
		response.write("</div>")
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
