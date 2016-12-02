<% 
session("add_css") = "reports.css"
session("window_page_title") = "Sign-In History - Personnel Plus"
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then 

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 14) 
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

 %>
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Sign-in and Availability Log History")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">

<table id="formOptions"><tr><td>
      <label style="float:left; clear:left" for="fromDate">From </label>

      <input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
</td><td>
<label for="toDate" style="float:left; clear:left">To </label>
      <input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=toDate%>">
</td><td>
	
<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="javascript:document.whoseHereForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>
<tr><td colspan=3>
      <label style="float:left; clear:left" for="likeName">Search</label>
      <input  style="float:left; clear:left" name="likeName" id="likeName" type="text" value="<%=likeName%>">
</td></tr>
</table>

  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
  
</form>
  <%
	dim sSearchString
	if len(likeName) > 0 then
		sSearchString = "(Applicants.LastnameFirst LIKE '%" & likeName & "%') AND "
	end if

	if len(whichCompany & "") > 0 then
		Select Case whichCompany
		Case "BUR"
			thisConnection = dsnLessTemps(BUR)
		Case "PER"
			thisConnection = dsnLessTemps(PER)
		Case "BOI"
			thisConnection = dsnLessTemps(BOI)
		Case "IDA"									'Richard Added 11/15/2012
			thisConnection = dsnLessTemps(IDA)
		Case "PPI"
			thisConnection = dsnLessTemps(PPI)
		Case "POC"
			thisConnection = dsnLessTemps(POC)
		Case "WYO"
			thisConnection = dsnLessTemps(WYO)
		End Select

		'fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		'toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1
		fromMySqlFriendlyDate = fromDate
		toMySqlFriendlyDate = toDate

		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Applicants.ApplicantID, Applicants.LastnameFirst, Applicants.Address, Applicants.City, Applicants.State, " &_
				"Applicants.Zip, Applicants.Telephone, Applicants.[2ndTelephone], HistorySignIn.SignInTime, HistorySignIn.Hours, " &_
				"HistorySignIn.Comment " &_
				"FROM Applicants INNER JOIN HistorySignIn ON Applicants.ApplicantID = HistorySignIn.ApplicantId " &_
				"WHERE " & sSearchString & "HistorySignIn.SignInTime >= '" & fromMySqlFriendlyDate &_
				"' AND HistorySignIn.SignInTime <= '" & toMySqlFriendlyDate & "' " &_
				"ORDER By SignInTime Desc"
				
				'print sqlCommandText
				'print thisConnection
				
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
	
	'rsQuery = request.serverVariables("QUERY_STRING")
	'queryPageNumber = Request.QueryString("Page")
	'if queryPageNumber then
	'	rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
	'end if
	
	qryOptions = "&whichCompany=" & whichCompany &_
		"&fromDate=" & request.form("fromDate") &_
		"&toDate=" & request.form("toDate")
		
	response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
	response.write "<A HREF=""" & aspPageName & "?Page=1" & qryOptions & """>First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""" & aspPageName & "?Page="& i & qryOptions & """>&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
	Next
	response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount &  qryOptions & """>Last</A>"
	response.write("</div>")

	' Position recordset to the correct page

	dim applicantid, lastnameFirst, maintain_link, resourcelink
	resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

	if Not WhoseHere.Eof then WhoseHere.AbsolutePage = nPage

		'tableHeader = "<table style='width:100%'><tr>" &_
		'	"<th>Applicant Name</th>" &_
		'	"<th>City</th><th>Telephone</th>" &_
		'	"<th>2nd Telephone</th>" &_
		'	"<th>Comments</th>" &_
		'	"</tr>"
				

		tableHeader = "<table class=""generalTable""><tr>" &_
			"<th class=""whApplicant"">Applicant</th>" &_
			"<th class=""whAddress"">Address</th>" &_
			"<th class=""whContact"">Contact #'s</th>" &_
			"<th class=""whSignIn""></th>" &_
			"<th class=""whComments"">Comments</th>" &_
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

		tableRecord = tableHeader &_
				"<tr>" &_
					"<td>" & maintain_link & "</td>" &_
					"<td>" & WhoseHere("Address") & "</td>" &_
					"<td><a href=""tel:" & only_numbers(WhoseHere("Telephone"))  & """ />" & FormatPhone(WhoseHere("Telephone")) & "</td>" &_
					"<th></th>" &_
					"<td>" & WhoseHere("Comment") & "</td>" &_
				"</tr><tr>" &_
					"<td><i>Hours worked:</i>"  & WhoseHere("Hours") & "</td>" &_
					"<td>" & WhoseHere("City") & ", " & WhoseHere("State") & " " & WhoseHere("Zip") & "</td>" &_
					"<td><a href=""tel:" & only_numbers(WhoseHere("2ndTelephone"))  & """ />" & FormatPhone(WhoseHere("2ndTelephone")) & "</td>" &_
					"<th></th>" &_
					"<td>" & WhoseHere("SignInTime") & "</td>" &_
				"</tr>"
			Response.write tableRecord
			WhoseHere.MoveNext
		loop
		Response.write "</table>"
		Set WhoseHere = nothing

		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""" & aspPageName & "?Page=1" & qryOptions & """>First</A>"
		For i = 1 to nPageCount
			response.write "<A HREF=""" & aspPageName & "?Page="& i & qryOptions & """>&nbsp;"
			if i = nPage then
				response.write "<span style=""color:red"">" & i & "</span>"
			Else
				response.write i
			end if
			response.write "&nbsp;</A>"
		Next
		response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount & qryOptions & """>Last</A>"
		response.write("</div>")
	end if
End if %>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->