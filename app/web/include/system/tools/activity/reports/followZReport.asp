<%
session("add_css") = "reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Current Direct Deposits - Personnel Plus"
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
    <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
  </form>
  <%
	if len(whichCompany & "") > 0 then      'added POC; IDA; & PPI 2013.11.15 *Richard* ORE WYO 2014.12.22
		Select Case whichCompany
		Case "BUR"
			thisConnection = dsnLessTemps(BUR)
		Case "PER"
			thisConnection = dsnLessTemps(PER)
		Case "BOI"
			thisConnection = dsnLessTemps(BOI)
        Case "POC"
            thisConnection = dsnLessTemps(POC)
		Case "ORE"
            thisConnection = dsnLessTemps(ORE)
		Case "WYO"
            thisConnection = dsnLessTemps(WYO)
        Case "IDA"		
            thisConnection = dsnLessTemps(IDA)
        Case "PPI"
            thisConnection = dsnLessTemps(PPI)
		End Select
		
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Applicants.LastnameFirst, CurrentChecks.TypeZ, CurrentChecks.TypeY " &_
				"FROM CurrentChecks CurrentChecks LEFT OUTER JOIN Applicants Applicants ON " &_
				"CurrentChecks.ApplicantId=Applicants.ApplicantID " &_
				"WHERE CurrentChecks.TypeZ <> 0 OR CurrentChecks.TypeY <> 0 ORDER BY Applicants.LastnameFirst ASC; " 'Added ORDER BY 2013.11.15 *Richard*
			.Open sqlCommandText, thisConnection
		End With
		
	dim nPage, nItemsPerPage, nPageCount
	nPage = CInt(Request.QueryString("Page"))
	nItemsPerPage = 150
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
			"<th class=""padQuarter""></th>" &_
			"<th class=""TypeZname"">Lastname, First</th>" &_
			"<th style=""text-align:center; padding-bottom:1em;"" class=""TypeZ"">z</th>" &_
			"<th style=""text-align:center; padding-bottom:1em;"" class=""TypeY"">y</th>" &_
			"<th class=""padQuarter""></th>" &_
			"</tr>"
	
		Response.write tableHeader
		
		dim TotalZ, TypeZ, TypeY
		do while not (WhoseHere.eof Or WhoseHere.AbsolutePage <> nPage)

			if WhoseHere.eof then
				WhoseHere.Close
				' Clean up
				' Do the no results HTML here
				response.write "No Items found."
					' Done
				Response.End 
			end if
			
			TypeZ = WhoseHere("TypeZ")
			TypeZ = TypeZ * -1 'inverse negative to correct two decimal issue
			
			TypeY = WhoseHere("TypeY")
			TypeY = TypeY * -1 'inverse negative to correct two decimal issue
			
			if Background = "YellowZ" then
				Background = "WhiteZ"
			Else
				Background = "YellowZ"
			end if
			
			TotalZ = TotalZ + TypeZ
			TotalY = TotalY + TypeY		
			
			tableRecord = "<tr>" &_
				"<td></td>" &_
				"<td class=""" & Background & """>" & WhoseHere("LastnameFirst") & "</td>" &_
				"<td class=""alignC " & Background & """>$" & TwoDecimals(TypeZ) & "</td>" &_
				"<td class=""alignC " & Background & """>$" & TwoDecimals(TypeY) & "</td>" &_
				"<td></td>" &_
			"</tr>"
			

			
			Response.write tableRecord
			WhoseHere.MoveNext
		loop

		tableRecord = "<tr>" &_
			"<td colspan=2></td>" &_
			"<td class=""alignL""><b>Total: </b>$" & TwoDecimals(TotalZ) & "</td>" &_
			"<td class=""alignL""><b>Total: </b>$" & TwoDecimals(TotalY) & "</td>" &_
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
