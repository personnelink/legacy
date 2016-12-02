<% session("add_css") = "timecardform.asp.css"
session("additionalScripting") = "<script type=""text/javascript"" src=""/include/js/global.js""></script>" &_
	"<script type=""text/javascript"" src=""/include/js/timecardform.js""></script>" &_
	"<script type=""text/javascript"" src=""/include/js/timeDetails.js""></script>" 
session("javascriptOnLoad") = "initapprovalform()"
%>
	
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Created: 2009.11.25 -->
<%


formAction = request.form("formAction")
if formAction = "save" then
	updateTime
end if

if len(session("timecardMessageBody")) > 0 then
	response.write(decorateTop("timecardMessageArea", "marLR10", session("timecardMessageHeading")))
	response.write(session("timecardMessageBody"))
	response.write(decorateBottom())
	
	session("timecardMessageBody") = ""
	session("timecardMessageHeading") = ""
end if


	'On Error Resume Next
	weekid = Replace(Trim(Request.QueryString("week")), "'", "")
	Response.write "<form id=""form1"" name=""form1"" method=""post"" action=""""><div id=""listTimeDetails"">" &_
		"<select name=""weekending"" id=""weekending"" onChange=""setweekdays()"" style=""display:none"">" &_
		"<option value=""" & weekid & """>" & weekid & "</option></select>"
	
	companyid = companyId
	WeekEndingDate = Year(weekid) & "/" & Month(weekid) & "/" & Day(weekid)
	Set getTimecards_cmd = Server.CreateObject("ADODB.Command")
	With getTimecards_cmd
		.ActiveConnection = MySql
		.CommandText = "SELECT tbl_timecards.*, tbl_users.userID, tbl_users.userName, tbl_users.firstName, tbl_users.lastName, tbl_addresses.city, tbl_addresses.state, " &_
			"tbl_addresses.zip, list_status.description, tbl_approvers.userID, tbl_locations.description " &_
			"FROM (((((tbl_timecards LEFT JOIN tbl_users ON tbl_timecards.userID = tbl_users.userID) LEFT JOIN tbl_addresses ON  " &_
			"tbl_users.addressID = tbl_addresses.addressID) LEFT JOIN list_status ON tbl_timecards.status = list_status.short) LEFT JOIN tbl_locations ON  " &_
			"tbl_users.locationid = tbl_locations.locationID) LEFT JOIN tbl_companies ON tbl_locations.companyID = tbl_companies.companyid) LEFT JOIN  " &_
			"tbl_approvers ON tbl_locations.locationID = tbl_approvers.locationid  " &_
			"WHERE (((tbl_timecards.weekending)='" & WeekEndingDate & "') AND " &_
			"((tbl_approvers.userID)=" & user_id & ")) " &_
			"ORDER BY tbl_locations.description, tbl_addresses.city;"
		'response.write getTimecards_cmd.CommandText
		'Response.End()
		.Prepared = true
		
	End With

	Database.Open MySql
	Set  dbQuery= Database.Execute("Select weekends FROM tbl_companies WHERE companyID = " & companyid)
	WeekEndsOn = dbQuery("weekends")
	Database.Close
	
	'response.write getTimecards_cmd.CommandText
	'Response.End()
	Set Timecards = getTimecards_cmd.Execute
	
	dim i, DayTimeInfo, WeekTimeInfo, FullTimeCard(6, 6), TimecardInfo, FiguredRegular
	const inTime = 0, luoutTime = 1, luinTime = 2, outTime = 3, regularTime = 4, otherTime = 5, otherTypeTime = 6

	dim Today, WeekDayNames(6), id, commentsEmp, defaultShow
	
	For i = 1 to 7
		Today = i - Cint(WeekEndsOn)
		if Today < 1 then Today = Today + 7
		Select Case Today
		Case 1
			WeekDayNames(id) = "Tue"
		Case 2
			WeekDayNames(id) = "Wed"
		Case 3
			WeekDayNames(id) = "Thu"
		Case 4
			WeekDayNames(id) = "Fri"
		Case 5
			WeekDayNames(id) = "Sat"
		Case 6
			WeekDayNames(id) = "Sun"
		Case 7
			WeekDayNames(id) = "Mon"
		End Select
			
		id = id + 1
	Next
	
	id = 0	
	if Not Timecards.eof then
		response.write(decorateTop("", "marLR10", Timecards("description") & " Timecard Detail " & WeekEndingDate))
		end if
	dim strZero : strZero = "0"
	do while not Timecards.eof

		commentsEmp = Timecards("comments")
		if len(commentsEmp) > 0 then
			defaultShow = "show"
		Else
			defaultShow = "hide"
		end if

		id = id + 1
		supcomment = Timecards("supcomment")
		
		Select Case Timecards("status")
		Case "o"
			strCurrentStatus = "Open"
		Case "a"
			strCurrentStatus = "Approved"

		Case "r"
			strCurrentStatus = "Rejected"

		Case "c"
			strCurrentStatus = "Aproved w/Change"
		Case "s"
			strCurrentStatus = "Submitted, Pending..."
		Case Else
			strCurrentStatus = "- not set -"
		End Select
		
		
		statusOfTimeOptions = "<option value=""nc"">- options -&nbsp;</option>" &_
			"<option value=""c"">Change</option>" &_
			"<option value=""a"">Approve</option>" &_
			"<option value=""r"">Reject</option>"
		
		Response.write "<table class='timeSheet'><tr>" &_
			"<th class='employee'>Employee</th>" &_
			"<th class='address'>Location</th>" &_
			"<th class='created'>Created</th>" &_
			"<th class='modified'>Modified</th>" &_
			"<th colspan=""2"" class='status toggledetail'>Status: " & strCurrentStatus & "</th>" &_
			"</tr><tr>" &_
			"<td>" & Timecards("firstName") & " " & Timecards("lastName") & "</td>" &_
			"<td>" & Timecards("description") & "</td>" &_
			"<td>" & Timecards("creationDate") & "</td>" &_
			"<td>" & Timecards("modifiedDate") & "</td>" &_
			"<td><input type=""hidden"" id=""oStatus" & id & """ name=""oStatus" & id & """ value=""" & Timecards("status") & """ />" &_
			"<select name=""actionID" & id & """ onchange=""changeTime(this.value, '" & id & "')"">" &_
				statusOfTimeOptions &_
			"</select></td>" &_
			"<td><a id='toggle" & id & "' href='javascript:showtable(""" & id & """);'>[more]</a>&nbsp;" &_
				"</th></td>" &_
			"</tr><tr>" &_
			"<td colspan='6'>" &_
"<input type=""hidden"" id=""timecardid" & id & """ name=""timecardid" & id & """ value=""" & Timecards("timecardid") & """ />" &_
    "<input type=""hidden"" id=""timeinfo" & id & """ name=""timeinfo" & id & """ value=""" & Timecards("timeinfo") & """ />" &_
    "<input type=""hidden"" id=""timeuser" & id & """ name=""timeuser" & id & """ value=""" & Timecards("userid") & """ />" &_
    "<input type=""hidden"" id=""supcommentsize" & id & """ name=""supcommentsize" & id & """ value=""" & len(supcomment) & """ />" &_
	
					"<table class='timeDetails' style=""display:block;""><tr><td class='hours'>" &_
			"<table id='detail" & id & "' class='detailside'><tr>" &_
			"<th class='dayname'>&nbsp;</th>" &_
			"<th class='intimeout'>Time-In</th>" &_
			"<th class='intimeout'>Time-Out</th>" &_
			"<th class='intimeout'>Time-In</th>" &_
			"<th class='intimeout'>Time-Out</th>" &_
			"<th class='tally'>Regular</th>" &_
			"<th class='tally'>Other</th>" &_
			"<th class='othertype'>Type</th>" &_
			"</tr>"
				
		WeekTimeInfo = Split(Timecards("timeinfo"), ";")
		For i = 0 to 6
			DayTimeInfo = Split(WeekTimeInfo(i), ",")
			FullTimeCard(inTime, i) = DayTimeInfo(inTime)
			FullTimeCard(luoutTime, i) = DayTimeInfo(luoutTime)
			FullTimeCard(luinTime, i) = DayTimeInfo(luinTime)
			FullTimeCard(outTime, i) = DayTimeInfo(outTime)
			FullTimeCard(regularTime, i) = DayTimeInfo(regularTime)
			FullTimeCard(otherTime, i) = DayTimeInfo(otherTime)
			FullTimeCard(otherTypeTime, i) = DayTimeInfo(otherTypeTime)
		Next
		Erase WeekTimeInfo
		Erase DayTimeInfo
	'"<div id=""editDetail" & id & """ class=""hide""><div class=""dayOfTheWeek"">" &_
			'"" &_
	  editTimeCard = "<tr>" &_
			  "<td class=""title"">&nbsp;</td>" &_
			  "<td>Time-In</td>" &_
			  "<td>Time-Out</td>" &_
			  "<td>Time-In</td>" &_
			  "<td>Time-Out</td>" &_
			  "<td class=""tally"">Total</td>" &_
			  "<td class=""tally"">Regular</td>" &_
			  "<td class=""tally"">Other</td>" &_
			  "<td class=""othertype"">Type</td>" &_
			"</tr>"
			  
	For i = 1 to 7

	inTimeOptions = TimeOptions(FullTimeCard(inTime, i - 1))
	luoutTimeOptions = TimeOptions(FullTimeCard(luoutTime, i - 1))
	luinTimeOptions = TimeOptions(FullTimeCard(luinTime, i - 1))
	outTimeOptions = TimeOptions(FullTimeCard(outTime, i - 1))
'"<div id=""day" & i & ".hours"" class=""dayOfTheWeek"">" &
  	editTimeCard = editTimeCard &_
     "<tr id=""day" & i & ".row1"">" &_
      "<td id=""name.day" & i & ".row1"" class=""title""> " & WeekDayNames(i-1) & " &nbsp;</td>" &_
      "<td>" &_
        "<select id=""id" & id & ".day" & i & ".in"" name=""id" & id & ".day" & i & ".in"" " &_
		"onclick=""buildClockOptions('id" & id & ".day" & i & ".in', '" & FullTimeCard(inTime, i - 1) & "')"" " &_
		"onchange=""adjustclocks('id" & id & ".day" & i & "')"">" &_
          inTimeOptions &_
        "</select>" &_
      "</td>" &_
      "<td>" &_
        "<select id=""id" & id & ".day" & i & ".luout"" name=""id" & id & ".day" & i & ".luout"" " &_
		"onclick=""buildClockOptions('id" & id & ".day" & i & ".luout', '" & FullTimeCard(luoutTime, i - 1) & "')"" " &_
		"onchange=""adjustclocks('id" & id & ".day" & i & "')"">" &_
          luoutTimeOptions &_
        "</select>" &_
      "</td>" &_
      "<td>" &_
        "<select id=""id" & id & ".day" & i & ".luin"" name=""id" & id & ".day" & i & ".luin"" " &_
		"onclick=""buildClockOptions('id" & id & ".day" & i & ".luin', '" & FullTimeCard(luinTime, i - 1) & "')"" " &_
		"onchange=""adjustclocks('id" & id & ".day" & i & "')"">" &_
          luinTimeOptions &_
        "</select>" &_
      "</td>" &_
      "<td>" &_
        "<select id=""id" & id & ".day" & i & ".out"" name=""id" & id & ".day" & i & ".out"" " &_
			"onclick=""buildClockOptions('id" & id & ".day" & i & ".out', '" & FullTimeCard(outTime, i - 1) & "')"" " &_
			"onchange=""adjustclocks('id" & id & ".day" & i & "')"">" &_
          outTimeOptions &_
        "</select>" &_
      "</td>" &_
      "<td class=""tally totalhours"">" &_
	  	"<input id=""id" & id & ".day" & i & ".total"" name=""id" & id & ".day" & i & ".total"" type=""text"" onblur=""computeAllTime()"" readonly></td>" &_
      "<td class=""tally totalhours"">" &_
        "<input id=""id" & id & ".day" & i & ".regular"" name=""id" & id & ".day" & i & ".regular"" type=""text"" value=""" & FullTimeCard(regularTime, i - 1) & " "" onblur=""computeAllTime()"" readonly></td>" &_
      "<td class=""tally totalhours"">" &_
        "<input id=""id" & id & ".day" & i & ".other"" name=""id" & id & ".day" & i & ".other"" type=""text"" value=""" & FullTimeCard(otherTime, i - 1) & " "" onblur=""computeAllTime()"">" &_
      "</td>" &_
      "<td class=""othertype"">" &_
        "<select id=""id" & id & ".day" & i & ".other.type"" name=""id" & id & ".day" & i & ".other.type"" onblur=""computeAllTime()"">" &_
          "<option value="""">&nbsp;</option>" &_
          "<option value=""S"""
		  		  if FullTimeCard(otherTypeTime, i - 1) = "S" then editTimeCard = editTimeCard & " selected"
		  editTimeCard = editTimeCard &  " >Sick</option>" &_
          "<option value=""H""" 
		  
		  if FullTimeCard(otherTypeTime, i - 1) = "H" then editTimeCard = editTimeCard & " selected"
		  editTimeCard = editTimeCard & " >Holiday</option>" &_
          "<option value=""V"""
		  if FullTimeCard(otherTypeTime, i - 1) = "V" then  editTimeCard = editTimeCard & " selected" 
		  editTimeCard = editTimeCard & ">Vacation</option>" &_
          "<option value=""O"""
		  if FullTimeCard(otherTypeTime, i - 1) = "O" then  editTimeCard = editTimeCard & " selected"
		  editTimeCard = editTimeCard & ">Other</option>" &_
        "</select>" &_
      "</td>" &_
    "</tr>" &_
  ""
			
		if instr(FullTimeCard(regularTime, i - 1), "-") > 0 then
			strZero = ""
		else
			strZero = "0"
		end if

		if CInt(strZero & FullTimeCard(regularTime, i - 1)) > 0 then
			FiguredRegular = FullTimeCard(regularTime, i - 1)
		else
			if len(FullTimeCard(outTime, i - 1)) > 0 and len(FullTimeCard(inTime, i - 1)) > 0 and len(FullTimeCard(luinTime, i - 1)) > 0 and len(FullTimeCard(luoutTime, i - 1)) then
				FiguredRegular = (FullTimeCard(outTime, i - 1) - FullTimeCard(inTime, i - 1)) - (FullTimeCard(luinTime, i - 1) - FullTimeCard(luoutTime, i - 1))
			end if
		end if

			
			If len(FiguredRegular) > 0 Then
				FiguredRegular = Replace(FiguredRegular, " ", "")
				if left(FiguredRegular, 1) = "-" Then
					TotalRegular = TotalRegular + CDbl(FiguredRegular)
				else
					TotalRegular = TotalRegular + CDbl("0" & FiguredRegular)
					
				end if
			end if
			
			if Instr(FullTimeCard(otherTime, i - 1), "-") > 0 Or Instr(FullTimeCard(otherTime, i - 1), ".") > 0 then
				TotalOther = TotalOther +  CDbl(FullTimeCard(otherTime, i - 1))
			Else
				TotalOther = TotalOther +  CDbl("0" & Trim(FullTimeCard(otherTime, i - 1)))
			end if
			
			if cdbl(FiguredRegular) > 0 then 
				FiguredRegular = TwoDecimals(FiguredRegular)
			Else
				FiguredRegular = 0
			end if
			
			response.write "<tr>" &_
				"<td>" & WeekDayNames(i-1) & "</td>" &_
				"<td>" & ShowAsFormatted(FullTimeCard(inTime, i - 1)) & "</td>" &_
				"<td>" & ShowAsFormatted(FullTimeCard(luoutTime, i - 1)) & "</td>" &_
				"<td>" & ShowAsFormatted(FullTimeCard(luinTime, i - 1)) & "</td>" &_
				"<td>" & ShowAsFormatted(FullTimeCard(outTime, i - 1)) & "</td>" &_
				"<td class='totalhours'>" & FiguredRegular & "</td>" &_
				"<td class='totalhours'>" & FullTimeCard(otherTime, i - 1) & "</td>" &_
				"<td>" 
			Select Case FullTimeCard(otherTypeTime, i - 1)
			Case "S"
				response.write "Sick"
			Case "H"
				response.write "Holiday"
			Case "V"
				response.write "Vacation"
			Case "O"
				response.write "Other"
			End Select
			
			response.write "</td></tr>"
		Next
		
		response.write "</table></td><td class='comments'><table id='comment" & id & "' class='commentside'><tr>" &_
			"<th>Comments</th></tr><tr>" &_
			"<td>" & commentsEmp & "</td>" &_
			"</tr></table></td></tr></table>"
			
		response.write "<table id=""editDetail" & id & """ class=""hide""><tr><td colspan=""9"">" & editTimeCard  & "</div></td></tr></table>" &_
			"</td></tr>" &_
			"<tr><td><strong>Week Ending</strong> " & weekid & "</td>" &_
			"<td colspan='2' class='totalofhours'>" &_
				"<b>Regular Hours: </b><span id=""id" & id & ".regular.total"">" & TwoDecimals(TotalRegular) & "</span><br>" &_
				"<b>Other Hours: </b><span id=""id" & id & ".other.total"">" & TwoDecimals(TotalOther) & "</span><br>" &_
				"<b>Total Hours: </b><span id=""id" & id & ".hours.total""></span></td>" &_
			"<td style=""vertical-align:bottom; text-align:right;"" colspan='3'><textarea class=""approvalNotes"" name=""approvalNotes" & id & """>" &_
			supcomment & "</textarea></td>" &_
			"</tr><tr></table>"
				

			
		lastLocation = Timecards("description")	
		Timecards.MoveNext
		if Not Timecards.eof then
			thisLocation = Timecards("description")
			if lastLocation <> thisLocation then
				response.write "<p>" &_
		"<a class=""squarebutton"" href=""javascript:updateAllTime();""><span>Save</span></a>" &_
		"<a class=""squarebutton"" href=""/include/system/tools/timecardEmp.asp""><span>Cancel</span></a></p>"
		response.write decorateBottom()
				response.write decorateTop("", "marLR10", thisLocation & " Timecard Detail " & WeekEndingDate)
			end if
		end if
		
		TotalRegular = 0
		TotalOther = 0
	loop
	Set Timecards = Nothing
	Set getTimecards_cmd = Nothing
	
	response.write "" & decorateBottom()
	response.write "<input type=""hidden"" id=""totaltimeids"" name=""totaltimeids"" value=""" & id & """ />" &_
		"<input type=""hidden"" id=""formAction"" name=""formAction"" value="""" />" &_
		"<p>" &_
		"<a class=""squarebutton"" href=""javascript:updateAllTime();""><span>Save</span></a>" &_
		"<a class=""squarebutton"" href=""javascript:window.print();""><span>Print</span></a>" &_
		"<a class=""squarebutton"" href=""/include/system/tools/timecardEmp.asp""><span>Cancel</span></a></p>" &_
		"</div></form>"
	
Function ShowAsFormatted (timePiece)
	dim MinuteSlice, TimeMinute, HourSlice, DisplayTime

	if not vartype(timePiece) = 8 then 
		if timePiece >= 0 then
			MinuteSlice = (timePiece - int(timePiece)) * 60
			if MinuteSlice = 0 then
				TimeMinute =  "00"
			Else
				TimeMinute = CStr(MinuteSlice)
			end if
			
			HourSlice = timePiece
			if timePiece > 11.75 then
				if int(HourSlice - 12) = 0 then
					DisplayTime = "12:" & TimeMinute & "pm"
				Else
					DisplayTime = int(HourSlice - 12) & ":" & TimeMinute & "pm"
				end if
			Else
				if Int(HourSlice) = 0 then
					DisplayTime = "12:" &  TimeMinute & "am"
				Else
					DisplayTime = int(HourSlice) & ":" &  TimeMinute & "am"
				end if
			end if
			ShowAsFormatted = DisplayTime
		Else
			ShowAsFormated = ""
		end if
	end if
End Function

Sub updateTime ()
	Database.Open mysql
	
	dim z, timecardid, timeinfo, timeuser, approvalNotes, oStatus, sAction, approveTimeInfo, i, DayTimeInfo(6), WeekTimeInfo(6), TimecardInfo

	For z = 1 to CInt(request.form("totaltimeids"))
		timecardid = Replace(request.form("timecardid" & CStr(z)), "'", "''")
		approvalNotes = Server.HTMLEncode(Replace(request.form("approvalNotes" & CStr(z)), "'", "''"))
		
		oStatus = request.form("oStatus" & CStr(z))
		sAction = Replace(request.form("actionID" & CStr(z)), "'", "''")
		if sAction = "c" then
			timeinfo = Replace(request.form("timeinfo" & CStr(z)), "'", "''")
			timeuser = Replace(request.form("timeuser" & CStr(z)), "'", "''")
			
			For i = 1 to 7
				DayTimeInfo(inTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".in")
				DayTimeInfo(luoutTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".luout")
				DayTimeInfo(luinTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".luin")
				DayTimeInfo(outTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".out")
				DayTimeInfo(regularTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".regular")
				DayTimeInfo(otherTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".other")
				DayTimeInfo(otherTypeTime) = request.form("id" & CStr(z) & ".day" & CStr(i) & ".other.type")
		
				WeekTimeInfo(i-1) = Join(DayTimeInfo, ",")
			Next
			TimecardInfo = Join(WeekTimeInfo, ";")
			
			'Compare and backup original and changed time data
			if TimecardInfo <> timeinfo then
				auditEntry = "INSERT INTO tbl_timecards_audits (timeinfo, timecardid, userid) VALUES ('" &_
					timeinfo & "', '" &_
					timecardid & "', '" &_
					timeuser & "')"
				Database.Execute(auditEntry)
				
				newTimeInfo = "timeinfo='" & TimecardInfo & "', "
			end if
		end if

		if sAction <> "nc" then
			newTimeStatus = "status='" & sAction & "', "
			if sAction = "a" then
				timeApprover = "approver='" & user_id & "', "
				timeApprovedDate = "approvedDate=Now() "
			end if
		end if
		
		
		if len(approvalNotes) > 0 then
			timeSupComments = "supComment='" & approvalNotes & "', "
		Else
	 		originalCommentSize = "0" & request.form("supcommentsize" & CStr(z))
			if CInt(originalCommentSize) <> 0 then
				timeSupComments = "supComment='', "
			end if
		end if
		
		timeSql = newTimeStatus & timeApprover & newTimeInfo & timeSupComments
		'response.write timeSql

		if len(timeSql) > 0 then
			if len(timeApprovedDate) > 0 then 
				timeSql = timeSql & timeApprovedDate
			end if
			
			approveTimeInfo = Replace("UPDATE tbl_timecards SET " & timeSql & "WHERE timecardid=" & timecardid, "', WHERE", "' WHERE")
			'response.write(approveTimeInfo)
			'Response.End()
			Database.Execute(approveTimeInfo)
		end if
		approveTimeInfo = ""
		newTimeStatus = ""
		timeApprover = ""
		newTimeInfo = ""
		timeSupComments = ""
	Next
	Database.Close

	session("timecardMessageHeading") = "Timecards Saved"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>All timecards status have been updated and were successfully saved.</span></p>" &_
	"<p>Please remember timecards cannot be payed until they have been reviewed and approved by a manager. Also note that we can only issue paychecks for timecards" &_
	" with which the hours logged on have been reviewed and approved by an agent of the client company.</p></div>"

End Sub	

Function TimeOptions (timePiece)
	dim TimeOption, MinuteSlice, TimeMinute, HourSlice, DisplayTime
	TimeOption = "<option value='-1'>&nbsp</option>"
	StartClock = 0 : StopClock = 24

	z = timePiece
	if len(z) > 0 then 
		MinuteSlice = (z - int(z)) * 60
		if MinuteSlice = 0 then
			TimeMinute =  "00"
		Else
			TimeMinute = CStr(MinuteSlice)
		end if
		
		if z > 11.75 then
			if int(z-12) = 0 then
				DisplayTime = "12:" & TimeMinute & "pm"
			Else
				DisplayTime = int(z-12) & ":" & TimeMinute & "pm"
			end if
		Else
			if int(z) = 0 then
				DisplayTime = "12:" &  TimeMinute & "am"
			Else
				DisplayTime = int(z) & ":" &  TimeMinute & "am"
			end if
		end if

		'Build Options
		TimeOption = TimeOption & "<option value='" & z & "'>" & DisplayTime & "</option>"
	
		if VarType(timePiece) = 8 then
			z = CDbl(timePiece)
			TimeOptions = Replace(TimeOption, "'" & z & "'>", "'" & z & "' selected>")
		end if
		
	end if
End Function

%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
