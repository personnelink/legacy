<% session("add_css") = "tinyForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelSupervisor) = true then

if len(session("insertInfo")) > 0 then
	response.write(decorateTop("doneInsertingApp", "marLR10", "Applicants Application Insertion"))
	response.write(session("insertInfo"))
	response.write(decorateBottom())
	session("insertInfo") = ""
end if
%>

<%=decorateTop("AccountActivity", "notToShort marLRB10", "Employment Applications")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="viewApplications.asp" method="post" class="oneHalf left">
<p>&nbsp;</p>
<p style="float:left; clear:left">
      <label style="float:left; clear:left" for="fromDate">From </label>
      <% fromDate = request.form("fromDate") 
		if isDate(fromDate) = false then fromDate = CStr(Date() - 7) %>
      <input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
    </p>
	
<p style="float:left; clear:right; margin-left:2.4em; ">
      <label for="toDate" style="float:left; clear:left">To </label>
      <% toDate = request.form("toDate") 
		if isDate(toDate) = false then toDate = CStr(Date() + 1) %>
      <input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=toDate%>">
    </p>
	
<p><div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></form>
  <%
	dim whichCompany, linkInvoice, inIDA, inPER, inBUR, inBOI, inAtLeastOne, inSystem, notInSystem, rowEmphasis
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
		
		fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1

		SQL = "SELECT tbl_users.addressID, tbl_applications.applicationId, tbl_applications.email, tbl_applications.lastName, " &_
				"tbl_applications.firstName, tbl_applications.ssn, tbl_applications.city, tbl_applications.appState, tbl_applications.zipcode, " &_
				"tbl_applications.modifiedDate, tbl_applications.inPER, tbl_applications.inIDA, tbl_applications.inBOI, tbl_applications.inBUR, " &_
				"tbl_applications.lastInserted, tbl_applications.submitted " &_
				"FROM tbl_users RIGHT JOIN tbl_applications ON tbl_users.applicationId = tbl_applications.applicationId " &_
				"WHERE tbl_applications.modifiedDate>='" & fromMySqlFriendlyDate &_
				"' AND tbl_applications.modifiedDate<='" & toMySqlFriendlyDate & "' AND submitted='y' " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"
		
		Set Applications = Server.CreateObject ("ADODB.RecordSet")
		Applications.CursorLocation = 3 ' adUseClient
		Applications.Open SQL, MySql
		
		'Response.write getApplications_cmd.CommandText
		'Response.End()

		Response.write "<div id='appResults'><table class='onlineApps'><tr>" &_
			"<th class='appCompanies' colspan='4'>Insert Into</th>" &_
			"<th class='appName'>Name</th>" &_
			"<th class='appSSN'>SSN4</th>" &_
			"<th class='appLocation'>Location</th>" &_
			"<th class='appDate'>Date</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

	
		dim addressLine, userAddressId, getUserAddress, lnkName
		Database.Open MySql
		
		nPage = CInt(Request.QueryString("Page"))
		nItemsPerPage = 75
		Applications.PageSize = nItemsPerPage
		nPageCount = Applications.PageCount

		if nPage < 1 Or nPage > nPageCount then
			nPage = 1
		end if
		
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""/include/system/tools/activity/devViewApplications.asp?Page=1"">First</A>"
		For i = 1 to nPageCount
			response.write "<A HREF=""/include/system/tools/activity/devViewApplications.asp?Page=" & i & " "">&nbsp;" & i & "&nbsp;</A>"
		Next
		response.write "<A HREF=""/include/system/tools/activity/devViewApplications.asp?Page=" & nPageCount & """>Last</A>"
		response.write("</div>")
	
		' Position recordset to the correct page
		Applications.AbsolutePage = nPage

dim rsDataInBUR
do while not ( Applications.Eof Or Applications.AbsolutePage <> nPage )
	
		if Applications.eof then
			Applications.Close
			' Clean up
			' Do the no results HTML here
			response.write "No Items found."
				' Done
			Response.End 
		end if

		
			appID = Applications.Fields.Item("applicationId")
			ssn = Applications.Fields.Item("ssn")
			inAtLeastOne = false : rowEmphasis = ""
			
			inIDA = notInSystem
			inBOI = notInSystem
			inPER = notInSystem
			inBUR = notInSystem
			
			if Not VarType(Applications("inIDA")) = 1 then
				inIDA = inSystem
				inAtLeastOne = true
			end if
			
			if Not VarType(Applications("inPER")) = 1 then
				inPER = inSystem
				inAtLeastOne = true
			end if

			if Not VarType(Applications("inBOI")) = 1 then
				inBOI = inSystem
				inAtLeastOne = true
			end if
			
			if Not VarType(Applications("inBUR")) = 1 then
				inBUR = inSystem
				inAtLeastOne = true
			end if
			
			if inAtLeastOne = false then
				rowEmphasis = " notInSystem"
			end if
			
			ModifiedTime = Applications.Fields.Item("modifiedDate")
			InsertedTime = Applications.Fields.Item("lastInserted")
			if  DateDiff("n", InsertedTime, ModifiedTime) > 0 then
				rowEmphasis = " notInSystem"
				Updated = "<img src=" & Chr(34) & updatedLink & Chr(34) & ">"
			Else
				Updated = "<img src=" & Chr(34) & notUpdatedLink & Chr(34) & ">"
			end if
			
			applicationLink = "/pdfServer/pdfApplication/createApplication.asp?appID=" & CStr(appID)
			if i > 0 then
				ShadeData = "FFFFFF"
				i = 0
			Else
				ShadeData = "EFF5FA"
				i = 1
			end if
			
			userAddressId = Applications("addressID")
			if len(userAddressId) > 0 then
				Set getUserAddress = Database.Execute("SELECT city, state, zip FROM tbl_addresses WHERE addressID=" & userAddressID)
				addressLine = PCase(getUserAddress.Fields.Item("city")) & ", " & UCase(getUserAddress.Fields.Item("state")) & " " & getUserAddress.Fields.Item("zip")
			Else
				addressLine = PCase(Applications.Fields.Item("city")) & ", " & UCase(Applications.Fields.Item("appState")) & " " & Applications.Fields.Item("zipcode")
			end if
			Set getUserAddress = Nothing
			
			form_link = "<a href='" & applicationLink & "&amp;action=review'>"
			applicantEmail = Applications("email")
			if len(applicantEmail) > 0 then
				lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & Chr(34) & "><img src=" &_
					Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName")
			Else
				lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
					form_link & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName")
			end if
			
			Response.write "<tr style='background-color:#" & ShadeData & "'>"
			Response.write "<td class='appCompany'><a " & inBOI & "href='" & appplicationLink & "&amp;action=inject&amp;company=BOI'>BOI</a></td>"
			Response.write "<td class='appCompany'><a " & inBUR & "href='" & appplicationLink & "&amp;action=inject&amp;company=BUR'>BUR</a></td>"
			Response.write "<td class='appCompany'><a " & inPER & "href='" & appplicationLink & "&amp;action=inject&amp;company=PER'>PER</a></td>"
			Response.write "<td class='appCompany'><a " & inIDA & "href='" & appplicationLink & "&amp;action=inject&amp;company=IDA'>IDA</a></td>"
			Response.write "<td class='appName" & rowEmphasis & "'>" & lnkName & "</a></td>"
			Response.write "<td class='appSSN" & rowEmphasis & "'>" & form_link & Right(ssn, 4) & "</a></td>"
			Response.write "<td class='appLocation" & rowEmphasis & "'>" & form_link & addressLine & "</a></td>"
			Response.write "<td class='appDate" & rowEmphasis & "'>" & form_link & FormatDateTime(Applications.Fields.Item("modifiedDate"), 2) & "</a></td></tr>"
			inBOI = "" : inBUR = "" : inPER = "" : inIDA = "" : 
			Applications.MoveNext
		loop
		Response.write "</table></div>"
		Set Applications = nothing
		'Set getApplications_cmd = Nothing
		Database.Close
	'end if
End if 
response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
response.write "<A HREF=""/include/system/tools/activity/devViewApplications.asp?Page=1"">First</A>"
For i = 1 to nPageCount
	response.write "<A HREF=""/include/system/tools/activity/devViewApplications.asp?Page=" & i & " "">&nbsp;" & i & "&nbsp;</A>"
Next
response.write "<A HREF=""/include/system/tools/activity/devViewApplications.asp?Page=" & nPageCount & """>Last</A>"
response.write("</div>") %>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
