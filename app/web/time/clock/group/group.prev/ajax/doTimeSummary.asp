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
			"SELECT t.id, t.weekending, t.workday, SUM(t.halftotal) as totalhours " &_ 
			"FROM (SELECT time_summary.id, weekending, workday, timetotal AS halftotal " &_
					 "FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					  "WHERE placementid=" & placementid & " " &_
					 "UNION ALL " &_
					"SELECT time_summary.id, weekending, workday, SUM(TIME_TO_SEC(TIMEDIFF(timeout, timein))) AS halftotal " &_
					 "FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					  "WHERE placementid=" & placementid & " " &_
					 ") t " &_
			"GROUP By t.id, t.workday ORDER By t.weekending asc, t.id asc, t.workday asc;"
			
	end with
	
	'print cmd.CommandText
	
	dim rs
	set rs = cmd.execute()

	dim SumOfHours, this_summary, current_id, last_id, last_week
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
			.id = current_id
			.WeekEnding = last_week
			'print "Hello world" & last_week
			
			select case rs("workday")
			case "1"
				.Day(1) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 1
			case "2"
				.Day(2) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 2
			case "3"
				.Day(3) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 3
			case "4"
				.Day(4) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 4
			case "5"
				.Day(5) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 5
			case "6"
				.Day(6) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 6
			case "7"
				.Day(7) = TwoDecimals(cdbl("0" & rs("totalhours")))
				.WorkDay = 7
			end select

		end with
		rs.movenext
	loop
	if not isnull(this_summary.id) then SumOfHours.Add this_summary.WeekEnding & ":" & this_summary.id, this_summary
	set this_summary = nothing

	dim Summary, i
	for each Summary in SumOfHours.Items
%>
		<table class="time_summary">
			<tr>
				<th class="col_we weekending"><span id="TimeDetail<%=placementid & "_" & Summary.id%>" class="ShowMore" onclick="timedetail.open('<%=placementid & "_" & Summary.id%>', '<%=g_strSite%>');">&nbsp;</span></a>&nbsp;Week Ending:</th>
				<th class="col_time">&nbsp;</th>
				<th class="col_day"><%=Summary.DayName(1)%></th>
				<th class="col_day"><%=Summary.DayName(2)%></th>
				<th class="col_day"><%=Summary.DayName(3)%></th>
				<th class="col_day"><%=Summary.DayName(4)%></th>
				<th class="col_day"><%=Summary.DayName(5)%></th>
				<th class="col_day"><%=Summary.DayName(6)%></th>
				<th class="col_day"><%=Summary.DayName(7)%></th>
				<th class="col_spc"></th>
				<th class="col_day">Time</th>
				<th class="col_spc">&nbsp;</th>
				<th class="col_day">Expense</th>
				<th class="col_cntrls">&nbsp;</th>
			</tr></table>
			
			<div id="we_connector_<%=placementid & "_" & Summary.id%>" class="no_connector">
			<table class="time_summary">
			<tr>
				<td class="col_we_b weekending"><%=inpWeekEndsOn(company_weekends, placementid, Summary.id, Summary.WeekEnding)%></td>
				<th class="col_time lbl_time">Time:</th>
				<td class="col_day"><input id="sum_d1_<%=placementid%>_<%=Summary.id%>" name="sum_d1_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(1)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_day"><input id="sum_d2_<%=placementid%>_<%=Summary.id%>" name="sum_d2_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(2)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_day"><input id="sum_d3_<%=placementid%>_<%=Summary.id%>" name="sum_d3_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(3)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_day"><input id="sum_d4_<%=placementid%>_<%=Summary.id%>" name="sum_d4_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(4)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_day"><input id="sum_d5_<%=placementid%>_<%=Summary.id%>" name="sum_d5_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(5)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_day"><input id="sum_d6_<%=placementid%>_<%=Summary.id%>" name="sum_d6_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(6)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_day"><input id="sum_d7_<%=placementid%>_<%=Summary.id%>" name="sum_d7_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.Day(7)%>" onChange="timedetail.change(this.name, '<%=g_strSite%>')"></td>
				<td class="col_spc">&nbsp;=&nbsp;</td>		
				<td class="col_day"><input id="sum_rt_<%=placementid%>_<%=Summary.id%>" name="sum_rt_<%=placementid%>_<%=Summary.id%>" size="2" value="<%=Summary.TotalHours%>" onChange="timedetail.changel(this.name, '<%=g_strSite%>')"></td>
				<td class="col_spc">+</td>		
				<td class="col_day"><input id="sum_et_<%=placementid%>_<%=Summary.id%>" name="sum_et_<%=placementid%>_<%=Summary.id%>" size="2" disabled="disabled" value="<%=Summary.TotalExpense%>" onChange="timedetail.changel(this.name, '<%=g_strSite%>')"></td>
				<td class="col_cntrls cntrlTimeDetail">
					<span class="button" onclick="timesummary.remove('<%=placementid%>', '<%=g_strSite%>', '<%=Summary.id%>');"><span class="remove">Remove</span></span>
					<span class="button" onclick="timesummary.remove('<%=placementid%>', '<%=g_strSite%>', '<%=Summary.id%>');"><span class="approve">Approve</span></span>
				</td>
			</tr>
		</table>
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

function inpWeekEndsOn(p_WeekEndsOn, placementid, summaryid, forWeekEnding)
	dim Today, AdjustedDate, i, WeekEndDate, strBuffer, thisOneSelected, formattedWeekEnding
	dim noneSelected : noneSelected = true

	if not isnull(forWeekEnding) then
		formattedWeekEnding = FormatDateTime(forWeekEnding) 
	end if

	strBuffer = "" &_
		"<span class=""calendarButton"" id=""calBtn" & placementid & "_" & summaryid & """>&nbsp;</span>" &_
		"<input name=""slct_we_" & placementid & "_" & summaryid & _
		"""  id=""slct_we_" & placementid & "_" & summaryid & """  onChange=""timedetail.changewe(this.name, '" & g_strSite & "')""" &_
		"class=""inpWeekEnding"" value=""" & formattedWeekEnding & """>"

 
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


public function doUpdateDay()
	dim placementid
	placementid = getParameter("id")
	
	dim dayofweek
	dayofweek = getParameter("dn") '[d]ay [n]umber
	
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
			"SET " & dayofweek & "=" & timeamount & " " &_
			"WHERE placementid=" & placementid & " AND id=" & summaryid & ";"
	end with
	
	dim rs
	set rs = cmd.execute()

	cmd.CommandText = "" &_
			"DELETE FROM time_detail " &_
			"WHERE summaryid=" & summaryid & " AND workday=" & right(dayofweek, 1) & ";"
			
	cmd.execute()
	
	cmd.CommandText = "" &_
			"INSERT INTO time_detail " &_
			"(summaryid, workday, timetotal, modified, creatorId) " &_
			"VALUE (" &_
			summaryid & ", " &_
			right(dayofweek, 1) & ", " &_
			timeamount & ", " &_
			"now(), " & user_id & ");"
			'"'0000-00-00 " & replace(timeamount, ".", ":") & ":00'" & ", " &_
	cmd.execute()
	
	'break cmd.CommandText
	
	response.write "<!-- _" & dayofweek & "_" & placementid & "_" & summaryid & "_" & timeamount & "_ -->"
	
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

%>

