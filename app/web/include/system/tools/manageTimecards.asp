<%
session("add_css") = "timesheets.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 3.29.2009 -->
<!-- Created: 08.17.2008 -->
<script type="text/javascript" src="/include/js/timesheets.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>

<%
dim WhatToDo
WhatToDo = Request.QueryString("deleteTimesheet") 
if len(WhatToDo & "") > 0 then
	'Put Session verification and delete timesheet code here
end if

' Remarked for developement
' timeSheetMode = user_level
timeSheetMode = userLevelAssigned

employeeTimeSheets
AddTimeSheet
AddTimesheetHours

'Database Connections



Sub employeeTimeSheets 
	if request.form("reviewTimesheetBtn") = "Update" then UpdateTimeSheet

	Database.Open MySql
'	Set dbQuery = Database.Execute("Select * From tbl_timesheets Where companyID=" & companyId)%>

<%=DecorateTop("storedTimesheets", "", "Timesheets")%>

	<table style="margin:2px;border:none" width="605">
		<tr style="background:#97A4B3">
			<td><p>Timesheet Description</p></td>
			<td><p>Data Submitted</p></td>
			<td><p>Total Hours</p></td>
			<td><p>Status</p></td>
		</tr>
		<%
			Set timeSheets = Database.Execute("Select * From tbl_timesheets Where userID=" & user_id)
			
			do while not timeSheets.eof
				TimePeriod = timeSheets("payperiod") & " - " & CDate(timeSheets("payperiod")) + 7
				TotalHours = 0
				For i = 1 to 7
					TotalHours = Totalhours + timeSheets("day" & i)
				Next
				TimeSheetStatus = timeSheets("status")
				Assignment = timeSheets("assignmentID")

				SupervisorName = GetName(GetSupervisorID("tbl_assignments", "assignmentID=" & Assignment))	%>
		<tr>
			<td><%=PostTo & timeSheets("TimesheetID") & imgAccept%></td>
			<td><%=imgDelete & timeSheets("TimesheetID")%></td>
			<td><%=TimePeriod%></td>
			<td><%=TotalHours%></td>
			<td><%=TimeSheetStatus%></td>
			<td><%=SupervisorName%></td>
		</tr>
		<%
				timeSheets.Movenext
			loop %>
	</table>
	<p style="text-align:right;margin-right:20;">
		<input class="normalbtn" type="submit" name="addSheetBtn" id="addSheetBtn" value="Add Timesheet">
	</p>
	<input type='hidden' name='addtimesheet' value='true'>
</div>
<%
	Set timeSheets = Nothing
	Database.Close
	if request.form("addtimesheet") = "true" And request.form("payperiod") <> "Cancel" then	AddTimeSheet 
	if Request.QueryString("editTimesheet") > 0 then
		EditTimeSheet
	end if
End Sub

Sub AddTimeSheet 
		Set Database=Server.CreateObject("ADODB.Connection") : Database.Open MySql
		Set dbQuery=Database.Execute("Select assignmentID, companyID From tbl_assignments Where employeeID=" & user_id)
		Do Until dbQuery.eof
			i = i + 1
			dbQuery.Movenext
		loop
		i = i - 1
		Redim EmployerInformation(2, i) : assignmentID = 0 : companyID = 1 : companyName = 2 : i = 0
		dbQuery.Movefirst
		Do Until dbQuery.eof
			EmployerInformation(assignmentID, i) = dbQuery("assignmentID")
			EmployerInformation(companyID, i) = dbQuery("companyID")
			i = i + 1
			dbQuery.Movenext
		loop
		For x = 0 to i - 1
			Set dbQuery=Database.Execute("Select companyName From tbl_companies Where companyID=" & EmployerInformation(companyID, x))
			EmployerInformation(companyName, x) = dbQuery("companyName")
		Next
		Database.Close	%>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;height:62px;;margin-left:-1px;width:618px;">
	<div class="normalTitle" style="margin-bottom:0;">Timesheet Assignment Information</div>
	<p style="padding-left:10;">
		<label for="assignmentID">Company</label>
		<select name="assignmentID" style="margin-right:5px;"id="assignmentID">
			<%
			For x = 0 To i -1 
				if Trim(request.form("assignmentID")) = Trim(EmployerInformation(assignmentID, x)) then
					response.write("<option value='" & EmployerInformation(assignmentID, x) & "' selected=&quot;selected&quot;>" &  EmployerInformation(companyName, x) & "</option>")
				Else		
					response.write("<option value='" & EmployerInformation(assignmentID, x) & "'>" &  EmployerInformation(companyName, x) & "</option>")
				end if
			Next
			%>
		</select>
		<label for="startdate">Week Of</label>
		<input type="text" id="f_startdate" name="startdate" style="width:60;" value="<%=request.form("startdate")%>">
		<label for="enddate">-&nbsp;</label>
		<input type="text" id="f_enddate" name="enddate" style="width:60;" value="<%=request.form("enddate")%>">
		<input type='hidden' name='addtimesheet' value='true'>
		<input class="normalbtn" style="margin-left:23px" type="submit" name="payperiod" id="assignmentBtn" value="Cancel">
		&nbsp;
		<input class="normalbtn" type="submit" name="payperiod" id="continueBtn" value="Continue">
	</p>
</div>
<%
		if request.form("startdate") <> "" then AddTimesheetHours
End Sub	

Sub AddTimesheetHours
	if request.form("TimesheetHours") = "Submit Timesheet" then
		SubmitTimesheet
	elseif request.form("TimesheetHours") = "Save Timesheet" then
		SaveTimesheet
	elseif request.form("TimesheetHours") <> "Cancel" then

	Database.Open MySql
	Set dbQuery=Database.Execute("Select * From tbl_assignments Where assignmentID=" & request.form("assignmentID")) %>
<input type='hidden' name='assignmentID' value='<%=dbQuery("assignmentID")%>'>
<input type='hidden' name='companyID' value='<%=dbQuery("companyID")%>'>
<%
	
	Set RelationQuery = Database.Execute("Select companyName, addressID From tbl_companies Where companyID=" & dbQuery("companyID"))
	CompanyName = RelationQuery("companyName")

	
	JobLocation = GetAddress("addressID=" & dbQuery("addressID"), True)
	CompanyPrimaryAddress = GetAddress("addressID=" &  RelationQuery("addressID"), True)
	PersonalAddress = user_firstname & " " & user_lastname & "<br>" & GetAddress("userID=" & dbQuery("employeeID"), false) & "<br><br>" & user_email
	
	Set RelationQuery = Database.Execute("Select firstName, lastName From tbl_users Where userID=" & dbQuery("supervisorID"))
	Supervisor = relationQuery("lastName") & ", " & relationQuery("firstName")
	
	Set RelationQuery = Nothing
	Set dbQuery = Nothing
	Database.Close %>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;;margin-left:-1px;margin-left:-1px;width:618px;">
	<div class="normalTitle" style="margin-bottom:5px;">Timesheet Information</div>
	<table style="margin-left:10;" cellpadding="0" cellspacing="0" width="615">
		<tr>
			<td style="vertical-align:text-top" width="40%"><strong><%=CompanyName%></strong><br>
				<%=CompanyPrimaryAddress%> <br>
				<br>
				<strong>Supervisor</strong><br>
				<%=Supervisor%></td>
			<td style="vertical-align:text-top" width="30%"><strong>Job Location</strong><br>
				<%=JobLocation%></td>
			<td style="vertical-align:text-top" width="30%"><strong> Personal Information</strong><br>
				<%=PersonalAddress%> </td>
		</tr>
	</table>
</div>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;margin-left:-1px;width:618px;">
	<div class="normalTitle" style="margin-bottom:10;">Timesheet For Period: <%=request.form("startDate")%>&nbsp;-&nbsp;<%=request.form("enddate")%></div>
	<p style="text-align:center">
	<table style="margin-bottom:5px;" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top"><br>
				<table cellpadding="0" cellspacing="1">
					<tr>
						<td></td>
						<%
							For i = 0 to 6 %>
						<td style='text-align:center;background:#97A4B3'><%=DayOfTheWeek(CDate(request.form("startDate")) + i)%></td>
						<%
							Next	%>
					</tr>
					<tr>
						<td><p style="text-align:center; padding-right:5px;">Enter Daily Hours</td>
						<td><input name="day1" type="text" size="5"></td>
						<td><input name="day2" type="text" size="5"></td>
						<td><input name="day3" type="text" size="5"></td>
						<td><input name="day4" type="text" size="5"></td>
						<td><input name="day5" type="text" size="5"></td>
						<td><input name="day6" type="text" size="5"></td>
						<td><input name="day7" type="text" size="5"></td>
					</tr>
				</table>
				</p>
			</td>
			<td>&nbsp;</td>
			<td><p style="text-align:center"><strong>Comments:</strong><br>
					<textarea class="normalbtn" name="comments" cols="20" rows="5"></textarea>
				</p></td>
		</tr>
	</table>
	<input type='hidden' name='startdate' value="<%=request.form("startdate")%>">
	<input type='hidden' name='enddate' value="<%=request.form("enddate")%>">
	<input type='hidden' name='addtimesheet' value='true'>
	<input type='hidden' name='addhours' value='true'>
	<input type='hidden' name='submittimesheet' value='true'>
	<input type='hidden' name='submit' value='<%=request.form("assignmentID")%>'>
	<p style="text-align:center">
		<input class="normalbtn" name="TimesheetHours" type="submit" value="Cancel">
		<input class="normalbtn" name="TimesheetHours" type="submit" value="Save Timesheet">
		<input class="normalbtn" name="TimesheetHours" type="submit" value="Submit Timesheet">
	</p>
</div>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;margin-left:-1px;width:618px;">
	<div class="normalTitle" style="margin-bottom:10;">Term of Use</div>
	<p style="text-align:center">
	<table style="margin-bottom:5px;margin-left:15px;" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top"><br>
				I agree that by submitting this timesheet, I attest that the hours presented on this document are true and accurate. I also attest that I have not been physically impaired or injured as a result of, or during the performance of, my work-related functions for the period of time covered by this timesheet. </td>
		</tr>
	</table>
	</p>
</div>
<%
	end if
End Sub	

Sub SubmitTimesheet
	CreationDate=Now()
	Database.Open MySql
	dbQueryString = "INSERT INTO tbl_timesheets (assignmentID, companyID, userID, payperiod, paycode, day1, day2, day3, day4, day5, day6, day7, status, comments, modifiedDate, CreationDate) VALUES ('" & request.form("assignmentID") & "','" & request.form("companyID") & "','" & user_id & "','" & request.form("startdate") & "','" & request.form("paycode") & "',"
	For i = 1 to 7
		dbQueryString = dbQueryString & "'" & TwoDecimals(request.form("day" & i)) & "',"
	Next
	dbQueryString = dbQueryString &  "'Submitted " & CreationDate & "','" & request.form("comments") & "','" & CreationDate & "','" & CreationDate & "')"
	'response.write(dbQueryString)
	Set dbQuery=Database.Execute(dbQueryString)
	
	Set dbQuery = Nothing
	Database.Close
	Response.Redirect("/tools/timemanagement/manageTimesheets.asp?Submitted=True")
End Sub

Sub DeleteTimesheet (TimeID)
	Database.Open MySql
	set dbQuery=Database.Execute("Delete From tbl_timesheets Where TimesheetID=" & TimeID)
	Database.Close
	%>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;margin-left:-1px;width:618px;">
	<div class="normalTitle" style="margin-bottom:0;">Timesheet Deleted</div>
	<P style="text-align:center">Timesheet was successfully deleted from system.</P>
</div>
<%
End Sub

Sub SaveTimesheet
	CreationDate=Now()
	Database.Open MySql
	dbQueryString = "INSERT INTO tbl_timesheets (assignmentID, companyID, userID, payperiod, paycode, day1, day2, day3," & _
									" day4, day5, day6, day7, status, comments, modifiedDate, CreationDate) VALUES ('" & _
									request.form("assignmentID") & "','" & request.form("companyID") & "','" & user_id & "','" & _
									request.form("startdate") & "','" & request.form("paycode") & "',"
	For i = 1 to 7
		dbQueryString = dbQueryString & "'" & TwoDecimals(request.form("day" & i)) & "',"
	Next
	dbQueryString = dbQueryString &  "'Saved " & CreationDate & "','" & request.form("comments") & "','" & _
																		CreationDate & "','" & CreationDate & "')"
	Set dbQuery=Database.Execute(dbQueryString)
	
	Set dbQuery = Nothing
	Database.Close
	Response.Redirect("/tools/timemanagement/manageTimesheets.asp?Submitted=True")
End Sub

Sub UpdateTimesheet
	ModifiedDate=Now()
	Database.Open MySql
	dbQueryString = "UPDATE tbl_timesheets SET day1=" & TwoDecimals(request.form("day1")) & ", day2=" & TwoDecimals(request.form("day2")) & ", day3=" & TwoDecimals(request.form("day3")) & ", day4=" & TwoDecimals(request.form("day4")) & ", day5=" & TwoDecimals(request.form("day5")) & ", day6=" & TwoDecimals(request.form("day6")) & ", day7=" & TwoDecimals(request.form("day7")) & ", status='Submitted " & ModifiedDate & "', comments='" & request.form("comments") & "', modifiedDate='" & ModifiedDate & "' WHERE timesheetID=" & request.form("timeSheetID")
	Set dbQuery=Database.Execute(dbQueryString)
	
	Set dbQuery = Nothing
	Database.Close
	Response.Redirect("/tools/timemanagement/manageTimesheets.asp?Submitted=True")
End Sub

Sub EditTimeSheet
	TimesheetID = Request.QueryString("editTimesheet")
	
	dim HourDetail(1, 7)
	Database.Open MySql
	dbQuery = Database.Execute("Select * From tbl_timesheets Where timesheetID=" & TimesheetID & " AND userID=" & user_id)
	EmployeeName = GetName(GetEmployeeID("tbl_assignments", "assignmentID=" & dbQuery("assignmentID")))
	Title = "Timesheet for " &  "Pay Period (" & dbQuery("payperiod") & " - " & (CDate(dbQuery("payperiod")) + 7) & ")"
	TimeSheetStatus = dbQuery("status")
	For i = 1 to 7
		HourDetail(1,i) = dbQuery("day" & i)
		HourDetail(1,0) = HourDetail(1,0) + HourDetail(1,i)
		HourDetail(0,i) = DayOfTheWeek(CDate(dbQuery("payperiod")) + (i-1))
	Next	
	HourDetail(0,0) = "&nbsp;Total&nbsp;"
%>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;margin-left:-1px;width:618px;">
<div class="normalTitle" style="margin-bottom:0;"><%=Title%></div>
<p style="text-align:center">
<form name="editTimeSheet" method="post" action="/tools/timemanagement/manageTimesheets.asp">
<input type='hidden' name='timeSheetID' value="<%=TimesheetID%>">
<table style="margin-bottom:10;" width="625">
	<tr>
		<td width="70%"><table width="97%" cellpadding="0" cellspacing="1" style="margin-bottom:0;">
				<tr>
					<td width="33%"></td>
					<td width="11%"></td>
					<td width="11%"></td>
					<td width="11%"></td>
					<td width="11%"></td>
					<td width="11%"></td>
					<td width="11%"></td>
					<td width="11%">&nbsp;</td>
				</tr>
				<tr>
					<td></td>
					<%
						For i = 1 to 7
							response.write("<td style='text-align:center;background:#97A4B3'>" & HourDetail(0,i) & "</td>")
						Next	%>
				</tr>
				<tr>
					<td style="text-align:right;background-color:#282F7F;color:#FFFFFF">Daily Hours&nbsp;</td>
					<%
						For i = 1 to 7
							response.write("<td style='text-align:center;'>&nbsp;<input class='createUser' name='day" & i & "' type='text' size='5' value='" & TwoDecimals(HourDetail(1,i)) & "'>&nbsp;</td>")
						Next	%>
				</tr>
			</table></td>
		<td style="padding-left:10" width="30%"><strong>Comments</strong><br>
			<textarea name="comments" cols="21" rows="4"><%=dbQuery("comments")%></textarea>
		</td>
	</tr>
</table>
<p style="text-align:center">
	<input class="normalbtn" name="reviewTimesheetBtn" type="submit" value="Cancel">
	<input class="normalbtn" name="reviewTimesheetBtn" type="submit" value="Update">
</p>
</p>
<%
End Sub

%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
