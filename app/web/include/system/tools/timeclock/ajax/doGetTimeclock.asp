<%
public function doGetTimeclock()
	
	dim today, weekEndingDate
	weekEndingDate = getWeekending(today)
	
	'print "weekEndingDate: " & weekEndingDate
	
	
	today = Weekday(Date)

	dim MySqlFriendlyDate
	MySqlFriendlyDate = Year(weekEndingDate) & "/" & Month(weekEndingDate) & "/" & Day(weekEndingDate)
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")	
	with cmd
		.ActiveConnection = MySql
		
		.CommandText = "" &_
			"SELECT time_detail.timein, time_detail.timeout, time_summary.placementid, time_summary.site, time_detail.workday, time_detail.creatorid, time_detail.id " &_
				"FROM pplusvms.time_detail " &_
				"LEFT JOIN pplusvms.time_summary on time_summary.id = time_detail.summaryid " &_
				"WHERE (placementid=" & placementid & " AND site=" & g_strSite & " AND time_detail.creatorid=" & creatorid & " AND time_detail.created >= NOW() - INTERVAL 16 HOUR) " &_
				"AND (time_detail.timein IS NOT NULL AND time_detail.timeout IS NULL) ORDER By time_detail.id desc;"

'				"WHERE (placementid='" & placementid & "' AND site='" & g_strSite & "' AND time_detail.creatorid=" & applicantid & " AND workday=" & today & ") " &_
	
	end with

	
	if applicantid <> "NaN" then
		dim rs
		
		'print cmd.CommandText
		
		set rs = cmd.Execute()
		if rs.eof then
			'not clocked in, get cost-centers present option to clock in
	
%>
			<div style="vertical-align:bottom; min-height:3em; width:27em; color:white; font-weight:normal;font-family:arial;font-size:80%;"><p>Hours subject to pre-approved shift. <br /><br /><i>All over-time hours must be approved in advance.</i></p></div>

<!--
			<div style="heigh:3em; width:27em; color:white; font-weight:bold;font-family:arial;">Choose Action</div>

			<div style="border:1px solid #73a54c;background-color:#5cbb15;float:left;clear:left;margin-right:1.2em;">
				<a href="javascript:;" onclick="timeclock.clockin('<%=placementid%>','<%=g_strSite%>', '<%=customer%>', '<%=applicantid%>');" style="color:white;font-weight:bold;font-family:arial;text-decoration:none;">
					<div style="width:12em;height:5em;text-align:center; vertical-align: middle;box-shadow: 10px 10px 5px #888888;">
						<p style="position:relative; top:25%">Clock In</p>
					</div>
				</a>
			</div>
-->
<%
			doClockIn
		else
		
			'clocked in, present option to clock-out [and present time clocked in and sort by highest detail id, in-case of multiple clock-ins]
%>
			<div style="vertical-align:bottom;min-height:3em; width:27em; color:white; font-weight:normal;font-family:arial;font-size:80%;"><p>Hours subject to pre-approved shift. <br /><br /><i>All over-time hours must be approved in advance.</i></p></div>
<!--
			<div style="heigh:3em; width:26em; color:white; font-weight:bold;font-family:arial;">Choose Action</div>	

				<div style="border:1px solid #73a54c;background-color:#f74a46;float:right;">
					<a href="javascript:;" onclick="timeclock.clockout('<%=placementid%>','<%=g_strSite%>', '<%=customer%>', '<%=applicantid%>');" style="color:white;font-weight:bold;font-family:arial;text-decoration:none;">
						<div style="width:12em;height:5em;text-align:center; padding:auto 0; vertical-align: middle;box-shadow: 10px 10px 5px #888888;">
							<p style="position:relative; top:25%">Clock Out</p>
						</div>
					</a>
				</div>	
-->

<%
				doClockOut
			
			end if
	end if
	
	set cmd = nothing
	set rs = nothing
end function

function getWeekending(today)
	
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

function lookupCreatorId (applicantid, site)
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT tbl_users.userID, tbl_applications.in" & getTempsCompCode(site) & " FROM pplusvms.tbl_applications " &_
				"INNER JOIN tbl_users on tbl_applications.applicationID=tbl_users.applicationID " &_
				"WHERE tbl_applications.in" & getTempsCompCode(site) & "=" & applicantid & ";"
	end with
	
	dim rs
	set rs = cmd.Execute()
	
	
	if not rs.eof then
		lookupCreatorId = rs("userID")
	else
		lookupCreatorId = false
	end if

end function


function doClockIn

	'get summaryid
	'if no summary, create summary and get lastindex as summaryid
	'insert time_detail record
	
	
	dim summaryid
	'summaryid = getParameter("summaryid")
	'
	'need to figure out summary id...
	'thinking if empty summary id exists [with no weekending] then commandeer the highest id and set the weekending, rerun query
	'
	'* scratch that, if now summary id exists with the current weeks weekending date then create a new summary for the current weekending date
	
	dim today, weekEndingDate
	weekEndingDate = getWeekending(today)
	
	dim MySqlFriendlyDate
	MySqlFriendlyDate = Year(weekEndingDate) & "/" & Month(weekEndingDate) & "/" & Day(weekEndingDate)

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT time_summary.id FROM pplusvms.time_summary " &_
				"WHERE (placementid='" & placementid & "' AND site='" & g_strSite & "' AND weekending='" & MySqlFriendlyDate & "');"
	end with
	
	dim rs
	set rs = cmd.Execute()
	
	if not rs.eof then
		'existing time summary exists
		'
		summaryid = rs("id")
	else
		'time summary for week doesn't exist, create one
		'
				
		' get temps details from placementid

		with cmd
		.ActiveConnection = dsnLessTemps(g_strSite)
		
		.CommandText = "" &_
			"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, " &_
			"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
			"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
			"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
			"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
			"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
			"WHERE Placements.PlacementID=" & placementid
		end with

		set rs = cmd.Execute()

		if not rs.eof then

			cmd.ActiveConnection = MySql
			cmd.CommandText = "" &_
				"INSERT INTO time_summary " &_
				"(workcode, wc_description, employeenumber, department, costcenter, cc_description, regpay, regbill, otpay, otbill, placementid, customer, site, weekending, createdby, creatorid, foruserid) " &_
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
					 placementid & ", " & insert_string(customerid) & ", " & getTempsSiteId(siteid)  & ", '" & MySqlFriendlyDate & "', 'T', '" & creatorid & "', '" & creatorid & "');SELECT last_insert_id();"
		'print cmd.CommandText
		
		set rs = cmd.execute.nextrecordset
		
			summaryid = rs(0)
		
		end if
		
		
	end if
	
	
	
	
	with cmd
		.CommandText = "" &_
			"INSERT INTO time_detail (summaryid, workday, timein, creatorid, createdby) " &_
				"VALUES (" & summaryid & ", " & today & ", now(), " & creatorid & ", 'T');"
	end with
	
	set rs = cmd.execute()
	
	set cmd = nothing
	set rs = nothing
	
	dim confirmationHTML
		confirmationHTML = "" &_
		
			"<div style=""border:1px solid #73a54c;background-color:#5cbb15;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em;box-shadow: 10px 10px 5px #888888;"">" &_
				"<table style=""width:25em;"">" &_
				"<tr><td colspan=""2""></td></tr>" &_
				"<tr>" &_
					"<td colspan=""2""><span style=""color:white; font-weight:bold;"">You have successfully clocked <em>in</em> at " & time & "<br><br></span></td>" &_
				"</tr>" &_
				"<tr><td colspan=""2""></td></tr>" &_
				"<tr><td colspan=""2""></td></tr>" &_
				"</table>" &_
			"</div>"
			
	response.write confirmationHTML
	
	call sendEmailNotice("in", confirmationHTML, time)	

end function


function doClockOut

	'get summaryid
	'if no summary, create summary and get lastindex as summaryid
	'insert time_detail record
	
	
	dim summaryid
	'summaryid = getParameter("summaryid")
	'
	'need to figure out summary id...
	'thinking if empty summary id exists [with no weekending] then commandeer the highest id and set the weekending, rerun query
	'
	'* scratch that, if now summary id exists with the current weeks weekending date then create a new summary for the current weekending date
	
	dim today, weekEndingDate
	weekEndingDate = getWeekending(today)
	
	dim MySqlFriendlyDate
	MySqlFriendlyDate = Year(weekEndingDate) & "/" & Month(weekEndingDate) & "/" & Day(weekEndingDate)

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT time_summary.id FROM pplusvms.time_summary " &_
				"WHERE (placementid='" & placementid & "' AND site='" & g_strSite & "' AND weekending='" & MySqlFriendlyDate & "');"
	end with
	
	set rs = cmd.Execute()
	
	if not rs.eof then
		summaryid = rs("id")
		
		'print "summary id: " & summaryid

	else
	
		
		' get temps details from placementid
		
		with cmd
			.ActiveConnection = dsnLessTemps(g_strSite)
			
			.CommandText = "" &_
				"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, " &_
				"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
				"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
				"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
				"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
				"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
				"WHERE Placements.PlacementID=" & placementid
		end with

		dim rs
		set rs = cmd.Execute()

		if not rs.eof then

	
			cmd.ActiveConnection = MySql
			cmd.CommandText = "" &_
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
					 placementid & ", " & insert_string(customerid) & ", " & getTempsSiteId(siteid)  & ", '" & MySqlFriendlyDate & "', 'T', '" & creatorid & "');SELECT last_insert_id();"
			set rs = cmd.execute.nextrecordset
			
			summaryid = rs(0)
			
		end if

	end if

	cmd.CommandText = "" &_
		"SELECT id, timein, timeout FROM time_detail " &_
			"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL) AND time_detail.created >= NOW() - INTERVAL 1 DAY;"
			'"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL);"
'			"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL) AND workday=" & today & ";"

	set rs = cmd.execute()
	
	'print cmd.CommandText
	
	if rs.eof then
		'no timedetail today, select previous summaries that may still be clocked in and clock them out
		
		cmd.CommandText = "" &_
			"SELECT time_detail.summaryid, time_detail.timein, time_detail.timeout, time_summary.placementid, time_summary.site, " &_
				"time_detail.workday, time_detail.creatorid, time_detail.id " &_
					"FROM pplusvms.time_detail " &_
					"LEFT JOIN pplusvms.time_summary on time_summary.id = time_detail.summaryid " &_
			"WHERE (placementid=" & placementid & " AND site=" & g_strSite & " AND time_detail.creatorid=" & creatorid & ") " &_
				"AND (time_detail.timein IS NOT NULL AND time_detail.timeout IS NULL) ORDER By time_detail.id desc;"
			
		'print cmd.CommandText
		
		set rs = cmd.execute()
		
		do until rs.eof
			'print "iterating: " & rs("summaryid")
			
			cmd.CommandText = "" &_
				"UPDATE time_detail SET modified=now(), timeout=now() " &_
				"WHERE summaryid=" & rs("summaryid") & " AND (timeout IS NULL AND timein IS NOT NULL);"
			
			rs.movenext
			
			cmd.execute()
		loop
		

	else
		cmd.CommandText = "" &_
			"UPDATE time_detail SET modified=now(), timeout=now() " &_
				"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL);"
				'"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL);"
	'			"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL) AND workday=" & today & ";"
	end if

	set rs = cmd.execute()
	
	REM cmd.CommandText = "" &_
			REM "UPDATE time_detail " &_
			REM "SET timetotal=(" &_
				REM "SELECT TIME_TO_SEC(TIMEDIFF(Time_Format(time_detail.timeout, '%H:%i'), Time_Format(time_detail.timein, '%H:%i')))/60)/60 " &_
				REM "WHERE summaryid=" & summaryid & " AND (timeout IS NOT NULL AND timein IS NOT NULL);"
				
	REM set rs = cmd.execute()
	
	set cmd = nothing
	set rs = nothing
	
	dim confirmationHTML
	
	confirmationHTML = "" &_
				"<div style=""border:1px solid #73a54c;background-color:#f74a46;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em;box-shadow: 10px 10px 5px #888888;"">" &_
					"<table style=""width:25em;"">" &_
					"<tr><td colspan=""2""></td></tr>" &_
					"<tr>" &_
						"<td colspan=""2""><span style=""color:white; font-weight:bold;"">You have successfully clocked <em>out</em> at " & time & "</span></td>" &_
					"</tr>" &_
					"<tr><td colspan=""2""></td></tr>" &_
					"<tr><td colspan=""2""></td></tr>" &_
					"</table>" & _
				"</div>"
	
	response.write confirmationHTML
	
	call sendEmailNotice("out", confirmationHTML, time)
	
	'send email for previous weeks unapproved and pending time
		'
	sendEmployeeTimeSummaryEmail(MySqlFriendlyDate)


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
			"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, " &_
			"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
			"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
			"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
			"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
			"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
			"WHERE Placements.PlacementID=" & placementid
	end with

	dim rs
	set rs = cmd.Execute()

	if not rs.eof then
	
	
		with cmd
			.ActiveConnection = MySql
			
			if isnumeric(g_strSite) then
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
						
						placementid & ", " & insert_string(customer) & ", " & g_strSite & ", " & insert_string(p_weekending) & ", 'T', " & insert_number(user_id) & ")"
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
						 placementid & ", " & insert_string(customer) & ", " & getSiteNumber(g_strSite) & ", " & insert_string(p_weekending) & ", 'T', " & insert_number(user_id) & ")"
			end if
			
			.Execute()

			' .CommandText = "" &_
				' "SELECT weekending, workday, SUM(TIME_TO_SEC(TIMEDIFF(timeout, timein))) AS totalhours " &_
				' "FROM time_summary INNER JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
				' "WHERE placementid=" & placementid & " " &_
				' "GROUP By workday ORDER By weekending desc, workday asc;"
		end with


	end if

	set cmd = nothing
	response.write placementid & ":" & g_strSite
end function

public function removeTimeSummary()
	dim placementid
	placementid = getParameter("id")
	
	dim siteid
	siteid = getTempsDSN(g_strSite)
	
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