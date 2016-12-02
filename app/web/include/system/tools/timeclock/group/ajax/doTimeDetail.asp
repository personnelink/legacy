<%
public function doDeleteTimedetail()
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	
	dim detailid
	detailid = getParameter("detailid")
	
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"DELETE FROM time_detail WHERE id=" & detailid & ";"
		.Execute()
	end with
	
	set cmd = nothing

	response.write getParameter("table") & "_" & detailid

end function

public function doAddTimedetail()
	
	dim TimeDetail
	set TimeDetail = new cTimeDetail
	
	with TimeDetail
		.PlacementId = getParameter("placementid")
		.SummaryId   = getParameter("summaryid")
	end with
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")

	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"INSERT INTO time_detail (summaryid, creatorId) VALUES (" & TimeDetail.SummaryId & ", " & user_id & ");select last_insert_id();"
	end with

			REM "SELECT time_summary.id, time_summary.weekending, time_summary.placementid, time_detail.id, " &_
				REM "time_summary.site, time_detail.workday, Time_Format(time_detail.timein, '%H:%i') as timein, " &_
				REM "Time_Format(time_detail.timeout, '%H:%i') as timeout, " &_
				REM "time_detail.timetotal, (TIME_TO_SEC(TIMEDIFF(timeout, timein))/60)/60 as hours, time_types.description, time_types.id, " &_
				REM "time_detail.modified, tbl_users.firstName, tbl_users.lastName, time_detail.created " &_
			REM "FROM " &_
				REM "((time_summary RIGHT JOIN time_detail ON time_summary.id = time_detail.summaryid) " &_
				REM "LEFT JOIN tbl_users ON time_detail.creatorId = tbl_users.userID) LEFT JOIN time_types ON time_detail.timetype = time_types.id " &_
			REM "WHERE (time_summary.placementid=" & TimeDetail.PlacementId & ") AND (time_summary.id=" & TimeDetail.SummaryId & ") " &_
			REM "ORDER BY time_detail.workday, time_detail.id, time_detail.created;"
			
	
	dim rs
	set rs = cmd.execute.nextrecordset
	
	dim detailid
		detailid = rs(0)
	
	REM 'Main input template to be used by client script to create additional table rows later.
			
	dim tmpWorkDay
	if not rs.eof then
		
		'TimeDetail.Workday = rs("workday")
		dim rowid

		rowid  = "" &_
			"tPlacementid_" &_
			"tSummaryid_" &_
			"tDetailId_" &_
			"tWorkday"
		dim i
		dim timeIn
		dim timeOut
		dim totalhours
		
		with TimeDetail
			REM .TimeIn = rs("timein")
			REM .TimeOut = rs("timeout")
			.DetailId = detailid
			REM .Site = rs("site")
			rem .Workday = 0
			REM .TimeType = rs("description")
			REM .TimeTypeId = rs(8)
			REM .EnteredBy = rs("firstName") & " " & rs("lastName") 
			REM .Created = rs("created")
			REM .Modified = rs("modified")
		end with

		i = i + 1

		rowid  = TimeDetail.PlacementId & "_" &_
					TimeDetail.SummaryId & "_" &_
					TimeDetail.DetailId & "_" &_
					TimeDetail.Workday
		totalhours = 0
		
		dim strResponse
		strResponse = "<table id=""timedetail" & detailid & """ class=""time_detail"">" &_
			"<tr>" &_
				"<td class=""left_margin"">&nbsp;</td>" &_
				"<td class=""weekday"">" &_
					objDaySelect(TimeDetail.Workday, rowid, TimeDetail.CreatorId) &_
				"</td>" &_
				"<td class=""timeinput"">" &_
					"<input  id=""in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
						"onchange=""timeclock.setTime(this.id)"" value="""""">" &_
				"</td>" &_
				"<td class=""timeinput"">" &_	 
					"<input  id=""out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
						"onchange=""timeclock.setTime(this.id)"" value="""""">" &_
				"</td>" &_
				"<td class=""hourstotal"">" &_
					"<input id=""total_" & rowid & """ name=""detailRow_" & rowid & """ " &_
					"type=""text"" class=""hoursTimeInput"" value=""" & TwoDecimals(totalhours)	& """ " &_
					"onchange=""timeclock.setTime(this.id)"" /></td>" &_
				"<td><select id=""type_" & rowid & """ name=""detailRow_" & rowid & """>" &_
						"<option value="""">Regular Time</option>" &_
						"<option value="""">Over Time</option>" &_
						"<option value="""">Double Time</option>" &_
						"<option value="""">Sick Time</option>" &_
						"<option value="""">Vacation Time</option>" &_
						"<option value="""">Comp Time</option>" &_
						"<option value="""">Salary Day</option>" &_
						"<option value="""">Salary Week</option>" &_
						"<option value="""">Salary Biweekly</option>" &_
						"<option value="""">Salary Semi-monthly</option>" &_
						"<option value="""">Salary Monthly</option>" &_
						"<option value="""">Piece Rate</option>" &_
					"</select>" &_
				"</td>" &_
				"<td class=""delete_time_detail"">" &_
					"<span class=""button"" onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & detailid & "');""><span>Delete</span></span>" &_
				"</td>" &_
			"</tr>" &_
			"<tr class=""userinfo"">" &_
				"<td>&nbsp;</td><td colspan=""6""><span>Entered By: " & user_firstname & " " & user_lastname & " Created on: " & Now & " Last modified: " & TimeDetail.Modified &_
			"</tr>"
		end if
			
		strResponse = strResponse & "</table>"

		response.write strResponse
	
	set cmd = nothing
	set rs = nothing
	

	response.write "<!-- [split] -->" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId
end function

public function doTimedetail()
	
	dim TimeDetail
	set TimeDetail = new cTimeDetail
	
	with TimeDetail
		.PlacementId = getParameter("id")
		.SummaryId   = getParameter("summary")
	end with
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT time_summary.id, time_summary.weekending, time_summary.placementid, time_detail.id, " &_
				"time_summary.site, time_detail.workday, Time_Format(time_detail.timein, '%H:%i') as timein, " &_
				"Time_Format(time_detail.timeout, '%H:%i') as timeout, " &_
				"time_detail.timetotal, (ABS(TIME_TO_SEC(TIMEDIFF(timeout, timein)))/60)/60 as hours,  (ABS(TIME_TO_SEC(TIMEDIFF(ADDTIME(timeout, '24:00:00'), timein)))/60)/60 as midnight, time_types.description, time_types.id, " &_
				"time_detail.modified, tbl_users.firstName, tbl_users.lastName, time_detail.created, time_summary.creatorid " &_
			"FROM " &_
				"((time_summary RIGHT JOIN time_detail ON time_summary.id = time_detail.summaryid) " &_
				"LEFT JOIN tbl_users ON time_detail.creatorId = tbl_users.userID) LEFT JOIN time_types ON time_detail.timetype = time_types.id " &_
			"WHERE (time_summary.placementid=" & TimeDetail.PlacementId & ") AND (time_summary.id=" & TimeDetail.SummaryId & ") " &_
			"ORDER BY time_detail.workday, time_detail.id, time_detail.created;"
	end with
		
	dim rs
	set rs = cmd.execute()
	
	dim strResponse
		strResponse = "<table class=""time_detail"" id=""plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & """>" &_
					"<tr>" &_
						"<th class=""left_margin"">&nbsp;</th>" &_
						"<th>Weekday</th>" &_
						"<th>Time-In</th>" &_
						"<th>Time-Out</th>" &_
						"<th>Total</th>" &_
						"<th>Time Type</th>" &_
						"<th class=""delete"">&nbsp;</th>" &_
					"</tr></table>"

					
			'Main input template to be used by client script to create additional table rows later.
			
			dim tmpWorkDay
			if not rs.eof then
				
				'TimeDetail.Workday = rs("workday")
				dim rowid

				rowid  = "" &_
					"tPlacementid_" &_
					"tSummaryid_" &_
					"tDetailId_" &_
					"tWorkday"

			dim i
			dim timeIn
			dim timeOut
			dim totalhours
			
			do until rs.eof
			
				with TimeDetail
					.Workday = rs("workday")
					.TimeIn = rs("timein")
					.TimeOut = rs("timeout")
					.DetailId = rs(3)
					.Site = rs("site")
					.TimeType = rs("description")
					.TimeTypeId = rs(8)
					.EnteredBy = rs("firstName") & " " & rs("lastName") 
					.Created = rs("created")
					.CreatorId = rs("creatorid")
					.Modified = rs("modified")
				end with

				i = i + 1

				rowid  = TimeDetail.PlacementId & "_" &_
							TimeDetail.SummaryId & "_" &_
							TimeDetail.DetailId & "_" &_
							TimeDetail.Workday

				if vartype(rs("hours")) = 14 then 'calculated timeout - timein hours
					totalhours = cdbl(rs("hours"))
				else
					totalhours = 0
				end if

				if TimeDetail.TimeIn > TimeDetail.TimeOut then
					'alternate procedures for time that roles over midnight
					if vartype(rs("midnight")) = 14 then 'calculated timeout - timein hours
						totalhours = cdbl(rs("midnight"))
					else
						totalhours = 0
					end if
				end if
					
				if totalhours = 0 then 
					if vartype(rs("timetotal")) = 14 then 'manually entered hours
						totalhours = cdbl(rs("timetotal"))
					end if
				end if
				
				if totalhours < 0 then totalhours = totalhours*-1
				
				strResponse = strResponse &_
					"<table id=""timedetail" & TimeDetail.DetailId & """ class=""time_detail"">" &_
						"<tr>" &_
							"<td class=""left_margin"">&nbsp;</td>" &_
							"<td class=""weekday"">" &_
								objDaySelect(TimeDetail.Workday, rowid, TimeDetail.CreatorId) &_
							"</td>" &_
							"<td class=""timeinput"">" &_
								"<input  class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									"onchange=""timeclock.setTime(this.id)"" value=""" & TimeDetail.TimeIn & """>" &_
							"</td>" &_
							"<td class=""timeinput"">" &_	 
								"<input class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									"onchange=""timeclock.setTime(this.id)"" value=""" & TimeDetail.TimeOut & """>" &_
							"</td>" &_
							"<td class=""hourstotal"">" &_
								"<input id=""total_" & rowid & """ name=""detailRow_" & rowid & """ " &_
								"type=""text"" class=""hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """ value=""" & TwoDecimals(totalhours)	& """ " &_
								"onchange=""timeclock.setTime(this.id)"" /></td>" &_
							"<td><select  class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""type_" & rowid & """ name=""detailRow_" & rowid & """>" &_
									"<option value="""">Regular Time</option>" &_
									"<option value="""">Over Time</option>" &_
									"<option value="""">Double Time</option>" &_
									"<option value="""">Sick Time</option>" &_
									"<option value="""">Vacation Time</option>" &_
									"<option value="""">Comp Time</option>" &_
									"<option value="""">Salary Day</option>" &_
									"<option value="""">Salary Week</option>" &_
									"<option value="""">Salary Biweekly</option>" &_
									"<option value="""">Salary Semi-monthly</option>" &_
									"<option value="""">Salary Monthly</option>" &_
									"<option value="""">Piece Rate</option>" &_
								"</select>" &_
							"</td>" &_
							"<td class=""delete_time_detail"">" &_
								"<span class=""button  cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Delete</span></span>" &_
							"</td>" &_
						"</tr>" &_
						"<tr class=""userinfo"">" &_
							"<td>&nbsp;</td><td colspan=""6""><span>Entered By: " & TimeDetail.EnteredBy & " Created on: " & TimeDetail.Created & " Last modified: " & TimeDetail.Modified &_
						"</tr>" &_
					"</table>"
'							<input name=""timein[]"" type=""text"" class=""inTimeInput"" value=""" & rs("timein") & """ /></td>" &_
				rs.movenext
			loop
		else
			'strResponse = strResponse & replace(inpRowTemplate, "hide", "")
		end if
			
		strResponse = strResponse &_
			"<span class=""add_detail_row button"" href=""javascript:;"" onclick=""timedetail.addRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "');""><span>Add Row</span></span>"
	
		response.write strResponse
	
	set cmd = nothing
	set rs = nothing
	

	response.write "<!-- [split] -->" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId
end function


function objDaySelect (ByVal workday, rowid, creatorid)
	dim strBuffer
	
	strBuffer = "<select id=""workday_" & rowid & """ name=""workday_" & rowid & """ " &_
		"class=""cid" & creatorid & " sid" & user_id & """ onchange=""timeclock.setTime(this.id)"" >" &_
		"<option value=""""> Day: </option>"

	dim i
	for i = 1 to 7
		if workday = i then
			strBuffer = strBuffer & "<option value=""" & i & """ selected=""selected"">" & getWorkDayName(i) & "</option>"
		else
			strBuffer = strBuffer & "<option value=""" & i & """>" & getWorkDayName(i) & "</option>"
		end if
	next
	objDaySelect = strBuffer & "</select>"

end function

public function getWorkDayName(workday)
	dim current_day
	current_day = company_weekends - (8 - workday)
	if current_day < 1  then
		current_day = current_day + 7
	end if
	getWorkDayName = Left(WeekDayName(current_day), 3)
end function

Function TimeOptions (timePiece)
	dim TimeOption    : TimeOption = "<option value='-1'>&nbsp</option>"
	dim StartClock     : StartClock = 0
	dim StopClock     : StopClock = 24
	dim m_timePiece : m_timePiece = ""
	
	'check if a string was passed
	if vartype(timePiece) = 8 and instr(timePiece, ":") > 0 then	
			' check if time instead of integer is being passed: "2:30" instead of expected "2.5"
			dim sMinutes, iMinutes
			sMinutes = right(timePiece, len(timePiece) - instr(timePiece, ":"))
			if isnumeric(sMinutes) then
				iMinutes = cint(sMinutes) * 1.666666666666667
			else
				iMinutes = 0
			end if
			dim iHours
			iHours = cint(left(timePiece, instr(timePiece, ":")-1))
			m_timePiece = cstr(iHours + iMinutes)
	else
		m_timePiece = timePiece
	end if

	dim i
	dim MinuteSlice
	dim TimeMinute
	dim DisplayTime
	
	for i = StartClock to StopClock step 0.25
		MinuteSlice = (i - int(i)) * 60
		
		if MinuteSlice = 0 then
			TimeMinute =  "00"
		Else
			TimeMinute = CStr(MinuteSlice)
		end if

		if i > 11.75 then
			if int(i - 12) = 0 then
				DisplayTime = "12:" & TimeMinute & "pm"
			Else
				DisplayTime = int(i - 12) & ":" & TimeMinute & "pm"
			end if
		Else
			if int(i) = 0 then
				DisplayTime = "12:" &  TimeMinute & "am"
			Else
				DisplayTime = int(i) & ":" &  TimeMinute & "am"
			end if
		end if

		if VarType(m_timePiece) = 8 then
			if i = CDbl(m_timePiece) then
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

%>
