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
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Direct Deposit/Debit Report - Deduction Z")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
  <p>
	<%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%>
  </p>
</form>
  <%
	if len(whichCompany & "") > 0 then
		thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
		
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT CurrentChecks.NetPay, CurrentChecks.CheckNumber, CurrentChecks.CheckDate, " &_
				"PR3MSTR.EmployeeNumber, Applicants.LastnameFirst " &_
				"FROM (CurrentChecks CurrentChecks LEFT OUTER JOIN Applicants Applicants ON CurrentChecks.ApplicantId=Applicants.ApplicantID) " &_
				"LEFT OUTER JOIN PR3MSTR PR3MSTR ON Applicants.EmployeeNumber=PR3MSTR.EmployeeNumber " &_
				"WHERE CurrentChecks.CheckNumber<>-1 " &_
				"ORDER BY CurrentChecks.CheckNumber"
			.Open sqlCommandText, thisConnection
		End With
				
	Break sqlCommandText
	
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

		tableHeader = "<table style=""width:100%""><tr>" &_
			"<th class=""padQuarter"">Check #</th>" &_
			"<th class=""padQuarter"">Date</th>" &_
			"<th class=""padQuarter"">Emp#</th>" &_
			"<th class=""TypeZname"">Lastname, First</th>" &_
			"<th class=""TypeZ"">Amount</th>" &_
			"</tr>"
	
		Response.write tableHeader
		
		dim TotalZ, TypeZ
		do while not (WhoseHere.eof Or WhoseHere.AbsolutePage <> nPage)

			if WhoseHere.eof then
				WhoseHere.Close
				' Clean up
				' Do the no results HTML here
				response.write "No Items found."
					' Done
				Response.End 
			end if
			
			if Background = "YellowZ" then
				Background = "WhiteZ"
			Else
				Background = "YellowZ"
			end if
			
			tableRecord = "<tr>" &_
				"<td>" & WhoseHere("CheckNumber") & "</td>" &_
				"<td class=""" & Background & """>" & WhoseHere("CheckDate") & "</td>" &_
				"<td class=""alignR " & Background & """>" & WhoseHere("EmployeeNumber") & "</td>" &_
				"<td class=""alignR " & Background & """>" & WhoseHere("LastnameFirst") & "</td>" &_
				"<td class=""alignR " & Background & """>" & TwoDecimals(WhoseHere("NetPay")) & "</td>" &_
			"</tr>"
			
			TotalZ = TotalZ + TypeZ
			
			Response.write tableRecord
			WhoseHere.MoveNext
		loop

		tableRecord = "<tr>" &_
			"<td colspan=2></td>" &_
			"<td class=""alignR""><b>Total: </b>" & TwoDecimals(TotalZ) & "</td>" &_
			"<td></td>" &_
		"</tr></table>"

		Response.write tableRecord
		Response.write ""
		Set WhoseHere = nothing
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
