<%
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
				"time_detail.timetotal, (TIME_TO_SEC(TIMEDIFF(timeout, timein))/60)/60 as hours, time_types.description, time_types.id, " &_
				"time_detail.modified, tbl_users.firstName, tbl_users.lastName, time_detail.created " &_
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
						"<th>&nbsp;</th>" &_
					"</tr>"

					
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

			dim inpRowTemplate
			inpRowTemplate = "" &_
					"<tr id=""plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "_template"" class=""hide"">" &_
						"<td>&nbsp;</td>" &_
						"<td class=""weekday"">" & objDaySelect(TimeDetail.Workday, rowid) & "</td>" &_
						"<td class=""timeinput"">" &_
							"<select  id=""In_" & TimeDetail.PlacementId & "_" & TimeDetail.DetailId & """ name=""timein_" & TimeDetail.PlacementId & "[]"" " &_
								"onclick=""buildClockOptions(this, '" & TimeDetail.TimeIn & "')"" " &_
								"onchange=""timeclock.setTime(this.id)"">" &_
								  TimeOptions(TimeDetail.TimeIn) &_
							  "</select>" &_
						"</td>" &_
						"<td class=""timeinput"">" &_	 
							"<select  id=""Out_" & TimeDetail.PlacementId & "_" & i & """ name=""timeout_" & TimeDetail.PlacementId & "[]"" " &_
								"onclick=""buildClockOptions(this, '" & TimeDetail.TimeOut & "')"" " &_
								"onchange=""timeclock.setTime(this.id)"">" &_
								  TimeOptions(TimeDetail.TimeOut) &_
							  "</select>" &_
						"</td>" &_
						"<td class=""hourstotal""><input name=""hours"" type=""text"" class=""hoursTimeInput"" value="""" /></td>" &_
						"<td><select>" &_
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
							"</select></td>" &_
						"<td>" &_
							"<a href=""javascript:;"" style=""font-size:85%"" onclick=""timedetail.deleteRow('plcemntTbl" & TimeDetail.PlacementId & "');"">[delete]</a>" &_
						"</td>" &_
					"</tr>"
					
					strResponse = strResponse & inpRowTemplate

			
			dim i
			dim timeIn
			dim timeOut
			dim totalhours
			
			do until rs.eof
			
				with TimeDetail
					.TimeIn = rs("timein")
					.TimeOut = rs("timeout")
					.DetailId = rs(3)
					.Site = rs("site")
					.Workday = rs("workday")
					.TimeType = rs("description")
					.TimeTypeId = rs(8)
					.EnteredBy = rs("firstName") & " " & rs("lastName") 
					.Created = rs("created")
					.Modified = rs("modified")
				end with
	
				i = i + 1

				rowid  = TimeDetail.PlacementId & "_" &_
							TimeDetail.SummaryId & "_" &_
							TimeDetail.DetailId & "_" &_
							TimeDetail.Workday

				totalhours = rs("hours")
				if isnull(totalhours) then totalhours = 0
				
				strResponse = strResponse &_
						"<tr>" &_
							"<td class=""left_margin"">&nbsp;</td>" &_
							"<td class=""weekday"">" &_
								objDaySelect(TimeDetail.Workday, rowid) &_
							"</td>" &_
							"<td class=""timeinput"">" &_
								"<select  id=""in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									"onchange=""timeclock.setTime(this.id)"">" &_
									  TimeOptions(TimeDetail.TimeIn) &_
								  "</select>" &_
							"</td>" &_
							"<td class=""timeinput"">" &_	 
								"<select  id=""out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									"onchange=""timeclock.setTime(this.id)"">" &_
									  TimeOptions(TimeDetail.TimeOut) &_
								  "</select>" &_
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
								"<span class=""button"" onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "');""><span>Delete</span></span>" &_
							"</td>" &_
						"</tr>" &_
						"<tr class=""userinfo"">" &_
							"<td>&nbsp;</td><td colspan=""6""><span>Entered By: " & TimeDetail.EnteredBy & " Created on: " & TimeDetail.Created & " Last modified: " & TimeDetail.Modified &_
						"</tr>"
'							<input name=""timein[]"" type=""text"" class=""inTimeInput"" value=""" & rs("timein") & """ /></td>" &_
				rs.movenext
			loop
		else
			strResponse = strResponse & replace(inpRowTemplate, "hide", "")
		end if
			
		strResponse = strResponse &_
			"</table>" &_
			"<span class=""add_detail_row button"" href=""javascript:;"" onclick=""timedetail.addRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "');""><span>Add Row</span></span>"
	
		response.write strResponse
	
	set cmd = nothing
	set rs = nothing
	

	response.write "<!-- [split] -->" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId
end function

function objDaySelect (ByVal workday, rowid)
	dim strBuffer
	
	strBuffer = "<select id=""workday_" & rowid & """ name=""workday_" & rowid & """ " &_
		"onchange=""timeclock.setTime(this.id)"" >" &_
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
	current_day = company_weekends - (7 - workday)
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
