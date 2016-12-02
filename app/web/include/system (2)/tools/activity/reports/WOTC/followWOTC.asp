<%
session("add_css") = "./reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Follow WOTC - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/activity/reports/common_reports.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Follow WOTC Applicants Status")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="post">
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%></p>
</form>
  <%
	if len(whichCompany & "") > 0 then
		thisConnection = useThisCompany(whichCompany)
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Applicants.EntryDate, Applicants.LastnameFirst, KeyDictionary.KeywordId, Sum(CheckHistoryDetails.Hours) AS SumOfHours " &_
			"FROM ((KeyDictionary INNER JOIN (Applicants " &_
			"INNER JOIN KeysApplicants ON Applicants.ApplicantID = KeysApplicants.ApplicantId) ON KeyDictionary.KeywordId = KeysApplicants.KeywordId) " &_
			"LEFT JOIN CheckHistory ON Applicants.ApplicantID = CheckHistory.ApplicantId) LEFT JOIN CheckHistoryDetails ON " &_
			"CheckHistory.PayNumber = CheckHistoryDetails.Paynumber " &_
			"GROUP BY Applicants.EntryDate, Applicants.LastnameFirst, KeyDictionary.KeywordId " &_
			"HAVING (((KeyDictionary.KeywordId)=1628 Or (KeyDictionary.KeywordId)=3346 Or (KeyDictionary.KeywordId)=3345 " &_
			"Or (KeyDictionary.KeywordId)=3347)) " &_
			"ORDER BY Applicants.LastnameFirst;"

			.Open sqlCommandText, thisConnection
			.PageSize = nItemsPerPage
		End With
		
	if not WhoseHere.eof then nPageCount = WhoseHere.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
	
	response.write rs_navigation(whichCompany, rsQuery, nPageCount)

	' Position recordset to the correct page
	if not WhoseHere.eof then WhoseHere.AbsolutePage = nPage
		tableHeader = "<table style='width:100%'><tr>" &_
			"<th class=""alignL"">Entry Date</th>" &_
			"<th class=""alignL"">Applicant</th>" &_
			"<th class=""alignC alignC"">Application</th>" &_
			"<th class=""alignC"">Submitted</th>" &_
			"<th class=""alignC"">Denied</th>" &_
			"<th class=""alignC"">Accepted</th>" &_
			"<th class=""alignR"">Hours</th>" &_
			"</tr>"
	
		Response.write tableHeader
		
		dim imgCheck
		imgCheck = "<img src=""images/check.png"">"

		dim Background
		dim imgApp
		dim imgSub
		dim imgDen
		dim imgAcc
		
		dim reset_trigger
		dim current_person
		
		dim recent_date
		dim current_date
		
		'dim image_bucket(3)
		'const wApplication = 0
		'const wSubmitted = 1
		'const wDenied = 2
		'const wAccepted = 3

		dim totalhours
		dim sumofhours
		
		do while not (WhoseHere.eof Or WhoseHere.AbsolutePage <> nPage)
			current_person = WhoseHere("LastnameFirst")
			current_date = WhoseHere("EntryDate")
			
			if DateDiff("d", recent_date, current_date) > 0 then
				recent_date = current_date
			end if
			
			sumofhours = WhoseHere("SumOfHours")
			if len(sumofhours) > 0 then 
				totalhours = totalhours + cint(sumofhours)
			end if
			
			select case WhoseHere("KeywordId")
			case 3347
				imgAcc = imgCheck
			case 3345
				imgApp = imgCheck
			case 3346
				imgDen = imgCheck
			case 1628
				imgSub = ImgCheck
			end select
			
			if reset_trigger <> current_person then
			 	'dump response
				if reset_trigger = "" then
					'check first before dumping to make sure this isn't first loop
					reset_trigger = current_person
					recent_date = current_date
				else
					'not first run, okay to dump
					if Background = "DarkYellowZ" then
						Background = "WhiteZ"
					Else
						Background = "DarkYellowZ"
					end if
					
					tableRecord = "<tr class=""" & Background & """>" &_
						"<td>" & recent_date & "</td>" &_
						"<td>" & WhoseHere("LastnameFirst") & "</td>" &_
						"<td class=""alignC"">" & imgApp & "</td>" &_
						"<td class=""alignC"">" & imgSub & "</td>" &_
						"<td class=""alignC"">" & imgDen & "</td>" &_
						"<td class=""alignC"">" & imgAcc & "</td>" &_
						"<td class=""alignR"">" & TwoDecimals(totalhours) & "</td>" &_
						"</tr>"
			
					Response.write tableRecord
					reset_trigger = current_person
					recent_date = current_date
					totalhours = 0
					imgAcc = "" : imgApp = "" : imgDen = "" : imgSub = ""
				end if
			end if
			WhoseHere.MoveNext
		loop
		Response.write "</table>"
		WhoseHere.Close
		Set WhoseHere = nothing
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
