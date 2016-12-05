<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%

select case request.querystring("do")
	case "close"
		doClose

	case "open"
		doOpen
end select

sub doClose ()
	'on error resume next
	
	'retrieve placement id
	dim tmpInt
	tmpInt = request.querystring("id")
	if isnumeric(tmpInt) then
		dim PlacementId
		PlacementId = cdbl(tmpInt)
	end if
	
	'check if final time card is needed
	dim blnNeedFinalTime
	Select Case request.querystring("needfinaltime")
		Case "1"
			blnNeedFinalTime = true
		Case "0"
			blnNeedFinalTime = false
		Case "false"
			blnNeedFinalTime = false
		Case "true"
			blnNeedFinalTime = true
		Case else
			blnNeedFinalTime = false
	End Select
	
	'set up database connection	and get placement info
	dim doQuery_cmd
	set doQuery_cmd = server.CreateObject("ADODB.Command")
	with doQuery_cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(request.querystring("site")))
		.CommandText =	"" &_
			"SELECT Customer, ApplicantId, Reference, PlacementStatus " &_
			"FROM Placements " &_
			"WHERE PlacementID=" & PlacementId
	end with
	dim rsApptInfo
	set rsApptInfo = doQuery_cmd.Execute()
	
	const DispTypeCode = 3 'Disposistion status for 'TookPlace'
	Const ApptType = -5 'System Activity Type for 'Placement'

	'if placement exists, make an 'appointment'
	if not rsApptInfo.eof then
		dim strWhatWasDone : strWhatWasDone = "Changed PID " & PlacementId & " " &_
			"[PlacementStatus] from [" & rsApptInfo("PlacementStatus") & "] to [3] [Closed] " &_
			"by VMS User " & user_name & "(" & Request.ServerVariables("REMOTE_ADDR") & ")"

		doQuery_cmd.CommandText = "" &_
			"INSERT INTO Appointments " &_
				"(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, Customer, Reference, ContactId, Entered, EnteredBy, LocationId)" &_
				"VALUES (" &_
					"'" & Date() & "', " & _
					insert_number(rsApptInfo("ApplicantId")) & ", " &_
					insert_string(strWhatWasDone) & ", " &_
					insert_string("{Anyone}") & ", " &_
					insert_number(ApptType) & ", " &_
					insert_number(DispTypeCode) & ", " &_
					insert_string(rsApptInfo("Customer")) & ", " &_
					insert_number(rsApptInfo("Reference")) & ", 0, " &_
					"'" & Date() & "', " & _
					insert_string("VMS" & user_id) & ", 1" &_
				")"
				
		doQuery = doQuery_cmd.Execute()
	end if
	
	'set the placement status and stop date
	dim strPlacementStopDate
	strPlacementStopDate = request.querystring("we")
	
	if len(strPlacementStopDate) > 0 then
		if IsDate(strPlacementStopDate) then
			strPlacementStopDate = "PStopDate='" & strPlacementStopDate & "', "
		else
			strPlacementStopDate = ""
		end if
	end if
	
	dim doQuery
	doQuery_cmd.CommandText = "" &_
			"UPDATE Placements " &_
			"SET " &_
				"PlacementStatus=3, " &_
				strPlacementStopDate &_
				"NeedFinalTime=" & insert_string(blnNeedFinalTime) & " " &_
			"WHERE PlacementID=" & PlacementId & ""
	doQuery = doQuery_cmd.Execute()
	
	set rsApptInfo = nothing
	set doQuery = nothing
	set doQuery_cmd = nothing
	
	call sendEmailNotice(PlacementId, "closed")
	
	if Err.number <> 0 then
		response.write PlacementId & " Err# " & Err.number
	else
		response.write PlacementId
	end if
end sub

sub doOpen ()
	'on error resume next
	
	'retrieve placement id
	dim tmpInt
	tmpInt = request.querystring("id")
	if isnumeric(tmpInt) then
		dim PlacementId
		PlacementId = cint(tmpInt)
	end if
	
	'set need final time card to false since placement is being opened
	dim blnNeedFinalTime : blnNeedFinalTime = false
	
	'set up database connection	and get placement info
	dim doQuery_cmd
	set doQuery_cmd = server.CreateObject("ADODB.Command")
	with doQuery_cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(request.querystring("site")))
		.CommandText =	"" &_
			"SELECT Customer, ApplicantId, Reference, PlacementStatus " &_
			"FROM Placements " &_
			"WHERE PlacementID=" & PlacementId
	end with
	dim rsApptInfo
	set rsApptInfo = doQuery_cmd.Execute()
	
	const DispTypeCode = 3 'Disposistion status for 'TookPlace'
	Const ApptType = -5 'System Activity Type for 'Placement'

	'if placement exists, make an 'appointment'
	if not rsApptInfo.eof then
		dim strWhatWasDone : strWhatWasDone = "Changed PID " & PlacementId & " " &_
			"[PlacementStatus] from [" & rsApptInfo("PlacementStatus") & "] to [0] [Active] " &_
			"by VMS User " & user_name & "(" & Request.ServerVariables("REMOTE_ADDR") & ")"

		doQuery_cmd.CommandText = "" &_
			"INSERT INTO Appointments " &_
				"(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, Customer, Reference, ContactId, Entered, EnteredBy, LocationId)" &_
				"VALUES (" &_
					"'" & Date() & "', " & _
					insert_number(rsApptInfo("ApplicantId")) & ", " &_
					insert_string(strWhatWasDone) & ", " &_
					insert_string("{Anyone}") & ", " &_
					insert_number(ApptType) & ", " &_
					insert_number(DispTypeCode) & ", " &_
					insert_string(rsApptInfo("Customer")) & ", " &_
					insert_number(rsApptInfo("Reference")) & ", 0, " &_
					"'" & Date() & "', " & _
					insert_string("VMS" & user_id) & ", 1" &_
				")"
				
		doQuery = doQuery_cmd.Execute()
	end if
	
	'set the placement status
	dim doQuery
	doQuery_cmd.CommandText = "" &_
			"UPDATE Placements " &_
			"SET " &_
				"PlacementStatus=0, " &_
				"NeedFinalTime=" & insert_string(blnNeedFinalTime) & " " &_
			"WHERE PlacementID=" & PlacementId & ""
	doQuery = doQuery_cmd.Execute()
	
	set rsApptInfo = nothing
	set doQuery = nothing
	set doQuery_cmd = nothing

	call sendEmailNotice(PlacementId, "opened")
	
	if Err.number <> 0 then
		response.write PlacementId & " Err# " & Err.number
	else
		response.write PlacementId
	end if
end sub

public function sendEmailNotice(placementid, status)
dim g_strSite
	g_strSite = request.querystring("site") 

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText = "" &_
			"SELECT Customers.CustomerName, Applicants.LastnameFirst, Applicants.ApplicantID, Orders.JobDescription, " &_
				"Orders.Reference " &_
			"FROM Applicants " &_
				"RIGHT JOIN (Customers RIGHT JOIN (Orders RIGHT JOIN Placements ON Orders.Reference = Placements.Reference) ON Customers.Customer = Placements.Customer) ON Applicants.ApplicantID = Placements.ApplicantId " &_
			"WHERE PlacementID=" & placementid
	end with
		
	dim indenter : indenter = "<br>----&nbsp;"
	
	dim rs, empinfo
	set rs = cmd.Execute()
	
	'print cmd.CommandText
	
	if not rs.eof then

		dim employeeName : employeeName = rs("LastnameFirst")
				
		empinfo = "" &_
				"Placement for " & employeeName & " (id:" & rs("ApplicantID") & ") at " & rs("CustomerName") & " - " & rs("JobDescription") &_
				", was " & status & " by " & user_firstname & " " & user_lastname & " at " & Now() & ".<br><br>For more information follow this link: https://www.personnelinc.com/include/system/tools/activity/forms/maintainApplicant.asp?where=" & g_strSite & "&who=" & rs("ApplicantID") & "&action=review"
	end if	

	'create email to internal
	dim sendToEmail
	select case g_strSite
		case "PER"
			sendToEmail = "twin@personnel.com"
		case "BUR"
			sendToEmail = "burley@personnel.com"
		case "BOI"
			sendToEmail = "boise@personnel.com;nampa@personnel.com"
		case "POC"
			sendToEmail = "pocatello@personnel.com;burley@personnel.com"
		case "WYO"
			sendToEmail = "wyoming@personnel.com"
		case "IDA"
			sendToEmail = "twin@personnel.com;burley@personnel.com;boise@personnel.com;nampa@personnel.com;pocatello@personnel.com"
		case "ORE"
			sendToEmail = "burley@personnel.com"
		case "PPI"
			sendToEmail = "twin@personnel.com;burley@personnel.com;boise@personnel.com;nampa@personnel.com;pocatello@personnel.com"
	end select
	
	dim eSubject : eSubject = "Placement " & status & " for " & employeeName & " by " & user_firstname & " " & user_lastname & " @ " & Now()
	dim eBody : eBody = empinfo
	
	Call SendEmail ("Employee Placement Activity<" & sendToEmail & ">;", timeclock_email, eSubject, "<send_as_html>" & eBody, "")

	set rs = nothing
	set cmd = nothing
	
end function


%>