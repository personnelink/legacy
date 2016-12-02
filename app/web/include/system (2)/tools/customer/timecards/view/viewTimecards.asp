<%
session("add_css") = "./viewTimecards.css"
session("no_cache") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="viewTimecards.js"></script>

<!-- #include file='viewTimecards.do.asp' -->

<%=decorateTop("", "marLRB10", "Timecards")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="viewTimecards.asp" method="get" />
<table id="formOptions"><tr><td>
      <label for="fromDate">From </label>
      <input  name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
</td><td>
	<label for="toDate">To </label>
	<input name="toDate" id="toDate" type="text" value="<%=toDate%>">
</td><td>
	
<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>
<tr><td colspan=3>
      <label for="likeName">Search</label>
      <input name="likeName" id="likeName" type="text" value="<%=likeName%>">
</td></tr>
</table>
</form>
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
		dim sSearchString
		if len(likeName) > 0 then
			sSearchString = "((CONCAT(tbl_users.lastName,', ',tbl_users.firstName)) LIKE '%" & likeName & "%') AND "
		end if
		
		fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1

		SQL = "SELECT list_status.description AS stat_desc, tbl_timecards.status, CONCAT(tbl_users.lastName,', ',tbl_users.firstName) AS lastnameFirst, " &_
			"tbl_companies.companyName, tbl_timecards.timecardID, tbl_companies.companyid, tbl_users.addressID, tbl_locations.description AS " &_
			"loca_desc, tbl_timecards.weekending, tbl_timecards.modifiedDate, tbl_users.userEmail, tbl_timecards.approvedDate, tbl_timecards.timeinfo, " &_
			"(SELECT CONCAT(tbl_users.firstName,' ',tbl_users.lastName) From tbl_users where userID = tbl_timecards.approver) AS approver " &_
			"FROM ((tbl_users RIGHT JOIN (tbl_companies RIGHT JOIN tbl_timecards ON tbl_companies.companyid = tbl_timecards.companyID) " &_
			"ON tbl_users.userID = tbl_timecards.userID) LEFT JOIN tbl_locations ON tbl_users.locationid = tbl_locations.locationID) " &_
			"LEFT JOIN list_status ON tbl_timecards.status = list_status.short " &_
			"WHERE " & sSearchString & "tbl_timecards.modifiedDate>='" & fromMySqlFriendlyDate &_
			"' AND tbl_timecards.modifiedDate<='" & toMySqlFriendlyDate & "' " &_
			"ORDER BY tbl_timecards.weekending DESC, tbl_locations.description ASC, CONCAT(tbl_users.lastName,', ',tbl_users.firstName) ASC;"
		
	Set Timecards = Server.CreateObject ("ADODB.RecordSet")
		Timecards.CursorLocation = 3 ' adUseClient
		Timecards.Open SQL, MySql
		
		dim addressLine, userAddressId, getUserAddress, employeeDisplayName
		Database.Open MySql
		
		nPage = CInt(Request.QueryString("Page"))
		nItemsPerPage = 25
		Timecards.PageSize = nItemsPerPage
		nPageCount = Timecards.PageCount

		if nPage < 1 Or nPage > nPageCount then
			nPage = 1
		end if
		
		qryOptions = "&fromDate=" & fromDate &_
			"&toDate=" & toDate
		
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""/include/system/tools/activity/viewTimecards.asp?Page=1&" & qryOptions & """>First</A>"
		For i = 1 to nPageCount
			response.write "<A HREF=""/include/system/tools/activity/viewTimecards.asp?Page="& i & qryOptions & """>&nbsp;"
			if i = nPage then
				response.write "<span style=""color:red"">" & i & "</span>"
			Else
				response.write i
			end if
			response.write "&nbsp;</A>"
		Next
		response.write "<A HREF=""/include/system/tools/activity/viewTimecards.asp?Page=" & nPageCount & qryOptions & """>Last</A>"
		response.write("</div>")
	
		' Position recordset to the correct page
		if Not Timecards.eof then Timecards.AbsolutePage = nPage
		
		Response.write "<div id='timecards'><table><tr>" &_
			"<th class='tempscodes' colspan='4'>Insert Into<br>Status</th>" &_
			"<th class='timestatus'></th>" &_
			"<th class='employee'>Employee<br>Activity, Hours</th>" &_
			"<th class='location'>Company</th>" &_
			"<th class='totalhours'>Location</th>" &_
			"<th class='weekending'>Week Ends</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Timecards.eof then response.write "No Items found."

dim approver, approved

do while not ( Timecards.Eof Or Timecards.AbsolutePage <> nPage )
	
		if Timecards.eof then
			Timecards.Close
			' Clean up
			' Do the no results HTML here
			response.write "No Items found."
				' Done
			Response.End 
		end if

		
			timeid = Timecards.Fields.Item("timecardID")
			'ssn = Timecards.Fields.Item("ssn")
			'inAtLeastOne = false : rowEmphasis = ""
			
			'inIDA = notInSystem
			'inBOI = notInSystem
			'inPER = notInSystem
			'inBUR = notInSystem
			
			'if Not VarType(Applications("inIDA")) = 1 then
			'	inIDA = inSystem
			'	inAtLeastOne = true
			'end if
			
			'if Not VarType(Applications("inPER")) = 1 then
			'	inPER = inSystem
			'	inAtLeastOne = true
			'end if

			'if Not VarType(Applications("inBOI")) = 1 then
			'	inBOI = inSystem
			'	inAtLeastOne = true
			'end if
			
			'if Not VarType(Applications("inBUR")) = 1 then
			'	inBUR = inSystem
			'	inAtLeastOne = true
			'end if
			
			'if inAtLeastOne = false then
			'	rowEmphasis = " notInSystem"
			'end if
			
			ModifiedTime = Timecards.Fields.Item("modifiedDate")
			'InsertedTime = Timecards.Fields.Item("lastInserted")
			'if  DateDiff("n", InsertedTime, ModifiedTime) > 0 then
			'	rowEmphasis = " notInSystem"
			'	Updated = "<img src=" & Chr(34) & updatedLink & Chr(34) & ">"
			'Else
			'	Updated = "<img src=" & Chr(34) & notUpdatedLink & Chr(34) & ">"
			'end if
			
			applicationLink = "/.asp?timeid=" & CStr(timeid)
			if i > 0 then
				ShadeData = "FFFFFF"
				i = 0
			Else
				ShadeData = "EFF5FA"
				i = 1
			end if
			
			approved = Timecards.fields.item("approvedDate")
			approver = Timecards.fields.item("approver")
			if len(approver) >0 then
				approver = "<i>" & approver & " approved on " & approved & "</i>"
			elseif len(approved) >0 then
				approver = "<i>" & approved & "</i>"
			end if
			
			form_link = "<a href='" & applicationLink & "&amp;action=review'>"
			emp_email = Timecards("userEmail")
			if len(emp_email) > 0 then
				employeeDisplayName = Updated & "<a href=" & Chr(34) & "mailto:" & emp_email & Chr(34) & "><img src=" &_
					Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Timecards.Fields.Item("lastnameFirst")
			Else
				employeeDisplayName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
					form_link & Timecards.Fields.Item("lastnameFirst")
			end if



			'rowEmphasis = rowEmphasis & " notSubmitted"
			Response.write "<tr style='background-color:#" & ShadeData & "'>" &_
				"<td><a " & inBOI & "href='" & applicationLink & "&amp;action=inject&amp;company=BOI'>BOI</a></td>" &_
				"<td><a " & inBUR & "href='" & applicationLink & "&amp;action=inject&amp;company=BUR'>BUR</a></td>" &_
				"<td><a " & inPER & "href='" & applicationLink & "&amp;action=inject&amp;company=PER'>PER</a></td>" &_
				"<td><a " & inIDA & "href='" & applicationLink & "&amp;action=inject&amp;company=IDA'>IDA</a></td>"

			Response.write "<td class='" & rowEmphasis & "'></td>" &_
				"<td class='" & rowEmphasis & "'>" & employeeDisplayName & "</a></td>" &_
				"<td class='" & rowEmphasis & "'>" & Timecards.Fields.Item("companyName") & "</td>" &_
				"<td class='" & rowEmphasis & "'>" & Timecards.Fields.Item("loca_desc") &  "</td>" &_
				"<td class=""weekending" & rowEmphasis & """>" &_
					FormatDateTime(Timecards.Fields.Item("weekending"), 2) & "</td></tr>"
					
			Response.write "<tr style='background-color:#" & ShadeData & "'>" &_
				"<td colspan='4' class='" & rowEmphasis & "'>" & Timecards.Fields.Item("stat_desc") & "</td>" &_
				"<td class='" & rowEmphasis & "'>" &  "</td>" &_
				"<td class='" & rowEmphasis & "'>" & FormatDateTime(Timecards.Fields.Item("modifiedDate"), 2) &_
					",&nbsp;&nbsp;&nbsp;<i>" & total_time(Timecards.Fields.Item("timeinfo")) & " hours</i></td>" &_
				"<td colspan='3' class='weekending" & rowEmphasis & "'>" & approver & "</td></tr>"
					
					
			inBOI = "" : inBUR = "" : inPER = "" : inIDA = "" : 
			Timecards.MoveNext
			
		loop
		Response.write "</table></div>"
		Set Applications = nothing
		'Set getApplications_cmd = Nothing
		Database.Close
	'end if
End if 



response.write "<div id=""topPageRecords"" class=""navPageRecords"">"
response.write "<A HREF=""/include/system/tools/activity/viewTimecards.asp?Page=1" & qryOptions & """>First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""/include/system/tools/activity/viewTimecards.asp?Page="& i & qryOptions & """>&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
	Next
response.write "<A HREF=""/include/system/tools/activity/viewTimecards.asp?Page=" & nPageCount & qryOptions & """>Last</A>"
response.write("</div></div>") %>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
