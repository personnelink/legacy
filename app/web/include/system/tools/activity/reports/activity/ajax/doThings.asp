<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include file='doLookUp.asp' -->
<!-- #INCLUDE file='search.classes.vb' -->

<%
'-----------------------------------------------------------------
' parameters:
'	do     = view
'	id     = customer code
'	site   = temps site id
'	status = job order status
'
'-----------------------------------------------------------------
'flag to toggle using query string or form post data
dim use_qs
if request.querystring("use_qs") = "1" then
	use_qs = true
else
	use_qs = false
end if

'retrieve site id and make sure it's numeric
dim g_strSite : g_strSite = getParameter("site")

'retrieve site id and make sure it's numeric
dim g_intApptType : g_intApptType = getParameter("apptype")

select case getParameter("do")
	case "change"
		doChange

	case "lookup"
		doLookup

end select

sub doChange ()
	'on error resume next
	
	'retrieve appointment id
	dim tmpInt
	tmpInt = getParameter("id")
	if isnumeric(tmpInt) then
		dim AppointmentId
		AppointmentId = cdbl(tmpInt)
	end if
	
	'set the disposition type
	dim theDisposistion, theComment, m_PlacementId
	Select Case getParameter("disposition")
		Case "0"
			theDisposistion = 0 'Active
			theComment = "New placement follow up."
			if g_intApptType = 4 then
				'make sure placement is open [in case of accidental miss click]
				m_PlacementId = getPlacementViaAppointment(AppointmentId)
				openPlacement(m_PlacementId)
			end if

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
			
			if g_intApptType = 4 then
				'close the placement
				m_PlacementId = getPlacementViaAppointment(AppointmentId)
				closePlacement(m_PlacementId)
			end if
		
		Case Else
			response.write AppointmentId
			response.end
	End Select
	
	'set up database connection	and get placement info
	dim doQuery_cmd
	set doQuery_cmd = server.CreateObject("ADODB.Command")
	with doQuery_cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		
		select case g_intApptType
			case "4" 'New Placement Follow Up ...
				.CommandText =	"" &_
					"UPDATE Appointments " &_
					"SET " &_
						"DispTypeCode=" & theDisposistion & ", " &_
						"Comment='" & theComment & "' " &_
					"WHERE Id=" & AppointmentId & ";"
	
			case else
				.CommandText =	"" &_
					"UPDATE Appointments " &_
					"SET " &_
						"DispTypeCode=" & theDisposistion & " " &_
					"WHERE Id=" & AppointmentId & ";"
		end select
	end with

	'set the placement status
	dim doQuery
	doQuery = doQuery_cmd.Execute()
	
	set doQuery = nothing
	set doQuery_cmd = nothing

	if Err.number <> 0 then
		response.write AppointmentId & " Err# " & Err.number
	else
		response.write AppointmentId
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
			.ActiveConnection = dsnLessTemps(getTempsDSN(getParameter("site")))
			.CommandText =	"" &_
				"UPDATE Placements " &_
				"SET " &_
					"PlacementStatus=3, " &_
					"NeedFinalTime=" & insert_string(blnNeedFinalTime) & " " &_
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
			.ActiveConnection = dsnLessTemps(getTempsDSN(getParameter("site")))
			.CommandText =	"" &_
				"UPDATE Placements " &_
				"SET " &_
					"PlacementStatus=0, " &_
					"NeedFinalTime=" & insert_string(blnNeedFinalTime) & " " &_
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



public function doUpdateAppointment ()
	
	dim customercode : customercode = getParameter("id")
	
	
	if userLevelRequired(userLevelPPlusStaff) then
		dim HiddenCustomer
		set HiddenCustomer = new cTempsAttribute
		with HiddenCustomer
			.site = g_strSite
			.table = "Customers"
			.element = "ETimeCardStyle"
			.newvalue = "86"
			.whereclause = "Customer='" & customercode & "'"
			.update()
		end with
		set HiddenCustomer = nothing
	end if
	
	response.write customercode & " hidden."

end function




function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function


%>