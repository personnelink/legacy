<%
session("add_css") = "./timecardform.asp.css"
session("javascriptOnLoad") = "initform()" %>
<!-- #include virtual='/include/core/init_secure_session.asp' -->
<!-- #include file='timecardSup.doStuff.asp' -->

<script type="text/javascript" src="timecardform.js"></script>

<form id="timecardForm" name="timecardForm" action="<%=aspPageName%>" method="post">

<%

Sub showTimeEntryForm
break "showTimeEntryForm"
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
	TempsDB = Request.QueryString("companyid")
	EmpCode = Request.QueryString("emp")
	dim objXMLHTTP, OrderDetail, PlacementDetail
	if len(JobOrderID & "") > 0 then
		Response.write DecorateTop("orderDetails", "", "Job Order Information")
		'Response.Buffer = true
		Set OrderDetail = Server.CreateObject("MSXML2.ServerXMLHTTP")
		OrderDetail.Open "GET", "http://primary.personnelplus.net:8008/include/system/tools/timecards/getOrderDetail.asp?orderid=" & JobOrderID & "&companyid=PER", false
		OrderDetail.Send
		Response.write OrderDetail.responseText
		Set OrderDetail = Nothing
	Else
		Response.write DecorateTop("placementDetails", "", "Placement Information")
		'Response.Buffer = true
		'Check in internal employee
		if companyId = 67 then
			is_internal = true
		Else
			is_internal = false
		end if
				
		Set PlacementDetail = Server.CreateObject("MSXML2.ServerXMLHTTP")
		PlacementDetail.Open "GET", "http://primary.personnelplus.net:8008/include/system/tools/timecards/getPlacementDetail.asp?placementid=" & PlacementID & "&companyid=PER", false
		PlacementDetail.Send
		Response.write PlacementDetail.responseText
		Set PlacementDetail = Nothing
	end if
	Response.write DecorateBottom() & DecorateTop("timeEntryForm", "dashboard", "Time Entry") %>
<form id="form1" name="form1" method="post" action="">
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
          <% TimeOptions (FullTimeCard(inTime, i - 1)) %>
        </select>
      </li>
      <li>
        <select id="day<%=i%>.row1.luout" name="day<%=i%>.row1.luout" onchange="adjustclocks('day<%=i%>.row1')">
          <% TimeOptions (FullTimeCard(luoutTime, i - 1)) %>
        </select>
      </li>
      <li>
        <select id="day<%=i%>.row1.luin" name="day<%=i%>.row1.luin" onchange="adjustclocks('day<%=i%>.row1')">
          <% TimeOptions (FullTimeCard(luinTime, i - 1)) %>
        </select>
      </li>
      <li>
        <select id="day<%=i%>.row1.out" name="day<%=i%>.row1.out" onchange="adjustclocks('day<%=i%>.row1')">
          <% TimeOptions (FullTimeCard(outTime, i - 1)) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day<%=i%>.row1.total"></span></li>
      <li class="tally">
        <input id="day<%=i%>.row1.regular" name="day<%=i%>.row1.regular" type="text" value="<%=FullTimeCard(regularTime, i - 1)%>" onblur="computeTime()">
      </li>
      <li class="tally">
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
  <p> <a class="squarebutton" href="#" onclick="document.form1.formAction.value='save';document.form1.submit()"><span>Save</span></a>  <a class="squarebutton" href="/include/system/tools/timecardSup.asp"><span>Cancel</span></a> <a class="squarebutton" href="<%=FormPostTo & remove%>" onclick="document.taskaction.formAction.value='submit';document.taskaction.submit()"><span>Submit</span></a> </p>
</form>
<%
End Sub 

Sub TimeOptions (timePiece)
	Response.write "<option value='-1'>&nbsp</option>"
	optiontext = "<option value='increment' isSelected>display</option>"
		StartClock = 0 : StopClock = 24
		For i = StartClock to StopClock step 0.25
			HourSlice = (i - int(i)) * 60
			if HourSlice = 0 then
				Time12HourDisplay =  "00"
				'Time24HourDisplay = "00"
			Else
				Time12HourDisplay = CStr(HourSlice)
				'Time24HourDisplay = CStr(HourSlice)
			end if
			if i > 11.75 then
				if int(i-12) = 0 then
					Time12HourDisplay = "12:" & Time12HourDisplay & "pm"
				Else
					Time12HourDisplay = int(i-12) & ":" & Time12HourDisplay & "pm"
				end if
			Else
				if int(i) = 0 then
					Time12HourDisplay = "12:" &  Time12HourDisplay & "am"
				Else
					Time12HourDisplay = int(i) & ":" &  Time12HourDisplay & "am"
				end if
			end if
			'if i < 10 then
			'	if i < 1 then
			'		Time24HourDisplay = "00:" & Time24HourDisplay
			'	Else
			'		Time24HourDisplay = "0" & Int(i) & ":" & Time24HourDisplay
			'	end if
			'Else
			'	Time24HourDisplay = int(i) & ":" & Time24HourDisplay
			'end if
			timesegment = optiontext
			timesegment = Replace(timesegment, "increment", i)
			if VarType(timePiece) = 8 then
					if i = CDbl(timePiece) then
					timesegment = Replace(timesegment, "isSelected", "selected")
				end if
			Else
				timesegment = Replace(timesegment, "isSelected", "")
			end if
			'timesegment = Replace(timesegment, "display", Time12HourDisplay & " / " &  Time24HourDisplay)
			timesegment = Replace(timesegment, "display", Time12HourDisplay)
			Response.write timesegment
		Next
End Sub

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
		"', timeInfo='" & Server.HTMLEncode(TimecardInfo) & "', comments='" & Server.HTMLEncode(request.form("comments")) &_
		"'" & TempsID_cmd & ", modifiedDate=Now() WHERE timecardID=" & TimecardID

	response.write sqlTimecard
	
	Database.Execute(sqlTimecard)
	Database.Close

	session("timecardMessageHeading") = "Timecard Saved"
	session("timecardMessageBody") = "<div id=" & chr(34) & "timecardSaved" & chr(34) & "><p><span>Your timecard was successfully saved.</span></p>" &_
	"<p>Please remember your timecard cannot be approved until it is completed in full and submitted. We can only issue paychecks for timecards" &_
	" with which the hours logged on have been reviewed and approved by an agent of the client company.</p></div>"
	
	Response.Redirect("/include/system/tools/supTimecardform.asp")
End Sub	
%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
