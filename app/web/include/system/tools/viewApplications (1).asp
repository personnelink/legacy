<%
session("add_css") = "tinyForms.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/activity/common_activity.inc' -->
<script type="text/javascript" src="/include/js/viewApplications.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
dim page_title

dim insertInfo
insertInfo = get_session("insertInfo")
if len(insertInfo) > 0 then
	
	dim name_length, name_start, start_txt, end_txt 'detect and set page_title if an update
	start_txt = "<th>Applicant Name:&nbsp;</th><td>"
	end_txt = "</td></tr><tr><th>"
 	name_start = instr(insertInfo, start_txt)
	if name_start > 0 then
		name_start = name_start + len(start_txt) 'offset for search txt
		name_length =  instr(name_start, insertInfo, end_txt) - name_start
		if instr(insertInfo, "already exists in system") > 0 then
			page_title = "Update:&nbsp;" & mid(insertInfo, name_start, name_length) & "?"
		else
			page_title = mid(insertInfo, name_start, name_length) & " - Enrolled"
		end if
	end if
			
	response.write(decorateTop("doneInsertingApp", "marLRB10", "Applicants Application Insertion"))
	response.write(insertInfo)
	response.write(decorateBottom())
	insertInfo = set_session("insertInfo", "")
end if

dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 4) 
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

dim expand_srch, checkedText
checkedText = " checked=""checked"" autocomplete=""off"""
if request("expand_srch") = "expand" then
	expand_srch = true
end if

if len(likeName) > 0 then
	page_title = "Apps like:&nbsp;&nbsp;" & likeName & ", " & fromDate & " - " & toDate
elseif len(page_title) = 0 then
	page_title = "View Employment Applications"
end if
%>

<%=decorateTop("AccountActivity", "marLRB10", "Employment Applications")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="viewApplications.asp" method="get" />
<table id="formOptions"><tr><td>
      <label style="float:left; clear:left" for="fromDate">From </label>
	  <input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>" onKeyPress="return submitenter(this,event)">
</td><td>
	<label for="toDate" style="float:left; clear:left">To </label>
	<input name="toDate" id="toDate" type="text" value="<%=toDate%>" onKeyPress="return submitenter(this,event)">
</td><td>
	
<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="javascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>
<tr><td colspan=3>
      <label style="float:left; clear:left" for="likeName">Search</label>
      <input  style="float:left; clear:left" name="likeName" id="likeName" type="text" value="<%=likeName%>" onKeyPress="return submitenter(this,event)"><br />
	  <label id="expand_srch_lbl" for="expand_srch">
	  	<input type="checkbox" name="expand_srch" id="expand_srch" value="expand"
		<% if expand_srch then response.write checkedText %>/>
		Include skills, additional info and job history.
		</label>
</td></tr>
</table>
<input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">

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
			if expand_srch then
				'sSearchString = "(MATCH(tbl_applications_srch.additionalInfo) AGAINST('" & likeName & "')) AND "
			else
				sSearchString = "((CONCAT(tbl_applications.lastName, ', ', tbl_applications.firstName)) LIKE '%" & likeName & "%') AND "
			end if
		end if
				
		fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1

		Set Applications = Server.CreateObject ("ADODB.RecordSet")
		Applications.CursorLocation = 3 ' adUseClient
		
		'slightly slower query joined for full text search
		if expand_srch then
			'sure table exists
			SQL = "SELECT `table_name` " &_
					"FROM `information_schema`.`TABLES` " &_
					"WHERE table_schema = ""pplusvms"" " &_
					"AND table_name = ""txt_srch"""

			Applications.Open SQL, MySql

			if Applications.eof then 
				Applications.close
				'create temporary table
				SQL = "CREATE TABLE `pplusvms`.`txt_srch` (" &_
					  "`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " &_
					  "`session_id` VARCHAR(38), " &_
					  "`hit_id` INTEGER UNSIGNED, " &_
					  "PRIMARY KEY (`id`) " &_
					") " &_
					"ENGINE = InnoDB " &_
					"COMMENT = 'Temporary Table for text seaches';" 
				
				Applications.Open SQL, MySql
			else
				Applications.close
			end if

			SQL = "" &_
				"INSERT INTO txt_srch (hit_id, session_id) " &_
				"SELECT applicationID, '" & session_id & "' AS session_id " &_
				"FROM  tbl_applications_srch " &_
				"WHERE MATCH(additionalInfo, jobDutiesOne, " &_
					"jobReasonOne, jobDutiesTwo, " &_
					"jobReasonTwo, jobDutiesThree, " &_
					"jobReasonThree) " &_
					"AGAINST('" & likeName & "');"

'					"AGAINST('" & likeName & "' WITH QUERY EXPANSION);"

			'break SQL
			Applications.Open SQL, MySql

			'search as if mining for keywords
			SQL = "SELECT tbl_users.addressID, tbl_applications.applicationID, tbl_applications.email, " &_
				"tbl_applications.lastName, tbl_applications.firstName, tbl_addresses.city, " &_
				"tbl_addresses.state, tbl_addresses.zip, tbl_applications.ssn, tbl_applications.modifiedDate, " &_
				"tbl_applications.inPER, tbl_applications.inIDA, tbl_applications.inBOI, tbl_applications.inBUR, " &_
				"tbl_applications.lastInserted, tbl_applications.submitted " &_
				"FROM ((tbl_users RIGHT JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID) " &_
				"LEFT JOIN tbl_addresses ON tbl_users.addressID = tbl_addresses.addressID) " &_
				"INNER JOIN txt_srch ON tbl_applications.applicationID = txt_srch.hit_id "  &_
				"WHERE " & sSearchString & "tbl_applications.modifiedDate>='" & fromMySqlFriendlyDate &_
				"' AND tbl_applications.modifiedDate<='" & toMySqlFriendlyDate & "' " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"

		else 	'search as if lastname, first
			SQL = "SELECT tbl_users.addressID, tbl_applications.applicationId, tbl_applications.email, tbl_applications.lastName, " &_
				"tbl_applications.firstName, tbl_addresses.city, tbl_addresses.state, " &_
				"tbl_addresses.zip, tbl_applications.ssn, tbl_applications.modifiedDate, tbl_applications.inPER, tbl_applications.inIDA, " &_
				"tbl_applications.inBOI, tbl_applications.inBUR, tbl_applications.lastInserted, tbl_applications.submitted " &_
				"FROM (tbl_users RIGHT JOIN tbl_applications ON tbl_users.applicationId = tbl_applications.applicationId) " &_
				"LEFT JOIN tbl_addresses ON tbl_users.addressID = tbl_addresses.addressID " &_
				"WHERE " & sSearchString & "tbl_applications.modifiedDate>='" & fromMySqlFriendlyDate &_
				"' AND tbl_applications.modifiedDate<='" & toMySqlFriendlyDate & "' " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"
		end if
		
		Applications.Open SQL, MySql
		
		dim addressLine, userAddressId, lnkName
		Database.Open MySql
		
		nPage = CInt(Request.QueryString("Page"))
		nItemsPerPage = 50
		Applications.PageSize = nItemsPerPage
		nPageCount = Applications.PageCount

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
		response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=1&" & qryOptions & """>First</A>"
		For i = 1 to nPageCount
			response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page="& i & qryOptions & """>&nbsp;"
			if i = nPage then
				response.write "<span style=""color:red"">" & i & "</span>"
			Else
				response.write i
			end if
			response.write "&nbsp;</A>"
		Next
		response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=" & nPageCount & qryOptions & """>Last</A>"
		response.write("</div>")
	
		' Position recordset to the correct page
		if Not Applications.eof then Applications.AbsolutePage = nPage
		
		Response.write "<div id='appResults'><table class='onlineApps'><tr>" &_
			"<th class='appCompanies' colspan='4'>Enroll Into</th>" &_
			"<th class='appName'>Name</th>" &_
			"<th class='appSSN'>&nbsp;</th>" &_
			"<th class='appLocation'>Location</th>" &_
			"<th class='appDate'>Date</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Applications.eof then response.write "No Items found."

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
			
			addressLine = PCase(Applications.Fields.Item("city")) & ", " & UCase(Applications.Fields.Item("state")) & " " & Applications.Fields.Item("zip")
			
			form_link = "<a href='" & applicationLink & "&amp;action=review'>"
			applicantEmail = Applications("email")
			if len(applicantEmail) > 0 then
				lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & Chr(34) & "><img src=" &_
					Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName")
			Else
				lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
					form_link & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName")
			end if

			if Applications("submitted") = "n" then
				ssn4 = "<span class=""incomplete"">&nbsp;</span>"
			else
				'ssn4 = form_link & Right(ssn, 4)
				if inAtLeastOne then
					ssn4 = "<span class=""enrolled"">&nbsp;</span>"
				else
					ssn4 = "<span class=""appcompleted"">&nbsp;</span>"
				end if

			end if
			Response.write "<tr style='background-color:#" & ShadeData & "'>"
			Response.write "<td class='appCompany'><a " & inBOI & "href='" & applicationLink & "&amp;action=inject&amp;company=BOI'>Boi</a></td>"
			Response.write "<td class='appCompany'><a " & inBUR & "href='" & applicationLink & "&amp;action=inject&amp;company=BUR'>Bur</a></td>"
			Response.write "<td class='appCompany'><a " & inPER & "href='" & applicationLink & "&amp;action=inject&amp;company=PER'>Per</a></td>"
			Response.write "<td class='appCompany'><a " & inIDA & "href='" & applicationLink & "&amp;action=inject&amp;company=IDA'>IDA</a></td>"
			Response.write "<td class='appName" & rowEmphasis & "'><a href='" & applicationLink & "&amp;action=review&amp;giveme=mostofit'> m </a>" &_			
				"<a href='" & applicationLink & "&amp;action=review&amp;giveme=allofit'> A </a>&nbsp;&nbsp;" & lnkName & "</a></td>"
			Response.write "<td class='appSSN" & rowEmphasis & "'>" & ssn4 & "</a></td>"
			Response.write "<td class='appLocation" & rowEmphasis & "'>" & form_link & addressLine & "</a></td>"
			Response.write "<td class='appDate" & rowEmphasis & "'>" &_			
				"" &_
				form_link & FormatDateTime(Applications.Fields.Item("modifiedDate"), 2) & "</a>&nbsp;" &_
				"</td></tr>"
			inBOI = "" : inBUR = "" : inPER = "" : inIDA = "" : 
			Applications.MoveNext
			
		loop
		Response.write "</table></div>"
		
		'drop temp search bindings for this session, if used
		if instr(SQL, "txt_srch ON") > 0 then
			Applications.close
				'create temporary table
			SQL = "DELETE FROM txt_srch WHERE session_id=""" & session_id & """;"

			Applications.Open SQL, MySql
		end if
		
		Set Applications = nothing
		'Set getApplications_cmd = Nothing
		Database.Close
	'end if
response.write "<div id=""topPageRecords"" class=""navPageRecords"">"
response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=1" & qryOptions & """>First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page="& i & qryOptions & """>&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
	Next
response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=" & nPageCount & qryOptions & """>Last</A>"
response.write("</div></div>") %>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
