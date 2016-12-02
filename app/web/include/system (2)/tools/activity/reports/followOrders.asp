<%
session("add_css") = "reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<%

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim orderType
orderType = Request.QueryString("type")
if len(orderType) = 0 then
	orderType = request.form("type")
	if len(orderType) = 0 then
		orderType = 1
	end if
end if

%>
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Open Orders That Need People [Unfilled]")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
</form>
  <%
	if len(whichCompany & "") > 0 then
		thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
		Set SubWhoseHere = Server.CreateObject ("ADODB.RecordSet")
		'Set getDailySignIn_cmd = Server.CreateObject ("ADODB.Command")
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")

		With WhoseHere
			'.ActiveConnection = thisConnection
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Orders.Customer, Customers.CustomerName, Orders.Reference, Orders.ReportTo, Orders.JobDescription, " &_
				"Orders.WorkSite1, Orders.WorkSite2, Orders.EmailAddress, Orders.WorkSite3, Orders.JobSupervisor, Orders.Memo, Orders.Bill1, " &_
				"Orders.Bill2, Orders.Bill3, Orders.Bill4, Orders.RecordedBy, Orders.JobChangedBy, Orders.JobChangedDate, Orders.Dispatcher, " &_
				"Orders.NextDispatchDate, OtherOrders.Def1, OtherOrders.Def2 " &_
				"FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)) " &_
				"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
				"WHERE (((Orders.JobStatus)<2)) " &_
				"ORDER BY Orders.JobChangedDate DESC;"
			'.Prepared = true
			'response.write sqlCommandText
			'Response.End()
			.Open sqlCommandText, thisConnection
		End With
		'Set WhoseHere = getDailySignIn_cmd.Execute	
		
	dim maintain_link
	dim resourcelink
	
	resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"


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
	response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount & "&whichCompany=" & whichCompany & "&" & rsQuery & """>Last</A>"
	response.write("</div>")

	' Position recordset to the correct page
	WhoseHere.AbsolutePage = nPage

		dim CustomerCode, ReportTo, JobSupervisor
		do while not ( WhoseHere.Eof Or WhoseHere.AbsolutePage <> nPage )
				if WhoseHere.eof then
					WhoseHere.Close
					' Clean up
					' Do the no results HTML here
					response.write "No Items found."
						' Done
					Response.End 
				end if
				
			CustomerCode = WhoseHere("Customer")
			ReportTo = WhoseHere("ReportTo") : if len(ReportTo) = 0 then ReportTo = "<i>not specified</i>"
			JobSupervisor = WhoseHere("JobSupervisor") : if len(JobSupervisor) = 0 then JobSupervisor = "<i>not specified</i>"

			tableHeader = "<table class='generalTable catCustomer' style='width:100%'>" &_
			"<tr>" &_
				"<th class="""">Reference</th>" &_
				"<th class="""">Customer Name and Job Description</th>" &_
				"<th class=""""></th>" &_
				"<th class="""">Work Site</th>" &_
				"<th class=""""></th>" &_
				"<th class="""">Recorded By</th>" &_
			"</tr><tr>" &_
				"<td>" & CustomerCode & "</td>" &_
				"<td>" & WhoseHere("CustomerName") & "</td>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("WorkSite1") & "</td>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("RecordedBy") & "</td>" &_
			"</tr><tr>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("JobDescription") & "</td>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("WorkSite2") & "</td>" &_
				"<td></td>" &_
				"<th>Job Changed By</th>" &_
			"</tr><tr>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("Def2") & "</td>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("WorkSite3") & "</td>" &_
				"<td></td>" &_
				"<td>" & WhoseHere("JobChangedBy") & "</td>" &_
			"</tr><tr>" &_
				"<th>Report To</th>" &_
				"<td>" & ReportTo & "</td>" &_
				"<td colspan=""4""></td>" &_
			"</tr><tr>" &_
				"<th>Supervisor</th>" &_
				"<td>" & JobSupervisor & "</td>" &_
				"<td></td>" &_
				"<th>Billing Information</th>" &_
				"<td></td>" &_
				"<th>Job Changed Date</th>" &_
			"</tr><tr>" &_
				"<th>Memo</th>" &_
				"<td colspan=""2"">" & WhoseHere("Memo") & "</td>" &_
				"<td>" & WhoseHere("Bill1") & "<br>" &_
					WhoseHere("Bill2") & "<br>" &_
					WhoseHere("Bill3") & "<br>" &_
					WhoseHere("Bill4") & "</td>" &_
					"<td></td>" &_
				"<td>" & WhoseHere("JobChangedDate") & "<br>" &_
					"Dispatcher<br>" &_
					WhoseHere("Dispatcher") & "<br>" &_
					"Next Dispatch Date" & "<br>" &_
					WhoseHere("NextDispatchDate") & "</td>" &_
			"</tr><tr class=""padTB5"">" &_
				"<th class=""padR1"">Description</th>" &_
				"<td colspan=""5"" class=""padTB5"">" & WhoseHere("Def1") & "<br></td>" &_
			"</tr><tr>" &_
				"<td colspan=""6"">"
				
			response.write tableHeader
			
			tableHeaderClose = "</td>" &_
				"</tr></table>"

		'Set getDailySignIn_cmd = Server.CreateObject ("ADODB.Command")
		With SubWhoseHere
			'.ActiveConnection = thisConnection
			.CursorLocation = 3 ' adUseClient
			dim sqlSubCommandText
			sqlSubCommandText = "SELECT Appointments.AppDate, Appointments.Reference, Applicants.LastnameFirst, Appointments.Comment, " &_
				"Appointments.Customer, Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.EnteredBy, " &_
				"Dispositions.Disposition, ApptTypes.ApptType, Appointments.AssignedTo " &_
				"FROM ApptTypes INNER JOIN ((((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer) LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				"INNER JOIN Dispositions ON Appointments.DispTypeCode = Dispositions.DispTypeCode) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode " &_
				"WHERE (((Appointments.Customer)='" & CustomerCode & "') " &_
				"AND ((ApptTypes.ApptTypeCode)=0 Or (ApptTypes.ApptTypeCode)=7 Or (ApptTypes.ApptTypeCode)=13)) " &_
				"ORDER BY Orders.Reference ASC, Orders.JobDescription ASC, Appointments.AppDate DESC"
			'.Prepared = true
			'response.write sqlSubCommandText
			'Response.End()
			.Open sqlSubCommandText, thisConnection
		End With
		'Set WhoseHere = getDailySignIn_cmd.Execute	

		tableSubHeader = "<table class='generalTable catActivity' style='width:100%'><tr>" &_
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
		
		
		dim PreviousJobOrder, CurrentJobOrder
		
		if not SubWhoseHere.Eof then PreviousJobOrder = SubWhoseHere("Reference") 'init
		
		do while not ( SubWhoseHere.Eof )
				if SubWhoseHere.eof then
					SubWhoseHere.Close
					' Clean up
					' Do the no results HTML here
					response.write "No Items found."
						' Done
					Response.End 
				end if
				
			CurrentJobOrder = SubWhoseHere("Reference")
			if PreviousJobOrder <> CurrentJobOrder then 
				PreviousJobOrder = CurrentJobOrder 
				Response.write tableHeaderClose & tableHeader
			end if
				CommentBlob = SubWhoseHere("Comment")
				if len(CommentBlob) = 0 then
					CommentBlob = "{none}"
				end if
	
				applicantid = SubWhoseHere("ApplicantID")
				lastnameFirst = SubWhoseHere("LastnameFirst")
				
				maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>" &_
					applicantid & " : " & lastnameFirst
	
	
				tableSubRecord = "<tr>" &_
					"<td>" & SubWhoseHere("AppDate") & "</td>" &_
				"<td>" & SubWhoseHere("Customer") & " : " & SubWhoseHere("CustomerName") & "</td>" &_
				 "<td>" & SubWhoseHere("ApptType") & "</td>" &_
				"<td></td>" &_
				"<td>" & SubWhoseHere("EnteredBy") & "</td>" &_
				"</tr><tr>" &_
					"<th></th>" &_
					"<td>" & SubWhoseHere("Reference") & " : " & SubWhoseHere("JobDescription") & "</td>" &_
					"<th colspan=""3""></th>" &_
				"</tr><tr>" &_
					"<th></th>" &_
					"<th>Applicant</th>" &_
					"<th>Status</th>" &_
					"<th></th>" &_
					"<th>Assigned To</th>" &_
				"</tr><tr>" &_
					"<td></td>" &_
					"<td>" & maintain_link & "</td>" &_
					"<td colspan=""2"">" & SubWhoseHere("Disposition") & "</td>" &_
					"<td>" & SubWhoseHere("AssignedTo") & "</td>" &_
				"</tr><tr>" &_
				"<td colspan=""5"">" & CommentBlob & "</td>" &_
				"</tr>"
				
				Response.write tableSubHeader
				Response.write tableSubRecord
				Response.write "</table>"
				Response.Flush

			SubWhoseHere.MoveNext
		loop
		SubWhoseHere.Close
		Response.write tableHeaderClose
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
</div><%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
