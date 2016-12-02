<%

dim calendarIds

public function doTimeSummary()	

	dim placementid
	placementid = getParameter("id")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		REM "SELECT time_summary.id, weekending, workday, SUM(TIME_TO_SEC(TIMEDIFF(timeout, timein))) AS totalhours " &_
		REM "FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
		REM "WHERE placementid=" & placementid & " " &_
		REM "GROUP By time_summary.id, workday ORDER By weekending asc, id asc, workday asc;"

		.CommandText = "" &_
			"SELECT t.id, t.weekending, t.workday, SUM(t.halftotal) as totalhours, t.creatorid " &_ 
			"FROM (SELECT time_summary.id, weekending, workday, timetotal AS halftotal, time_summary.creatorid " &_
					 "FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					  "WHERE placementid=" & placementid & " " &_
				 "UNION ALL " &_
					"SELECT time_summary.id, weekending, workday, (ABS(TIME_TO_SEC(TIMEDIFF(timeout, timein))))/60/60 AS halftotal, time_summary.creatorid " &_
					 "FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					  "WHERE placementid=" & placementid & " AND (timeout > timein) " &_
				 "UNION ALL " &_
					"SELECT time_summary.id, weekending, workday, (ABS(TIME_TO_SEC(TIMEDIFF(ADDTIME(timeout, '24:00:00'), timein))))/60/60 AS halftotal, time_summary.creatorid " &_
					 "FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					  "WHERE placementid=" & placementid & " AND (timeout < timein) " &_
					 ") t " &_
			"GROUP By t.id, t.workday ORDER By t.weekending asc, t.id asc, t.workday asc, t.creatorid;"
			
	end with
	
	'print cmd.CommandText
	
	
	dim rs
	set rs = cmd.execute()

	dim SumOfHours, this_summary, current_id, last_id, last_week, total_buffer, weekEndingOffset
	set SumOfHours = Server.CreateObject("Scripting.Dictionary")
	set this_summary = New cTimeSummary
	do while not rs.eof
		current_id = rs("id")
		
		'print "rs:" & rs("weekending")
		
		if len(last_id) = 0 then
			last_id = current_id
			last_week = rs("weekending")		
		elseif (last_id <> current_id) or rs.eof then
			last_id = current_id			
			if not rs.eof then
				last_week = rs("weekending")
			end if
						
			SumOfHours.Add this_summary.WeekEnding & ":" & this_summary.id, this_summary
			set this_summary = New cTimeSummary
		end if

		with this_summary
			.id         = current_id
			.creatorid  = rs("creatorid")
			.WeekEnding = last_week
		
		'print "rs:" & rs("creatorid") & ", filtered: " & this_summary.creatorId
		
			weekEndingOffset = Weekday(last_week)
			if weekEndingOffset > 1 then
				weekEndingOffset = 1
			else
				weekEndingOffset = 0
			end if
			
			'print "Hello world" & last_week
			if vartype(rs("totalhours")) = 14 then 
				
				total_buffer = cdbl(rs("totalhours"))
				if total_buffer < 0 then total_buffer = total_buffer*-1
				
			
				select case rs("workday")   'Changed starting day to 0 instead of 1 Richard 2013.09.27
				case "1"
					.Day(0 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 1
				case "2"
					.Day(1 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 2
				case "3"
					.Day(2 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 3
				case "4"
					.Day(3 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 4
				case "5"
					.Day(4 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 5
				case "6"
					.Day(5 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 6
				case "7"
					.Day(6 + weekEndingOffset) = TwoDecimals(total_buffer)
					.WorkDay = 7
				end select
			end if
		end with
		rs.movenext
	loop
	if not isnull(this_summary.id) then SumOfHours.Add this_summary.WeekEnding & ":" & this_summary.id, this_summary
	set this_summary = nothing

	dim Summary, i
	for each Summary in SumOfHours.Items
		if Summary.id > 0 then
			%>
			<table class="time_summary cid<%=Summary.creatorid%>">
				<tr>
					<th class="col_we weekending"><span id="TimeDetail<%=placementid & "_" & Summary.id%>" class="ShowMore" onclick="timedetail.open('<%=placementid & "_" & Summary.id%>', '<%=g_strSite%>');">&nbsp;</span>&nbsp;Week Ending:</th>
					<th class="col_time">&nbsp;</th>
					<th class="col_day"><%=Summary.DayName(0)%></th>
					<th class="col_day"><%=Summary.DayName(1)%></th>
					<th class="col_day"><%=Summary.DayName(2)%></th>
					<th class="col_day"><%=Summary.DayName(3)%></th>
					<th class="col_day"><%=Summary.DayName(4)%></th>
					<th class="col_day"><%=Summary.DayName(5)%></th>
					<th class="col_day"><%=Summary.DayName(6)%></th>
					<th class="col_spc"></th>
					<th class="col_day">Time</th>
					<th class="col_spc">&nbsp;</th>
					<th class="col_day">Expense</th>
					<th class="col_cntrls">&nbsp;</th>
				</tr></table>
				
				<div id="we_connector_<%=placementid & "_" & Summary.id%>" class="no_connector">
				<table class="time_summary">
				<tr>
					<td class="col_we_b weekending"><%=inpWeekEndsOn(company_weekends, placementid, Summary.id, Summary.WeekEnding, "cid" & Summary.creatorid & " sid" & user_id)%></td>
					<th class="col_time lbl_time">Time:</th>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>" id="sum_d<%=lcase(Summary.DayName(0))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(0))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(1)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>"  id="sum_d<%=lcase(Summary.DayName(1))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(1))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(2)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>"  id="sum_d<%=lcase(Summary.DayName(2))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(2))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(3)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>"  id="sum_d<%=lcase(Summary.DayName(3))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(3))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(4)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>"  id="sum_d<%=lcase(Summary.DayName(4))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(4))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(5)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>"  id="sum_d<%=lcase(Summary.DayName(5))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(5))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(6)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_day"><input class="daysum cid<%=Summary.creatorid%> sid<%=user_id%>"  id="sum_d<%=lcase(Summary.DayName(6))%>_<%=placementid%>_<%=Summary.id%>" name="sum_d<%=lcase(Summary.DayName(6))%>_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(7)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
					<td class="col_spc">&nbsp;=&nbsp;</td>		
					<td class="col_day"><input class="cid<%=Summary.creatorid%> sid<%=user_id%>" id="sum_rt_<%=placementid%>_<%=Summary.id%>" name="sum_rt_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.TotalHours%>" onChange="timedetail.changel(this.name, '<%=g_strSite%>')"></td>
					<td class="col_spc">+</td>		
					<td class="col_day"><input id="sum_et_<%=placementid%>_<%=Summary.id%>" name="sum_et_<%=placementid%>_<%=Summary.id%>" size="2" disabled="disabled" value="<%=Summary.TotalExpense%>" onChange="timedetail.changel(this.name, '<%=g_strSite%>')"></td>
					<td class="col_cntrls cntrlTimeDetail">
						<span class="button" onclick="timesummary.remove('<%=placementid%>', '<%=g_strSite%>', '<%=Summary.id%>');"><span class="remove">Remove</span></span>
						<span class="button" onclick="timesummary.approve('<%=placementid%>', '<%=g_strSite%>', '<%=Summary.id%>');"><span class="approve">Approve</span></span>
					</td>
				</tr>
			</table>
		<%
		end if
		%>
		
		<div id="timedetaildiv<%=placementid & "_" & Summary.id%>" class=""></div>
		</div>
		<span class="table_seperator"></span>
<%
	next
%>	

	<table class="time_summary">
		<tr>
			<td class="cntrlAddServices">
				<span class="button addtime" onclick="timesummary.add('<%=placementid%>', '<%=g_strSite%>');"><span>Add Time</span></span>&nbsp;&nbsp;
				<span class="greybutton addexpense" future_onclick="expense.add('<%=placementid%>', '<%=g_strSite%>');"><span>Add Expense</span></span>&nbsp;&nbsp;
				<span class="greybutton viewother" future_onclick="placements.view('<%=placementid%>', '<%=g_strSite%>');"><span>View Other Placements</span></span></td>&nbsp;
			<td colspan="10"></td>
		</tr>
	</table>

	<!-- [split] --><%=placementid%>

<%
end function

function inpWeekEndsOn(p_WeekEndsOn, placementid, summaryid, forWeekEnding, sids)
	dim Today, AdjustedDate, i, WeekEndDate, strBuffer, thisOneSelected, formattedWeekEnding
	dim noneSelected : noneSelected = true

	if not isnull(forWeekEnding) then
		formattedWeekEnding = FormatDateTime(forWeekEnding) 
	end if

	strBuffer = "" &_
		"<span class=""calendarButton"" id=""calBtn" & placementid & "_" & summaryid & """>&nbsp;</span>" &_
		"<input name=""slct_we_" & placementid & "_" & summaryid & _
		"""  id=""slct_we_" & placementid & "_" & summaryid & """  onChange=""timedetail.changewe(this.name, '" & g_strSite & "')""" &_
		"class=""inpWeekEnding " & sids & """ value=""" & formattedWeekEnding & """>"
		
		'print sids

 
'print p_WeekEndsOn & " - " & Weekday(Date) & " : " & forWeekEnding
 
	'figure next week ending date
	Today = Weekday(Date)
	if Today > p_WeekEndsOn then
		AdjustedDate = DateAdd("d", 7 - (Today - p_WeekEndsOn), Date)
	Else
		AdjustedDate = DateAdd("d", 7 - (p_WeekEndsOn - Today), Date)
	end if
	
	inpWeekEndsOn = strBuffer
end function

function getdaynumber(p_day)
	dim p_return
	

	
	select case lcase(p_day)
	case "mon"
		p_return = 2
		
	case "tue"
		p_return = 3

	case "wed"
		p_return = 4

	case "thu"
		p_return = 5
		
	case "fri"	
		p_return = 6

	case "sat"
		p_return = 7

	case "sun"
		p_return = 1

	case ""
		p_return = -1

	end select
	
	getdaynumber = p_return
	
end function


public function doUpdateDay()
	dim placementid
	placementid = getParameter("id")
	
	dim dayofweek, daynumber, dayname
	dayofweek = getParameter("dn") '[d]ay [n]umber
	
	' fixup 'd' that may be being passed by calling javascript
	if not isnumeric(dayofweek) then dayname = right(dayofweek, 3)
	
	if not isnumeric(dayname) then
		daynumber = getdaynumber(dayname)
	end if

	'print "dayofweek: " & dayofweek & ", dayname: " & dayname & ", daynumber: " & daynumber
	
	dim week_begins
	'receiving day value of 1st day of week, 2nd day, 3rd, etc.
	'convert to standard day of week enumeration values
	
	week_begins = company_weekends - 6
	if week_begins < 1 then week_begins = week_begins + 7
	
	'deprecated, javascript service now passes value back from time_summary 2014.4.5
	REM dim workday
	REM workday = (week_begins-1) + daynumber  'decrement worday by 1 to account for dayofweek starting at 1 instead of 0
	REM if workday > 7 then workday = workday - 7

	dim summaryid
	summaryid = getParameter("summaryid")
	
	dim timeamount
	timeamount = getParameter("time")
	if len(timeamount) = 0 then timeamount="Null"
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"UPDATE time_summary " &_
			"SET d" & daynumber & "=" & insert_number(timeamount) & " " &_
			"WHERE placementid=" & placementid & " AND id=" & summaryid & ";"
	end with
	
	'print cmd.CommandText
	dim rs
	set rs = cmd.execute()

	cmd.CommandText = "" &_
			"DELETE FROM time_detail " &_
			"WHERE summaryid=" & summaryid & " AND workday=" & daynumber & ";"
	cmd.execute()

	cmd.CommandText = "" &_
			"INSERT INTO time_detail " &_
			"(summaryid, workday, timetotal, modified, creatorId, createdby) " &_
			"VALUE (" &_
			summaryid & ", " &_
			daynumber & ", " &_
			timeamount & ", " &_
			"now(), " & user_id & ", 'H');"
			'"'0000-00-00 " & replace(timeamount, ".", ":") & ":00'" & ", " &_
	cmd.execute()
	
	'break cmd.CommandText
	
	response.write "<!-- _d" & dayname & "_" & placementid & "_" & summaryid & "_" & timeamount & "_" & g_strSite & " -->"
	
end function

public function doUpdateWeekEnding()
	dim placementid
	placementid = getParameter("id")
	
	dim summaryid
	summaryid = getParameter("summaryid")
	
	dim weekenddate
	weekenddate = getParameter("we")

	dim MySqlFriendlyDate
	MySqlFriendlyDate = Year(weekenddate) & "/" & Month(weekenddate) & "/" & Day(weekenddate)

	dim dayofweek
	dayofweek = getParameter("dn")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"UPDATE time_summary " &_
			"SET weekending='" & MySqlFriendlyDate & "' " &_
			"WHERE placementid=" & placementid & " AND id=" & summaryid & ";"
	end with
	
	dim rs
	set rs = cmd.execute()
	
	response.write "<!-- _" & dayofweek & "_" & placementid & "_" & summaryid & "_ -->"
	
end function

function getWeekending(today, customer)
	
	'print "cust: " & customer
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		
		.CommandText = "" &_
			"Select weekends FROM tbl_companies WHERE INSTR(Customer, '" & customer & "') > 0;"
	end with
	
	dim rs
	set rs = cmd.Execute()

	dim weekEndsOn
	weekEndsOn = cint(rs("weekends"))
	
	today = Weekday(Date)
	
	'print "today: " & today
	'print "week ends on: " & WeekEndsOn
	
	if today > WeekEndsOn then

		getWeekending = DateAdd("d", 7 - (today - WeekEndsOn), Date)
		
	elseif today < WeekEndsOn then

		getWeekending = DateAdd("d", (WeekEndsOn - today), Date)
		
	elseif today = WeekEndsOn then
		getWeekending = Date
	else
		getWeekending = DateAdd("d", 7 - (WeekEndsOn - today), Date)
	end if
	
end function

function getCustomerFromPlacement(placementid, p_conn)

	dim rs, cmd

    set rs = Server.CreateObject("adodb.Recordset")
    set cmd = Server.CreateObject("adodb.Command")
    
	dim dbConnectionString
	if isnumeric(p_conn) then
		dbConnectionString = dsnLessTemps(p_conn)
	elseif len(p_conn) > 3 then
		dbConnectionString = p_conn
	elseif len(p_conn) > 0 then
		dbConnectionString = dsnLessTemps(getCompanyNumber(p_conn))
	end if

	cmd.ActiveConnection = dbConnectionString
	cmd.CommandText = "SELECT Customer FROM Placements WHERE PlacementId=" & placementid
	
	set rs = cmd.Execute()
	if not rs.eof then getCustomerFromPlacement = rs("Customer")
	
	set rs = nothing
	set cmd = nothing
	
end function

function getUserIdFromApplicantId(applicantid, p_conn)

	dim rs, cmd

    set rs = Server.CreateObject("adodb.Recordset")
    set cmd = Server.CreateObject("adodb.Command")
    
	REM dim dbConnectionString
	REM if isnumeric(p_conn) then
		REM dbConnectionString = dsnLessTemps(p_conn)
	REM elseif len(p_conn) > 3 then
		REM dbConnectionString = p_conn
	REM elseif len(p_conn) > 0 then
		REM dbConnectionString = dsnLessTemps(getCompanyNumber(p_conn))
	REM end if

	cmd.ActiveConnection = MySql
	cmd.CommandText = "SELECT tbl_users.userID FROM tbl_applications RIGHT JOIN tbl_users on tbl_users.applicationid=tbl_applications.applicationid WHERE in" & getTempsCompCode(p_conn) & "=" & applicantid
	
	set rs = cmd.Execute()
	if not rs.eof then getUserIdFromApplicantId = rs("userid")
	
	set rs = nothing
	set cmd = nothing
	
end function

public function addTimeSummary()
	dim placementid
	placementid = getParameter("id")

	' get temps details from placementid
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	
	with cmd
		.ActiveConnection = dsnLessTemps(g_strSite)
		
		.CommandText = "" &_
			"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, Placements.ApplicantId, " &_
			"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
			"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
			"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
			"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
			"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
			"WHERE Placements.PlacementID=" & placementid
	end with

	dim rs
	set rs = cmd.Execute()
	
	dim customer
	customer = getCustomerFromPlacement(placementid, g_strSite)
	
	if not rs.eof then dim applicantid : applicantid = rs("ApplicantId")
		
	dim vms_userid
	vms_userid = getUserIdFromApplicantId(rs("ApplicantId"), g_strSite)
	
	dim p_weekending, p_today
	p_weekending = getWeekending(p_today, customer)

	' make mysql friendly
	p_weekending = Year(p_weekending) & "/" & Month(p_weekending) & "/" & Day(p_weekending)
	
	
	if not rs.eof then

		with cmd
			.ActiveConnection = MySql
			
			if isnumeric(g_strSite) then
				.CommandText = "" &_
					"INSERT INTO time_summary " &_
					"(workcode, wc_description, employeenumber, department, costcenter, cc_description, regpay, regbill, otpay, otbill, placementid, customer, site, weekending, createdby, foruserid, creatorid) " &_
					"VALUES " &_
					"(" & insert_string(rs("WorkCode")) & ", " &_
						insert_string(rs("Description")) & ", " &_
						insert_string(rs("EmployeeNumber")) & ", " &_
						insert_number(rs("JobNumber")) & ", " &_
						insert_number(rs("Reference")) & ", " &_
						insert_string(rs("JobDescription")) & ", " &_
						insert_string(rs("RegPayRate")) & ", " &_
						insert_string(rs("RegBillRate")) & ", " &_
						insert_string(rs("OvertimePayRate")) & ", " &_
						insert_string(rs("OvertimeBillRate")) & ", " &_
						
						placementid & ", " & insert_string(customer) & ", " & g_strSite & ", " & insert_string(p_weekending) & ", 'H', " & insert_number(vms_userid) & ", " & insert_number(user_id) & ")"
			else
				.CommandText = "" &_
					"INSERT INTO time_summary " &_
					"(workcode, wc_description, employeenumber, department, costcenter, cc_description, regpay, regbill, otpay, otbill, placementid, customer, site, weekending, createdby, creatorid) " &_
					"VALUES " &_
					"(" & insert_string(rs("WorkCode")) & ", " &_
						insert_string(rs("Description")) & ", " &_
						insert_string(rs("EmployeeNumber")) & ", " &_
						insert_number(rs("JobNumber")) & ", " &_
						insert_number(rs("Reference")) & ", " &_
						insert_string(rs("JobDescription")) & ", " &_
						insert_string(rs("RegPayRate")) & ", " &_
						insert_string(rs("RegBillRate")) & ", " &_
						insert_string(rs("OvertimePayRate")) & ", " &_
						insert_string(rs("OvertimeBillRate")) & ", " &_
						 placementid & ", " & insert_string(customer) & ", " & getSiteNumber(g_strSite) & ", " & insert_string(p_weekending) & ", 'H', " & insert_number(applicantid) & ", " & insert_number(user_id) & ")"
			end if
			
			'print cmd.CommandText
			.Execute()
		end with
	end if
		' .CommandText = "" &_
			' "SELECT weekending, workday, SUM(TIME_TO_SEC(TIMEDIFF(timeout, timein))) AS totalhours " &_
			' "FROM time_summary INNER JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
			' "WHERE placementid=" & placementid & " " &_
			' "GROUP By workday ORDER By weekending desc, workday asc;"

	set cmd = nothing
	response.write placementid & ":" & g_strSite
end function

public function removeTimeSummary()
	dim placementid
	placementid = getParameter("id")
	
	dim siteid
	if isnumeric(g_strSite) then
		siteid = getTempsDSN(getCompCode(g_strSite))
	else
		siteid = getTempsDSN(g_strSite)
	end if
	
	dim summaryid
	summaryid = getParameter("summary")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"DELETE FROM time_summary " &_
			"WHERE (placementid=" & placementid & ") AND (site=" & siteid & ") AND (id=" & summaryid & ")"
			
		.Execute()
	end with

	with cmd
		.CommandText = "" &_
			"DELETE FROM time_detail " &_
			"WHERE (summaryid=" & summaryid & ")"
		.Execute()
	end with

	set cmd = nothing
	response.write placementid & ":" & g_strSite
end function


%>

