<%
dim isInternal
if companyId = 67 then
	isInternal = "true"
Else
	isInternal = "false"
end if

session("add_css") = "empTools.asp.css"
session("javascriptOnLoad") = "initform('" & user_empcode & "', '" & isInternal & "')" %>
<!-- #include virtual='/include/core/init_secure_session.asp' -->
<%
	whatToDo = request.form("formAction")
	if whatToDo = "save" then
		SaveTimecard
	elseif whatToDo = "submit" then
		SubmitTimecard
	elseif whatToDo = "delete" then
		DeleteTimecard
	end if
	
	showDashboard
	
Sub showDashboard

if len(session("toolsAnnouncement")) > 0 then
	response.write(decorateTop("toolsAnnouncementArea", "marLR10y", session("toolsAnnouncementHeading")))
	response.write(session("toolsAnnouncement"))
	response.write(decorateBottom())
	
	session("toolsAnnouncementHeading") = ""
	session("toolsAnnouncement") = ""
End if %>
<form id="form1" name="form1" method="post" action="timecardEmp.asp">
<%
	Response.Buffer = true
	dim objXMLHTTP, placements
	
	'Check in internal employee
	if companyId = 67 then
		isInternal = "true"
	Else
		isInternal = "false"
	end if

	Response.write DecorateTop("currentPlacements", "dashboard", "Current Placements")
	'Check in internal employee
	if companyId = 67 then
		isInternal = "true"
	Else
		isInternal = "false"
	end if
	
	'Set placements = Server.CreateObject("MSXML2.ServerXMLHTTP")
	'placements.Open "GET", "http://192.168.0.6/include/system/tools/timecards/getPlacements.asp?empcode=" & user_empcode & "&status=0&isint=" & isInternal, false
	'placements.Send
	'Response.write placements.responseText
	Response.write "<span id=""placementBlob""></span>"
	'Set placements = Nothing
	
	Response.write DecorateBottom() & DecorateTop("savedTimecards", "dashboard", "Saved Timecards")
	dim timecards
	Set timecards = Server.CreateObject("MSXML2.ServerXMLHTTP")

	timecards.Open "GET", "http://192.168.0.6/include/system/tools/timecards/getSavedTime.asp?id=" & user_id, false
	timecards.Send
	Response.write timecards.responseText
	Set timecards = Nothing
	Response.write DecorateBottom()
	
	dim textResponse
	response.write DecorateTop("pastPlacements", "", "Past Placements")
	Set placements = Server.CreateObject("MSXML2.ServerXMLHTTP")
	placements.Open "GET", "http://192.168.0.6/include/system/tools/timecards/getPlacements.asp?empcode=" & user_empcode & "&status=3", false
	placements.Send
	
	textResponse = placements.responseText
	if len(textResponse) > 0 then Response.write textResponse
	Set placements = Nothing
	Response.write DecorateBottom() 
	
	dim checkIfApprover, weekending
	
	Database.Open MySql
	Set checkIfApprover = Database.Execute("SELECT userID, companyID FROM tbl_approvers " &_
		"WHERE companyID=" & companyId & " AND userID=" & user_id)
	if Not checkIfApprover.eof then
			
		response.write DecorateTop("viewCompanyTimecards", "marLRB10", "Saved Company Timecards")
		
		Set weekending = Server.CreateObject("MSXML2.ServerXMLHTTP")
		weekending.Open "GET", "http://192.168.0.6/include/system/tools/timecards/getCompanySavedTime.asp?id=" & companyId, false
		weekending.Send
		
		textResponse = weekending.responseText
		if len(textResponse) > 0 then Response.write textResponse
		Set weekending = Nothing
		Response.write DecorateBottom() 
	end if		
	Set checkIfApprover = Nothing
	Database.Close
	
End Sub

Sub showTimeEntryForm
	dim i, DayTimeInfo, WeekTimeInfo, FullTimeCard(6, 6), TimecardInfo
	if TimecardID > 0 then
		Database.Open MySql
		
		sqlTimecard = Database.Execute("SELECT * FROM tbl_timecards WHERE timecardID=" & TimecardID)
		WeekTimeInfo = Split(sqlTimecard("timeinfo"), ";")
		
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
		timecardComments = sqlTimecard("comments")
		PlacementID = sqlTimecard("placementID")
		weekending = sqlTimecard("weekending")
		lastModified = sqlTimecard("modifiedDate")
		creationDate = sqlTimecard("creationDate")
		Database.Close
		Erase WeekTimeInfo
		Erase DayTimeInfo
	end if
	
	JobOrderID = Request.QueryString("joborderid")
	dim objXMLHTTP, OrderDetail, PlacementDetail
	if len(JobOrderID & "") > 0 then
		Response.write DecorateTop("orderDetails", "marLRB10", "Job Order Information")
		Response.Buffer = true
		Set OrderDetail = Server.CreateObject("MSXML2.ServerXMLHTTP")
		OrderDetail.Open "GET", "http://192.168.0.6/include/system/tools/timecards/getOrderDetail.asp?orderid=" & JobOrderID & "&companyid=PER", false
		OrderDetail.Send
		Response.write OrderDetail.responseText
		Set OrderDetail = Nothing
	Else
		Response.write DecorateTop("placementDetails", "marLRB10", "Placement Information")
		Response.Buffer = true
		'Check in internal employee
		if companyId = 67 then
			isInternal = "true"
		Else
			isInternal = "false"
		end if
				
		Set PlacementDetail = Server.CreateObject("MSXML2.ServerXMLHTTP")
		PlacementDetail.Open "GET", "http://192.168.0.6/include/system/tools/timecards/getPlacementDetail.asp?placementid=" & PlacementID & "&companyid=PER", false
		PlacementDetail.Send
		Response.write PlacementDetail.responseText
		Set PlacementDetail = Nothing
	end if
	Response.write DecorateBottom() & DecorateTop("timeEntryForm", "dashboard marLRB10", "Time Entry") %>
<form id="form1" name="form1" method="post" action="">
	<div id="overTimeNote" class="dayOfTheWeek">
    <p> PLEASE NOTE: Company policy requires approval for all work hours and that all over-time hours require prior approval. All hours not approved will not be paid.</p>
	</div>

  <div class="weekEndingDate">
    <p><span>For Week Ending&nbsp;</span>
      <select name="weekending" id="weekending" onChange="setweekdays()">
        <%
	For i = -31 To 7
		WeekEndDate = DateAdd("d", i, Date)
		if FormatDateTime(weekending) = FormatDateTime(WeekEndDate) then
			thisOneSelected = "' selected>"
		Else
			thisOneSelected = "'>"
		end if
		Response.write("<option value='" & WeekEndDate & thisOneSelected & FormatDateTime(WeekEndDate, 1) & "</option>")
	Next
	%>
      </select>
  </div>
  <div class="dayOfTheWeek">
    <ul>
      <li class="title">&nbsp;</li>
      <li>Time-In</li>
      <li>Time-Out</li>
      <li>Time-In</li>
      <li>Time-Out</li>
      <li class="tally">Total</li>
      <li class="tally">Regular</li>
      <li class="tally">Other</li>
      <li class="othertype">Type</li>
    </ul>
  </div>
  <%
	For i = 1 to 7 %>
  <div id="day<%=i%>.hours" class="dayOfTheWeek">
    <input type="hidden" id="day<%=i%>.rows" value="1" />
    <ul id="day<%=i%>.row1">
      <li id="name.day<%=i%>.row1" class="title">&nbsp;</li>
      <li>
        <select id="day<%=i%>.row1.in" name="day<%=i%>.row1.in" onchange="adjustclocks('day<%=i%>.row1')">
          <%=TimeOptions(FullTimeCard(inTime, i - 1))%>
        </select>
      </li>
      <li>
        <select id="day<%=i%>.row1.luout" name="day<%=i%>.row1.luout" onchange="adjustclocks('day<%=i%>.row1')">
          <%=TimeOptions(FullTimeCard(luoutTime, i - 1))%>
        </select>
      </li>
      <li>
        <select id="day<%=i%>.row1.luin" name="day<%=i%>.row1.luin" onchange="adjustclocks('day<%=i%>.row1')">
          <%=TimeOptions(FullTimeCard(luinTime, i - 1))%>
        </select>
      </li>
      <li>
        <select id="day<%=i%>.row1.out" name="day<%=i%>.row1.out" onchange="adjustclocks('day<%=i%>.row1')">
          <%=TimeOptions(FullTimeCard(outTime, i - 1))%>
        </select>
      </li>
      <li class="tally totalhours">
	  	<input id="day<%=i%>.row1.total" name="day<%=i%>.row1.total" type="text" onblur="computeTime()" readonly></li>
      <li class="tally totalhours">
        <input id="day<%=i%>.row1.regular" name="day<%=i%>.row1.regular" type="text" value="<%=FullTimeCard(regularTime, i - 1)%>" onblur="computeTime()" readonly></li>
      <li class="tally totalhours">
        <input id="day<%=i%>.row1.other" name="day<%=i%>.row1.other" type="text" value="<%=FullTimeCard(otherTime, i - 1)%>" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day<%=i%>.row1.other.type" name="day<%=i%>.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S"<% if FullTimeCard(otherTypeTime, i - 1) = "S" then Response.write " selected" %>>Sick</option>
          <option value="H"<% if FullTimeCard(otherTypeTime, i - 1) = "H" then Response.write " selected" %>>Holiday</option>
          <option value="V"<% if FullTimeCard(otherTypeTime, i - 1) = "V" then Response.write " selected" %>>Vacation</option>
          <option value="O"<% if FullTimeCard(otherTypeTime, i - 1) = "O" then Response.write " selected" %>>Other</option>
        </select>
      </li>
    </ul>
  </div>
  <%
	Next %>
  <div class="dayOfTheWeek">
    <ul>
      <li class="title">&nbsp;</li>
      <li>&nbsp;</li>
      <li>&nbsp;</li>
      <li>&nbsp;</li>
      <li>
        <p>Total Hours</p>
      </li>
      <li class="tally totalhours"><span id="hours.total"></span></li>
      <li class="tally totalhours"><span id="regular.total"></span></li>
      <li class="tally totalhours"><span id="other.total"></span></li>
    </ul>
  </div>
  <div class="comments">
    <p><b>Comments</b></p>
    <p>
      <textarea name="comments"><%=timecardComments%></textarea>
    </p>
  </div>
  <div class="dayOfTheWeek" style="margin:2em; padding:1em; border:1px solid #A8A8A8; background-color:#FFF8D1">
    <p> Timecard's must be completed by 8:00 am Monday. if you submit your timecard late, your check may be delayed at least one week. Personnel Plus may not pay you until proper approval is obtained. Failure to notify your Personnel Plus representative of completion of your job assignment will be considered job abandonment, and employment benefits will be denied.</p>
    <p style="margin-top:0.5em">By clicking "Submit" you certify that you have worked the hours listed, that while on this assign-ment you have not had any work-related injuries or illnesses that you have not reported to Personnel Plus, you agree that you have read, understand and are bound by provisions of the <a href="#">Personnel Plus End User License Agreement</a> and the <a href="#">Personnel Plus Terms of Service</a></p>
  </div>
  <input type="hidden" id="placementID" name="placementID" value="<%=PlacementID%>" />
  <input type="hidden" id="tempsID" name="tempsID" value="<%=Request.QueryString("companyid")%>" />
  <input type="hidden" id="formAction" name="formAction" value="" />
  <p> <a class="squarebutton" href="#" onclick="document.form1.formAction.value='save';document.form1.submit()"><span>Save</span></a>  <a class="squarebutton" href="/include/system/tools/timecardEmp.asp"><span>Cancel</span></a> <a class="squarebutton" href="javascript:submitTime();"><span>Submit</span></a> <a class="squarebutton" href="javascript:deleteTime();"><span>Delete</span></a> </p>

</form>
<%
End Sub 

Function TimeOptions (timePiece)
	dim TimeOption, MinuteSlice, TimeMinute, HourSlice, DisplayTime
	TimeOption = "<option value='-1'>&nbsp</option>"
	StartClock = 0 : StopClock = 24
	For i = StartClock to StopClock step 0.25
		MinuteSlice = (i - int(i)) * 60
		if MinuteSlice = 0 then
			TimeMinute =  "00"
		Else
			TimeMinute = CStr(MinuteSlice)
		end if
		
		if i > 11.75 then
			if int(i-12) = 0 then
				DisplayTime = "12:" & TimeMinute & "pm"
			Else
				DisplayTime = int(i-12) & ":" & TimeMinute & "pm"
			end if
		Else
			if int(i) = 0 then
				DisplayTime = "12:" &  TimeMinute & "am"
			Else
				DisplayTime = int(i) & ":" &  TimeMinute & "am"
			end if
		end if

		'response.write VarType(timePiece)
		if VarType(timePiece) = 8 then
			if i = CDbl(timePiece) then
				TimeOption = TimeOption & "<option value='" & i & "' selected>" & DisplayTime & "</option>"
			Else
				TimeOption = TimeOption & "<option value='" & i & "'>" & DisplayTime & "</option>"
			end if
		Else
			TimeOption = TimeOption & "<option value='" & i & "'>" & DisplayTime & "</option>"
		end if
	Next
	TimeOptions = TimeOption
End Function

Sub SaveTimecard
	dim i, DayTimeInfo(6), WeekTimeInfo(6), TimecardInfo

	For i = 1 to 7
		DayTimeInfo(inTime) = request.form("day" & CStr(i) & ".row1.in")
		DayTimeInfo(luoutTime) = request.form("day" & CStr(i) & ".row1.luout")
		DayTimeInfo(luinTime) = request.form("day" & CStr(i) & ".row1.luin")
		DayTimeInfo(outTime) = request.form("day" & CStr(i) & ".row1.out")
		DayTimeInfo(regularTime) = request.form("day" & CStr(i) & ".row1.regular")
		DayTimeInfo(otherTime) = request.form("day" & CStr(i) & ".row1.other")
		DayTimeInfo(otherTypeTime) = request.form("day" & CStr(i) & ".row1.other.type")

		WeekTimeInfo(i-1) = Join(DayTimeInfo, ",")
	Next
	TimecardInfo = Join(WeekTimeInfo, ";")
	
	Database.Open MySql
	if TimecardID = -1 then
		Database.Execute("INSERT INTO tbl_timecards (creationDate) VALUES (Now())")
		newTimecardID = Database.Execute("Select LAST_INSERT_ID()")
		TimecardID = CLng(newTimecardID("LAST_INSERT_ID()"))
	end if
	
	'Convert Date
	WeekEnding = request.form("weekending")
	PlacementID = request.form("placementID")

	Select Case request.form("tempsID")
	Case "PER"
		TempsID_cmd = ", tempsID=" & PER
	Case "IDA"
		TempsID = ", tempsID=" & IDA
	Case "BUR"
		TempsID_cmd = ", tempsID=" & BUR
	Case "BOI"
		TempsID_cmd = ", tempsID=" & BOI
	End Select

	if len(PlacementID & "") > 0 then
		PlacementID_cmd = "placementID=" & PlacementID & ", "
	end if
	MySqlFriendlyDate = Year(WeekEnding) & "/" & Month(WeekEnding) & "/" & Day(WeekEnding)
	sqlTimecard = "UPDATE tbl_timecards SET " & PlacementID_cmd & "userID=" & user_id &_
		", companyID=" & companyId & ", weekending='" & MySqlFriendlyDate &_
		"', timeInfo='" & Server.HTMLEncode(TimecardInfo) & "', comments='" & Server.HTMLEncode(Replace(request.form("comments"), "'", "''")) &_
		"'" & TempsID_cmd & ", modifiedDate=Now() WHERE timecardID=" & TimecardID

	response.write sqlTimecard
	
	Database.Execute(sqlTimecard)
	Database.Close

	session("timecardMessageHeading") = "Timecard Saved"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Your timecard was successfully saved.</span></p><br>" &_
	"<p>Please remember your timecard cannot be approved until it is completed in full and submitted. We can only issue paychecks for timecards" &_
	" with which the hours logged on have been reviewed and approved by an agent of the client company.</p></div>"
	
	Response.Redirect("/include/system/tools/timecardEmp.asp")
End Sub	

Sub SubmitTimecard
	dim i, DayTimeInfo(6), WeekTimeInfo(6), TimecardInfo

	For i = 1 to 7
		DayTimeInfo(inTime) = request.form("day" & CStr(i) & ".row1.in")
		DayTimeInfo(luoutTime) = request.form("day" & CStr(i) & ".row1.luout")
		DayTimeInfo(luinTime) = request.form("day" & CStr(i) & ".row1.luin")
		DayTimeInfo(outTime) = request.form("day" & CStr(i) & ".row1.out")
		DayTimeInfo(regularTime) = request.form("day" & CStr(i) & ".row1.regular")
		DayTimeInfo(otherTime) = request.form("day" & CStr(i) & ".row1.other")
		DayTimeInfo(otherTypeTime) = request.form("day" & CStr(i) & ".row1.other.type")

		WeekTimeInfo(i-1) = Join(DayTimeInfo, ",")
	Next
	TimecardInfo = Join(WeekTimeInfo, ";")
	
	Database.Open MySql
	'if TimecardID = -1 then
	'	Database.Execute("INSERT INTO tbl_timecards (creationDate) VALUES (Now())")
	'	newTimecardID = Database.Execute("Select LAST_INSERT_ID()")
	'	TimecardID = CLng(newTimecardID("LAST_INSERT_ID()"))
	'end if
	
	'Convert Date
	WeekEnding = request.form("weekending")
	PlacementID = request.form("placementID")

	Select Case request.form("tempsID")
	Case "PER"
		TempsID_cmd = ", tempsID=" & PER
	Case "IDA"
		TempsID = ", tempsID=" & IDA
	Case "BUR"
		TempsID_cmd = ", tempsID=" & BUR
	Case "BOI"
		TempsID_cmd = ", tempsID=" & BOI
	Case "TWI"
		TempsID_cmd = ", tempsID=" & TWI
	End Select

	if len(PlacementID & "") > 0 then
		PlacementID_cmd = "placementID=" & PlacementID & ", "
	end if
	MySqlFriendlyDate = Year(WeekEnding) & "/" & Month(WeekEnding) & "/" & Day(WeekEnding)
	sqlTimecard = "INSERT INTO tbl_submittedtime (" &_
		"timecardID, " &_
		"placementID, " &_
		"userID, " &_
		"companyID, " &_
		"weekending, " &_
		"timeInfo, " &_
		"comments, " &_
		"submitDate) VALUES (" &_
		TimecardID & ", " &_
		PlacementID & ", " &_
		user_id & ", " &_
		companyId & ", '" &_
		MySqlFriendlyDate & "', '" &_
		Server.HTMLEncode(TimecardInfo) & "', '" &_
		Server.HTMLEncode(request.form("comments")) & "', " &_
		"Now())"
	'Response.write sqlTimecard
	'Response.End()	
		
	Database.Execute(sqlTimecard)
	Database.Execute("DELETE FROM tbl_timecards WHERE timecardID=" & TimecardID)
	Database.Close

	session("timecardMessageHeading") = "Timecard Submitted"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Your timecard was successfully submitted.</span></p><br>" &_
		"<p>Please remember we can only issue paychecks for timecards with which the hours submitted have been approved by an agent of the client company.</p></div>"
	Response.Redirect("/include/system/tools/timecardEmp.asp")
End Sub	

Sub DeleteTimecard
	Database.Open MySql
	Database.Execute("DELETE FROM tbl_timecards WHERE timecardID=" & TimecardID)
	Database.Close

	session("timecardMessageHeading") = "Timecard Deleted"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Time card deleted.</span></p><br>" &_
		"<p>Your time card was successfully deleted from the online system database.</div>"
	Response.Redirect("/include/system/tools/timecardEmp.asp")
End Sub	
%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
