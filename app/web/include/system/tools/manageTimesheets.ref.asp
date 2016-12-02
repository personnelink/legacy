<!-- #INCLUDE VIRTUAL='/include/core/html_header.asp' -->
<!-- #INCLUDE VIRTUAL='/include/core/html_styles.asp' -->
<!-- Revised: 08.17.2008 -->
<script type="text/javascript">
//here you place the ids of every element you want.
var ids=new Array('employeePane','employerPane','orientationPane');

function switchid(id){	
	hideallids();
	showdiv(id);
}

function hideallids(){
	//loop through the array and hide each element by id
	for (var i=0;i<ids.length;i++){
		hidediv(ids[i]);
	}		  
}

function hidediv(id) {
	//safe function to hide an element with a specified id
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'none';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'none';
		}
		else { // IE 4
			document.all.id.style.display = 'none';
		}
	}
}

function showdiv(id) {
	//safe function to show an element with a specified id
		  
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'inline';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'inline';
		}
		else { // IE 4
			document.all.id.style.display = 'inline';
		}
	}
}

function confirmDelete(sheetID)
{
 var where_to= confirm("Do you really want to delete this Timesheet?");
 if (where_to== true)
 {
   window.location="/tools/timemanagement/manageTimesheets.asp?DeleteTimesheet="+sheetID;
 }
}

function checkit(action, formname) {
		document.getElementById('updateStatus').style.display = 'block'
		var act = (action.options[action.selectedIndex].value);

		hidediv(formname);
		if (act == 'change') {
					showdiv(formname);
		}
} 

</script>
<style type="text/css">
#updateStatus {display:none;}
.hide {display: none;}
.show {display: block;}
select {width:100px;height:19px;}
input {width:20px;margin:0 4px;}
.timeTable {margin:0;margin-left:-9px;border:none;width:606px;}
.timeTable table tr th {background-color:#99CCFF;text-decoration:underline;font-weight:normaltext-align:center;;}
.period {text-align:left; color:#000000;}
@import url(/include/functions/calendar/calendar-blue2.css);

</style>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<!-- #INCLUDE VIRTUAL='/Connections/VMS.asp' -->
<!-- #INCLUDE VIRTUAL='/include/core/navi_top_menu.asp' -->
<!-- #INCLUDE VIRTUAL='/user/checkSignIn.asp' -->
<!-- #INCLUDE VIRTUAL='/include/core/navi_side_menu.asp' -->
<% 
timeSheetMode = user_level

if timeSheetMode => userLevelAssigned and timeSheetMode <= userLevelEngaged then
	if Request.QueryString("DeleteTimesheet") > 0 then
		DeleteTimesheet Request.QueryString("DeleteTimesheet")
	end if
	employeeTimeSheets
elseif timeSheetMode => userLevelSupervisor then 
	employerShowSubmitted
End if 

Sub employerShowSubmitted
	Database.Open MySql

	if request.form("formAction") = "UpdateStatus" then
		ModifiedDate=Now()
		Set updateStatus = Server.CreateObject("ADODB.Recordset")

		With updateStatus
		.ActiveConnection = MySql
		.Source = "Select * From tbl_timesheets Where companyID=" & companyId & " ORDER BY payperiod ASC"
		.CursorType = 0
		.CursorLocation = 2
		.LockType = 1
		.Open()
	End With
while (Not updateStatus.eof)
			Database.Execute("UPDATE tbl_timesheets SET status='" & request.form("action" & updateStatus.Fields.Item("timesheetID").Value) & "', modifiedDate='" & ModifiedDate & "' WHERE timesheetID=" & updateStatus.Fields.Item("timesheetID").Value)
			updateStatus.Movenext
		Wend
		updateStatus.Close
		Set updateStatus = Nothing

	end if

	Set Timesheets = Server.CreateObject("ADODB.Recordset")
	With Timesheets
		.ActiveConnection = MySql
		.Source = "Select * From tbl_timesheets Where companyID=" & companyId & " ORDER BY payperiod ASC"
		.CursorType = 0
		.CursorLocation = 2
		.LockType = 1
		.Open()
	End With

%>
<div class="pageContent">
	<form name="timecardForm" id="timecardForm" method="post" action="/include/system/tools/manageTimesheets.ref.asp">
		<div id="employerTimeSummary" class="bordered">
			<div class="normalTitle">Employee Time Sheets </div>
			<div class="pageSubContent">
				<table class="timeTable">
					<tr style="background:#97A4B3">
						<th style="width:33%;">Period/Employee</th>
						<th style="width:45%;">Timecard Hours Details</th>
						<th style="width:20%;">Action</th>
					</tr>
				</table>
				<%
 			
			while (Not Timesheets.eof)
				Set TotalHours = Server.CreateObject("ADODB.Recordset")
				With TotalHours
					.ActiveConnection = MySql
					.Source = "Select SUM(day1 + day2 + day3 + day4 + day5 + day6 + day7) AS hoursTotal FROM tbl_timesheets Where timesheetID=" & Timesheets.Fields.Item("timesheetID")
					.Open()
				End With
				PayPeriod = Timesheets.Fields.Item("payperiod").Value %>
				<table class="timeTable" style="background-color:#<%=rowShading%>;">
					<tr>
						<td>
							<table>
								<tr>
									<td style="width:33%;">
										<table>
											<tr>
												<td style="vertical-align:top;"><h4 style="width:190px;"><%=CDate(PayPeriod) + 7%>-<%=GetName(Timesheets.Fields.Item("userID").Value)%></h4></td>
											</tr>
											<tr>
												<td><p>Fairbanks Fire</p></td>
											</tr>
										</table></td>
									<td style="width:45%;">
									<table>
											<tr>
												<%
							For i = 1 to 7 %>
												<td><h4><%=DayOfTheWeek(CDate(PayPeriod) + (i-1))%></h4></td>
												<%
							Next	%>
												<td><h4>Total</h4></td>
											</tr>
											<tr>
												<%
							For i = 1 to 7 %>
												<td><%=Timesheets.Fields.Item("day" & i)%></td>
												<%
							Next	%>
												<td><strong><%=TotalHours.Fields.Item("hoursTotal")%></strong></td>
											</tr>
										</table>
										<table id="correction<%=Timesheets.Fields.Item("timesheetID").Value%>" class="hide">
											<tr >
												<%
							For i = 1 to 7 %>
												<td><input name="Correction<%=Timesheets.Fields.Item("timesheetID").Value & "Day" & i%>" value="" ></td>
												<%
							Next	%>
												<td><strong>0</strong></td>
											</tr>
										</table></td>
									<td style="width:20%; vertical-align:top;"><h4><select name="action<%=Timesheets.Fields.Item("timesheetID").Value%>" onChange="checkit(this, 'correction<%=Timesheets.Fields.Item("timesheetID").Value%>');">
											<option value="" <% 
						timesheetStatus = Timesheets.Fields.Item("status").Value
						if timesheetStatus = "" then response.write("selected=" & chr(34) & "selected" & chr(34)) %> > Do Nothing </option>
											<option value="approve" <% if timesheetStatus = "approve" then response.write("selected=" & chr(34) & "selected" & chr(34)) %> > Approve </option>
											<option value="reject" <% if timesheetStatus = "reject" then response.write("selected=" & chr(34) & "selected" & chr(34)) %> > Reject </option>
											<option value="change" <% if timesheetStatus = "change" then response.write("selected=" & chr(34) & "selected" & chr(34)) %> > Change </option>
										</select></h4>
									</td>
								</tr>
							</table>
							<table style="width:100%">
								<tr>
									<td class="bordered w35"><strong>
										<%
						timesheetComment = Timesheets.Fields.Item("comments").Value
						if len(timesheetComment) <> 0 then %>
										<p>Comments:</p>
										<% End if %>
										</strong>
										<p><%=timesheetComment%></p></td>										

									<td style="width:10%"></td>
								<td style="width:55%"><textarea name="employerComment" style="width:200px;height:35px;margin:10px 0;">Employer Comments Go Here.</textarea></td>
								</tr>
							</table></td>
					</tr>
				</table>
				<%
				TotalHours.Close
				Timesheets.Movenext
				if rowShading = "CCFF99" then	rowShading = "FFFFFF"	Else rowShading = "CCFF99"
				
			Wend 
			Timesheets.Close %>
			</div>
		</div>
		<input type="hidden" name="formAction" value="">
		<div id="submitEmployeeTimecardBtn" class="buttonwrapper" style="padding:10px 0 10px 0;"> <a id="updateStatus" class="squarebutton" href="javascript:;" style="margin-left: 6px" onClick="document.timecard.formAction.value='UpdateStatus';document.forms['timecard'].submit();"><span> Update </span></a> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onClick="document.timecard.formAction.value='submitTimecard';document.forms['timecard'].submit();"><span> Submit An Employee Timecard </span></a> </div>
	</form>
</div>
<%
	formAction = request.form("formAction")
		
	Set dbQuery = Nothing
	Set Assignment = Nothing
	Set AssignmentSupervisor = Nothing
	Database.Close

End Sub

Sub TimesheetApproval
	TimeOfUpdate = Now()
	if request.form("timesheetBtn") = "Approve" then
		TimesheetStatus = "'Approved by " & GetName(user_id) & " on " & TimeOfUpdate & "'"
	elseif request.form("timesheetBtn") = "Reject" then
		TimesheetStatus = "'Rejected by " & GetName(user_id) & " on " & TimeOfUpdate & "'"
	end if
	
	Set dbQuery = Database.Execute("UPDATE tbl_timesheets SET status=" & TimesheetStatus & ", comments='" & _
																	request.form("comments") & "', modifiedDate='" & TimeOfUpdate & "' WHERE timesheetID=" & _
																	request.form("timesheetID"))

End Sub

Sub EnterEmployeeTime
	if user_level => userLevelPPlusStaff then
		Set assignedEmployees = Database.Execute("Select employeeID, assignmentID From tbl_assignments")
	Else
		Set assignedEmployees = Database.Execute("Select employeeID, assignmentID From tbl_assignments Where companyID=" & companyId)
	end if
	if Not assignedEmployees.eof then
		Do Until assignedEmployees.eof
			i = i + 1
			assignedEmployees.Movenext
		loop
		i = i - 1
		Redim EmployeeInformation(2, i)
		assignmentID = 0
		employeeName = 1
		employeeID = 2
		i = 0
		assignedEmployees.Movefirst
		Do Until assignedEmployees.eof
			EmployeeInformation(assignmentID, i) = assignedEmployees("assignmentID")
			EmployeeInformation(employeeName, i) = GetName(assignedEmployees("employeeID"))
			EmployeeInformation(employeeID, i) = assignedEmployees("employeeID")
			i = i + 1
			assignedEmployees.Movenext
		loop
	End if  %>
<div class="sideMargin border" style="width:615px;margin-left:0;margin-bottom:15px;">
	<div class="center" style="padding-bottom:15px">
		<div class="normalTitle" style="margin-bottom:0;">Employee Daily Hours</div>
		<div class="sideMargin" style="padding:0">
			<div class="" style="margin-bottom:10;margin-left:0">
				<div class="divided">
					<div class="" style="margin-left:0;padding-top:10;">
						<p>
							<label for="employeeID" class="Requisition">Select Employee</label>
							<select style="width:200;margin-left:10;margin-right:10;float:left" name="employeeID" >
								<%
							For x = 0 To i -1 
								if Trim(request.form("employeeID")) = Trim(EmployeeInformation(employeeID, x)) then
									response.write("<option value='" & EmployeeInformation(employeeID, x) & "' selected=&quot;selected&quot;>" &  EmployeeInformation(employeeName, x) & "</option>")
								Else		
									response.write("<option value='" & EmployeeInformation(employeeID, x) & "'>" &  EmployeeInformation(employeeName, x) & "</option>")
								end if
							Next	%>
							</select>
							<label for="startdate">Week Of&nbsp;</label>
							<input type="text" id="f_startdate" name="startdate" style="float:left;width:60;" value="<%=request.form("startdate")%>" Readonly>
							<label for="enddate">&nbsp;-&nbsp;</label>
							<input type="text" id="f_enddate" name="enddate"  style="width:60;float:left" value="<%=request.form("enddate")%>" Readonly>
							<script type="text/javascript">
								function catcalc(cal) {
									var date = cal.date;
									var time = date.getTime()
									// use the _other_ field
									var field = document.getElementById("f_enddate");
									if (field == cal.params.inputField) {
										field = document.getElementById("f_startdate");
										time -= Date.WEEK; // substract one week
									} else {
										time += Date.WEEK; // add one week
									}
									var date2 = new Date(time);
									field.value = date2.print("%m-%d-%Y");
								}
								Calendar.setup({
									inputField : "f_startdate",
									ifFormat : "%m-%d-%Y",
									showsTime : false,
									timeFormat : "24",
									onUpdate : catcalc
								});
								Calendar.setup({
									inputField : "f_enddate",
									ifFormat : "%m-%d-%Y",
									showsTime : false,
									timeFormat : "24",
									onUpdate : catcalc
								});
							</script>
						</p>
						<input type='hidden' name='addtimesheet' value='true'>
					</div>
					<%
						if request.form("addtimesheet") = "true" And request.form("endDate") <> "" then %>
					<div clas="">
						<table style="margin-bottom:0;width:550" cellpadding="0" cellspacing="1">
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
											response.write("<td style='text-align:center;background:#97A4B3'>" & DayOfTheWeek(CDate(request.form("startDate")) + i) & "</td>")
										Next	%>
							</tr>
							<tr>
								<td style="text-align:right;background-color:#282F7F;color:#FFFFFF">Daily Hours&nbsp;</td>
								<%
										For i = 1 to 7
											response.write("<td style='text-align:center;'>&nbsp;<input class='createUser' name='day" & i & "' type='text' size='5' value=''>&nbsp;</td>")
										Next	%>
							</tr>
						</table>
					</div>
					<div class="divided" style="width:575px">
						<label for="coments" class="createUser">Comments</label>
						<textarea name="comments" cols="71" rows="4"><%=request.form("comments")%></textarea>
					</div>
					<%
						End if %>
				</div>
			</div>
			<input class="normalbtn" style="margin-left:23px" type="submit" name="timesheetBtn" id="assignmentBtn" value="Cancel">
			&nbsp;
			<input class="normalbtn" type="submit" name="timesheetBtn" id="continueBtn" value="Continue">
			</p>
		</div>
	</div>
</div>
<div class="sideMargin border" style="padding-bottom:10;margin-left:0">
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
End Sub

%>
<%
Sub employeeTimeSheets 
	if request.form("reviewTimesheetBtn") = "Update" then UpdateTimeSheet
	dim imgAccept, imgDelete, PostTo
	dim TimesheetID, TimePeriod
	PostTo = "<a href='/tools/timemanagement/manageTimesheets.asp?editTimesheet="
	imgAccept = "'><img  style='border:none; cursor:pointer' src='/include/style/images/ico_msgAccept.gif'></a>"
	imgDelete = "<img style='border:none; cursor:pointer' src='/include/style/images/ico_msgDelete.gif' onclick='confirmDelete("
	
	Database.Open MySql
	Set dbQuery = Database.Execute("Select * From tbl_timesheets Where companyID=" & companyId)%>
<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;margin-left:-1px;width:618px;">
	<div class="normalTitle" style="margin-bottom:0;">Active Time Sheets</div>
	<table style="margin:2px;border:none" width="605">
		<tr style="background:#97A4B3">
			<td></td>
			<td></td>
			<td><p>Time Period</p></td>
			<td><p>Hours</p></td>
			<td><p>Status</p></td>
			<td><p>Controller</p></td>
		</tr>
		<%
			Set dbQuery = Database.Execute("Select * From tbl_timesheets Where userID=" & user_id)
			
			do while not dbQuery.eof
				TimePeriod = dbQuery("payperiod") & " - " & CDate(dbQuery("payperiod")) + 7
				TotalHours = 0
				For i = 1 to 7
					TotalHours = Totalhours + dbQuery("day" & i)
				Next
				TimeSheetStatus = dbQuery("status")
				Assignment = dbQuery("assignmentID")

				SupervisorName = GetName(GetSupervisorID("tbl_assignments", "assignmentID=" & Assignment))	%>
		<tr>
			<td><%=PostTo & dbQuery("TimesheetID") & imgAccept%></td>
			<td><%=imgDelete & dbQuery("TimesheetID")%>);'"></td>
			<td><%=TimePeriod%></td>
			<td><%=TotalHours%></td>
			<td><%=TimeSheetStatus%></td>
			<td><%=SupervisorName%></td>
		</tr>
		<%
				dbQuery.Movenext
			loop %>
	</table>
	<p style="text-align:right;margin-right:20;">
		<input class="normalbtn" type="submit" name="addSheetBtn" id="addSheetBtn" value="Add Timesheet">
	</p>
	<input type='hidden' name='addtimesheet' value='true'>
</div>
<%
	Set dbQuery = Nothing
	Set Assignment = Nothing
	Set AssignmentSupervisor = Nothing
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
		<script type="text/javascript">
				function catcalc(cal) {
					var date = cal.date;
					var time = date.getTime()
					// use the _other_ field
					var field = document.getElementById("f_enddate");
					if (field == cal.params.inputField) {
						field = document.getElementById("f_startdate");
						time -= Date.WEEK; // substract one week
					} else {
						time += Date.WEEK; // add one week
					}
					var date2 = new Date(time);
					field.value = date2.print("%m-%d-%Y");
				}
				Calendar.setup({
					inputField : "f_startdate",
					ifFormat : "%m-%d-%Y",
					showsTime : false,
					timeFormat : "24",
					onUpdate : catcalc
				});
				Calendar.setup({
					inputField : "f_enddate",
					ifFormat : "%m-%d-%Y",
					showsTime : false,
					timeFormat : "24",
					onUpdate : catcalc
				});
			</script>
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
		<td width="70%"><table style="margin-bottom:0;" cellpadding="0" cellspacing="1">
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
</div>
<%
End Sub

%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
