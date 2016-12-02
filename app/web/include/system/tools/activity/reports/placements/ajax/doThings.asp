<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%

'retrieve site id and make sure it's numeric
dim g_strSite : g_strSite = request.querystring("site")

select case request.querystring("do")
	case "changedisp"
		doChangeDisp
	case "changeappt"
		doChangeAppt

end select

sub doChangeAppt ()
	'on error resume next
	
	'retrieve appointment id
	dim tmpInt
	tmpInt = request.querystring("id")
	if isnumeric(tmpInt) then
		dim AppointmentId
		AppointmentId = cdbl(tmpInt)
	end if
	
	'set the appointment type
	dim theApptType
	Select Case request.querystring("appointment")
		Case "0"
			theApptType = 0 'Initial Interview

		Case "3"
			theApptType = 3 'Other
			
		Case "4"
			theApptType = 4 'Arrival Call

		Case "5"
			theApptType = 5 'Marketing Call

		Case "6"
			theApptType = 6 'Placement Follow-Up

		Case "7"
			theApptType = 7 'Sent Resume

		Case "8"
			theApptType = 8 'Unemployment
			
		Case "9"
			theApptType = 9 'CS Order/Garnishment

		Case "11"
			theApptType = 11 'Collection Call

		Case "12"
			theApptType = 12 'Separation
			
		Case "13"
			theApptType = 13 'Job Order Correspondence

		Case "14"
			theApptType = 14 'Client QA & Correspondence
			
		Case "15"
			theApptType = 15 'Availability

		Case "16"
			theApptType = 16 'Rates

		Case "17"
			theApptType = 17 'Work Comp

		Case "18"
			theApptType = 18 'Accident
			
		Case Else
			response.write AppointmentId
			response.end
	End Select
	
	'set up database connection	and get placement info
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"UPDATE Appointments " &_
			"SET " &_
				"ApptTypeCode=" & theApptType & " " &_
			"WHERE Id=" & AppointmentId & ";"
		.Execute()
	end with
	
	set cmd = nothing

	if Err.number <> 0 then
		response.write AppointmentId & "[:][Err#] " & Err.number
	else
		response.write AppointmentId & "[:]" & "No error"
	end if
end sub

sub doChangeDisp ()
	'on error resume next
	
	'retrieve appointment id
	dim tmpInt
	tmpInt = request.querystring("id")
	if isnumeric(tmpInt) then
		dim AppointmentId
		AppointmentId = cdbl(tmpInt)
	end if
	
	'set the disposition type
	dim theDisposistion, theComment, m_PlacementId
	Select Case request.querystring("disposition")
		Case "0"
			theDisposistion = 0 'Active
			theComment = "New placement follow up."
			
			'make sure placement is open [in case of accidental miss click]
			m_PlacementId = getPlacementViaAppointment(AppointmentId)
			openPlacement(m_PlacementId)

		Case "1"
			theDisposistion = 1 'Re-scheduled staff
			theComment = "New placement follow up [Placement was rescheduled by staff]. Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
			
		Case "2"
			theDisposistion = 2 'Re-secheduled applicant [called-in]
			theComment = "New placement follow up [Applicant rescheduled]. Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"

		Case "3"
			theDisposistion = 3 'Took Place
			theComment = "New placement follow up [Applicant showed up]. Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"

		Case "4"
			theDisposistion = 4 'No Show
			theComment = "New placement follow up [No Showed / No call / Placement closed]. Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
			
			'close the placement
			m_PlacementId = getPlacementViaAppointment(AppointmentId)
			closePlacement(m_PlacementId)
		Case Else
			response.write AppointmentId
			response.end
	End Select
	
	'set up database connection	and get placement info
	dim doQuery_cmd
	set doQuery_cmd = server.CreateObject("ADODB.Command")
	with doQuery_cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"UPDATE Appointments " &_
			"SET " &_
				"DispTypeCode=" & theDisposistion & ", " &_
				"Comment='" & theComment & "' " &_
			"WHERE Id=" & AppointmentId & ";"
	end with

	'set the placement status
	dim doQuery
	doQuery = doQuery_cmd.Execute()
	
	set doQuery = nothing
	set doQuery_cmd = nothing

	if Err.number <> 0 then
		response.write AppointmentId & "[:][Err#] " & Err.number
	else
		response.write AppointmentId & "[:]" & server.HTMLEncode(theComment)
	end if
end sub

function closePlacement(PlacementId)
	if PlacementId > 0 then
		'set need final time card to false since applicant no-showed
		dim blnNeedFinalTime : blnNeedFinalTime = false
		

		'set the placement status
		dim doQuery_cmd
		set doQuery_cmd = server.CreateObject("ADODB.Command")
		with doQuery_cmd
			.ActiveConnection = dsnLessTemps(getTempsDSN(request.querystring("site")))
			.CommandText =	"" &_
				"UPDATE Placements " &_
				"SET " &_
					"PlacementStatus=3, " &_
					"NeedFinalTime=" & blnNeedFinalTime & " " &_
				"WHERE PlacementID=" & PlacementId & ";"
		end with

		dim doQuery
		doQuery = doQuery_cmd.Execute()
		
		set doQuery = nothing
		set doQuery_cmd = nothing
	end if
end function

function openPlacement(PlacementId)
	if PlacementId > 0 then
		'set need final time card to false since applicant no-showed
		dim blnNeedFinalTime : blnNeedFinalTime = false
		

		'set the placement status
		dim doQuery_cmd
		set doQuery_cmd = server.CreateObject("ADODB.Command")
		with doQuery_cmd
			.ActiveConnection = dsnLessTemps(getTempsDSN(request.querystring("site")))
			.CommandText =	"" &_
				"UPDATE Placements " &_
				"SET " &_
					"PlacementStatus=0, " &_
					"NeedFinalTime=" & blnNeedFinalTime & " " &_
				"WHERE PlacementID=" & PlacementId & ";"
		end with

		dim doQuery
		doQuery = doQuery_cmd.Execute()
		
		set doQuery = nothing
		set doQuery_cmd = nothing
	end if
end function

function getPlacementViaAppointment(AppointmentId)
	if AppointmentId > 0 then
		'set up database connection	and get placement info
		dim doQuery_cmd
		set doQuery_cmd = server.CreateObject("ADODB.Command")
		with doQuery_cmd
			.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
			.CommandText =	"" &_
				"SELECT Appointments.Id, Placements.PlacementID, Placements.PlacementStatus " &_
				"FROM Appointments " &_
				"INNER JOIN Placements ON " &_
				"(Appointments.Reference = Placements.Reference) AND " &_
				"(Appointments.Customer = Placements.Customer) AND " &_
				"(Appointments.ApplicantId = Placements.ApplicantId) " &_
				"WHERE (Appointments.Id=" & AppointmentId & " AND Placements.PlacementStatus=0);"
		end with
		dim rsPlacementId
		set rsPlacementId = doQuery_cmd.Execute()
		
		'if placement exists, make an 'appointment'
		
		if not rsPlacementId.eof then
			getPlacementViaAppointment = rsPlacementId("PlacementID")
		end if

		set rsPlacementId = nothing
		set doQuery_cmd = nothing
	end if
end function

%>