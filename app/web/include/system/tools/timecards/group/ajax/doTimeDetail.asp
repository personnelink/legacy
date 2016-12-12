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
		.CreatorId   = user_id
	end with
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")

	dim p_createdby : p_createdby = "H"
	
	with cmd
		.ActiveConnection = MySql
	end with
	
	dim p_total_hours : p_total_hours = getParameter("th")
	if len(p_total_hours) > 0 then
		p_createdby = "P"
		
		cmd.CommandText = "" &_
			"INSERT INTO time_detail (summaryid, creatorId, timetotal, timetype, created, modified, createdby) " &_
				"VALUES (" & TimeDetail.SummaryId & ", " & user_id & ", " & insert_number(p_total_hours) & ", '1', now(), now(), '" &	p_createdby & "');" &_
				"select last_insert_id();"
	else
		cmd.CommandText = "" &_
			"INSERT INTO time_detail (summaryid, creatorId, createdby) VALUES (" &_
				TimeDetail.SummaryId & ", " & user_id & ", '" & p_createdby & "');select last_insert_id();"
	end if
	
	dim rs
	set rs = cmd.execute.nextrecordset
	
	dim detailid
		detailid = rs(0)
	
	REM 'Main input template to be used by client script to create additional table rows later.
			
	dim tmpWorkDay
	if not rs.eof then
		
		'TimeDetail.Workday = rs("workday")
		dim rowid, commentid

		' rowid  = "" &_
			' "tPlacementid_" &_
			' "tSummaryid_" &_
			' "tDetailId_" &_
			' "tWorkday"
			
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
			.CreatorId = cdbl(user_id)
			REM .Modified = rs("modified")
		end with

		i = i + 1

		commentid  = TimeDetail.PlacementId & "_" &_
					TimeDetail.SummaryId & "_" &_
					TimeDetail.DetailId
		
		rowid  = commentid & "_" & TimeDetail.Workday

		totalhours = 0
		
		dim strResponse
		strResponse = "" &_
			"<table id=""span_timedetail" & detailid & """ class=""time_detail hide"">" &_
			"<tr>" &_
				"<td class=""left_margin"">&nbsp;</td>" &_
				"<td class=""weekday"">" &_
					objDaySpan(TimeDetail.Workday, rowid, TimeDetail.CreatorId) &_
				"</td>" &_
				"<td class=""timeinput"">" &_
					"<span class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""span_in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
						"></span>" &_
				"</td>" &_
				"<td class=""timeinput"">" &_	 
					"<span class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""span_out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
						"onchange=""timeclock.setTime(this.id)""></span>" &_
				"</td>" &_
				"<td class=""hourstotal"">" &_
					"<span id=""span_total_" & rowid & """ name=""detailRow_" & rowid & """ " &_
					"class=""hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """>" & TwoDecimals(totalhours)	& "</span></td>" &_
				"<td class=""hourstotal"">" &_
					"<span id=""span_adjusted_" & rowid & """ name=""detailRow_" & rowid & """ " &_
					"class=""hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """" &_
					"></span></td>" &_
				"<td><span>Regular Time</span>" &_
				"</td>" &_
				"<td class=""delete_time_detail"">" &_
					"<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.edit('span_timedetail" & detailid & "');""><span>Edit</span></span>" &_
					"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.commentRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & detailid & "');""><span>Add Note</span></span>" &_
					"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & detailid & "');""><span>Delete</span></span>" &_
				"</td>" &_
			"</tr>" &_
			"<tr class=""userinfo"">" &_
				"<td>&nbsp;</td><td colspan=""7""><div id=""commentrow_" & commentid & """ class=""hide comments""></div><span>Entered By: " & user_firstname & " " & user_lastname & " Created on: " & Now & " Last modified: " & Now & "</span></td>" &_
			"</tr>" &_
			"<table id=""timedetail" & detailid & """ class=""time_detail detailentry"">" &_
			"<tr>" &_
				"<td class=""left_margin"">&nbsp;</td>" &_
				"<td class=""weekday"">" &_
					objDaySelect(TimeDetail.Workday, rowid, TimeDetail.CreatorId) &_
				"</td>" &_
				"<td class=""timeinput"">" &_
					"<input class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
						"onchange=""timeclock.setTime(this.id)"" value="""""">" &_
				"</td>" &_
				"<td class=""timeinput"">" &_	 
					"<input class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
						"onchange=""timeclock.setTime(this.id)"" value="""""">" &_
				"</td>" &_
				"<td class=""hourstotal"">" &_
					"<input id=""total_" & rowid & """ name=""detailRow_" & rowid & """ " &_
					"type=""text"" class=""hoursTimeInput detailtotal cid" & TimeDetail.CreatorId & " sid" & user_id & """ value=""" & TwoDecimals(totalhours)	& """ " &_
					"onchange=""timeclock.setTime(this.id)"" /></td>" &_
				"<td class=""hourstotal"">" &_
					"<input id=""adjusted_" & rowid & """ name=""detailRow_" & rowid & """ " &_
					"type=""text"" class=""detailadjusted hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """ value=""" & TwoDecimals(adjustedhours)	& """ " &_
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
					"<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.save('timedetail" & detailid & "');""><span>Save</span></span>" &_
					"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.commentRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & detailid & "');""><span>Add Note</span></span>" &_
					"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & detailid & "');""><span>Delete</span></span>" &_
				"</td>" &_
			"</tr>" &_
			"<tr class=""userinfo"">" &_
				"<td>&nbsp;</td><td colspan=""7""><div id=""commentrow_" & commentid & """ class=""hide comments""></div><span>Entered By: " & user_firstname & " " & user_lastname & " Created on: " & Now & " Last modified: " & Now & "</span></td>" &_
			"</tr>"
		end if
			
		strResponse = strResponse & "</table>"
	
		if p_createdby = "P" then
			
			'response text for other services, basically return back info that was passed to it
			response.write TimeDetail.PlacementId & ":" & g_strSite & ":" & TimeDetail.SummaryId & ":" & p_total_hours

		else
		
			'response text for group time detail refresh
			response.write strResponse
			response.write "<!-- [split] -->" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId
			
		end if
	
	set cmd = nothing
	set rs = nothing
	set TimeDetail = nothing

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
				"time_summary.emp_submitted, time_summary.paid, time_summary.pp_submitted, time_summary.approved, " &_
				"time_summary.site, time_detail.workday, Time_Format(time_detail.timein, '%H:%i') as timein, " &_
				"Time_Format(time_detail.timeout, '%H:%i') as timeout, " &_
				"time_detail.timetotal, time_detail.adjusted, (ABS(TIME_TO_SEC(TIMEDIFF(timeout, timein)))/60)/60 as hours,  (ABS(TIME_TO_SEC(TIMEDIFF(ADDTIME(timeout, '24:00:00'), timein)))/60)/60 as midnight, time_types.description, time_types.id, " &_
				"time_detail.modified, tbl_users.firstName, tbl_users.lastName, time_detail.created, time_detail.createdby, time_summary.creatorid " &_
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
					"</tr></table>"

						' "<th class=""left_margin"">&nbsp;</th>" &_
						' "<th>Weekday</th>" &_
						' "<th>Time-In</th>" &_
						' "<th>Time-Out</th>" &_
						' "<th>Total</th>" &_
						' "<th>Adjusted</th>" &_
						' "<th>Time Type</th>" &_
						' "<th class=""delete"">&nbsp;</th>" &_
					
			'Main input template to be used by client script to create additional table rows later.
			
			dim tmpWorkDay
			if not rs.eof then
				
				'TimeDetail.Workday = rs("workday")
				dim rowid, commentid

				rowid  = "" &_
					"tPlacementid_" &_
					"tSummaryid_" &_
					"tDetailId_" &_
					"tWorkday"

			dim i
			dim timeIn
			dim timeOut
			dim totalhours
			dim adjustedhours
			dim rsComments
			dim createdby
			dim showOrHide
			
			do until rs.eof
			
				with TimeDetail
					.Workday       = rs("workday")
					.TimeIn        = rs("timein")
					.TimeOut       = rs("timeout")
					.AdjustedTime  = rs("adjusted")
					.DetailId      = rs(3)
					.Site          = rs("site")
					.TimeType      = rs("description")
					.TimeTypeId    = rs(8)
					.EnteredBy     = rs("firstName") & " " & rs("lastName") 
					.Created       = rs("created")
					.CreatorId     = rs("creatorid")
					.emp_submitted = rs("emp_submitted")
					.paid          = rs("paid")
					.approved      = rs("approved")
					.pp_submitted  = rs("pp_submitted")
					.Modified      = rs("modified")
				end with

				createdby = lcase(trim(rs("createdby")))
				adjustedhours = TimeDetail.AdjustedTime
				
				if isnull(adjustedhours) then adjustedhours=0
				i = i + 1

				commentid  = TimeDetail.PlacementId & "_" &_
							TimeDetail.SummaryId & "_" &_
							TimeDetail.DetailId
							
				cmd.CommandText = "" & _
				
					"SELECT `comment`, concat(firstname, ' ', lastname) AS commentor_name, time_comments.created " & _
					"FROM time_comments RIGHT JOIN tbl_users ON time_comments.commentor=tbl_users.userid " & _
					"WHERE summaryid=" & insert_number(TimeDetail.SummaryId) & " AND detailid=" & insert_number(TimeDetail.DetailId) & " " & _
					"ORDER By created DESC;"
				
				'print cmd.CommandText
				
				set rsComments = cmd.Execute()
				
				if not rsComments.eof then
					showOrHide = ""
				else
					showOrHide = "hide"
				end if
				
				rowid  = commentid & "_" & TimeDetail.Workday

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
					
		
				if TimeDetail.AdjustedTime > 0 or createdby = "t" then
					disable_input = " disabled=""disabled"" "
				else
					disable_input = ""
				end if
				
				'print "disable? " & disable_input
				'print "disable? " & TimeDetail.TimeType
				
				
				if totalhours < 0 then totalhours = totalhours*-1
				'start read only
				strResponse = strResponse &_
					"<table id=""span_timedetail" & TimeDetail.DetailId & """ class=""time_detail "">" &_
						"<tr>" &_
							"<th>&nbsp;</th>" &_
							"<th>Weekday</th>" &_
							"<th>Time-In</th>" &_
							"<th>Time-Out</th>" &_
							"<th>Total</th>" &_
							"<th>Adjusted</th>" &_
							"<th>Time Type</th>" &_
							"<th class=""delete"">&nbsp;</th>" &_
						"</tr>" &_
						"<tr>" &_
							"<td class=""left_margin"">&nbsp;</td>" &_
							"<td class=""weekday"">" &_
								objDaySpan(TimeDetail.Workday, rowid, TimeDetail.CreatorId) &_
							"</td>" &_
							"<td class=""timeinput"">" &_
								"<span class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""span_in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									">" & TimeDetail.TimeIn & "</span>" &_
							"</td>" &_
							"<td class=""timeinput"">" &_	 
								"<span class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""span_out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									">" & TimeDetail.TimeOut & "</span>" &_
							"</td>" &_
							"<td class=""hourstotal"">" &_
								"<span id=""span_total_" & rowid & """ name=""detailRow_" & rowid & """ " &_
								"class=""hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """" &_
								">" & TwoDecimals(totalhours) & "</span></td>" &_
							"<td class=""hourstotal"">" &_
								"<span id=""span_adjusted_" & rowid & """ name=""detailRow_" & rowid & """ " &_
								"class=""hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """" &_
								">" & TwoDecimals(adjustedhours) & "</span></td>" &_
							"<td><span  class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""span_type_" & rowid & """ name=""detailRow_" & rowid & """>Regular Time</span>" &_
							"</td>" &_
						"<td class=""delete_time_detail"">"
					if TimeDetail.approval_status = 0 then
						strResponse = strResponse &_			
							"<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.edit('span_timedetail" & TimeDetail.DetailId & "');""><span>Edit</span></span>" &_
							"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.commentRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Add Note</span></span>" &_
							"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Delete</span></span>"
					else
						strResponse = strResponse &_		
							"<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.commentRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Add Note</span></span>"
							
					end if
					

				strResponse = strResponse &_			
					"</td>" &_
						"</tr>" &_
						"<tr class=""userinfo"">" &_
							"<td>&nbsp;</td><td colspan=""7""><div id=""commentrow_" & commentid & """ class=""" & showOrHide & " comments"">" 
								do while not rsComments.eof
									strResponse = strResponse & "<span><i>" & rsComments("comment") & "&nbsp;-&nbsp;" & rsComments("commentor_name") & ", " & rsComments("created") & "</i></span>"
									rsComments.movenext
								loop
							
				strResponse = strResponse & _			
							"<span>Entered By: " & TimeDetail.EnteredBy & " Created on: " & TimeDetail.Created & " Last modified: " & TimeDetail.Modified & "</span></div></td>" &_
						"</tr>" &_
					"</table>" &_
					"" &_
					"<table id=""timedetail" & TimeDetail.DetailId & """ class=""time_detail detailentry hide"">" &_
						"<tr>" &_
							"<th class=""left_margin"">&nbsp;</th>" &_
							"<th>Weekday</th>" &_
							"<th>Time-In</th>" &_
							"<th>Time-Out</th>" &_
							"<th>Total</th>" &_
							"<th>Adjusted</th>" &_
							"<th>Time Type</th>" &_
							"<th class=""delete"">&nbsp;</th>" &_
						"</tr>" &_
						"<tr>" &_
							"<td class=""left_margin"">&nbsp;</td>" &_
							"<td class=""weekday"">" &_
								objDaySelect(TimeDetail.Workday, rowid, TimeDetail.CreatorId) &_
							"</td>" &_
							"<td class=""timeinput"">" &_
								"<input class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""in_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									"onchange=""timeclock.setTime(this.id)"" value=""" & TimeDetail.TimeIn & """>" &_
							"</td>" &_
							"<td class=""timeinput"">" &_	 
								"<input class=""cid" & TimeDetail.CreatorId & " sid" & user_id & """ id=""out_" & rowid & """ name=""detailRow_" & rowid & """ " &_
									"onchange=""timeclock.setTime(this.id)"" value=""" & TimeDetail.TimeOut & """>" &_
							"</td>" &_
							"<td class=""hourstotal"">" &_
								"<input id=""total_" & rowid & """ name=""detailRow_" & rowid & """ " &_
								"type=""text"" class=""detailtotal hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """ value=""" & TwoDecimals(totalhours)	& """ " &_
								"onchange=""timeclock.setTime(this.id)"" " & disable_input & "/></td>" &_
							"<td class=""hourstotal"">" &_
								"<input id=""adjusted_" & rowid & """ name=""detailRow_" & rowid & """ " &_
								"type=""text"" class=""detailadjusted hoursTimeInput cid" & TimeDetail.CreatorId & " sid" & user_id & """ value=""" & TwoDecimals(adjustedhours)	& """ " &_
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
							"<td class=""delete_time_detail"">"
							
						if TimeDetail.approval_status = 0 then
							strResponse = strResponse &_			
								"<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """ onclick=""timedetail.save('timedetail" & TimeDetail.DetailId & "');""><span>Save</span></span>" &_
								"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.commentRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Add Note</span></span>" &_
								"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.deleteRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Delete</span></span>"
						else
							strResponse = strResponse &_			
								"&nbsp;&nbsp;<span class=""button cid" & TimeDetail.CreatorId & " sid" & user_id & """"" onclick=""timedetail.commentRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "', '" & TimeDetail.DetailId & "');""><span>Add Note</span></span>"
						end if
						
						strResponse = strResponse & _			
							"</td>" &_
						"</tr>" &_
						"<tr class=""userinfo"">" &_
							"<td>&nbsp;</td><td colspan=""7""><div id=""commentrow_" & commentid & """ class=""" & showOrHide & " comments"">" 
								do while not rsComments.eof
									strResponse = strResponse & "<span><i>" & rsComments("comment") & "&nbsp;-&nbsp;" & rsComments("commentor_name") & ", " & rsComments("created") & "</i></span>"
									rsComments.movenext
								loop
							
				strResponse = strResponse & _			
							"</div><span>Entered By: " & TimeDetail.EnteredBy & " Created on: " & TimeDetail.Created & " Last modified: " & TimeDetail.Modified & "</span></td>" &_
						"</tr>" &_
					"</table>"
'							<input name=""timein[]"" type=""text"" class=""inTimeInput"" value=""" & rs("timein") & """ /></td>" &_
				rs.movenext
			loop
		else
			'strResponse = strResponse & replace(inpRowTemplate, "hide", "")
		end if
					
		if TimeDetail.approval_status = 0 then
			strResponse = strResponse &_
				"<span class=""add_detail_row button"" href=""javascript:;"" onclick=""timedetail.addRow('plcemntTbl_" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId & "');""><span>Add Time</span></span>"
		end if
		response.write strResponse
	
	set cmd = nothing
	set rs = nothing
	set rsComments = nothing
	

	response.write "<!-- [split] -->" & TimeDetail.PlacementId & "_" & TimeDetail.SummaryId
end function


function objDaySelect (ByVal workday, rowid, creatorid)
	dim strBuffer
	
	strBuffer = "<select id=""workday_" & rowid & """ name=""workday_" & rowid & """ " &_
		"class=""detailday cid" & creatorid & " sid" & user_id & """ onchange=""timeclock.setTime(this.id)"" >" &_
		"<option value=""""> Day: </option>"

	dim i, day_num
	for day_num = 2 to 8
		i = day_num
		if i = 8 then i = 1
		if workday = i then
			strBuffer = strBuffer & "<option value=""" & i & """ selected=""selected"">" & getWorkDayName(i) & "</option>"
		else
			strBuffer = strBuffer & "<option value=""" & i & """>" & getWorkDayName(i) & "</option>"
		end if
	next
	objDaySelect = strBuffer & "</select>"

end function


function objDaySpan (ByVal workday, rowid, creatorid)
	dim strBuffer
	
	strBuffer = "<span id=""span_workday_" & rowid & """ class=""detaildayspan cid" & creatorid & " sid" & user_id & """>" &_
		getWorkDayName(workday)

	objDaySelect = strBuffer & "</span>"

end function


function objDaySpan (ByVal workday, rowid, creatorid)
	dim strBuffer
	
	strBuffer = "<span id=""span_workday_" & rowid & """ name=""workday_" & rowid & """ " &_
		"class=""detailday cid" & creatorid & " sid" & user_id & """ onchange=""timeclock.setTime(this.id)"" >"

	dim i, day_num
	for day_num = 2 to 8
		i = day_num
		if i = 8 then i = 1
		if workday = i then
			strBuffer = strBuffer & getWorkDayName(i)
		end if
	next
	objDaySpan = strBuffer & "</span>"

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
