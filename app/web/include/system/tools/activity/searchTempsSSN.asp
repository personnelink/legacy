<% session("add_css") = "./searchTempsSSN.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelSupervisor) = true then

'if len(session("insertInfo")) > 0 then
'	response.write(decorateTop("doneInsertingApp", "marLR10", "Applicants Attachments"))
'	response.write(session("insertInfo"))
'	response.write(decorateBottom())
'	session("insertInfo") = ""
'end if
tempsdsn = request.form("tempsdsn")
if len(tempsdsn) = 0 then
	tempsdsn = "boi"
end if

showLeftSideMenu = false
checkedText = "checked=""checked"""
sgOptionCustomer = request.form("sgOptionCustomer")
sgOptionApplicant = request.form("sgOptionApplicant")
%>
<%=decorateTop("AccountActivity", "notToShort marLRB10", "Attachments")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="searchTempsSSN.asp" method="post" class="oneHalf left">

<ul class="guide">
<li>      <label style="float:left; clear:left" for="fromDate">Enter Applicant SSN to Search </label>
      <% social = request.form("social")%>
      <input  style="float:left;" name="social" id="social" type="text" value="<%=social%>" onKeyPress="return submitenter(this,event)"></li>

</ul>	

<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></div></form><div style="clear:both; width:80%">&nbsp;</div>
  <%
	dim whichCompany, linkInvoice, inIDA, inPER, inBUR, inBOI, inPPI, inAtLeastOne, inSystem, notInSystem, rowEmphasis
	dim ModifiedTime, InsertedTime, Updated
	
	dim applicationLink
	
	'whichCompany = "IDA"
	'if len(whichCompanyID & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & whichCompanyID & "') AND "
	'end if
	
	'if len(whichCompany & "") > 0 then
		'Select Case whichCompany
		'Case "IDA"
			'thisConnection = TempsPlus(IDA)
		'End Select

		searchSocial = Replace(request.form("social"), "'", "''")
		'searchLastnameFirst = Replace(request.form("LastnameFirst"), "'", "''")
		'if len(searchLastnameFirst) > 0 then
		'	sGuideString = "WHERE Applicants.LastnameFirst LIKE '%" & searchLastnameFirst & "%' "
		'end if
		
		'if len(searchSoical) > 0 then
		'	if len(searchLastnameFirst) > 0 then
		'		sGuideString = sGuideString & "AND Applicants.SSNumber LIKE '%" & searchSocial & "%' "
		'	Else
		'		sGuideString = "WHERE Applicants.SSNumber LIKE '%" & searchSocial & "%' "
		'	end if
		'end if
		'
		'if len(sGuideString) = 0 then
		'	sGuideString = "WHERE Attachments.FileName Is Not Null "
		'end if


		'Database.Open MySql
		
		'nPage = CInt(Request.QueryString("Page"))
		nItemsPerPage = 125
		'Attachments.PageSize = nItemsPerPage
		'nPageCount = Attachments.PageCount

		'if nPage < 1 Or nPage > nPageCount then
		'	nPage = 1
		'end if
		
		'response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		'response.write "<A HREF=""/include/system/tools/activity/viewAttachments.asp?Page=1"">First</A>"
		'For i = 1 to nPageCount
		'	response.write "<A HREF=""/include/system/tools/activity/viewAttachments.asp?Page="& i & """>"
		'	if i = nPage then
		'		response.write "<span style=""color:red"">" & i & "</span>"
		'	Else
		'		response.write i
		'	end if
		'	response.write "&nbsp;</A>"
		'Next
		'response.write "<A HREF=""/include/system/tools/activity/viewAttachments.asp?Page=" & nPageCount & """>Last</A>"
		'response.write("</div>")
	
		' Position recordset to the correct page
				
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		SQL = "SELECT Applicants.LastnameFirst, Applicants.Address, Applicants.City, Applicants.State, Applicants.Zip, " &_
			"Applicants.SSNumber, Attachments.FileName, NotesApplicants.Notes AS AppNotes, NotesEmployees.Notes AS EmpNotes " &_
			"FROM ((Applicants LEFT JOIN NotesApplicants ON Applicants.ApplicantID = NotesApplicants.ApplicantId) " &_
			"LEFT JOIN Attachments ON Applicants.ApplicantID = Attachments.ApplicantId) " &_
			"LEFT JOIN NotesEmployees ON Applicants.EmployeeNumber = NotesEmployees.Employee " &_
			"WHERE Applicants.SSNumber LIKE '%" & searchSocial & "' " &_
			"ORDER BY Applicants.LastnameFirst;"
	
		'response.write SQL
		'Response.End()
		dim addressLine, userAddressId, getUserAddress, lnkName
		dim LastnameFirst, ApplicantAddress, CityStateZip, SSNumber, FileName, AppNotes,  EmpNotes

	if len(searchSocial & "") > 0 then
		For Each item In dsnLessTemps
			on error resume next
			if instr(item, "BLY") = 0 and instr(item, "BSE") = 0 then
				'response.write(item)
				
				Set Attachments = Server.CreateObject ("ADODB.RecordSet")
				Attachments.CursorLocation = 3 ' adUseClient
				if len(item) > 0 then 
					Attachments.Open SQL, item	
				
					if Attachments.eof then
						Attachments.Close
						response.write "Not in " & Right(item, 12) & "<br><br>"
					Else
						'do while not ( Attachments.Eof )
							response.write "<b>Found in <i>" & Right(item, 12) & "</i></b><br><br>"
	
							Response.write "<div id='attachments'><table style='width:100%' class='fileAttachments'><tr>" &_
								"<th class=''>Lastname, First</th>" &_
								"<th class=''>Address</th>" &_
								"<th class=''>SSNumber</th>" &_
								"<th class='' colspan='2'>Notes</th></tr>"
					
								
								LastnameFirst = Attachments.Fields.Item("LastnameFirst")
								ApplicantAddress = Attachments.Fields.Item("Address")
								CityStateZip = Attachments.Fields.Item("City") & " " & Attachments.Fields.Item("State") & ", " & Attachments.Fields.Item("Zip")
								SSNumber = Attachments.Fields.Item("SSNumber")
								FileName = Attachments.Fields.Item("FileName")
								AppNotes = Attachments.Fields.Item("AppNotes")
								EmpNotes = Attachments.Fields.Item("EmpNotes")
								
								
								
								
								'applicationLink = "\\personnelplus.net.\attachments" & CStr(appID)
								if i > 0 then
									ShadeData = "FFFFFF"
									i = 0
								Else
									ShadeData = "EFF5FA"
									i = 1
								end if
								
								Response.write "<tr style='background-color:#" & ShadeData & "'>" &_
									"<td class=''>" & LastnameFirst & "</td>" &_
									"<td class=''>" & ApplicantAddress & "<br>" & CityStateZip & "</td>" &_
									"<td class=''>" & SSNumber & "</a></td>" &_
									"<td class='' colspan='2'><textarea>" & AppNotes & "</textarea><br><br>" &_
									"<textarea>" & EmpNotes & "</textarea></td>" &_
									"</tr><tr style='background-color:#" & ShadeData & "'>" &_
									"<td class='' colspan='5'><a href='file:\\personnelplus.net.\attachments\" & FileName & "'>" & FileName & "</a></td>" &_
									"</tr>"
								
								Attachments.MoveNext
								'userAddressId = Attachments."addressID")
								'if len(userAddressId) > 0 then
									'Set getUserAddress = Database.Execute("SELECT city, state, zip FROM tbl_addresses WHERE addressID=" & userAddressID)
									'addressLine = PCase(getUserAddress.Fields.Item("city")) & ", " & UCase(getUserAddress.Fields.Item("state")) & " " & getUserAddress.Fields.Item("zip")
								'Else
									'addressLine = PCase(Attachments.Fields.Item("city")) & ", " & UCase(Attachments.Fields.Item("appState")) & " " & Attachments.Fields.Item("zipcode")
								'end if
								'Set getUserAddress = Nothing
								
								'form_link = "<a href='" & applicationLink & "&amp;action=review'>"
								'applicantEmail = Attachments."email")
								'if len(applicantEmail) > 0 then
								'	lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & Chr(34) & "><img src=" &_
								'		Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Attachments.Fields.Item("lastName") & ", " & Attachments.Fields.Item("firstName")
								'Else
								'	lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
								'		form_link & Attachments.Fields.Item("lastName") & ", " & Attachments.Fields.Item("firstName")
								'end if
						'loop
						Response.write "</table></div>"
						Attachments.Close
					end if
				end if
			end if
			on error goto 0
		Next
	end if
	Set Attachments = nothing
	'Set getAttachments.cmd = Nothing
	'end if
End if 
%>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
