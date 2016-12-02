<%
function findChanges(oldEnrollment, newEnrollment)
	dim applicantId
		applicantId = oldEnrollment.ApplicantId
		
	dim cmd, changedInfo
	set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = dsnLessTemps(oldEnrollment.SiteId)

	dim strWhatWasDone
		strWhatWasDone = "" &_
			"Applicant Information Updated by " &_
			"VMS User " & user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
	
	cmd.CommandText = MakeAppointmentSQL(oldEnrollment, strWhatWasDone, applicantId)

'print cmd.CommandText
	on error resume next
		cmd.Execute()
	on error goto 0
		
	'Applicant
	InsertActivity oldEnrollment.LastnameFirst, newEnrollment.LastnameFirst, "LastnameFirst", applicantId, cmd
	InsertActivity oldEnrollment.Address, newEnrollment.Address, "Address", applicantId, cmd
	InsertActivity oldEnrollment.City, newEnrollment.City, "City", applicantId, cmd
	InsertActivity oldEnrollment.State, newEnrollment.State, "State", applicantId, cmd
	InsertActivity oldEnrollment.Zip, newEnrollment.Zip, "Zip", applicantId, cmd
	InsertActivity oldEnrollment.ApplicantStatus, newEnrollment.ApplicantStatus, "ApplicantStatus", applicantId, cmd
	InsertActivity oldEnrollment.Telephone, newEnrollment.Telephone, "Telephone", applicantId, cmd
	InsertActivity oldEnrollment.AltTelephone, newEnrollment.AltTelephone, "AltTelephone", applicantId, cmd
	InsertActivity oldEnrollment.ShortMemo, newEnrollment.ShortMemo, "ShortMemo", applicantId, cmd
	InsertActivity oldEnrollment.k, newEnrollment.k, "Skills", applicantId, cmd
	InsertActivity oldEnrollment.AppChangedDate, newEnrollment.AppChangedDate, "AppChangedDate", applicantId, cmd
	InsertActivity oldEnrollment.EmailAddress, newEnrollment.EmailAddress, "EmailAddress", applicantId, cmd
	InsertActivity oldEnrollment.TaxJurisdiction, newEnrollment.TaxJurisdiction, "TaxJurisdiction", applicantId, cmd
	InsertActivity oldEnrollment.DateHired, newEnrollment.DateHired, "DateHired", applicantId, cmd
	InsertActivity oldEnrollment.Birthdate, newEnrollment.Birthdate, "Birthdate", applicantId, cmd
	InsertActivity oldEnrollment.MaritalStatus, newEnrollment.MaritalStatus, "MaritalStatus", applicantId, cmd
	InsertActivity oldEnrollment.EmpChangedDate, newEnrollment.EmpChangedDate, "EmpChangedDate", applicantId, cmd
	InsertActivity oldEnrollment.StateExemptions, newEnrollment.StateExemptions, "StateExemptions", applicantId, cmd
	InsertActivity oldEnrollment.FedExemptions, newEnrollment.FedExemptions, "FedExemptions", applicantId, cmd
	InsertActivity oldEnrollment.EmpChangedBy, newEnrollment.EmpChangedBy, applicantId, "EmpChangedBy", cmd
	
	set cmd = nothing
	
end function

function CompareProperties(oldData, newData, propertyName, applicantId)

	if (oldData <> newData) then
		select case lcase(propertyName)
		case "skills"
		
			dim oldSkills
			oldSkills = split(oldData, ".")
			
			dim addedSkills
			addedSkills = newData
			
			dim skill
			for each skill in oldSkills
				if len(skill) > 0 then 
					addedSkills = replace(addedSkills, "." & skill, "")
				end if
			next
			
			dim newSkills
			newSkills = split(newData, ".")
			
			dim removedSkills
			removedSkills = oldData
			
			for each skill in newSkills
				if len(skill) > 0 then
					removedSkills = replace(removedSkills, "." & skill, "")
				end if
			next
			
			CompareProperties = "" &_
					"Changed [Skills] " &_
					"added skills [" & addedSkills & "] " &_
					"removed [" & removedSkills & "] " &_
					"By ApplicantId: [" & applicantId & "]" 
			
			set oldSkills = nothing
			set newSkills = nothing
			
		case else
			CompareProperties = "" &_
				"Changed [" & propertyName & "] " &_
				"from [" & oldData & "] " &_
				"to [" & newData & "] " &_
				"By ApplicantId: [" & applicantId & "]" 
		
		end select
	end if

end function

function InsertActivity(oldData, newData, thisProperty, applicantId, cmd)
	dim changedInfo
	
	changedInfo = CompareProperties(oldData, newData, thisProperty, applicantId)
	if len(changedInfo) > 0 then
		cmd.CommandText = MakeAppointmentSQL(newEnrollment, left(changedInfo,255), applicantId)
		'print cmd.commandText
		on error resume next
		cmd.Execute()
		on error goto 0
	end if

end function
	
function MakeAppointmentSQL(objEnrollment, Comment, applicantId)
	const DispTypeCode = 3 'Disposistion status for 'TookPlace'
	Const ApptType = -1 'System Activity Type for 'Initial Interview'
	
		MakeAppointmentSQL =	"" &_
			"INSERT INTO Appointments " &_
				"(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, ContactId, Entered, EnteredBy, LocationId) " &_
				"VALUES (" &_
					"'" & Date() & "', " & _
					insert_number(applicantId) & ", " &_
					insert_string(Comment) & ", " &_
					insert_string("{Anyone}") & ", " &_
					insert_number(ApptType) & ", " &_
					insert_number(DispTypeCode) & ", 0, " &_
					"'" & Date() & "', " & _
					insert_string(tUser_id) & ", 1" &_
				")"
end function

function cleanAddress(address)
	'for future development

end function

%>

<!-- #include file='application.classes.vb' -->
