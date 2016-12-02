<%

session("noGuestHead") = "Are you registered?"
session("noGuestBody") = "<p><em>Are you registered?</em></p><br><p>The Guest account cannot submit time with this tool. " &_
	"You can create an account by pressing ""Sign Up"" below and registering or " &_
	"if you have already registed you can use that account to sign in and continue.</p><br><br>"

dim isInternal
if companyId = 67 then
	isInternal = "true"
Else
	isInternal = "false"
end if

dim whatToDo
whatToDo = request.form("formAction")
if whatToDo = "save" or whatToDo = "delete" or whatToDo = "submit" or whatToDo = "continue" then session("no_header") = true
	
session("page_title") = "Employee Timecards"
session("window_page_title") = "Employee Timecards - Personnel Plus"
session("add_css") = "timecardform.asp.css"
session("javascriptOnLoad") = "initform('" & user_empcode & "', '" & isInternal & "')"
session("additionalScripting") = "<script type=""text/javascript"" src=""/include/js/global.js""></script>" &_
	"<script type=""text/javascript"" src=""/include/js/timecardform.js""></script>"

session("no_cache") = true
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
 %>
<!-- #include virtual='/include/core/init_secure_session.asp' --><%

if len(user_empcode & "") = 0 then
	if request.form("formAction") = "continue" then
		EmpCode2B = request.form("ssn4")
		if len(EmpCode2B & "") = 4 then
			if CInt(EmpCode2B) > 0 then
				EmpCode = Ucase(Left(user_lastname, 3)) & Right(Trim(EmpCode2B), 3)
				Database.Open MySql
				Database.Execute("UPDATE tbl_users SET EmpCode='" & EmpCode & "' WHERE userID=" & user_id)
				Database.Close
				session("no_header") = false
				user_empcode = EmpCode
				Response.Redirect("/include/system/tools/timecardEmp.asp")
			end if
		end if
	end if

	response.write(decorateTop("solicitEmpCode", "marLR10", "Need Last Four")) %>

<div id="getLastFour">
   <form action="timecardEmp.asp" method="post" name="timecardForm" id="timecardForm" on="document.timecardForm.formAction.value='continue'">
  <p><em>Additional Information Needed.</em></p>
  <p>In order to manage your timecard information online our system needs to get some more information from you. Please
    type the the last 4 digits of your social security number in the field provided and press continue when you are done.</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>Please type the last 4 digits of your SSN
 <input name="ssn4" id="ssn4" type="text" maxlength="4" Value="<%=request.form("ssn4")%>" /></p>
	<input type="" id="s1" name="s1" style="display:none" value="continue" />
	<input type="hidden" id="formAction" name="formAction" style="display:none" value="" />
  <p> <a class="squarebutton" href="#" onclick="document.timecardForm.formAction.value='continue';document.timecardForm.submit()"><span>Continue</span></a> </p>
  </form>
</div>
<%

	response.write(decorateBottom())
	TheEnd()
end if
	

const inTime = 0, luoutTime = 1, luinTime = 2, outTime = 3, regularTime = 4, otherTime = 5, otherTypeTime = 6

'Creating new or retrieving previously saved timecard
	PlacementID = Replace(Request.QueryString("placementID"), "'", "")
	TimecardID = Replace(Request.QueryString("timecardID"), "'", "")
	if VarType(TimecardID) = 8 then
		if Instr(TimecardID, "new") > 0 then
			TimecardID = -1
		elseif IsNumeric(TimecardID) then
			TimecardID = CLng(TimecardID)
		Else
			TimecardID = 0
		End IF
	end if
	
	Select Case whatToDo
	Case "save"
		Database.Open MySql
		TimecardID = SaveTimecard
		Database.Close
		session("no_header") = false
		Response.Redirect("/include/system/tools/timecardEmp.asp")
	Case "submit"
		SubmitTimecard
		session("no_header") = false
		Response.Redirect("/include/system/tools/timecardEmp.asp")
	Case "delete"
		DeleteTimecard
	End Select
	
	if TimecardID = 0 then 
		showDashboard
	Else
		showTimeEntryForm
	end if

Sub showDashboard

dim timecard_msg, msg_body
timecard_msg = get_session("timecardMessageHeading")
if len(timecard_msg) > 0 then
	response.write decorateTop("timecardMessageArea", "marLR10", timecard_msg)
	response.write get_session("timecardMessageBody")
	response.write decorateBottom()
	
	timecard_msg = set_session("timecardMessageBody", "")
	msg_body = set_session("timecardMessageHeading", "")
End if %>
<form id="timecardForm" name="timecardForm" method="post" action="timecardEmp.asp">
<%
	'Response.Buffer = true
	dim objXMLHTTP, placements
	
	'Check in internal employee
	if companyId = 67 then
		isInternal = "true"
	Else
		isInternal = "false"
	end if

	Response.write DecorateTop("currentPlacements", "dashboard marLRB10", "Current Placements")
	'Check in internal employee
	if companyId = 67 then
		isInternal = "true"
	Else
		isInternal = "false"
	end if
	
	'Set placements = Server.CreateObject("MSXML2.ServerXMLHTTP")
	'placements.Open "GET", "http://192.168.0.8/include/system/tools/timecards/getPlacements.asp?empcode=" & user_empcode & "&status=0&isint=" & isInternal, false
	'placements.Send
	'Response.write placements.responseText
	GetPlacements
	Response.write "<span id=""placementBlob""></span>"
	Set placements = Nothing
	
	Response.write DecorateBottom() & DecorateTop("savedTimecards", "dashboard marLRB10", "Saved Timecards")
	dim timecards
	Set timecards = Server.CreateObject("MSXML2.ServerXMLHTTP")
	
	timecards.Open "GET", "https://www.personnelinc.com/include/system/tools/timecards/getSavedTime.asp?id=" & user_id, false
	timecards.Send
	Response.write timecards.responseText
	Set timecards = Nothing
	Response.write DecorateBottom()
	
	'dim textResponse
	'response.write DecorateTop("pastPlacements", "marLRB10", "Past Placements")
	'Set placements = Server.CreateObject("MSXML2.ServerXMLHTTP")
	'placements.Open "GET", "http://192.168.0.2/include/system/tools/timecards/getPlacements.asp?empcode=" & user_empcode & "&status=3", false
	'placements.Send
	
	'textResponse = placements.responseText
	'if len(textResponse) > 0 then Response.write textResponse
	'Set placements = Nothing
	'Response.write DecorateBottom() 
	
	dim checkIfApprover, weekending
	
	Database.Open MySql
	Set checkIfApprover = Database.Execute("SELECT userID, companyID FROM tbl_approvers " &_
		"WHERE companyID=" & companyId & " AND userID=" & user_id)
	if Not checkIfApprover.eof then
			
		response.write DecorateTop("viewCompanyTimecards", "marLRB10", "Saved Company Timecards")
		
		Set weekending = Server.CreateObject("MSXML2.ServerXMLHTTP")
		weekending.Open "GET", "https://www.personnelinc.com/include/system/tools/timecards/getCompanySavedTime.asp?id=" & companyId, false
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
	dim i, DayTimeInfo, WeekTimeInfo, FullTimeCard(6, 6), TimecardInfo, WeekEndsOn
	
	Database.Open MySql
	if TimecardID > 0 then
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
		Erase WeekTimeInfo
		Erase DayTimeInfo
	end if
	Set  dbQuery= Database.Execute("Select weekends FROM tbl_companies WHERE companyID = " & companyId)
	WeekEndsOn = dbQuery("weekends")
	Database.Close
	
	JobOrderID = Request.QueryString("joborderid")
	dim objXMLHTTP, OrderDetail, PlacementDetail
	if len(JobOrderID & "") > 0 then
		Response.write DecorateTop("orderDetails", "marLRB10", "Job Order Information")
		'Response.Buffer = true
		Set OrderDetail = Server.CreateObject("MSXML2.ServerXMLHTTP")
		OrderDetail.Open "GET", "http://primary.personnelplus.net:8008/include/system/tools/timecards/getOrderDetail.asp?orderid=" & JobOrderID & "&companyid=PER", false
		OrderDetail.Send
		Response.write OrderDetail.responseText
		Set OrderDetail = Nothing
	Else
		'Response.write DecorateTop("placementDetails", "marLRB10", "Placement Information")

		'if companyId = 67 then
		'	isInternal = "true"
		'Else
		'	isInternal = "false"
		'end if
				
		'Set PlacementDetail = Server.CreateObject("MSXML2.ServerXMLHTTP")
		'PlacementDetail.Open "GET", "http://primary.personnelplus.net:8008/include/system/tools/timecards/getPlacementDetail.asp?placementid=" & PlacementID & "&companyid=PER", false
		'PlacementDetail.Send
		'Response.write PlacementDetail.responseText
		'Set PlacementDetail = Nothing
	end if
	'Response.write DecorateBottom()
	Response.write DecorateTop("timeEntryForm", "dashboard marLRB10", "Time Entry") %>
<form id="timecardForm" name="timecardForm" method="post" action="">
	<div id="overTimeNote" class="dayOfTheWeek">
    <p> PLEASE NOTE: Company policy requires approval for all work hours and that all over-time hours require prior approval. All hours not approved will not be paid.</p>
	</div>

  <div class="weekEndingDate">
    <p><span>For Week Ending&nbsp;</span>
      <select name="weekending" id="weekending" onChange="setweekdays()">
        <%
	Today = Weekday(Date)
	if Today > WeekEndsOn then
		AdjustedDate = DateAdd("d", 7 - (Today - WeekEndsOn), Date)
	Else
		AdjustedDate = DateAdd("d", 7 - (WeekEndsOn - Today), Date)
	end if
	
	For i = -28 To 14 Step 7
		WeekEndDate = DateAdd("d", i, AdjustedDate)
		if FormatDateTime(weekending) = FormatDateTime(WeekEndDate) then
			thisOneSelected = "' selected>"
		Else
			thisOneSelected = "'>"
		end if
		Response.write "<option value='" & WeekEndDate & thisOneSelected & FormatDateTime(WeekEndDate, 1) & "</option>"
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
    <p> Timecard's must be completed by 8:00 am Monday. if you  your timecard late, your check may be delayed at least one week. Personnel Plus may not pay you until proper approval is obtained. Failure to notify your Personnel Plus representative of completion of your job assignment will be considered job abandonment, and employment benefits will be denied.</p>
    <p style="margin-top:0.5em">By clicking "Submit" you certify that you have worked the hours listed, that while on this assign-ment you have not had any work-related injuries or illnesses that you have not reported to Personnel Plus, you agree that you have read, understand and are bound by provisions of the <a href="#">Personnel Plus End User License Agreement</a> and the <a href="#">Personnel Plus Terms of Service</a></p>
  </div>
  <input type="hidden" id="placementID" name="placementID" value="<%=PlacementID%>" />
  <input type="hidden" id="tempsID" name="tempsID" value="<%=Request.QueryString("companyid")%>" />
  <input type="hidden" id="formAction" name="formAction" value="" />
  <p> <a class="squarebutton" href="javascript:saveTime();"><span>Save</span></a>  <a class="squarebutton" href="/include/system/tools/timecardEmp.asp"><span>Cancel</span></a> <a class="squarebutton" href="javascript:submitTime();"><span>Submit</span></a> <a class="squarebutton" href="javascript:deleteTime();"><span>Delete</span></a> </p>

</form>
<span id="placementBlob" style="display:none;"></span>
<%
Response.write DecorateBottom()
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

Function SaveTimecard
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

	if TimecardID = -1 then
		Set dbQuery = Database.Execute("INSERT INTO tbl_timecards (creationDate) VALUES (Now());SELECT last_insert_id()").nextrecordset
		TimecardID = CLng(dbQuery(0))
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
	sqlTimecard = "UPDATE tbl_timecards SET " &_
		PlacementID_cmd &_
		"userID=" & user_id & ", " &_
		"companyID=" & companyId & ", " &_
		"weekending='" & MySqlFriendlyDate & "', " &_
		"timeInfo='" & Server.HTMLEncode(TimecardInfo) & "', " &_
		"comments='" & Replace(request.form("comments"), "'", "''") & "'" &_
		TempsID_cmd & ", " &_
		"status='o', " &_
		"modifiedDate=Now() " &_
		"WHERE timecardID=" & TimecardID 
		
	Database.Execute(sqlTimecard)
	
	session("timecardMessageHeading") = "Timecard Saved"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Your timecard was successfully saved.</span></p><br>" &_
	"<p>Please remember your timecard cannot be approved until it is completed in full and submitted. We can only issue paychecks for timecards" &_
	" with which the hours logged on have been reviewed and approved by an agent of the client company.</p></div>"
	SaveTimecard = TimecardID
End Function	

Sub SubmitTimecard
	Database.Open MySql
	Database.Execute("UPDATE tbl_timecards SET status='s' WHERE timecardID=" & SaveTimecard)
	Database.Close

	session("timecardMessageHeading") = "Timecard Submitted"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Your timecard was successfully submitted.</span></p><br>" &_
		"<p>Please remember we can only issue paychecks for timecards with which the hours submitted have been approved by an agent of the client company.</p></div>"
End Sub	

Sub DeleteTimecard
	dim strMsgHeading, strMsgBody
	
	Database.Open MySql
	Database.Execute("DELETE FROM tbl_timecards WHERE timecardID=" & TimecardID)
	Database.Close

	strMsgHeading = "Timecard Deleted"
	strMsgBody    = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Time card deleted.</span></p><br>" &_
					"<p>Your time card was successfully deleted from the online system database.</div>"
	strMsgHeading = set_session("timecardMessageHeading", strMsgHeading)
	strMsgBody = set_session("timecardMessageBody", strMsgBody)
	Response.Redirect("/include/system/tools/timecardEmp.asp")
End Sub

sub GetPlacements
	dim empcode, getApplicants_cmd, Applicants, selectedID, applicantID

	empcode = Replace(Trim(Request.QueryString("empcode")), "'", "")
	placedStatus = Replace(Trim(Request.QueryString("status")), "'", "")

	'if placedStatus = 0 then
	'	imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/currentPlacements.png" & Chr(34) & "/></li>"
	'Else
	'	imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/pastPlacements.png" & Chr(34) & "/></li>"
	'end if

	Response.write "<ul class='dashboard'>"
	'if Request.QueryString("isint") = "true" AND placedStatus = 0 then
		Response.write "<li><a href='timecardEmp.asp?timecardID={new}&placementID=0'><ul>"
		Response.write "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/internalEmployee.png" & Chr(34) & "/></li>"
		Response.write "<li>Create</li><li>New Timecard</li>"
		Response.write "</ul></a></li>"
	'end if

	'Set getPlacements = Server.CreateObject ("ADODB.Connection")
	'For Each item In dsnLessTemps
	'	IF len(item & "") > 0 then
	'		getPlacements_sql = "SELECT WorkCodes.Description, Customers.CustomerName,  Placements.PlacementID " &_
	'				"FROM (WorkCodes INNER JOIN Placements ON WorkCodes.WorkCode = Placements.WorkCode) INNER JOIN Customers ON Placements.Customer = Customers.Customer " &_
	'				"WHERE ((Placements.PlacementStatus=" & placedStatus & " AND Placements.EmployeeNumber='" & empcode & "'));"
	'		getPlacements.Open item
	'		Set Placements = getPlacements.Execute(getPlacements_sql)
	'			
	'		do while not Placements.eof
	'			Response.write "<li><a href='timecardEmp.asp?timecardid={new}&companyid=" & Mid(item, 5, 3) & "&placementID=" & Placements("PlacementID") & "'><ul>" & imageIcon
	'			Response.write "<li>" & Placements("CustomerName") & "</li><li>" & Placements("Description") & "</li>"
	'			Response.write "</ul></a></li>"
	'			Placements.Movenext
	'		loop
	'		getPlacements.Close
	'	end if
	'Next
	'Set getPlacements_cmd = Nothing
	'Set Placements = Nothing

	Response.write "</ul>"
end sub

%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
