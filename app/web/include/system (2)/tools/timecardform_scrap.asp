<%
session("add_css") = "timecardform.asp.css"
session("javascriptOnLoad") = "initform()" %>

<!-- #include virtual='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/timecardform.js"></script>

<%=DecorateTop("timeEntryForm", "", "Time Entry Form...Scratchpad")%>

<form id="form1" name="form1" method="post" action="">
  
<table id="timecards" cellspacing="1"> <%

	Set getTimecards_cmd = Server.CreateObject ("ADODB.Command")
	With getTimecards_cmd
		.ActiveConnection = MySql
		.CommandText = "SELECT timesheetID, payperiod, placementID, TotalHours FROM tbl_timecards WHERE userID='" & user_id & "' Order By payperiod DESC"
		.Prepared = true
	End With
	Set Timecards = getTimecards_cmd.Execute
	
	Set getPlacementDetail_cmd = Server.CreateObject("ADODB.Command")
	getPlacementDetail_cmd.ActiveConnection = TempsPlus(PER)

	Set getWorkDetail_cmd = Server.CreateObject("ADODB.Command")
	getWorkDetail_cmd.ActiveConnection = TempsPlus(PER)

	Set getCustomer_cmd = Server.CreateObject("ADODB.Command")
	getCustomer_cmd.ActiveConnection = TempsPlus(PER)
	
	Response.write "Choose Timecard <select name='savedtimecards'><option value=''>Start a new time card...</option>"	
	
	do while not Timecards.eof
		PlacementID = Timecards("placementID")
		TotalPlacements = TotalPlacements + 1
		'Response.write "<option value=" & Chr(34) & applicantID & Chr(34) & " "
		'Response.write "> " & Applicants("LastnameFirst") & " </option>"
		
		'Retrieve placement detail
		With getPlacementDetail_cmd
			.CommandText = "SELECT Customer, WorkCode, RegPayRate FROM Placements WHERE PlacementID=" & PlacementID
			.Prepared = true
		End With
		Set PlacementDetail = getPlacementDetail_cmd.Execute

		'Retrieve workcode description
		With getWorkDetail_cmd
			.CommandText = "SELECT Description FROM WorkCodes WHERE WorkCode='" & PlacementDetail("WorkCode") & "'"
			.Prepared = true
		End With
		Set WorkDetail = getWorkDetail_cmd.Execute

		'Retrieve Customer description
		With getCustomer_cmd
			.CommandText = "SELECT CustomerName FROM Customers WHERE Customer='" & PlacementDetail("Customer") & "'"
			.Prepared = true
		End With
		Set Customer = getCustomer_cmd.Execute
		
		
		Response.write "<option value='" & Timecards("timesheetID") & "'>"
		Response.write Timecards("payperiod") & ", " & Customer("CustomerName") & " - " & WorkDetail("Description") & ",  Total Hours: " & Timecards("TotalHours") & " @ $" & TwoDecimals(PlacementDetail("RegPayRate")) & "</option>"
		Timecards.Movenext
	loop
	Timecards.Close
	PlacementDetail.Close
	WorkDetail.Close
	Customer.Close

	Response.write "</select>"
		
	Set getTimecards_cmd = Nothing
	Set getPlacementDetail_cmd = Nothing
	Set getWorkDetail_cmd = Nothing
	Set getCustomer_cmd = Nothing
	Set Timecards = Nothing
	Set PlacementDetail = Nothing
	Set WorkDetail = Nothing
	Set Customer = Nothing %>

</table>
  
  <div class="weekEndingDate">
    <p><span>For Week Ending&nbsp;</span>
      <select name="weekending" id="weekending" onChange="setweekdays()">
    <%
	For i = -31 To 7
		WeekEndDate = DateAdd("d", i, Date)
		Response.write("<option value='" & WeekEndDate & "'>" & FormatDateTime(WeekEndDate, 1) & "</option>")
	Next
	%>
	</select>
      <select name="placement" id="placement" >
    <%
	'Response.Buffer = true
 	dim objXMLHTTP, placements
	
	Set placements = Server.CreateObject("MSXML2.ServerXMLHTTP")
	placements.Open "GET", "http://www.personnelplus.net/include/system/tools/timecards/getPlacements.asp?empcode=agn700", false
	placements.Send
	Response.write placements.responseText
	Set placements = Nothing
	%>
	</select></p>
	 
	
	
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
  
  <div id="day1.hours" class="dayOfTheWeek">
  	<input type="hidden" id="day1.rows" value="1" />
    <ul id="day1.row1">
      <li id="name.day1.row1" class="title">&nbsp;</li>
      <li>
        <select id="day1.row1.in" name="day1.row1.in" onchange="adjustclocks('day1.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day1.row1.luout" name="day1.row1.luout" onchange="adjustclocks('day1.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day1.row1.luin" name="day1.row1.luin" onchange="adjustclocks('day1.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day1.row1.out" name="day1.row1.out" onchange="adjustclocks('day1.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day1.row1.total"></span></li>
      <li class="tally">
        <input id="day1.row1.regular" name="day1.row1.regular" type="text" value=" " onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day1.row1.other" name="day1.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day1.row1.other.type" name="day1.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
	  <!-- <li class="controls">
	  	<img src="/include/system/tools/images/add.png" onclick="addElement()" />
	  </li> -->
    </ul>
  </div>
  
  
  <div id="day2.hours" class="dayOfTheWeek">
	<input type="hidden" id="day2.rows" value="1" />
    <ul id="day2.row2">
      <li id="name.day2.row1" class="title">&nbsp;</li>
      <li>
        <select id="day2.row1.in" name="day2.row1.in" onchange="adjustclocks('day2.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day2.row1.luout" name="day2.row1.luout" onchange="adjustclocks('day2.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day2.row1.luin" name="day2.row1.luin" onchange="adjustclocks('day2.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day2.row1.out" name="day2.row1.out" onchange="adjustclocks('day2.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day2.row1.total"></span></li>
      <li class="tally">
        <input id="day2.row1.regular" name="day2.row1.regular" type="text" value="" onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day2.row1.other" name="day2.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day2.row1.other.type" name="day2.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
    </ul>
  </div>
  
  <div id="day3.hours" class="dayOfTheWeek">
  	<input type="hidden" id="day3.rows" value="1" />
    <ul id="day3.row1">
      <li id="name.day3.row1" class="title">&nbsp;</li>
      <li>
        <select id="day3.row1.in" name="day3.row1.in" onchange="adjustclocks('day3.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day3.row1.luout" name="day3.row1.luout" onchange="adjustclocks('day3.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day3.row1.luin" name="day3.row1.luin" onchange="adjustclocks('day3.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day3.row1.out" name="day3.row1.out" onchange="adjustclocks('day3.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day3.row1.total"></span></li>
      <li class="tally">
        <input id="day3.row1.regular" name="day3.row1.regular" type="text" value="" onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day3.row1.other" name="day3.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day3.row1.other.type" name="day3.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
    </ul>
  </div>
  
  <div id="day4.hours" class="dayOfTheWeek">
  	<input type="hidden" id="day4.rows" value="1" />
    <ul id="day4.row1">
      <li id="name.day4.row1" class="title">&nbsp;</li>
      <li>
        <select id="day4.row1.in" name="day4.row1.in" onchange="adjustclocks('day4.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day4.row1.luout" name="day4.row1.luout" onchange="adjustclocks('day4.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day4.row1.luin" name="day4.row1.luin" onchange="adjustclocks('day4.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day4.row1.out" name="day4.row1.out" onchange="adjustclocks('day4.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day4.row1.total"></span></li>
      <li class="tally">
        <input id="day4.row1.regular" name="day4.row1.regular" type="text" value="" onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day4.row1.other" name="day4.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day4.row1.other.type" name="day4.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
    </ul>
  </div>
  
  <div id="day5.hours" class="dayOfTheWeek">
  	<input type="hidden" id="day5.rows" value="1" />
    <ul id="day5.row1">
      <li id="name.day5.row1" class="title">&nbsp;</li>
      <li>
        <select id="day5.row1.in" name="day5.row1.in" onchange="adjustclocks('day5.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day5.row1.luout" name="day5.row1.luout" onchange="adjustclocks('day5.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day5.row1.luin" name="Day5.luin" onchange="adjustclocks('day5.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day5.row1.out" name="day5.row1.out" onchange="adjustclocks('day5.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day5.row1.total"></span></li>
      <li class="tally">
        <input id="day5.row1.regular" name="day5.row1.regular" type="text" value="" onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day5.row1.other" name="day5.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day5.row1.other.type" name="day5.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
    </ul>
  </div>
  
  <div id="day6.hours" class="dayOfTheWeek">
  	<input type="hidden" id="day6.rows" value="1" />
    <ul id="day6.row1">
      <li id="name.day6.row1" class="title">&nbsp;</li>
      <li>
        <select id="day6.row1.in" name="day6.row1.in" onchange="adjustclocks('day6.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day6.row1.luout" name="day6.row1.luout" onchange="adjustclocks('day6.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day6.row1.luin" name="day6.row1.luin" onchange="adjustclocks('day6.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day6.row1.out" name="day6.row1.out" onchange="adjustclocks('day6.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day6.row1.total"></span></li>
      <li class="tally">
        <input id="day6.row1.regular" name="day6.row1.regular" type="text" value="" onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day6.row1.other" name="day6.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day6.row1.other.type" name="day6.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
    </ul>
  </div>
  
  <div id="day7.hours" class="dayOfTheWeek">
  	<input type="hidden" id="day7.rows" value="1" />
    <ul id="day7.row1">
      <li id="name.day7.row1" class="title">&nbsp;</li>
      <li>
        <select id="day7.row1.in" name="day7.row1.in" onchange="adjustclocks('day7.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day7.row1.luout" name="day7.row1.luout" onchange="adjustclocks('day7.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day7.row1.luin" name="day7.row1.luin" onchange="adjustclocks('day7.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li>
        <select id="day7.row1.out" name="day7.row1.out" onchange="adjustclocks('day7.row1')">
          <% TimeOptions (null) %>
        </select>
      </li>
      <li class="tally totalhours"><span id="day7.row1.total"></span></li>
      <li class="tally">
        <input id="day7.row1.regular" name="day7.row1.regular" type="text" value="" onblur="computeTime()">
      </li>
      <li class="tally">
        <input id="day7.row1.other" name="day7.row1.other" type="text" value="" onblur="computeTime()">
      </li>
      <li class="othertype">
        <select id="day7.row1.other.type" name="day7.row1.other.type" onblur="computeTime()">
          <option value="">&nbsp;</option>
          <option value="S">Sick</option>
          <option value="H">Holiday</option>
          <option value="V">Vacation</option>
          <option value="O">Other</option>
        </select>
      </li>
    </ul>
  </div>
  
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
      <textarea name="comments"></textarea>
    </p>
  </div>
  <div class="dayOfTheWeek" style="margin:2em; padding:1em; border:1px solid #A8A8A8; background-color:#FFF8D1">
    <p> Timecard's must be completed by 8:00 am Monday. if you submit your timecard late, your check may be delayed at least one week. Personnel Plus may not pay you until proper approval is obtained. Failure to notify your Personnel Plus representative of completion of your job assignment will be considered job abandonment, and employment benefits will be denied.</p>
    <p style="margin-top:0.5em">By clicking "Submit" you certify that you have worked the hours listed, that while on this assign-ment you have not had any work-related injuries or illnesses that you have not reported to Personnel Plus, you agree that you have read, understand and are bound by provisions of the <a href="#">Personnel Plus End User License Agreement</a> and the <a href="#">Personnel Plus Terms of Service</a></p>
  </div>
  <p> <a class="squarebutton" href="<%=FormPostTo & remove%>" onclick="document.taskaction.formAction.value='save';document.taskaction.submit()"><span>Save</span></a> <a class="squarebutton" href="<%=FormPostTo & remove%>" onclick="document.taskaction.formAction.value='submit';document.taskaction.submit()"><span>Submit</span></a> </p>
</form>
<%
Sub TimeOptions (selected)
	Response.write "<option value=''>&nbsp</option>"
	optiontext = "<option value='increment'>display</option>"

		StartClock = 0 : StopClock = 24
		For i = StartClock to StopClock step 0.25
			HourSlice = (i - int(i)) * 60
			if HourSlice = 0 then
				Time12HourDisplay =  "00"
				Time24HourDisplay = "00"
			Else
				Time12HourDisplay = CStr(HourSlice)
				Time24HourDisplay = CStr(HourSlice)
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
			if i < 10 then
				if i < 1 then
					Time24HourDisplay = "00:" & Time24HourDisplay
				Else
					Time24HourDisplay = "0" & Int(i) & ":" & Time24HourDisplay
				end if
			Else
				Time24HourDisplay = int(i) & ":" & Time24HourDisplay
			end if
			timesegment = optiontext
			timesegment = Replace(timesegment, "increment", i)
			timesegment = Replace(timesegment, "display", Time12HourDisplay & " / " &  Time24HourDisplay)
			Response.write timesegment
		Next
End Sub
%>
<%=DecorateBottom()%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
