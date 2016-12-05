<%
session("add_css") = "./whoseHere.002.css"
session("required_user_level") = 4 'userLevelApplicant
session("window_page_title") = "Daily Sign-In - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/pdfServer/pdfApplication/application.classes.vb' -->

<script type="text/javascript" src="whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<!-- Ajax'd: 9.8.2013 -->

<%

dim cmd
Set cmd = Server.CreateObject("ADODB.Command")

dim rs

dim CurrentApplication
set CurrentApplication = new cApplication

CurrentApplication.ApplicationId = applicationId

if userLevelRequired(userLevelPPlusStaff) then

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

else

	'do stuff for applicant signing themselves in
end if

dim where, where_friendly, who, who_check
where_friendly = request.QueryString("where")
where = getTempsDSN(where_friendly)
if not len(where_friendly) > 0 then	where_friendly = whichCompany

who = request.QueryString("who")
if len(who) = 0 then who = request.Form("signApplicantIn")
if IsNumeric(who) then
	who = cdbl(who)
else
	who = -1
end if




dim signInComments
signInComment = request.form("signInComment")

dim applicant_name
if who > 0 then
	if Len(where_friendly) > 0 then
		dim getApplicant, sql, temprs
		sql = "select LastnameFirst from Applicants where ApplicantId=" & who
		
		set getApplicant = server.CreateObject("adodb.connection")
		getApplicant.Open dsnLessTemps(getTempsDSN(where_friendly))
		
		set temprs = getApplicant.Execute(sql)
		if not temprs.eof then applicant_name = temprs("LastnameFirst")

		if request.Form("action") = "signin" then 
			sql = "select * from DailySignIn where ApplicantId=" & who
			set temprs = getApplicant.Execute(sql)
			if temprs.eof then
				sql = "insert into DailySignIn (ApplicantId, SignInTime, Comment) Values (" &_
					who & ", '" & Now & "', '" & replace(signInComment, "'", "''") & "')"
				set temprs = getApplicant.Execute(sql)
			else
				applicant_name = applicant_name & " <i>is signed in</i>"
			end if
		end if
		
		getApplicant.Close
		set getApplicant = nothing
	end if
end if

if request.form("action") = "clear" then
	dim current_time, hours_back, sign_in_list
	hours_back = request.form("older_than")
	if len(hours_back) > 0 and IsNumeric(hours_back) then
		current_time = Now
		sql = "insert into HistorySignIn (ApplicantId, Reference, SignInTime, Hours, Comment) " &_
			"select * from DailySignIn where SignInTime < '" & DateAdd("h", cdbl(hours_back) * -1, current_time) & "'"

		set sign_in_list = server.CreateObject("adodb.connection")
		sign_in_list.Open dsnLessTemps(getTempsDSN(where_friendly))
		sign_in_list.execute(sql)
		sql = "delete from DailySignIn where SignInTime < '" & DateAdd("h", cdbl(hours_back) * -1, current_time) & "'"
		sign_in_list.execute(sql)
		sign_in_list.close
		set sign_in_list = nothing
	end if
end if

 %>
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Daily Sign-in and Availability Log")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
  
	<p id="applicant_name">Applicant Name: <%=applicant_name%> </p>
  <p>
  	<a id="lookup" href="#" onclick="return false;">&nbsp;</a>
	<label for="signApplicantIn">Applicant Id:<br />
		<input name="signApplicantIn" id="signApplicantIn" value="" onkeyup="lookup_id();" /></label>
	<label for="signInComment">Comments:<br />
		<input name="signInComment" id="signInComment" value="<%=signInComment%>" onkeypress="check_enter(event)" /></label>
		<a id="sign_in" class="squarebutton" href="#" onclick="sign_in();"><span>Sign-In</span></a>
	</p>
	<input type="hidden" name="action" value="" />
  <%
	if len(whichCompany & "") > 0 then
	
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Applicants.ApplicantID, LastnameFirst, ApplicantStatus, Address, City, State, Zip, Telephone, [2ndTelephone], SignInTime, Hours, Comment  " &_
				"FROM Applicants, DailySignIn " &_
				"WHERE Applicants.ApplicantID = DailySignIn.ApplicantID " &_
				"ORDER By LastnameFirst Asc"
			.Open sqlCommandText, dsnLessTemps(getTempsDSN(whichCompany))
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
	response.write("<div id=""lookup_applicant"" class=""show"">")
		Response.Write("<p></p>")
	response.write("</div>")

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

		'tableHeader = "<table style='width:100%'><tr>" &_
		'	"<th>Applicant Name</th>" &_
		'	"<th>City</th><th>Telephone</th>" &_
		'	"<th>2nd Telephone</th>" &_
		'	"<th>Comments</th>" &_
		'	"</tr>"
			

		
		dim applicantid, lastnameFirst, maintain_link, resourcelink
			resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

		dim applicant_status
		response.write "<table class=""generalTable""><tr>" &_
			"<th class=""whApplicant"">Applicant</th>" &_
			"<th class=""whAddress"">Address</th>" &_
			"<th class=""whContact"">Contact #'s</th>" &_
			"<th class=""whSignIn""></th>" &_
			"<th class=""whComments"">Comments</th>" &_
			"</tr>"
		
		tableHeader = "" &_
			"<tr>" &_
			"<th colspan=""5"" class="""">&nbsp;</th>" &_
			"</tr>"
		
		do while not (WhoseHere.eof Or WhoseHere.AbsolutePage <> nPage)

			if WhoseHere.eof then
				WhoseHere.Close
				' Clean up
				' Do the no results HTML here
				response.write "No Items found."
					' Done
				Response.End 
			end if
				
			applicantid = WhoseHere("ApplicantID")
			lastnameFirst = WhoseHere("LastnameFirst")
			maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>" & lastnameFirst
			applicant_status = "status" & WhoseHere("ApplicantStatus")
			
			
			tableRecord =  tableHeader &_
				"<tr class=""" & applicant_status & """>" &_
					"<td>" & maintain_link & "</td>" &_
					"<td>" & WhoseHere("Address") & "</td>" &_
					"<td><a href=""tel:" & only_numbers(WhoseHere("Telephone"))  & """ />" & FormatPhone(WhoseHere("Telephone")) & "</td>" &_
					"<th></th>" &_
					"<td>" & WhoseHere("Comment") & "</td>" &_
				"</tr><tr class=""" & applicant_status & """>" &_
					"<td><i>Hours worked:</i>"  & WhoseHere("Hours") & "</td>" &_
					"<td>" & WhoseHere("City") & ", " & WhoseHere("State") & " " & WhoseHere("Zip") & "</td>" &_
					"<td><a href=""tel:" & only_numbers(WhoseHere("2ndTelephone"))  & """ />" & FormatPhone(WhoseHere("2ndTelephone")) & "</td>" &_
					"<th></th>" &_
					"<td>" & WhoseHere("SignInTime") & "</td>" &_
				"</tr>"
				
			Response.write tableRecord
			WhoseHere.MoveNext
		loop
		Response.write tableHeader & "</table>" &_
			"<div id=""color_key"">" &_
				"<table>" &_
					"<tr>" &_
						"<td><div class=""key key_no_emp_record""></div></td><td>Applicant-no Employee Record</td>" &_
						"<td><div class=""key key_unreviewed""></div></td><td>Unreviewed Placed Employee</td>" &_
						"<td><div class=""key key_assigned""></div></td><td>On Active Assignment</td>" &_
						"<td><div class=""key key_not_assigned""></div></td><td>Employee-no Assignments</td>" &_
						"<td><div class=""key key_inactive""></div></td><td>Inactive/Terminated/Deleted</td>" &_
					"</tr>" &_
				"</table>" &_
			"</div>"

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

if userLevelRequired(userLevelPPlusSupervisor) = true then
%>
	<a id="clear_list" class="squarebutton" href="#" onclick="javascript:document.whoseHereForm.action.value='clear';document.whoseHereForm.submit();"><span>Clear Older than: </span></a>
	<input type="text" name="older_than" id="older_than" value="12" /> hours.
<%
end if
%>
</form>
</div>

<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->