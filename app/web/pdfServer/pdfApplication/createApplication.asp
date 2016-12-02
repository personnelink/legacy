<%Option Explicit%>
<%
session("add_css") = "submitapplication.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff

dim debug_mode
if request.queryString("debug") = "1" then debug_mode = true

dim rpcMode
dim remotePath
select case lcase(request.ServerVariables("SERVER_NAME"))
	case "nampa.rpc.personnelplus.net"
		rpcMode = true
		remotePath = "Z:\Network Storage\Attached\"

	case "burley.rpc.personnelplus.net"
		rpcMode = true
		remotePath = "Z:\Network Storage\Attached\"

	case "boise.rpc.personnelplus.net"
		rpcMode = true
		remotePath = "Z:\Network Storage\Attached\"

	case "twin.rpc.personnelplus.net"
		rpcMode = true
		remotePath = "Z:\Network Storage\Attached\"

	case "home.rpc.personnelplus.net"
		rpcMode = true
		remotePath = "Z:\Network Storage\Attached\"

	case "pocatello.rpc.personnelplus.net"
		rpcMode = true
		remotePath = "Z:\Network Storage\Attached\"

	case else
		rpcMode = false
		remotePath = ""

end select

dim isservice
if request.queryString("isservice") = "true" then isservice = true

dim responseHTML 'service response text

if request.QueryString("action") = "review" or request.querystring("action") = "inject" or request.queryString("update") = "1" or isservice then
	Session("no_header") = true
end if

%>
<!-- #include virtual='/include/core/init_secure_session.asp' -->
<!-- #include file='createApplication.do.asp' -->
<%

dim cmd
Set cmd = Server.CreateObject("ADODB.Command")

dim rs

dim CurrentApplication
set CurrentApplication = new cApplication

CurrentApplication.ApplicationId = Request.Form("appID")
If CurrentApplication.ApplicationId = "" Then
	CurrentApplication.ApplicationId = Request.QueryString("appID")
End If

'On Error Resume Next

if isservice then response.write "<!-- [AppId:" & CurrentApplication.ApplicationId & "] -->"

CurrentApplication.LoadApplication()

dim NewEnrollment
set NewEnrollment = new cEnrollment

NewEnrollment.LoadNewEnrollmentData(CurrentApplication)

On Error Goto 0

dim whatToDo
whatToDo = Request.QueryString("action")

dim maintain_enrollment_lnk

If whatToDo = "review" Then

	viewApplication ""

ElseIf whatToDo = "inject" Then
	dim qsCompany
	qsCompany = Request.QueryString("company")

	'update all enrollments except those set in QS [to avoid duplcation]
	dim Enrollment, dontInject
	dontInject = false

	for each Enrollment in CurrentApplication.Enrollments.Items
		if Enrollment.CompCode = qsCompany then dontInject = true 'suppress reupdating
		CurrentApplication.WhichCompany = Enrollment.CompCode
		Enrollment.LoadExistingEnrollment()
		InjectIntoTemps
	next

	'creates a new enrollment and updates if already exists
	if len(qsCompany) > 0 and not dontInject then
		CurrentApplication.WhichCompany = qsCompany
		InjectIntoTemps
	end if

	if not isservice then
		'running in compatibility mode, redirect to 'view applications' tool
		session("no_header") = false
		Response.Redirect("/include/system/tools/activity/applications/view/")
	else
		if debug_mode then print "Running as service: sending responseHTML"
		'run as a service, sent resonse html text
		if len(responseHTML) > 0 then
			dim name_length, name_start, start_txt, end_txt 'detect and set page_title if an update
			start_txt = "<th>Applicant Name:&nbsp;</th><td>"
			end_txt = "</td></tr><tr><th>"
			name_start = instr(responseHTML, start_txt)
			if name_start > 0 then
				name_start = name_start + len(start_txt) 'offset for search txt
				name_length =  instr(name_start, responseHTML, end_txt) - name_start
				dim page_title
				if instr(responseHTML, "already exists in system") > 0 then
					page_title = "Update:&nbsp;" & mid(responseHTML, name_start, name_length) & "?"
				else
					page_title = mid(responseHTML, name_start, name_length) & " - Enrolled"
				end if
			end if
			response.write(responseHTML)
		end if
	end If
end if

dim attached_stub_directory
Sub InjectIntoTemps

	' Error handling variables
	dim cmdGetSkill, rsMissingSkill
	Set cmdGetSkill = Server.CreateObject("ADODB.Command")
	dim msgSubject, msgBody, blnSendEmail, vbErrNumber

	if debug_mode then print "Running as service: Starting 'Inject'"

	dim insertInfo, name_link, id_link
	Dim sqlApplicant, sqlPR3MSTR, sqlNotesApplicants, sqlAttachment,  i, EmployeeCode
	Dim Skill, skillsArray, insertionStatus, getExistingNote

	'set debug flag'
	Dim debugMode, debugText
	debugMode = cbool(Request.QueryString("debug"))
	if debugMode then debugText = "&debug=1"

	attached_stub_directory = lcase(CurrentApplication.WhichCompany) & "\"

	dim UserNumeric9
	If CurrentApplication.WorkValidLicense = "y" Then UserNumeric9 = -1 Else UserNumeric9 = 0

	CurrentApplication.ApplicantNote = "%date%......APPLIED IN %city%" & Chr(13) & Chr(13) &_
		 "Minimum Wage Accepted:	%wage%" & Chr(13) &_
		 "Worked for other Temp Services: {}" & Chr(13) &_
		 "    If yes, list services: {}" & Chr(13) &_
		 "Interviewed By: {}" & Chr(13) &_
		 Chr(13) &  Chr(13) &_
		 "Work History Verification:"
		CurrentApplication.ApplicantNote = Replace(CurrentApplication.ApplicantNote, "%date%", Date())
		CurrentApplication.ApplicantNote = Replace(CurrentApplication.ApplicantNote, "%city%", CurrentApplication.City)
		CurrentApplication.ApplicantNote = Replace(CurrentApplication.ApplicantNote, "%wage%", CurrentApplication.MinWageAmount)
		CurrentApplication.ApplicantNote = CurrentApplication.ApplicantNote & vbCrLf & CurrentApplication.EmployerNameHistOne &_
			vbCrLf & CurrentApplication.EmployerNameHistTwo &_
			vbCrLf & CurrentApplication.EmployerNameHistThree

	'Routine to build sql to insert a new record
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(CurrentApplication.WhichCompany))
		.CommandText = "Select SSNumber, ApplicantID FROM Applicants WHERE SSNumber='" & CurrentApplication.SSN & "'"
	end with

	dim rs
	set rs = cmd.Execute()
	if rs.eof Then
		do
			If i = 0 Then
				EmployeeCode = Ucase(Left(CurrentApplication.Lastname, 3)) & Right(CurrentApplication.SSN, 3)
			Else
				EmployeeCode = Left(EmployeeCode, 5) & Chr(65 + i)
			End If

			cmd.CommandText = "Select EmployeeNumber FROM Applicants WHERE EmployeeNumber='" & EmployeeCode & "'"
			set rs = cmd.Execute()
			i = i + 1
		Loop Until rs.EOF

		cmd.CommandText = "SELECT Max(Applicants.ApplicantID) + 1 As MaxApplicantID FROM Applicants"
		set rs = cmd.Execute()
		CurrentApplication.ApplicantId = rs("MaxApplicantID")
		NewEnrollment.ApplicantId = CurrentApplication.ApplicantId

		sqlApplicant = "INSERT INTO Applicants ([LastnameFirst], [Address], [City], [State], [Zip], [ApplicantStatus], [ApplicantID], " &_
				"[Telephone], [2ndTelephone], [ShortMemo], [EntryDate], [DateAvailable], [k], [AppChangedBy], [AppChangedDate], [EmployeeNumber], " &_
				"[EmailAddress], [SSNumber], [Sex], [MaritalStatus], [TaxJurisdiction], [UserNumeric9]) VALUES (" &_
				insert_string(CurrentApplication.LastNameFirst) & ", " &_
				insert_string(CurrentApplication.Address) & ", " &_
				insert_string(CurrentApplication.City) & ", " &_
				insert_string(CurrentApplication.State) & ", " &_
				insert_string(CurrentApplication.Zip) & ", " &_
				"1, " &	CurrentApplication.ApplicantId & ", " &_
				insert_string(CurrentApplication.Telephone) & ", " &_
				insert_string(CurrentApplication.AltTelephone) & ", " &_
				"'Active', " &_
				"'" & Now() & "', " &_
				insert_string(Date()) & ", " &_
				insert_string(CurrentApplication.SkillsSet) & ", " &_
				insert_string("V-" & user_id) & ", " &_
				"'" & Now() & "', " &_
				insert_string(EmployeeCode) & ", " &_
				insert_string(CurrentApplication.EmailAddress) & ", " &_
				insert_string(CurrentApplication.SSN) & ", " &_
				insert_string(Ucase(CurrentApplication.Sex)) & ", " &_
				insert_string(Ucase(CurrentApplication.MaritalStatus)) & ", 'ID', " &_
				UserNumeric9 & ")"

		sqlPR3MSTR = "INSERT INTO PR3MSTR ([EmployeeNumber], [Birthdate], [Sex], [DateHired], [MaritalStatus], [ActivityStatus], " &_
				"[FedExemptions], [StateExemptions], [FederalTaxPackageId], " &_
				"[EmpChangedBy], [EmpChangedDate], [TaxJurisdictionTaxPackageId], [TaxJurisdiction], [ApplicantID]) " &_
				"VALUES ('" & EmployeeCode & "', " &_
				"'" & CurrentApplication.DOB & "', '" &_
				Ucase(CurrentApplication.Sex) & "', " &_
				 "'"& Now() & "',  '"&_
				Ucase(CurrentApplication.MaritalStatus) & "', 'A', " &_
				insert_number(CurrentApplication.W4FilingTotal) & ", " &_
				insert_number(CurrentApplication.W4FilingTotal) & ", 1, " &_
				"'V-" & user_id & "', " &_
				"'" & Now() & "', 3, " &_
				"'ID', " &_
				CurrentApplication.ApplicantId & ")"

		cmd.CommandText = "Select Notes FROM NotesApplicants WHERE ApplicantID=" & CurrentApplication.ApplicantId
		set rs = cmd.Execute()
		If rs.EOF Then
			sqlNotesApplicants = "INSERT INTO NotesApplicants (ApplicantID, Notes) VALUES (" & CurrentApplication.ApplicantId & ", '" &	CurrentApplication.ApplicantNote & "')"
		End If
	'Existing Applicant and user has chosen to update applicant's information and status
	' Legacy for Pre-Change logging ... ElseIf Request.QueryString("update") = "1" Then
	else
		cmd.CommandText = "" &_
			"SELECT ApplicantID, EmployeeNumber " &_
			"FROM Applicants " &_
			"WHERE SSNumber='" & CurrentApplication.SSN & "'"
		Set rs = cmd.Execute()
		CurrentApplication.ApplicantId = rs("ApplicantID")
		EmployeeCode = rs("EmployeeNumber")

		If isnull(EmployeeCode) or len(EmployeeCode) = 0 then
			Do
				If i = 0 Then
					EmployeeCode = Ucase(Left(CurrentApplication.Lastname, 3)) & Right(CurrentApplication.SSN, 3)
				Else
					EmployeeCode = Left(EmployeeCode, 5) & Chr(65 + i)
				End If

				'Select Applicants.EmployeeNumber FROM Applicants WHERE EmployeeNumber='" & EmployeeCode & "'"
				cmd.CommandText = "" &_
					"SELECT Applicants.[LastnameFirst], Applicants.[EmployeeNumber], PR3MSTR.[EmployeeNumber] " &_
					"FROM PR3MSTR RIGHT JOIN Applicants ON PR3MSTR.[EmployeeNumber] = Applicants.[EmployeeNumber] " &_
					"WHERE Applicants.[EmployeeNumber] = '" & EmployeeCode & "' OR PR3MSTR.[EmployeeNumber] = '" & EmployeeCode & "';"

				set rs = cmd.Execute()
				i = i + 1
			Loop Until rs.EOF

			cmd.CommandText = "UPDATE Applicants SET EmployeeNumber=" & insert_string(EmployeeCode) & "WHERE ApplicantID=" & CurrentApplication.ApplicantId
			Set rs = cmd.Execute()
			Set rs = Nothing
		end if

		select case VarType(Enrollment)
		case 9
			'iterating companies, can use Enrollment

		case 0
			'company specified, need to create enrollment object
			dim Enrollment
			set Enrollment = new cEnrollment
			with Enrollment
				.SiteId = getTempsDSN(CurrentApplication.WhichCompany)
				.ApplicantId = CurrentApplication.ApplicantId
			end with
			Enrollment.LoadExistingEnrollment()

		case else
			break VarType(Enrollment)
		end select

		dim whatChanged
		whatChanged = findChanges(Enrollment, NewEnrollment)

		InsertUpdateActivity CurrentApplication.ApplicantId, CurrentApplication.LastNameFirst, CurrentApplication.WhichCompany

		if len(CurrentApplication.Address) > 30 then CurrentApplication.Address = left(CurrentApplication.Address, 30) 'truncate address if too long
		sqlApplicant = "UPDATE Applicants SET " &_
			"[LastnameFirst]=" & insert_string(CurrentApplication.LastNameFirst) & ", " &_
			"[Address]=" & insert_string(CurrentApplication.Address) & ", " &_
			"[City]=" & insert_string(CurrentApplication.City) & ", " &_
			"[State]=" & insert_string(CurrentApplication.State) & ", " &_
			"[Zip]=" & insert_string(CurrentApplication.Zip) & ", " &_
			"[ApplicantStatus]=1, " &_
			"[Telephone]=" & insert_string(CurrentApplication.Telephone) & ", " &_
			"[2ndTelephone]=" & insert_string(CurrentApplication.AltTelephone) & ", " &_
			"[ShortMemo]='Active', " &_
			"[DateAvailable]='" & Now() & "', " &_
			"[k]=" & insert_string(CurrentApplication.SkillsSet) & ", " &_
			"[AppChangedBy]='V-" & user_id & "', " &_
			"[AppChangedDate]='" & Now() & "', " &_
			"[EmailAddress]=" & insert_string(CurrentApplication.EmailAddress) & ", " &_
			"[TaxJurisdiction]='ID', " &_
			"[MaritalStatus]=" & insert_string(Ucase(CurrentApplication.MaritalStatus)) & " " &_
			"WHERE [ApplicantID]=" & CurrentApplication.ApplicantId

		cmd.CommandText = "" &_
			"Select ApplicantID " &_
			"FROM PR3MSTR " &_
			"WHERE ApplicantID=" & CurrentApplication.ApplicantId
		Set rs = cmd.Execute()
		If rs.EOF Then

			sqlPR3MSTR = "INSERT INTO PR3MSTR (EmployeeNumber, Birthdate, Sex, DateHired, MaritalStatus, ActivityStatus, " &_
				"FedExemptions, StateExemptions, EmpChangedBy, EmpChangedDate, " &_
				"TaxJurisdictionTaxPackageId, FederalTaxPackageId, ApplicantID) VALUES ('" & EmployeeCode & "', " &_
				"'" & CurrentApplication.DOB & "', '" &_
				Ucase(CurrentApplication.Sex) & "', " &_
				"'" & Now() & "', '" &_
				Ucase(CurrentApplication.MaritalStatus) & "', 'A', " &_
				insert_number(CurrentApplication.W4FilingTotal) & ", " &_
				insert_number(CurrentApplication.W4FilingTotal) & ", " &_
				"'V-" & user_id & "', " &_
				"'" & Now() & "', 3, 1, " &_
				CurrentApplication.ApplicantId & ")"
		Else
			sqlPR3MSTR = "UPDATE PR3MSTR SET " &_
				"DateHired='" & Now() & "', " &_
				"Birthdate='" & CurrentApplication.DOB & "', " &_
				"MaritalStatus='" & Ucase(CurrentApplication.MaritalStatus) & "', " &_
				"EmpChangedBy='V-" & user_id & "', " &_
				"EmpChangedDate='" & Now() & "', " &_
				"StateExemptions=" & insert_number(CurrentApplication.W4FilingTotal) & ", " &_
				"FedExemptions=" & insert_number(CurrentApplication.W4FilingTotal) & ", " &_
				"TaxJurisdictionTaxPackageId=3, " &_
				"FederalTaxPackageId=1 " &_
				"WHERE ApplicantID=" & CurrentApplication.ApplicantId
		End If

		Set rs = Nothing

		cmd.CommandText = "" &_
			"Select ApplicantID " &_
			"FROM NotesApplicants " &_
			"WHERE ApplicantID=" & CurrentApplication.ApplicantId
		Set rs = cmd.Execute()
		if rs.EOF Then
			sqlNotesApplicants = "INSERT INTO NotesApplicants (ApplicantID, Notes) VALUES (" & CurrentApplication.ApplicantId & ", '" &	CurrentApplication.ApplicantNote & "')"
		else
			cmd.CommandText = "" &_
			"SELECT Notes " &_
			"FROM NotesApplicants " &_
			"WHERE ApplicantID=" & CurrentApplication.ApplicantId

			set rs = cmd.Execute()
			dim chk_if
			chk_if = rs("Notes")
			if instr(chk_if, "Valid ID and/or DL:{") = 0 then
				CurrentApplication.ApplicantNote = Replace(chk_if, "'", "''") & Chr(13) & CurrentApplication.ApplicantNote
				sqlNotesApplicants = "UPDATE NotesApplicants SET Notes='" & CurrentApplication.ApplicantNote & "' WHERE ApplicantID="& CurrentApplication.ApplicantId
			end if
		end If
		insertionStatus =  "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td>Applicant Enrollment Information Updated</b>.</td></tr>"
	end if

	Database.Open MySql

	If CurrentApplication.ApplicantId > 0 Then
		Database.Execute "UPDATE tbl_applications SET in" & CurrentApplication.WhichCompany & "=" & CurrentApplication.ApplicantId & ", lastInserted=Now() WHERE applicationID=" & CurrentApplication.ApplicationId

	Else
		Database.Execute "UPDATE tbl_applications SET in" & CurrentApplication.WhichCompany & "=null WHERE applicationID=" & CurrentApplication.ApplicationId
	End If
	Database.Close

	'Applicant exisits, present option to update information
	REM Else
		REM dim tmpAplicantId
		REM tmpAplicantId = rs("ApplicantID")
		REM id_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & CurrentApplication.WhichCompany & "&who=" & tmpAplicantId & """>" & tmpAplicantId & "</a>"

		REM if isservice then
			REM 'use ajax style link
			REM insertionStatus =   "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td>Applicant [id: " & id_link & " ] already exists in system...</td>" &_
				REM "</tr><tr><th>&nbsp;</th><td><div class=" & Chr(34) & "alignL" & Chr(34) & " style=" & Chr(34) & "padding:10px 0 10px 0;" &_
				REM Chr(34) & "> <a class=" & Chr(34) & "squarebutton" & Chr(34) & " href=""javascript:;"" onclick=""action.inject('appID=" &_
				REM CurrentApplication.ApplicationId & "&action=inject&update=1&company=" & CurrentApplication.WhichCompany & debugText & "')"" style=" &_
				REM Chr(34) & "margin-left: 6px" & Chr(34) & "><span>Update Enrollment?</span></a></div></td></tr>"
		REM else
			REM 'use legacy style link
			REM insertionStatus =   "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td>Applicant [id: " & id_link & " ] already exists in system...</td>" &_
				REM "</tr><tr><th>&nbsp;</th><td><div class=" & Chr(34) & "alignL" & Chr(34) & " style=" & Chr(34) & "padding:10px 0 10px 0;" &_
				REM Chr(34) & "> <a class=" & Chr(34) & "squarebutton" & Chr(34) & " href=" & Chr(34) & "/" &_
				REM "pdfServer/pdfApplication/createApplication.asp?appID=" & CurrentApplication.ApplicationId & "&action=inject&update=1&company=" & CurrentApplication.WhichCompany & debugText & Chr(34) & " style=" &_
				REM Chr(34) & "margin-left: 6px" & Chr(34) & "><span>Update Enrollment?</span></a></div></td></tr>"
		REM end if
	REM end If

	'Modify Temps Database
	If Len(sqlApplicant) >0 Then
		If debugMode Then Response.Write(sqlApplicant & "<br><br>")

		cmd.CommandText = replace(sqlApplicant, "Null", "''")
		'print sqlApplicant

		cmd.Execute()

		cmd.CommandText = "" &_
			"INSERT INTO Attachments (ApplicantID, Reference, DescriptionOfFile, OriginalName, Extension, [By], [On], Source) VALUES (" &_
			CurrentApplication.ApplicantId & ", " &_
			Session.SessionID & ", " &_
			"'Application', " &_
			"'" & CurrentApplication.LastNameFirst & "', " &_
			"'" & CurrentApplication.WhichCompany & "', " &_
			"'" & user_id & "', '" &_
			Now() & "', " &_
			"1)"
		cmd.Execute(sqlAttachment)
		viewApplication "attach"
	End If

	If Len(sqlPR3MSTR) >0 Then
		If debugMode Then Response.Write(sqlPR3MSTR & "<br><br>")

		'print sqlPR3MSTR
		cmd.CommandText = replace(sqlPR3MSTR, "Null", "''")
		cmd.Execute()
	End If

	If Len(sqlNotesApplicants) >0 Then
		If debugMode Then Response.Write(sqlNotesApplicants & "<br><br>")
		cmd.CommandText = sqlNotesApplicants
		cmd.Execute()
	End If

	If CurrentApplication.ApplicantID > 0 Then
		If len(CurrentApplication.SkillsSet & "") > 0 Then skillsArray = Split(CurrentApplication.SkillsSet, ".")

		for each Skill In skillsArray
			'iterate skill
			on error resume next
			If Len(Skill & "") > 0 AND IsNumeric(Skill) Then
				cmd.CommandText = "" &_
					"Select ApplicantId " &_
					"FROM KeysApplicants " &_
					"WHERE ApplicantId=" & CurrentApplication.ApplicantId & " AND KeywordId=" & Skill
				set rs = cmd.Execute()
				if rs.EOF Then
					cmd.CommandText = "" &_
						"INSERT INTO KeysApplicants (ApplicantID, KeywordId) " &_
						"VALUES (" & CurrentApplication.ApplicantId & ", " & Skill & ")"
					cmd.Execute()
				end if
			end if

			' Error Handler
			If Err.Number <> 0 Then
				' Set flag to trigger email
				blnSendEmail = true
				vbErrNumber = Err.Number

				On Error Goto 0
				' Code to cope with the error here
				' Query missing skill information

				with cmdGetSkill
					.ActiveConnection = MySql
					.CommandText = "" &_
						"SELECT * FROM pplusvms.list_skills_import " &_
						"WHERE keywordid = '" & Skill & "';"
				end with
				set rsMissingSkill = cmdGetSkill.Execute()

				do while not rsMissingSkill.eof
					msgBody = msgBody & "    " & rsMissingSkill("keywordid") & "  |  " & rsMissingSkill("skill") & "  |  " & rsMissingSkill("tempskeyword") & vbCrLf &_

					rsMissingSkill.movenext
				loop

				Err.clear()

			End If

		next

		if blnSendEmail then

			' Compose email
			msgSubject = "Enrollment error (" & vbErrNumber & "),(" & CurrentApplication.WhichCompany & ") branch missing skills keyword"
			msgBody = "" &_
				"Enrollment error (" & vbErrNumber & "), branch missing skills keyword." & vbCrLf & vbCrLf &_
				"The following skill(s) are missing from Temps branch id (" & CurrentApplication.WhichCompany & "):" & vbCrLf &_
				"    TempsID  |  VMS Skill Keyword | Temps Skill Keyword" & vbCrLf &_
				"   -----------------------------------------------------------------" & vbCrLf &_
				msgBody & vbCrLf &_
				"This was most likely caused by a keyword being dropped or added in Temps manually." & vbCrLf & vbCrLf &_
				"Please notify your local IT personnel for assistance fixing the missing keyword ID's in Temps."

			' Send email
			Call SendEmail (managers_email, notify_managers_email, msgSubject, msgBody, "")

		end if

	End If

	' <%=decorateTop("doneInsertingApp", "notToShort", "Applicant Application Information")
	'<div id="whatWasInserted">

	name_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & CurrentApplication.WhichCompany & "&who=" & CurrentApplication.ApplicantId & """>" & CurrentApplication.LastNameFirst & "</a>"

	id_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" &_
		CurrentApplication.WhichCompany & "&who=" & CurrentApplication.ApplicantId &_
		""">" & CurrentApplication.WhichCompany & " : " & CurrentApplication.ApplicantId & "</a>"

	'tweak verbiage based on update status
	dim close_link : close_link = "<span class=""close_link"" onclick=""action.close();"">[ close ]</span>"
	if instr(insertionStatus, "Applicant Enrollment Information Updated") > 0 then
		if len(responseHTML) > 0 then
			responseHTML = replace(responseHTML, "<tr><th>Enrolled In: </th><td>", "<tr><th>Enrolled In: </th><td>"	& CurrentApplication.WhichCompany & ", ")

			responseHTML = replace(responseHTML, "<tr><th>Applicant ID:&nbsp;</th><td>", "<tr><th>Applicant ID:&nbsp;</th><td>"	& id_link & ", ")
		else
		insertInfo = close_link & "<p><span style=""color:red;"">Existing enrollment found</span>. Applicant information has been updated. Review applicants information for accuracy.</p><p>Below is some of the applicants identifying information that was used:</p>" &_
			"<table style=""margin-top:0.6em;"">" &_
			"<tr><th>Enrolled In: </th><td>" & CurrentApplication.WhichCompany & "</td></tr>" &_
			"<tr><th>Email Address:&nbsp;</th><td>" & CurrentApplication.EmailAddress & "</td></tr>" &_
			"<tr><th>Applicant Name:&nbsp;</th><td>" & CurrentApplication.LastNameFirst & "</td></tr>" &_
			"<tr><th>Applicant ID:&nbsp;</th><td>" & id_link & "</td></tr>" &_
			"<tr><th>Phone:&nbsp;</th><td>" & CurrentApplication.TelePhone & " " & CurrentApplication.AltTelephone & "</td></tr>" &_
			"<tr><th>Address:&nbsp;</th><td>" & CurrentApplication.Address & "</td></tr>" &_
			"<tr><th></th><td>" & CurrentApplication.City & ", " & CurrentApplication.State & " " & CurrentApplication.Zip & "</td></tr>" &_
			insertionStatus &_
			"</table>"
		end if
	else
		insertInfo = close_link & "<p>Applicant has been enrolled. Review applicants information for accuracy.</p>" &_
			"<p>Below is some of the applicants identifying information that was used:</p>" &_
			"<table style=""margin-top:0.6em;"">" &_
			"<tr><th>Email Address:&nbsp;</th><td>" & CurrentApplication.EmailAddress & "</td></tr>" &_
			"<tr><th>Applicant Name:&nbsp;</th><td>" & CurrentApplication.LastNameFirst & "</td></tr>" &_
			"<tr><th>Applicant ID:&nbsp;</th><td>" & id_link & "</td></tr>" &_
			"<tr><th>Phone:&nbsp;</th><td>" & CurrentApplication.Telephone & " " & CurrentApplication.AltTelephone & "</td></tr>" &_
			"<tr><th>Address:&nbsp;</th><td>" & CurrentApplication.Address & "</td></tr>" &_
			"<tr><th></th><td>" & CurrentApplication.City & ", " & CurrentApplication.State & " " & CurrentApplication.Zip & "</td></tr>" &_
			insertionStatus &_
			"</table>"
	end if

	if not isservice then
		'legacy mode
		insertInfo = "<div id=""whatWasInserted"">" & insertInfo & "</div>"
	end if

	if debug_mode then print "Running as service: Completing 'Inject'; starting return"

	dim check_if_iterating
	if not isservice then
		'running in legacy mode, set session response information
		check_if_iterating = get_session("insertInfo")

		if len(check_if_iterating) > 0 then
			insertInfo = set_session("insertInfo", insertInfo & check_if_iterating)
		else
			insertInfo = set_session("insertInfo", insertInfo)
		end if
	else
		if debug_mode then print "Running as service: Setting ResponseHTML in 'Update Iteration Loop'"
		'running as service, set response HTML
		if len(responseHTML) = 0 then
			responseHTML = insertInfo
		end if
	end if
end sub

sub setFieldAndValue(pdfDoc, field_name, field_value)

	if not isnull(field_value) then
		if len(field_value) > 0 then
			dim field
			if instr(instr(field_name, "."), field_name, "]") > 0 then
				Set field = pdfDoc.Form.FindField("root[0]." & field_name)
			else
				Set field = pdfDoc.Form.FindField("root[0]." & field_name & "[0]")
			end if
			'print "root[0]." & field_name & "[0]"
			field.SetFieldValue field_value, pdfDoc.Fonts("Arial")
		end if
	end if

end sub

function placetext(signature, pagenumber)

  ' Go over all items in arrays
   dim j
   For j = 0 to UBound(arrX)
	  Param("x") = arrX(j)
	  Param("y") = arrY(j) - 263 * 0

	  ' Draw text on canvas
	  Canvas.DrawText arrText(j), Param, Font
   Next ' j

end function

function SetSkill(skillset, skill, inputfield, objPDF)

	SetSkill = SetSkillAndValue(skillset, skill, inputfield, "1", objPDF)

end function

function SetSkillAndValue (skillset, skill, inputfield, skillvalue, objPDF)

	if instr(skillset, skill) > 0 then
		setFieldAndValue objPDF, inputfield, skillvalue
	end if
	SetSkillAndValue = true
end function

sub print_f_wWidth_and_font(Doc, Page, text, x, y, width, height, angle, fontsize)
	if vartype(x) = vbNull or vartype(x) = vbEmpty then x = 0
	if vartype(y) = vbNull or vartype(y) = vbEmpty then y = 0
	if vartype(width) = vbNull or vartype(width) = vbEmpty then width = 0
	if vartype(height) = vbNull or vartype(height) = vbEmpty then height = 0
	if vartype(angle) = vbNull or vartype(angle) = vbEmpty then angle = 0
	if vartype(fontsize) = vbNull or vartype(fontsize) = vbEmpty then fontsize = 0

	if not isnull(text) then
		if len(text) > 0 then
			dim pdf
			Set pdf = Server.CreateObject("Persits.PDF")

			dim canvas
			'print page
			Set canvas = Doc.Pages(page).Canvas

			dim font
			Set font = Doc.Fonts("Arial")

			dim param

			'on error resume next

			if cint(height) = 0 then height = 196 'default
			if cint(fontsize) = 0 then fontsize = 11 'default
			if cint(width) = 0 then width = 196 'default

			'print "x=" & x & ";y=" & y & ";height=" & height & ";width=" & width & ";size=" & fontsize & ";angle=" & angle & ";"
			Set param = pdf.CreateParam("x=" & x & ";y=" & y & ";height=" & height & ";width=" & width & ";size=" & fontsize & ";angle=" & angle & ";")

			'if err > 0 then
				'print "Page=" & Page & ";x=" & x & ";y=" & y & ";height=" & height & ";width=" & width & ";size=" & fontsize & ";angle=" & angle & ";"
			'end if

			'on error goto 0

			param("x") = x
			''Param("y") = y - 263 * 1 'what is 263?
			param("y") = y

			' Draw text on canvas
			Canvas.DrawText text, param, Font
		end if
	end if

end sub

sub print_f_wWidth(Doc, Page, text, x, y, width, height, angle)

	print_f_wWidth_and_font Doc, page, text, x, y, 196, 196, angle, 11

end sub

sub print_f(Doc, page, text, x, y)

		print_f_wWidth Doc, page, text, x, y, 196, 196, 0

end sub

sub rotate_print_f(Doc, page, text, x, y, angle)

	if isnumeric(angle) then
		print_f_wWidth Doc, page, text, x, y, 196, 196, angle
	else
		print_f_wWidth Doc, page, text, x, y, 196, 196, 0
	end if
end sub

function mmToScreenInches (millimeter)
	'print (millimeter * 0.0393701) * 72
	mmToScreenInches = TwoDecimals((millimeter * 0.0393701) * 72)
end function

Sub viewApplication (action)
	Dim PDF, Doc, field, Page
	const applicationP1=1
	const applicationP2=2
	const policies=3
	const noncompete=4
	const unemployment=5
	const Page6=6
	const i9=7
	const i9P2=8
	const i9P3=9
	const Page10=10
	const w4=11
	const w4P2=12
	const skills=13
	const skillsP2=14
	const skillsP3=15
	const Page16=16
	const background=17
	const Page18=18
	const safety=19
	const drug=20
	const sexual=21
	const payroll=22
	const dearEmployer=23
	const Page24=24
	const f8850=25
	const f8850P2=26
	const f9061=27
	const f9061P2=28
	const f9061P3=29
	const f9061P4=30
	const Page31=31
	const Page32=32
	const Page33=33
	const Page34=34

	'if script is running as a RPC build PDF object

	'if rpcMode then
		Set PDF = Server.CreateObject("Persits.PDF")

		' Open an existing form
		Set Doc = PDF.OpenDocument( Server.MapPath( "EmploymentApplication.pdf" ) )

		' Remove XFA support from it
		Doc.Form.RemoveXFA

		dim font
		Set Font = Doc.Fonts("Arial")

		Dim signed
		signed = "Electronically Signed by " & CurrentApplication.Firstname & " " &  CurrentApplication.Lastname & VbCrLf  &_
			"DN: cn=" & CurrentApplication.Firstname & " " &  CurrentApplication.Lastname & ",username=" & CurrentApplication.Username & VbCrLf &_
			 "Date: "
		dim dx, nx, sx, sy, ndy, x, y, w, h, f, p, text_angle

		text_angle = 90

		p = applicationP1									'y, x
		rotate_print_f Doc, p, CurrentApplication.LastName, 22, 20, text_angle
		'setFieldAndValue Doc, "applicationP1[0].lastName", CurrentApplication.Lastname
		rotate_print_f Doc, p, CurrentApplication.Firstname, 22 , 181.6, text_angle
		'setFieldAndValue Doc, "applicationP1[0].firstName", CurrentApplication.Firstname
		rotate_print_f Doc, p, CurrentApplication.Telephone, mmToScreenInches(8), mmToScreenInches(116.316), text_angle
		'setFieldAndValue Doc, "applicationP1[0].userPhone", CurrentApplication.Telephone
		rotate_print_f Doc, p, CurrentApplication.AltTelephone, mmToScreenInches(8), mmToScreenInches(159.046), text_angle
		'setFieldAndValue Doc, "applicationP1[0].userSPhone", CurrentApplication.AltTelephone
		rotate_print_f Doc, p, Left(CurrentApplication.SSN, 3) & "-" & Mid(CurrentApplication.SSN, 4, 2) & "-" & Right(CurrentApplication.SSN, 4), mmToScreenInches(8), mmToScreenInches(192.858), text_angle
		'setFieldAndValue Doc, "applicationP1[0].ssn", Left(CurrentApplication.SSN, 3) & "-" & Mid(CurrentApplication.SSN, 4, 2) & "-" & Right(CurrentApplication.SSN, 4)
		rotate_print_f Doc, p, Date(), mmToScreenInches(8), mmToScreenInches(232.5), text_angle
		'setFieldAndValue Doc, "applicationP1[0].date", Date()
		rotate_print_f Doc, p, CurrentApplication.Address, mmToScreenInches(16), mmToScreenInches(6.776), text_angle
		'setFieldAndValue Doc, "applicationP1[0].address", CurrentApplication.Address
		rotate_print_f Doc, p, CurrentApplication.City, mmToScreenInches(16), mmToScreenInches(88.823), text_angle
		'setFieldAndValue Doc, "applicationP1[0].city", CurrentApplication.City
		rotate_print_f Doc, p, CurrentApplication.State, mmToScreenInches(16), mmToScreenInches(145.543), text_angle
		'setFieldAndValue Doc, "applicationP1[0].state", CurrentApplication.State
		rotate_print_f Doc, p, CurrentApplication.Zip, mmToScreenInches(16), mmToScreenInches(225.343), text_angle
		'setFieldAndValue Doc, "applicationP1[0].zip", CurrentApplication.Zip
		'setFieldAndValue Doc, "applicationP1[0].city", CurrentApplication.City
		'setFieldAndValue Doc, "applicationP1[0].state", CurrentApplication.State
		'setFieldAndValue Doc, "applicationP1[0].zip", CurrentApplication.Zip
		rotate_print_f Doc, p, CurrentApplication.DesiredWageAmount, mmToScreenInches(33.907), mmToScreenInches(41.198), text_angle
		'setFieldAndValue Doc, "applicationP1[0].desiredWageAmount", CurrentApplication.DesiredWageAmount
		rotate_print_f Doc, p, CurrentApplication.MinWageAmount, mmToScreenInches(39.8), mmToScreenInches(32.351), text_angle
		'setFieldAndValue Doc, "applicationP1[0].minWageAmount", CurrentApplication.MinWageAmount

		Select Case CurrentApplication.CurrentlyEmployed
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(21), mmToScreenInches(234.75), text_angle
			'setFieldAndValue Doc, "applicationP1[0].employedYes", "1"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(21), mmToScreenInches(248.75), text_angle
			'setFieldAndValue Doc, "applicationP1[0].employedNo", "1"
		End Select

		Select Case CurrentApplication.WorkTypeDesired
		Case "f"
			rotate_print_f Doc, p, "X", mmToScreenInches(28), mmToScreenInches(9), text_angle
			'setFieldAndValue Doc, "applicationP1[0].fulltime", "1"
		Case "p"
			rotate_print_f Doc, p, "X", mmToScreenInches(24), mmToScreenInches(9), text_angle
			'setFieldAndValue Doc, "applicationP1[0].temporary", "1"
		Case "a"
			 rotate_print_f Doc, p, "X", mmToScreenInches(28), mmToScreenInches(9), text_angle
			 rotate_print_f Doc, p, "X", mmToScreenInches(24), mmToScreenInches(9), text_angle
			'setFieldAndValue Doc, "applicationP1[0].fulltime", "1"

			'setFieldAndValue Doc, "applicationP1[0].temporary", "1"
		End Select

		Select Case CurrentApplication.Smoker
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(43.75), mmToScreenInches(25.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].smokerYes", "1"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(43.75), mmToScreenInches(39.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].smokerNo", "1"
		End Select

		Select Case CurrentApplication.WorkAge
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(26), mmToScreenInches(234.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].eighteenYes", "1"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(26), mmToScreenInches(248.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].eighteenNo", "1"
		End Select

		Select Case CurrentApplication.Citizen
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(49.5), mmToScreenInches(74), text_angle
			'setFieldAndValue Doc, "applicationP1[0].authorizedYes", "1"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(49.5), mmToScreenInches(89), text_angle
			'setFieldAndValue Doc, "applicationP1[0].authorizedNo", "1"
		End Select

		rotate_print_f Doc, p, CurrentApplication.WorkConvictionExplain, mmToScreenInches(66), mmToScreenInches(7), text_angle
		'setFieldAndValue Doc, "applicationP1[0].felonyExplain", CurrentApplication.WorkConvictionExplain

		Select Case CurrentApplication.WorkConviction
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(57.5), mmToScreenInches(156.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].felonyYes", "1"
			rotate_print_f Doc, p, "Felony", mmToScreenInches(61), mmToScreenInches(32.943), text_angle
			'setFieldAndValue Doc, "applicationP1[0].convictionType", "felony"
		Case "f"
			rotate_print_f Doc, p, "X", mmToScreenInches(57.5), mmToScreenInches(156.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].felonyYes", "1"
			rotate_print_f Doc, p, "Felony", mmToScreenInches(61), mmToScreenInches(32.943), text_angle
			'setFieldAndValue Doc, "applicationP1[0].convictionType", "felony"
		Case "m"
			rotate_print_f Doc, p, "X", mmToScreenInches(57.5), mmToScreenInches(156.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].felonyYes", "1"
			rotate_print_f Doc, p, "Misdemeanor", mmToScreenInches(61), mmToScreenInches(32.943), text_angle
			'setFieldAndValue Doc, "applicationP1[0].convictionType", "misdemeanor"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(57.5), mmToScreenInches(169.255), text_angle
			'setFieldAndValue Doc, "applicationP1[0].felonyNo", "1"
		End Select

		Select Case CurrentApplication.WorkAuthProof
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(53), mmToScreenInches(74.125), text_angle
			'setFieldAndValue Doc, "applicationP1[0].authProofYes", "1"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(53),  mmToScreenInches(89), text_angle
			'setFieldAndValue Doc, "applicationP1[0].authProofNo", "1"
		End Select
			rotate_print_f Doc, p, CurrentApplication.WorkCommuteHow, mmToScreenInches(61.528), mmToScreenInches(196.135), text_angle
		'setFieldAndValue Doc, "applicationP1[0].workCommuteHow", CurrentApplication.WorkCommuteHow

		Select Case CurrentApplication.WorkValidLicense
			Case "y"
				rotate_print_f Doc, p, "X",  mmToScreenInches(63.33), mmToScreenInches(237.5), text_angle
			'setFieldAndValue Doc, "applicationP1[0].driversYes", "1"

		Select Case CurrentApplication.WorkLicenseType
			Case "n"
				rotate_print_f Doc, p, "Non-Commercial",  mmToScreenInches(67), mmToScreenInches(238.471), text_angle
				'setFieldAndValue D oc, "applicationP1[0].workLicenseType", "Non-Commerical"
			Case "a"
				rotate_print_f Doc, p, "CDL-A", mmToScreenInches(67), mmToScreenInches(238.471), text_angle
				'setFieldAndValue Doc, "applicationP1[0].workLicenseType", "CDL-A"
			Case "b"
				rotate_print_f Doc, p, "CDL-B", mmToScreenInches(67), mmToScreenInches(238.471), text_angle
				'setFieldAndValue Doc, "applicationP1[0].workLicenseType", "CDL-B"
			Case "c"
				rotate_print_f Doc, p, "CDL-C", mmToScreenInches(67), mmToScreenInches(238.471), text_angle
				'setFieldAndValue Doc, "applicationP1[0].workLicenseType", "CDL-C"
			Case Else
				rotate_print_f Doc, p, "[none]", mmToScreenInches(67), mmToScreenInches(238.471), text_angle
				'setFieldAndValue Doc, "applicationP1[0].workLicenseType", "[none]"
			End Select
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(63.33), mmToScreenInches(248), text_angle
			'setFieldAndValue Doc, "applicationP1[0].driversNo", "1"
		End Select

		Select Case CurrentApplication.AutoInsurance
		Case "y"
			rotate_print_f Doc, p, "X", mmToScreenInches(77), mmToScreenInches(223.125), text_angle
			'setFieldAndValue Doc, "applicationP1[0].insuranceYes", "1"
		Case "n"
			rotate_print_f Doc, p, "X", mmToScreenInches(77), mmToScreenInches(232), text_angle
			'setFieldAndValue Doc, "applicationP1[0].insuranceNo", "1"
		End Select

		SetSkill CurrentApplication.SkillsSet, ".16.", "applicationP1[0].landscaping", Doc
		SetSkill CurrentApplication.SkillsSet, ".20.", "applicationP1[0].delivery", Doc
		SetSkill CurrentApplication.SkillsSet, ".88.", "applicationP1[0].janitorial", Doc
		SetSkill CurrentApplication.SkillsSet, ".73.", "applicationP1[0].warehouse", Doc
		SetSkill CurrentApplication.SkillsSet, ".89.", "applicationP1[0].inventory", Doc
		SetSkill CurrentApplication.SkillsSet, ".21.", "applicationP1[0].security", Doc
		SetSkill CurrentApplication.SkillsSet, ".647.", "applicationP1[0].shippingReceiving", Doc
		SetSkill CurrentApplication.SkillsSet, ".202.", "applicationP1[0].cleanup", Doc
		SetSkill CurrentApplication.SkillsSet, ".17.", "applicationP1[0].farm", Doc
		SetSkill CurrentApplication.SkillsSet, ".23.", "applicationP1[0].dairy", Doc
		SetSkill CurrentApplication.SkillsSet, ".605.", "applicationP1[0].sprinkler", Doc
		SetSkill CurrentApplication.SkillsSet, ".606.", "applicationP1[0].floral", Doc
		SetSkill CurrentApplication.SkillsSet, ".1073.", "applicationP1[0].yardsGrounds", Doc
		SetSkill CurrentApplication.SkillsSet, ".12.", "applicationP1[0].housekeeping", Doc
		SetSkill CurrentApplication.SkillsSet, ".198.", "applicationP1[0].plumber", Doc
		SetSkill CurrentApplication.SkillsSet, ".1316.", "applicationP1[0].generalLabor", Doc
		SetSkill CurrentApplication.SkillsSet, ".215.", "applicationP1[0].concreteRough", Doc
		SetSkill CurrentApplication.SkillsSet, ".274.", "applicationP1[0].concreteFinish", Doc
		SetSkill CurrentApplication.SkillsSet, ".216.", "applicationP1[0].carpenterRough", Doc
		SetSkill CurrentApplication.SkillsSet, ".220.", "applicationP1[0].carpenterFinish", Doc
		SetSkill CurrentApplication.SkillsSet, ".204.", "applicationP1[0].framing", Doc
		SetSkill CurrentApplication.SkillsSet, ".190.", "applicationP1[0].readBlueprints", Doc
		SetSkill CurrentApplication.SkillsSet, ".62.", "applicationP1[0].roofing", Doc
		SetSkill CurrentApplication.SkillsSet, ".18.","applicationP1[0].painting", Doc
		SetSkill CurrentApplication.SkillsSet, ".440.", "applicationP1[0].electrician", Doc
		SetSkill CurrentApplication.SkillsSet, ".229.", "applicationP1[0].hvac", Doc
		SetSkill CurrentApplication.SkillsSet, ".19.", "applicationP1[0].siding", Doc
		SetSkill CurrentApplication.SkillsSet, ".1600.", "applicationP1[0].flagger", Doc
		SetSkill CurrentApplication.SkillsSet, ".1305.", "applicationP1[0].generalLaborL", Doc
		SetSkill CurrentApplication.SkillsSet, ".1608.", "applicationP1[0].generalLaborM", Doc
		SetSkill CurrentApplication.SkillsSet, ".1610.", "applicationP1[0].generalLaborH", Doc
		SetSkill CurrentApplication.SkillsSet, ".457.", "applicationP1[0].machineOperator", Doc
		SetSkill CurrentApplication.SkillsSet, ".1078.", "applicationP1[0].forkliftOperator", Doc
		SetSkill CurrentApplication.SkillsSet, ".208.", "applicationP1[0].packaging", Doc
		SetSkill CurrentApplication.SkillsSet, ".219.", "applicationP1[0].palletizing", Doc
		SetSkill CurrentApplication.SkillsSet, ".206.", "applicationP1[0].sanitation", Doc
		SetSkill CurrentApplication.SkillsSet, ".24.", "applicationP1[0].lab", Doc
		SetSkill CurrentApplication.SkillsSet, ".1003.", "applicationP1[0].qa", Doc
		SetSkill CurrentApplication.SkillsSet, ".42.", "applicationP1[0].maintenance", Doc
		SetSkill CurrentApplication.SkillsSet, ".34.", "applicationP1[0].electrical", Doc
		SetSkill CurrentApplication.SkillsSet, ".418.", "applicationP1[0].electronics", Doc
		SetSkill CurrentApplication.SkillsSet, ".429.", "applicationP1[0].hydraulics", Doc
		SetSkill CurrentApplication.SkillsSet, ".184.", "applicationP1[0].cabinetMaker", Doc
		SetSkill CurrentApplication.SkillsSet, ".647.", "applicationP1[0].industrialShippingReceiving", Doc
		SetSkill CurrentApplication.SkillsSet, ".773.", "applicationP1[0].fishProcessing", Doc
		SetSkill CurrentApplication.SkillsSet, ".1057.", "applicationP1[0].dieselMechanic", Doc
		SetSkill CurrentApplication.SkillsSet, ".1042.", "applicationP1[0].autoMechanic", Doc
		SetSkill CurrentApplication.SkillsSet, ".55.", "applicationP1[0].smallEngineMechanic", Doc
		SetSkill CurrentApplication.SkillsSet, ".287.", "applicationP1[0].machinist", Doc
		SetSkill CurrentApplication.SkillsSet, ".1082.", "applicationP1[0].toolDie", Doc
		SetSkill CurrentApplication.SkillsSet, ".697.", "applicationP1[0].millLathe", Doc
		SetSkill CurrentApplication.SkillsSet, ".501.", "applicationP1[0].welder", Doc
		SetSkill CurrentApplication.SkillsSet, ".286.", "applicationP1[0].glazier", Doc
		SetSkill CurrentApplication.SkillsSet, ".1121.", "applicationP1[0].skilledLaborOther", Doc
		SetSkill CurrentApplication.SkillsSet, ".652.", "applicationP1[0].assemblyPackaging", Doc
		SetSkill CurrentApplication.SkillsSet, ".1284.", "applicationP1[0].plasticMachineOperator", Doc
		SetSkill CurrentApplication.SkillsSet, ".665.", "applicationP1[0].plasticInjection", Doc
		SetSkill CurrentApplication.SkillsSet, ".214.", "applicationP1[0].plasticMolding", Doc
		SetSkill CurrentApplication.SkillsSet, ".1617.", "applicationP1[0].plasticMaintenance", Doc
		SetSkill CurrentApplication.SkillsSet, ".1338.", "applicationP1[0].plasticCustomerService", Doc
		SetSkill CurrentApplication.SkillsSet, ".1472.", "applicationP1[0].plasticQA", Doc
		SetSkill CurrentApplication.SkillsSet, ".254.", "applicationP1[0].plasticPrepRoom", Doc
		SetSkill CurrentApplication.SkillsSet, ".1285.", "applicationP1[0].plasticGlueRoom", Doc
		SetSkill CurrentApplication.SkillsSet, ".1115.", "applicationP1[0].foodserviceWaitress", Doc
		SetSkill CurrentApplication.SkillsSet, ".653.", "applicationP1[0].foodserviceLinecook", Doc
		SetSkill CurrentApplication.SkillsSet, ".442.", "applicationP1[0].foodserviceChef", Doc
		SetSkill CurrentApplication.SkillsSet, ".1604.", "applicationP1[0].foodserviceDishwasher", Doc
		SetSkill CurrentApplication.SkillsSet, ".1268.", "applicationP1[0].foodserviceHostess", Doc
		SetSkill CurrentApplication.SkillsSet, ".230.", "applicationP1[0].foodserviceSupervisor", Doc
		SetSkill CurrentApplication.SkillsSet, ".1255.", "applicationP1[0].foodserviceBanquet", Doc
		SetSkill CurrentApplication.SkillsSet, ".1603.", "applicationP1[0].foodserviceSanitation", Doc
		SetSkill CurrentApplication.SkillsSet, ".1119.", "applicationP1[0].foodserviceWarehouse", Doc
		SetSkill CurrentApplication.SkillsSet, ".438.", "applicationP1[0].drivingCDL", Doc
		SetSkill CurrentApplication.SkillsSet, ".438.", "applicationP1[0].drivingCDL", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".438.", "applicationP1[0].classCDL", "CDL-A", Doc
		SetSkill CurrentApplication.SkillsSet, ".343.", "applicationP1[0].drivingCDL", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".343.", "applicationP1[0].classCDL", "CDL-B", Doc
		SetSkill CurrentApplication.SkillsSet, ".500.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".500.", "applicationP1[0].cdlEndorsements", "Air Brakes", Doc
		SetSkill CurrentApplication.SkillsSet, ".558.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".558.", "applicationP1[0].cdlEndorsements", "All - TPXS", Doc
		SetSkill CurrentApplication.SkillsSet, ".1602.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".1602.", "applicationP1[0].cdlEndorsements", "End - H", Doc
		SetSkill CurrentApplication.SkillsSet, ".556.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".556.", "applicationP1[0].cdlEndorsements", "End - M", Doc
		SetSkill CurrentApplication.SkillsSet, ".500.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".500.", "applicationP1[0].cdlEndorsements", "Air Brakes", Doc
		SetSkill CurrentApplication.SkillsSet, ".491.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".491.", "applicationP1[0].cdlEndorsements", "End - N", Doc
		SetSkill CurrentApplication.SkillsSet, ".493.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".493.", "applicationP1[0].cdlEndorsements", "End - P", Doc
		SetSkill CurrentApplication.SkillsSet, ".1633.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".1633.", "applicationP1[0].cdlEndorsements", "End - S", Doc
		SetSkill CurrentApplication.SkillsSet, ".489.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".489.", "applicationP1[0].cdlEndorsements", "End - T", Doc
		SetSkill CurrentApplication.SkillsSet, ".1632.", "applicationP1[0].drivingEndorcements", Doc
		SetSkillAndValue CurrentApplication.SkillsSet, ".1632.", "applicationP1[0].cdlEndorsements", "End - X", Doc
		SetSkill CurrentApplication.SkillsSet, ".94.", "applicationP1[0].clericalReceptionist", Doc
		SetSkill CurrentApplication.SkillsSet, ".1122.", "applicationP1[0].clericalSwitchboard", Doc
		SetSkill CurrentApplication.SkillsSet, ".267.", "applicationP1[0].clerical", Doc
		SetSkill CurrentApplication.SkillsSet, ".207.", "applicationP1[0].clericalTelephone", Doc
		SetSkill CurrentApplication.SkillsSet, ".709.", "applicationP1[0].clericalWordprocessing", Doc
		SetSkill CurrentApplication.SkillsSet, ".590.", "applicationP1[0].clericalDictation", Doc
		SetSkill CurrentApplication.SkillsSet, ".852.", "applicationP1[0].clericalSpeedwriting", Doc
		SetSkill CurrentApplication.SkillsSet, ".76.", "applicationP1[0].clericalTyping", Doc
		SetSkill CurrentApplication.SkillsSet, ".360.", "applicationP1[0].clericalStatisticalTyping", Doc
		SetSkill CurrentApplication.SkillsSet, ".1614.", "applicationP1[0].clericalLegalOffice", Doc
		SetSkill CurrentApplication.SkillsSet, ".221.", "applicationP1[0].clericalMedicalOffice", Doc
		SetSkill CurrentApplication.SkillsSet, ".97.", "applicationP1[0].clericalCashier", Doc
		SetSkill CurrentApplication.SkillsSet, ".608.", "applicationP1[0].clerical10Key", Doc
		SetSkill CurrentApplication.SkillsSet, ".123.", "applicationP1[0].clericalTeller", Doc
		SetSkill CurrentApplication.SkillsSet, ".81.", "applicationP1[0].clericalDataEntry", Doc
		SetSkill CurrentApplication.SkillsSet, ".27.", "applicationP1[0].softwareWindows", Doc
		SetSkill CurrentApplication.SkillsSet, ".600.", "applicationP1[0].clericalMortgage", Doc
		SetSkill CurrentApplication.SkillsSet, ".613.", "applicationP1[0].clericalMedicalTerminology", Doc
		SetSkill CurrentApplication.SkillsSet, ".1399.", "applicationP1[0].clericalCreditCollection", Doc
		SetSkill CurrentApplication.SkillsSet, ".942.", "applicationP1[0].clericalCustomerService", Doc
		SetSkill CurrentApplication.SkillsSet, ".1621.", "applicationP1[0].clericalTitleEscrow", Doc
		SetSkill CurrentApplication.SkillsSet, ".1208.", "applicationP1[0].otherSoftware", Doc
		SetSkill CurrentApplication.SkillsSet, ".205.", "applicationP1[0].softwareWord", Doc
		SetSkill CurrentApplication.SkillsSet, ".426.", "applicationP1[0].softwareWordPerfect", Doc
		SetSkill CurrentApplication.SkillsSet, ".792.", "applicationP1[0].softwareExcel", Doc
		SetSkill CurrentApplication.SkillsSet, ".95.", "applicationP1[0].clericalFaxCopier", Doc
		SetSkill CurrentApplication.SkillsSet, ".1179.", "applicationP1[0].bookkeepingAR", Doc
		SetSkill CurrentApplication.SkillsSet, ".1173.", "applicationP1[0].bookkeepingAP", Doc
		SetSkill CurrentApplication.SkillsSet, ".31.", "applicationP1[0].bookkeepingPayroll", Doc
		SetSkill CurrentApplication.SkillsSet, ".187.", "applicationP1[0].bookkeepingBankRecon", Doc
		SetSkill CurrentApplication.SkillsSet, ".84.", "applicationP1[0].bookkeepingPosting", Doc
		SetSkill CurrentApplication.SkillsSet, ".85.", "applicationP1[0].bookkeepingTrialBalance", Doc
		SetSkill CurrentApplication.SkillsSet, ".111.", "applicationP1[0].bookkeepingFinancialStmntPrep", Doc
		SetSkill CurrentApplication.SkillsSet, ".144.", "applicationP1[0].bookkeepingMonthEndClose", Doc
		SetSkill CurrentApplication.SkillsSet, ".1609.", "applicationP1[0].bookkeepingAccounting", Doc
		SetSkill CurrentApplication.SkillsSet, ".630.", "applicationP1[0].bookkeepingTax", Doc
		SetSkill CurrentApplication.SkillsSet, ".607.", "applicationP1[0].softwareQuicken", Doc
		SetSkill CurrentApplication.SkillsSet, ".171.", "applicationP1[0].softwarePeachtree", Doc
		SetSkill CurrentApplication.SkillsSet, ".-1.", "applicationP1[0].bookkeepingOther", Doc
		SetSkill CurrentApplication.SkillsSet, ".99.", "applicationP1[0].healthDentalAssist", Doc
		SetSkill CurrentApplication.SkillsSet, ".38.", "applicationP1[0].healthCNA", Doc
		SetSkill CurrentApplication.SkillsSet, ".203.", "applicationP1[0].healthCMA", Doc
		SetSkill CurrentApplication.SkillsSet, ".339.", "applicationP1[0].healthWardClerk", Doc
		SetSkill CurrentApplication.SkillsSet, ".425.", "applicationP1[0].healthLabTechnician", Doc
		SetSkill CurrentApplication.SkillsSet, ".24.", "applicationP1[0].healthGeneralLabor", Doc
		SetSkill CurrentApplication.SkillsSet, ".459.", "applicationP1[0].healthHousekeeping", Doc
		SetSkill CurrentApplication.SkillsSet, ".421.", "applicationP1[0].healthRN", Doc
		SetSkill CurrentApplication.SkillsSet, ".269.", "applicationP1[0].healthDietary", Doc
		SetSkill CurrentApplication.SkillsSet, ".288.", "applicationP1[0].healthLPN", Doc
		SetSkill CurrentApplication.SkillsSet, ".289.", "applicationP1[0].technicalComputerTech", Doc
		SetSkill CurrentApplication.SkillsSet, ".1394.", "applicationP1[0].technicalCopierTech", Doc
		SetSkill CurrentApplication.SkillsSet, ".722.", "applicationP1[0].technicalTelecomTech", Doc
		SetSkill CurrentApplication.SkillsSet, ".534.", "applicationP1[0].technicalElectronicsTech", Doc
		SetSkill CurrentApplication.SkillsSet, ".134.", "applicationP1[0].technicalCADD", Doc
		SetSkill CurrentApplication.SkillsSet, ".231.", "applicationP1[0].technicalEngineer", Doc
		SetSkill CurrentApplication.SkillsSet, ".-1.", "applicationP1[0].technicalType", Doc
		SetSkill CurrentApplication.SkillsSet, ".-1.", "applicationP1[0].technicalCertificate", Doc
		SetSkill CurrentApplication.SkillsSet, ".241.", "applicationP1[0].technicalTelecommunications", Doc
		SetSkill CurrentApplication.SkillsSet, ".987.", "applicationP1[0].technicalComputerNetwork", Doc
		SetSkill CurrentApplication.SkillsSet, ".-1.", "applicationP1[0].softwareUsedOne", Doc
		SetSkill CurrentApplication.SkillsSet, ".-1.", "applicationP1[0].softwareUsedTwo", Doc
		SetSkill CurrentApplication.SkillsSet, ".-1.", "applicationP1[0].softwareUsedThree", Doc
		SetSkill CurrentApplication.SkillsSet, ".260.", "applicationP1[0].salesOutside", Doc
		SetSkill CurrentApplication.SkillsSet, ".164.", "applicationP1[0].salesRoute", Doc
		SetSkill CurrentApplication.SkillsSet, ".105.", "applicationP1[0].salesTelemarketing", Doc
		SetSkill CurrentApplication.SkillsSet, ".182.", "applicationP1[0].salesMarketing", Doc
		SetSkill CurrentApplication.SkillsSet, ".183.", "applicationP1[0].salesProductDemo", Doc
		SetSkill CurrentApplication.SkillsSet, ".247.", "applicationP1[0].salesSurvey", Doc
		SetSkill CurrentApplication.SkillsSet, ".7.", "applicationP1[0].salesRetail", Doc
		SetSkill CurrentApplication.SkillsSet, ".586.", "applicationP1[0].managementAccounting", Doc
		SetSkill CurrentApplication.SkillsSet, ".1626.", "applicationP1[0].managementCPA", Doc
		SetSkill CurrentApplication.SkillsSet, ".196.", "applicationP1[0].managementHR", Doc
		SetSkill CurrentApplication.SkillsSet, ".39.", "applicationP1[0].managementPurchasing", Doc
		SetSkill CurrentApplication.SkillsSet, ".197.", "applicationP1[0].managementPR", Doc
		SetSkill CurrentApplication.SkillsSet, ".1615.", "applicationP1[0].managementInfoSys", Doc
		SetSkill CurrentApplication.SkillsSet, ".120.", "applicationP1[0].managementSales", Doc
		SetSkill CurrentApplication.SkillsSet, ".1618.", "applicationP1[0].managementTechnical", Doc
		SetSkill CurrentApplication.SkillsSet, ".1098.", "applicationP1[0].managementQA", Doc
		SetSkill CurrentApplication.SkillsSet, ".514.", "applicationP1[0].managementConstruction", Doc
		SetSkill CurrentApplication.SkillsSet, ".482.", "applicationP1[0].managementFarm", Doc
		SetSkill CurrentApplication.SkillsSet, ".231.", "applicationP1[0].managementEngineering", Doc

'		setFieldAndValue Doc, "workLicenseState",
'		field.SetFieldValue workLicenseType
'		setFieldAndValue Doc, "workLicenseExpire",
'		field.SetFieldValue workLicenseExpire
'		setFieldAndValue Doc, "workLicenseNumber",
'		field.SetFieldValue workLicenseNumber

		rotate_print_f Doc, p, CurrentApplication.WorkRelocate, mmToScreenInches(83), mmToScreenInches(236.719), text_angle

		'setFieldAndValue Doc, "applicationP1[0].workCommuteDistance", CurrentApplication.WorkRelocate & "; " & CurrentApplication.WorkCommuteDistance

'		setFieldAndValue Doc, "eduLevel",
'		field.SetFieldValue eduLevel
'
'		setFieldAndValue Doc, "additionalInfo",
'		field.SetFieldValue additionalInfo

		'setFieldAndValue Doc, "applicationP1[0].workCommuteDistance", CurrentApplication.WorkRelocate & "; " & CurrentApplication.WorkCommuteDistance
		p = applicationP2
		setFieldAndValue Doc, "applicationP2[0].jobHistFromDateOne", CurrentApplication.JobHistFromDateOne
		setFieldAndValue Doc, "applicationP2[0].JobHistToDateOne", CurrentApplication.JobHistToDateOne
		setFieldAndValue Doc, "applicationP2[0].employerNameHistOne", CurrentApplication.EmployerNameHistOne
		setFieldAndValue Doc, "applicationP2[0].jobHistSupervisorOne", CurrentApplication.JobHistSupervisorOne
		setFieldAndValue Doc, "applicationP2[0].jobHistAddOne", CurrentApplication.JobHistAddOne & vbCrLf & CurrentApplication.JobHistCityStateZipOne
		setFieldAndValue Doc, "applicationP2[0].jobHistPhoneOne", CurrentApplication.JobHistPhoneOne
		setFieldAndValue Doc, "applicationP2[0].jobDutiesOne", CurrentApplication.JobDutiesOne
		setFieldAndValue Doc, "applicationP2[0].jobHistPayOne", CurrentApplication.JobHistPayOne
		setFieldAndValue Doc, "applicationP2[0].jobReasonOne", CurrentApplication.JobReasonOne

		setFieldAndValue Doc, "applicationP2[0].jobHistFromDateTwo", CurrentApplication.JobHistFromDateTwo
		setFieldAndValue Doc, "applicationP2[0].JobHistToDateTwo", CurrentApplication.JobHistToDateTwo
		setFieldAndValue Doc, "applicationP2[0].employerNameHistTwo", CurrentApplication.EmployerNameHistTwo
		setFieldAndValue Doc, "applicationP2[0].jobHistSupervisorTwo", CurrentApplication.JobHistSupervisorTwo
		setFieldAndValue Doc, "applicationP2[0].jobHistAddTwo", CurrentApplication.JobHistAddTwo & vbCrLf & CurrentApplication.JobHistCityStateZipTwo
		setFieldAndValue Doc, "applicationP2[0].jobHistPhoneTwo", CurrentApplication.JobHistPhoneTwo
		setFieldAndValue Doc, "applicationP2[0].jobDutiesTwo", CurrentApplication.JobDutiesTwo
		setFieldAndValue Doc, "applicationP2[0].jobHistPayTwo", CurrentApplication.JobHistPayTwo
		setFieldAndValue Doc, "applicationP2[0].jobReasonTwo", CurrentApplication.JobReasonTwo

		setFieldAndValue Doc, "applicationP2[0].jobHistFromDateThree", CurrentApplication.JobHistFromDateThree
		setFieldAndValue Doc, "applicationP2[0].JobHistToDateThree", CurrentApplication.JobHistToDateThree
		setFieldAndValue Doc, "applicationP2[0].employerNameHistThree", CurrentApplication.EmployerNameHistThree
		setFieldAndValue Doc, "applicationP2[0].jobHistSupervisorThree", CurrentApplication.JobHistSupervisorThree
		setFieldAndValue Doc, "applicationP2[0].jobHistAddThree", CurrentApplication.JobHistAddThree & vbCrLf & CurrentApplication.JobHistCityStateZipThree
		setFieldAndValue Doc, "applicationP2[0].jobHistPhoneThree", CurrentApplication.JobHistPhoneThree
		setFieldAndValue Doc, "applicationP2[0].jobDutiesThree", CurrentApplication.JobDutiesThree
		setFieldAndValue Doc, "applicationP2[0].jobHistPayThree", CurrentApplication.JobHistPayThree
		setFieldAndValue Doc, "applicationP2[0].jobReasonThree", CurrentApplication.JobReasonThree

		rotate_print_f Doc, 2, date(), 480, 441, 90 'setFieldAndValue Doc, "applicationP2[0].date", date()

		'Emergency Contact
		rotate_print_f Doc, p, CurrentApplication.ECFullName, mmToScreenInches(96.484), mmToScreenInches(167.492), text_angle
		rotate_print_f Doc, p, CurrentApplication.ECAddress, mmToScreenInches(103.23), mmToScreenInches(169.746), text_angle
		rotate_print_f Doc, p, CurrentApplication.ECPhone, mmToScreenInches(103.544), mmToScreenInches(247), text_angle
		rotate_print_f Doc, p, CurrentApplication.ECDoctor, mmToScreenInches(110.517), mmToScreenInches(176.446), text_angle
		rotate_print_f Doc, p, CurrentApplication.ECDocPhone, mmToScreenInches(110.831), mmToScreenInches(248.173), text_angle

		'setFieldAndValue Doc, "applicationP2[0].ecFullName", CurrentApplication.ECFullName
		'setFieldAndValue Doc, "applicationP2[0].ecAddress", CurrentApplication.ECAddress
		'setFieldAndValue Doc, "applicationP2[0].ecPhone", CurrentApplication.ECPhone
		'setFieldAndValue Doc, "applicationP2[0].ecDoctor", CurrentApplication.ECDoctor
		'setFieldAndValue Doc, "applicationP2[0].ecDocPhone", CurrentApplication.ECDocPhone

		If len(CurrentApplication.ApplicantAgree) > 0 and isnull(CurrentApplication.ApplicantAgree) = false then

			'Applicant Application, sign
			sx = 467
			sy = 58
			w = 296
			h = 64
			f = 8
			p = 2

			'setFieldAndValue Doc, "applicationP2[0].signature", signed & applicantAgree
			print_f_wWidth_and_font Doc, p, signed & CurrentApplication.ApplicantAgree, sx, sy, w, h, 90, f

		end if

		'Policies
		nx = 98
		ndy = 53
		p = policies ' page 3

		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy

		dx = 458
		print_f Doc, p, date(), dx, ndy

		If len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then
			sx = 245
			sy = 68
			print_f_wWidth_and_font Doc, p, signed & CurrentApplication.PAndPAgree, sx, sy, w, h, 0, f
		end if

		'noncompete
		nx = 100
		ndy = 60
		p = noncompete ' page 4

		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy

		dx = 490
		print_f Doc, p, date(), dx, ndy

		If len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then
			sx = 265
			sy = 73
			print_f_wWidth_and_font Doc, p, signed & CurrentApplication.PAndPAgree, sx, sy, w, h, 0, f
		end if

		'Unemployment
		p = unemployment
		dim iMidPage
		iMidPage = 390
        nx = 35    
        dx = 480
		'setFieldAndValue Doc, "unemployment[0].applicantName", applicantName
		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy
		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy + iMidPage

		'setFieldAndValue Doc, "unemployment[0].date", Date()
		print_f Doc, p, date(), dx, ndy + iMidPage
		print_f Doc, p, date(), dx, ndy

		If len(CurrentApplication.UnEmpAgree) > 0 and isnull(CurrentApplication.UnEmpAgree) = false then
			''setFieldAndValue Doc, "unemployment[0].signature", signed & unempAgree
			print_f_wWidth_and_font Doc, p, signed & CurrentApplication.UnEmpAgree, sx, sy + iMidPage, w, h, 0, f
			print_f_wWidth_and_font Doc, p, signed & CurrentApplication.UnEmpAgree, sx, sy, w, h, 0, f
		end if

		' Form I9

		p = i9

		print_f Doc, p, CurrentApplication.LastName, 40, 615
		'setFieldAndValue Doc, "i9[0].lastname", CurrentApplication.LastName
		print_f Doc, p, CurrentApplication.Firstname, 225, 615
		'setFieldAndValue Doc, "i9[0].firstname", CurrentApplication.Firstname
		print_f Doc, p, CurrentApplication.Address, 40, 580
		'setFieldAndValue Doc, "i9[0].address", CurrentApplication.Address
		print_f Doc, p, CurrentApplication.City, 310, 580
		'setFieldAndValue Doc, "i9[0].city", CurrentApplication.City
		print_f Doc, p, CurrentApplication.State, 450, 580
		'setFieldAndValue Doc, "i9[0].state", CurrentApplication.State
		print_f Doc, p, CurrentApplication.Zip, 500, 580
		'setFieldAndValue Doc, "i9[0].zip", CurrentApplication.Zip
		print_f Doc, p, CurrentApplication.DOB, 40, 550
		'setFieldAndValue Doc, "i9[0].dob", CurrentApplication.DOB
		print_f Doc, p, Left(CurrentApplication.SSN, 3), 150, 550
		print_f Doc, p, Mid(CurrentApplication.SSN, 4, 2), 182, 550
		print_f Doc, p, Right(CurrentApplication.SSN, 4), 210, 550
		'setFieldAndValue Doc, "i9[0].ssn", Left(CurrentApplication.SSN, 3) & "-" & Mid(CurrentApplication.SSN, 4, 2) & "-" & Right(CurrentApplication.SSN, 4)
		print_f Doc, p, CurrentApplication.EmailAddress, 260, 550
		If CurrentApplication.Citizen = "y" Then
			print_f Doc, p, "X", 38, 486
			'setFieldAndValue Doc, "i9[0].citizen", "1"
		Else
			If CurrentApplication.AlienType = "o" Then
				print_f Doc, p, "X", 38, 470
			elseif CurrentApplication.AlienType = "p" Then
				print_f Doc, p, "X", 38, 452
				'setFieldAndValue Doc, "i9[0].LPRAlienNumberCk", "1"
				if not isnull(CurrentApplication.AlienNumber) then
					print_f Doc, p, CurrentApplication.AlienNumber, 350, 455
					'setFieldAndValue Doc, "i9[0].LPRAlienNumber", CurrentApplication.AlienNumber
				end if
			elseif CurrentApplication.AlienType = "a" Then
				print_f Doc, p, "X", 38, 471
				'setFieldAndValue Doc, "i9[0].alienauthorizedtowork", "1"
				if not isnull(CurrentApplication.AlienNumber) then
					print_f Doc, p, CurrentApplication.AlienNumber, 310, 476
					'setFieldAndValue Doc, "i9[0].alienworknumber", CurrentApplication.AlienNumber
				end if
			end If
		end If
		'setFieldAndValue Doc, "i9[0].date", Date()
		print_f Doc, p, Date(), 490, 242.5 'certification date

		p = i9P2
		print_f Doc, p, CurrentApplication.LastName & ", " & CurrentApplication.Firstname, 300, 682
		print_f Doc, p, Date(), 280, 315
		print_f Doc, p, Date(), 290, 280
		print_f Doc, p, "Client Services", 380, 280 ', 'certtitle
		print_f Doc, p, "Personnel Plus, Inc.", 350, 250

		dim addressArry
		addressArry = split(branch_address, ",")

		const businessAddress = 1
		const businessCity = 2
		const businessStatezip = 3

		print_f Doc, p, addressArry(businessAddress), 40, 225 'businessaddress
		print_f Doc, p, addressArry(businessCity), 305, 225 'businesscity
		print_f Doc, p, right(addressArry(businessStatezip), 5), 500, 225 'businesszip
		print_f Doc, p, left (trim(addressArry(businessStatezip)), 2), 460, 225 'businessstate

		' Form W4
		p = w4
		print_f Doc, p, CurrentApplication.W4a, 558, 541
		print_f Doc, p, CurrentApplication.W4b, 558, 516
		print_f Doc, p, CurrentApplication.W4c, 558, 481
		print_f Doc, p, CurrentApplication.W4d, 558, 469
		print_f Doc, p, CurrentApplication.W4e, 558, 456
		print_f Doc, p, CurrentApplication.W4f, 558, 444
		print_f Doc, p, CurrentApplication.W4g, 558, 385
		print_f Doc, p, CurrentApplication.W4h,	558, 372

		if not cbool(CurrentApplication.W4Exempt) then
			print_f Doc, p, CurrentApplication.W4h, 525, 169
		else
			print_f Doc, p, "- - -", 525, 169
		end if

		REM Set field = Doc.Form.FindField("root[0].w4[0].h[1]")
			REM field.SetFieldValue w4total, Font
		REM end if

		print_f Doc, p, CurrentApplication.W4more, 525, 157

		select case CurrentApplication.W4filing
		case 0
			print_f Doc, p, "x", 325, 217
		case 1
			print_f Doc, p, "x", 368, 217
		case 2
			print_f Doc, p, "x", 411, 217
		end select

		if CurrentApplication.W4nameDiffers > 0 then
			print_f Doc, p, "x", 564, 181
		end if

		if cbool(CurrentApplication.W4Exempt) then
			print_f Doc, p, "Exempt", 460, 109
		end if

		print_f Doc, p, CurrentApplication.Lastname, 225, 230
		print_f Doc, p, CurrentApplication.Firstname & " " & CurrentApplication.MiddleInit, 65, 230
		print_f Doc, p, CurrentApplication.Address, 65 , 205
		print_f Doc, p, CurrentApplication.CityStateZip, 65 , 181

		if len(CurrentApplication.SSN) = 9 then
			print_f Doc, p, Left(CurrentApplication.SSN, 3) & " " & Mid(CurrentApplication.SSN, 4, 2) & " " & Right(CurrentApplication.SSN, 4), 450, 230
		end if

		print_f Doc, p, Date(), 470, 73
		print_f Doc, p, branch_address, 65, 52
		print_f Doc, p, company_location_description, 369, 52
		print_f Doc, p, "84-1370996", 450, 52

		If len(CurrentApplication.ApplicantAgree) > 0 and isnull(CurrentApplication.ApplicantAgree) = false then

				x = 194
				y = 87
				print_f_wWidth_and_font Doc, p, signed & CurrentApplication.ApplicantAgree, x, y, w, h, 0, f

			''setFieldAndValue Doc, "w4[0].signature", signed & applicantAgree

		End If

		'Skills
		p = skills
		print_f Doc, p, CurrentApplication.ApplicantName, 105, 735
		print_f Doc, p, Date(), 425, 735

		' Background Check
		p = background

		print_f Doc, p, CurrentApplication.Lastname, 28, 620
		print_f Doc, p, CurrentApplication.Firstname, 425, 620
		print_f Doc, p, CurrentApplication.AliasNames, 28, 583

		 if len(CurrentApplication.DOB) = 8 and isnumeric(CurrentApplication.DOB) then 'format as date
			dim dob

			dob = left(CurrentApplication.DOB, 2) & "/" & mid(CurrentApplication.DOB, 3, 2) & "/" & right(CurrentApplication.DOB, 4)

		end if

		print_f Doc, p, DatePart("m", CurrentApplication.DOB), 295, 583
		print_f Doc, p, DatePart("d", CurrentApplication.DOB), 325, 583
		print_f Doc, p, DatePart("yyyy", CurrentApplication.DOB), 355, 583

		print_f Doc, p, CurrentApplication.Address, 28, 550
		print_f Doc, p, CurrentApplication.City, 250, 550
		print_f Doc, p, CurrentApplication.State, 355, 550
		print_f Doc, p, CurrentApplication.Zip, 495, 550

		if len(CurrentApplication.SSN) = 9 then
			print_f Doc, p, Left(CurrentApplication.SSN, 3), 495, 583
			print_f Doc, p, Mid(CurrentApplication.SSN, 4, 2), 528, 583
			print_f Doc, p, Right(CurrentApplication.SSN, 4), 555, 583
		end if

		print_f Doc, p, Date(), 460, 472
		'setFieldAndValue Doc, "background[0].date", date()

		print_f Doc, p, replace(branch_address, "Personnel Plus, ", ""), 325, 385

		If len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then

			w = 388
			f = 6
			x = 30
			y = 468
			print_f_wWidth_and_font Doc, p, replace(signed, VbCrLf, " ") & CurrentApplication.PAndPAgree, x, y, w, h, 0, f

			'setFieldAndValue Doc, "background[0].signature", replace(signed, VbCrLf, " ") & pandpAgree

		End If

		'Safety form

		'Fill in medical providers for the site
		'dim mpId
		'for mpId = 0 to mProviderId -1
		'	if len(mproviders(mpId, mpName)) > 0 then
		'		setFieldAndValue Doc, "safety[0].mProvider" & mpId + 1 & "", mproviders(mpId, mpName)
		'	end if

		'	if len(mproviders(mpId, mpAddress)) > 0 then
		'		setFieldAndValue Doc, "safety[0].mProvider" & mpId + 1 & "Address", mproviders(mpId, mpAddress)
		'	end if

		'	if len(mproviders(mpId, mpCityline)) > 0 then
		'		setFieldAndValue Doc, "safety[0].mProvider" & mpId + 1 & "Cityline", mproviders(mpId, mpCityline)
		'	end if

		'	if len(mproviders(mpId, mpPhone)) > 0 then
		'		setFieldAndValue Doc, "safety[0].mProvider" & mpId + 1 & "Phone", mproviders(mpId, mpPhone)
		'	end if

		'	if len(mproviders(mpId, mpFax)) > 0 then
		'		setFieldAndValue Doc, "safety[0].mProvider" & mpId + 1 & "Fax", mproviders(mpId, mpFax)
		'	end if
		'
		'	if len(mproviders(mpId, mpOpen)) > 0 then
		'		setFieldAndValue Doc, "safety[0].mProvider" & mpId + 1 & "Open", mproviders(mpId, mpOpen)
		'	end if
		'next

		'applicant information

		f = 8
		'safety
		p = safety
        nx = 30
        ndy = 45
		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy
		print_f Doc, p, date(), dx, ndy
        
        sx = 237
        sy = 60

		If len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then
				print_f_wWidth_and_font Doc, p, signed & CurrentApplication.PAndPAgree, sx, sy, w, h, 0, f
		End If

		'Drugs
		p = drug
        nx = 30
        ndy = 57
        sx = 265
        sy = 71
		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy

		If len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then
				print_f_wWidth_and_font Doc, p, signed & CurrentApplication.PAndPAgree, sx, sy, w, h, 0, f
		End If
		print_f Doc, p, date(), dx, ndy

		'Sexual
		p = sexual
		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy

		if len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then
				print_f_wWidth_and_font Doc, p, signed & CurrentApplication.PAndPAgree, sx, sy, w, h, 0, f
		End If
		print_f Doc, p, date(), dx, ndy

		'Payroll Depost
		p = payroll
		print_f Doc, p, CurrentApplication.ApplicantName, nx, ndy
		print_f Doc, p, date(), dx, ndy

		'dearEmployer
		p = dearEmployer
		print_f Doc, p, CurrentApplication.ApplicantName, 125, 595
		print_f Doc, p, CurrentApplication.ApplicantName, 30, 60

		if len(CurrentApplication.SSN) = 9 then
			print_f Doc, p, Left(CurrentApplication.SSN, 3), 125, 575
			print_f Doc, p, Mid(CurrentApplication.SSN, 4, 2), 145, 575
			print_f Doc, p, Right(CurrentApplication.SSN, 4), 159, 575
		End if
		print_f Doc, p, Date(), dx, ndy
		print_f Doc, p, branch_address, 250, 265
		print_f Doc, p, branch_fax, 250, 235

		If len(CurrentApplication.PAndPAgree) > 0 and isnull(CurrentApplication.PAndPAgree) = false then
			print_f_wWidth_and_font Doc, p, signed & CurrentApplication.PAndPAgree, sx, sy, w, h, 0, f
		End If

		' Form 8850
		p = f8850
		print_f Doc, p, CurrentApplication.ApplicantName, 90, 685
		print_f Doc, p, CurrentApplication.Address, 170, 660
		print_f Doc, p, CurrentApplication.CityStateZip, 190, 637

		if len(CurrentApplication.SSN) = 9 then
			print_f Doc, p, Left(CurrentApplication.SSN, 3), 475, 685
			print_f Doc, p, Mid(CurrentApplication.SSN, 4, 2), 500, 685
			print_f Doc, p, Right(CurrentApplication.SSN, 4), 520, 685
		end if

		if len(CurrentApplication.Telephone) > 9 then
			print_f Doc, p, Left(CurrentApplication.Telephone, 3), 450, 612
		end if

		if len(CurrentApplication.Telephone) > 6 then
			print_f Doc, p, Mid(CurrentApplication.Telephone, 4, 3), 471, 612
			print_f Doc, p, Right(CurrentApplication.Telephone, 4), 490, 612
		end if
	'end if

	'Save document
		Dim FilenameWithPath, Path, SitePath, FileName, FileNameNoPath, hrefLink, getAttachmentInfo, NewDoc, NewAttachment
		Dim pagesToAttach, pagesToPrint, isItSigned, CurrentPage, aCopy

	if not rpcMode then
		select case CurrentApplication.WhereWeAre
		case "nampa"
			SitePath = "\\192.168.4.3\direct$\"
		case "boise"
			SitePath = "\\192.168.3.5\direct$\"
		case "burley"
			SitePath = "\\192.168.2.4\direct$\"
		case "pocatello"
			SitePath = "\\192.168.6.4\direct$\"
		case else
			SitePath = "\\personnelplus.net\attached\"
		end select
		'Break SitePath
	end if

	If action = "attach" Then
			if not rpcMode then

				cmd.CommandText = "" &_
					"SELECT FileId, ApplicantID, Extension " &_
					"FROM Attachments " &_
					"WHERE Reference=" & Session.SessionID
				Set rs = cmd.Execute()

				FileNameNoPath = rs("Extension") & rs("FileId") & ".pdf"
				FilenameWithPath = SitePath & attached_stub_directory & FileNameNoPath

			else
				dim fileExtension
				dim fileId

				FileNameNoPath = fileExtension & fileExtension & ".pdf"
				FilenameWithPath = SitePath & attached_stub_directory & FileNameNoPath
			end if

			'Maintain Attachment Pages
			pagesToAttach = "Page1=1; Page2=2; Page3=3; Page4=4; Page5=5; Page6=11; Page7=17; Page8=19; Page9=20; Page10=21; Page11=23;" 'Page12=17; Page13=21; Page14=22;"

			Set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToAttach)

			'\\personnelplus.net.\attached\boi\BOI16984.pdf
			'break FilenameWithPath

			if isDev then
				'print "isDev"
				FileNameWithPath = replace(FilenameWithPath, "\\personnelplus.net\attached", Server.MapPath("\") & "\pdfServer\scratch")
			end if

			'print FilenameWithPath

			NewDoc.Save FilenameWithPath

			if not rpcMode then
				cmd.CommandText = "" &_
					"UPDATE Attachments " &_
					"SET FileName='\\personnelplus.net\attached\" &_
					attached_stub_directory &_
					FileNameNoPath &_
					"', Extension='pdf', Reference=0 WHERE Reference=" & Session.SessionID
				cmd.Execute()
				'hrefLink = Replace(FilenameWithPath, " ", "%20")
			end if
		else
			Select Case request.QueryString("giveme")
			Case "mostofit"
				pagesToPrint  = "" &_
					"Page1=" & applicationP1 & "; " &_
					"Page2=" & applicationP2 & "; "

				CurrentPage = policies

				'policies and procedures signature [if signed, suppress printing]
				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & policies & "; "
					CurrentPage = CurrentPage + 1
				end if

				'noncompete
				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & noncompete & "; "
					CurrentPage = CurrentPage + 1
				end if

				'unemployment policy signature [if signed, suppress printing]
				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & unemployment & "; "
					CurrentPage = CurrentPage + 1
				end if

				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & i9 & "; "  &_
					"Page" & (CurrentPage + 1) & "=" & i9P2 & "; " &_
					"Page" & (CurrentPage + 2) & "=" & i9P3 & "; " &_
					"Page" & (CurrentPage + 3) & "=" & skills & "; " &_
					"Page" & (CurrentPage + 4) & "=" & skillsP2 & "; " &_
					"Page" & (CurrentPage + 5) & "=" & skillsP3 & "; " &_
					"Page" & (CurrentPage + 6) & "=" & payroll & "; " &_
					"Page" & (CurrentPage + 7) & "=" & f8850 & "; " &_
					"Page" & (CurrentPage + 8) & "=" & f8850P2 & "; " &_
					"Page" & (CurrentPage + 9) & "=" & f9061 & "; " &_
					"Page" & (CurrentPage + 10) & "=" & f9061P2 & "; " &_
					"Page" & (CurrentPage + 11) & "=" & f9061P3 & "; " &_
					"Page" & (CurrentPage + 12) & "=" & f9061P4 & "; " &_

				CurrentPage = CurrentPage + 13

				'other forms  [if signed, suppress printing]
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint &_
						"Page" & (CurrentPage + 0) & "=" & safety & "; " &_
						"Page" & (CurrentPage + 1) & "=" & drug & "; " &_
						"Page" & (CurrentPage + 2) & "=" & sexual & "; "

					CurrentPage = CurrentPage + 3
				end if

				'pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=16; " &_
				'	"Page" & (CurrentPage + 1) & "=12; "
				'CurrentPage = CurrentPage + 2

				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=17; "
					CurrentPage = CurrentPage + 1
				end if

				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=19; " &_
					"Page" & (CurrentPage + 1) & "=20; " &_
					"Page" & (CurrentPage + 2) & "=21; " &_
					"Page" & (CurrentPage + 3) & "=22; "
				aCopy = " [copy]"

			case "allofit"
				pagesToPrint  = "Page1=" & applicationP1 & "; " &_
								"Page2=" & applicationP2 & "; " &_
								"Page3=" & policies & "; " &_
								"Page4=" & noncompete & "; " &_
								"Page5=" & unemployment & "; " &_
								"Page6=" & Page6 & "; " &_
								"Page7=" & i9 & "; " &_
								"Page8=" &  i9P2 & "; " &_
								"Page9=" & i9P3 & "; " &_
								"Page10=" & Page10 & "; " &_
								"Page11=" & w4 & "; " &_
								"Page12=" & w4P2 & "; " &_
								"Page13=" & skills & "; " &_
								"Page14=" & skillsP2 & "; " &_
								"Page15=" & skillsP3 & "; " &_
								"Page16=" & Page16 & "; " &_
								"Page17=" & background & "; " &_
								"Page18=" & Page18 & "; " &_
								"Page19=" & safety & "; " &_
								"Page20=" & drug & "; " &_
								"Page21=" & sexual & "; " &_
								"Page22=" & payroll & "; " &_
								"Page23=" & dearEmployer & "; " &_
								"Page24=" & Page24 & "; " &_
								"Page25=" & f8850 & "; " &_
								"Page26=" & f8850P2 & "; " &_
								"Page27=" & f9061 & "; " &_
								"Page28=" & f9061P2 & "; " &_
								"Page29=" & f9061P3 & "; " &_
								"Page30=" & f9061P4 & "; "
						aCopy = " [copy]"

			case "justapp"
				pagesToPrint  = "Page1=" & applicationP1 & "; " &_
								"Page2=" & applicationP2 & "; "
				aCopy = " [copy]"

			case else
				CurrentPage = 1
				if IsNull(CurrentApplication.ApplicantAgree) = True Then
					pagesToPrint  = "Page" & CurrentPage & "=1; Page" & CurrentPage+1 & "=" & applicationP2 & " ; "
					CurrentPage = CurrentPage + 2
				end if

				'policies and procedures signature [if signed, suppress printing]
				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & policies & "; "
					pagesToPrint = pagesToPrint & "Page" & CurrentPage + 1 & "=" & noncompete & "; "
					CurrentPage = CurrentPage + 2
				end if

				'unemployment policy signature [if signed, suppress printing]
				if IsNull(CurrentApplication.UnEmpAgree) = True then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & unemployment & "; "
					CurrentPage = CurrentPage + 1
				end if

				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & i9 & " ; " &_
					"Page" & (CurrentPage + 1) & "=" & i9P2 & "; " &_
					"Page" & (CurrentPage + 2) & "=" & i9P3 & "; " &_
					"Page" & (CurrentPage + 3) & "=" & Page10 & "; "
					CurrentPage = CurrentPage + 4

				if IsNull(CurrentApplication.ApplicantAgree) = True Then 'w4
					pagesToPrint  = pagesToPrint & "Page" & CurrentPage & "=" & W4 & "; Page" & CurrentPage+1 & "=" & W4P2 & "; "
					CurrentPage = CurrentPage + 2
				end if

				pagesToPrint = pagesToPrint & "Page" & (CurrentPage) & "=" & skills & "; " &_
					"Page" & (CurrentPage + 1) & "=" & skillsP2 & "; " &_
					"Page" & (CurrentPage + 2) & "=" & skillsP3 & "; " &_
					"Page" & (CurrentPage + 3) & "=" & Page16 & "; "
					CurrentPage = CurrentPage + 4

				if IsNull(CurrentApplication.ApplicantAgree) = True Then
					pagesToPrint  = pagesToPrint & "Page" & CurrentPage & "=" & background & "; Page" & CurrentPage+1 & "=" & Page18 & "; "
					CurrentPage = CurrentPage + 2
				end if

				'other forms  [if signed, suppress printing]
				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint &_
						"Page" & (CurrentPage + 0) & "=" & safety & "; " &_
						"Page" & (CurrentPage + 1) & "=" & drug & "; " &_
						"Page" & (CurrentPage + 2) & "=" & sexual & "; "

					CurrentPage = CurrentPage + 3
				end if

				'pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=16; " &_
				'	"Page" & (CurrentPage + 1) & "=12; "
				'CurrentPage = CurrentPage + 2

				if IsNull(CurrentApplication.PAndPAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & dearEmployer & "; "
					CurrentPage = CurrentPage + 1
				end if

				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=" & f8850 & "; " &_
					"Page" & (CurrentPage + 1) & "=" & f8850P2 & "; " &_
					"Page" & (CurrentPage + 2) & "=" & f9061 & " ; " &_
					"Page" & (CurrentPage + 3) & "=" & f9061P2 & "; " &_
					"Page" & (CurrentPage + 4) & "=" & f9061P3 & "; " &_
					"Page" & (CurrentPage + 5) & "=" & f9061P4 & "; " &_
					"Page" & (CurrentPage + 6) & "=" & payroll & "; "

				aCopy = " [un-signed pages]"
		end select

		set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToPrint)

		Response.Buffer = true
		Response.Clear()
		Response.ContentType = "application/pdf"
		Response.AddHeader "Content-Type", "application/pdf"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & Chr(34)&   CurrentApplication.Lastname & ", " & CurrentApplication.Firstname & aCopy & ".pdf" & Chr(34)
		Response.BinaryWrite NewDoc.SaveToMemory
		Set Doc = Nothing
		Set Pdf = Nothing
		Session("noHeaders") = false
		Response.End
	End If
End Sub

if debug_mode then print "Running as service: Finished."

if not isservice then

%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
<%
end if

sub InsertUpdateActivity(appId, newApplication, site)
	const DispTypeCode = 3 'Disposistion status for 'TookPlace'
	Const ApptType = -1 'System Activity Type for 'Initial Interview'

	dim strWhatWasDone
		strWhatWasDone = "" &_
			"Applicant Information Updated by " &_
			"VMS User " & user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"

	dim cmd
	set cmd = Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(site))
		.CommandText =	"" &_
			"INSERT INTO Appointments " &_
				"(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, ContactId, Entered, EnteredBy, LocationId)" &_
				"VALUES (" &_
					"'" & Date() & "', " & _
					insert_number(appId) & ", " &_
					insert_string(strWhatWasDone) & ", " &_
					insert_string("{Anyone}") & ", " &_
					insert_number(ApptType) & ", " &_
					insert_number(DispTypeCode) & ", 0, " &_
					"'" & Date() & "', " & _
					insert_string(tUser_id) & ", 1" &_
				")"
		on error resume next
		.Execute()
		on error goto 0

	end with

	cmd.CommandText = "" &_
		"SELECT " &_
			"LastnameFirst, " &_
			"Address, " &_
			"City, " &_
			"State, " &_
			"Zip, " &_
			"ApplicantStatus, " &_
			"Telephone, " &_
			"Applicants.[2ndTelephone] AS AltTelephone, " &_
			"ShortMemo, " &_
			"DateAvailable, " &_
			"k AS Skills, " &_
			"AppChangedBy, " &_
			"AppChangedDate, " &_
			"EmailAddress, " &_
			"TaxJurisdiction, " &_
			"MaritalStatus " &_
		"FROM Applicants " &_
		"WHERE ApplicantID=" & appId

	dim rs
	set rs = cmd.Execute()

	if not rs.eof then
		'Populate old application with database values
		dim oldApplication
		set oldApplication = new cApplication
		with oldApplication
			.PrevLastnameFirst   = rs("LastnameFirst")
			.Address             = rs("Address")
			.City                = rs("City")
			.State               = rs("State")
			.Zip                 = rs("Zip")
			.ApplicantStatus     = rs("ApplicantStatus")
			.Telephone           = rs("Telephone")
			.AltTelephone        = rs("AltTelephone")
			.ShortMemo           = rs("ShortMemo")
			.DateAvailable       = rs("DateAvailable")
			.Skills              = rs("Skills")
			.AppChangedBy        = rs("AppChangedBy")
			.AppChangedDate      = rs("AppChangedDate")
			.EmailAddress        = rs("EmailAddress")
			.TaxJurisdiction     = rs("TaxJurisdiction")
			.MaritalStatus       = rs("MaritalStatus")
			.ApplicantId         = appId
		end with
	end if

	set oldApplication = nothing
	set rs             = nothing
	set cmd            = nothing

end sub

%>