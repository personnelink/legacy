<!-- #include virtual='/include/system/functions/common.asp' -->
<%

dim Company, UserName, Password, ReTypedPassword, FirstName, MiddleName, LastName, AddressOne, AddressTwo
dim City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, usertype, weekends, taxid

'dim sqlrealtionID, rsrelationID, addressID, userID, companyID, mySmartMail, CreationStamp, sqlInformation

dim post_to
post_to = "maintainApplicant.asp"
errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Information'>"

dim where, where_friendly, who, who_check
where_friendly = request.QueryString("where")
where = getTempsDSN(where_friendly)
who = request.QueryString("who")
if IsNumeric(who) then who = cdbl(who)

if who > 0 then
	dim ApplicantId, lastnameFirst, addressline, cityline, telephone, sec_telephone, sec_telephone_type, ssn, exemptions, memo, reactiviation
	dim applicant_status, notes
	
	ApplicantId = request.Form("ApplicantId")
	applicant_status = request.form("applicant_status")

	dim entry_date, LastAssignDate, LastAssignCust, DateAvailable
	dim EmployeeNumber
	entry_date = request.form("EntryDate")
	LastAssignDate = request.form("LastAssignDate")
	LastAssignCust = request.form("LastAssignCust")
	DateAvailable = request.form("DateAvailable")
	EmployeeNumber = request.form("EmployeeNumber")
	
	dim app_skills
	app_skills = request.form("app_skills") 
	
	dim i, test_results(8)
	for i = 0 to 8
		test_results(i) = request.Form("UserNumeric" & i + 1)
	next
	
	lastnameFirst = request.form("lastnameFirst")
	addressline = request.form("addressline")
	cityline = request.form("cityline")
	telephone = FormatPhone(request.form("telephone"))
	sec_telephone = FormatPhone(request.form("sec_telephone"))
	sec_telephone_type = request.form("sec_telephone_type")
	ssn = format_ssn(request.form("ssn"))
	exemptions = request.form("exemptions")
	memo = request.form("memo")
	'reactivation = request.form("reactivation")
	email = request.form("email")
	notes = server.HTMLEncode(request.Form("Notes"))
	
	dim update_applicant
	update_applicant = request.Form("action")
	if update_applicant = "update" then
		dim update_cmd, sqlStr

		sqlStr = "UPDATE Applicants " & _
							"SET LastnameFirst = " & replace(insert_string(lastnameFirst), "Null", "''") & ", " &_
								"Address = " & replace(insert_string(addressline), "Null", "''") & ", " &_
								"City = " & replace(insert_string(parse_cityline(cityline, "c")), "Null", "''") & ", " &_
								"State = " & replace(insert_string(parse_cityline(cityline, "s")), "Null", "''") & ", " &_
								"Zip = " & replace(insert_string(parse_cityline(cityline, "z")), "Null", "''") & ", " &_
								"Telephone = " & replace(insert_string(only_numbers(telephone)), "Null", "''") & ", " &_
								"[2ndTelephone] = " & replace(insert_string(only_numbers(sec_telephone)), "Null", "''") & ", " &_
								"[2ndTeleDescription] = " & replace(insert_string(sec_telephone_type), "Null", "''") & ", " &_
								"SSNumber = " & replace(insert_string(strip_ssn(ssn)), "Null", "''") & ", " &_
								"FederalExemptions = " & replace(insert_string(exemptions), "Null", "''") & ", " &_
								"ShortMemo = " & replace(insert_string(memo), "Null", "''") & ", " &_
								"EmailAddress = " & replace(insert_string(email), "Null", "''") & ", "
								
								for i = 0 to 8
									sqlStr = sqlStr & "UserNumeric" & (i + 1) & " = " & insert_number(test_results(i)) & ", " 
								next
																
								sqlStr = Left(sqlStr, len(sqlStr) - 2) & " WHERE ApplicantID=" & who
		'print sqlStr
		set update_cmd = Server.CreateObject("adodb.connection")
		update_cmd.Open dsnLessTemps(where)
		update_cmd.execute sqlStr
		update_cmd.Close
		set update_cmd = nothing
		dim updated : updated = "<i>Successfully Updated</i>"
	end if
	
	
	if not (cdbl(ApplicantId)) = cdbl(who) then 
		dim applicant_cmd, applicant
		set applicant_cmd = server.CreateObject("adodb.command")
		with applicant_cmd
			.activeconnection = dsnLessTemps(where)
			.CommandText = "SELECT Applicants.ApplicantId, Applicants.ApplicantStatus, Applicants.LastnameFirst, Applicants.Address, " &_
						"Applicants.City, Applicants.State, Applicants.Zip, Applicants.Telephone, Applicants.[2ndTelephone] AS SecTelephone, " &_
						"Applicants.[2ndTeleDescription] AS SecTelDesc, Applicants.Sex, Applicants.SSNumber, Applicants.MaritalStatus, " &_
						"Applicants.FederalExemptions, Applicants.[I9/W4] AS IW, Applicants.TaxJurisdiction, Applicants.ShortMemo, " &_
						"Applicants.UserNumeric1, Applicants.UserNumeric2, Applicants.UserNumeric3, Applicants.UserNumeric4, Applicants.UserNumeric5, " &_
						"Applicants.UserNumeric6, Applicants.UserNumeric7, Applicants.UserNumeric8, Applicants.UserNumeric9, Applicants.EntryDate, " &_
						"Applicants.LastAssignDate, Applicants.LastAssignCust, Applicants.DateAvailable, Applicants.EmployeeNumber, Applicants.k, " &_
						"Applicants.AppChangedBy, Applicants.AppChangedDate, Applicants.EmailAddress, Applicants.LocationId, Applicants.IsPrivate, " &_
						"Applicants.EmailTime, Applicants.LastPortalLogin, Applicants.PhotoFile, Applicants.ContactPath, NotesApplicants.Notes " &_
						"FROM Applicants LEFT JOIN NotesApplicants ON Applicants.ApplicantId = NotesApplicants.ApplicantId " &_
						"WHERE Applicants.ApplicantId=" & who & ";"
			.Prepared = true
		End With
		
		Set applicant = applicant_cmd.Execute
		
		for i = 0 to 8
			test_results(i) = applicant.fields.item("UserNumeric" & i + 1)
		next
		
		ApplicantId = applicant.fields.item("ApplicantId")
		applicant_status = applicant.fields.item("ApplicantStatus")
		
		entry_date = FormatDateTime(applicant.fields.item("EntryDate"),2)
		LastAssignDate = applicant.fields.item("LastAssignDate")
		LastAssignCust = applicant.fields.item("LastAssignCust")
		DateAvailable = applicant.fields.item("DateAvailable")
		EmployeeNumber = applicant.fields.item("EmployeeNumber")

		
		lastnameFirst = applicant.fields.item("LastnameFirst")
		addressline = applicant.fields.item("Address")
		cityline = applicant.fields.item("City") & ", " &_
			applicant.fields.item("State") & " " &_
			applicant.fields.item("Zip")
			
		telephone = FormatPhone(applicant.fields.item("Telephone"))
		sec_telephone = FormatPhone(applicant.fields.item("SecTelephone"))
		sec_telephone_type = applicant.fields.item("SecTelDesc")
		ssn = format_ssn(applicant.fields.item("SSNumber"))
		exemptions = applicant.fields.item("FederalExemptions")
		memo = applicant.fields.item("ShortMemo")
		'reactivation = applicant.fields.item("reactivation")
		email = applicant.fields.item("EmailAddress")
		
		notes = applicant.fields.item("Notes")
		
		dim vms_applicant_id, iAppIdStart, iAppIdStop
		iAppIdStart = instr(notes, "/* Id=")
		if iAppIdStart > 0 then
			iAppIdStart = instr(iAppIdStart, notes, ", Applicant=") + 12 
			iAppIdStop = instr(iAppIdStart, notes, ", Interviewer=")
			if iAppIdStop > iAppIdStart then
				vms_applicant_id = cdbl(mid(notes, iAppIdStart, iAppIdStop - iAppIdStart))
			end if
		end if
		
		dim resume_ctrl, strEncodeName
		strEncodeName = replace(lastnameFirst, ",", "%2c")
		strEncodeName = replace(strEncodeName, " ", "+")
		
		resume_ctrl = "" &_
			"nampa=checked&" &_
			"twin=checked&" &_
			"boise=checked&" &_
			"burley=checked&" &_
			"other=checked&" &_
			"resume_age=all&" &_
			"query=" & strEncodeName & "&" &_
			"searchCatalog=Resumes&isname=true&action="
		
		app_skills = applicant.fields.item("k")
		if len(app_skills) >2 then 
			dim skills_cmd, skills
			
			set skills_cmd = server.CreateObject("adodb.command")
			skills_cmd.ActiveConnection = applicant.ActiveConnection
			app_skills = replace(mid(app_skills, 2, len(app_skills)-2), ".", " or KeywordId=")
			skills_cmd.CommandText = "SELECT Keyword FROM KeyDictionary WHERE KeywordId=" & app_skills

			set skills = skills_cmd.Execute()
			app_skills = ""
			do until skills.eof
				app_skills = app_skills & "<li>" & skills("Keyword") & "</li>"
				skills.movenext
			loop
			set skills = nothing
			set skills_cmd = nothing
		end if
		set applicant = nothing
		set applicant_cmd = nothing

	end if
	
	' load mysql vms related attributes based on 'inCODE' lookup in users application
	'
	dim enrolledSites
	set enrolledSites = new cEnrollments
	enrolledSites.LoadInfo()
	
	'print enrolledSites.interviewID
	'print enrolledSites.userID
	
	maintainApplicantForm
	
end if

function CheckField(thisField)

end function

function CheckPhone(thisField)

end function





function getActivities(thisApplicant)

	dim activities_cmd
	set activities_cmd = server.CreateObject("adodb.command")
	with activities_cmd
		.activeconnection = dsnLessTemps(where)
		.CommandText = "SELECT Appointments.ApplicantId, Appointments.AppDate, Appointments.Comment, " &_
			"Appointments.AssignedTo, ApptTypes.ApptType, Dispositions.Disposition, Appointments.Customer, " &_
			"Appointments.Reference, Appointments.ContactId, Appointments.Entered, Appointments.EnteredBy, " &_
			"Appointments.LastModified, Appointments.LastModifiedBy " &_
			"FROM Dispositions RIGHT JOIN (ApptTypes RIGHT JOIN Appointments ON ApptTypes.ApptTypeCode = " &_
			"Appointments.ApptTypeCode) ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
			"WHERE Appointments.ApplicantId=" & ApplicantId & " " &_
			"ORDER BY Appointments.AppDate DESC;"
	end with
	
	dim activities
	set activities = activities_cmd.execute
	
	if activities.eof then
		response.write "<i>No actitivies</i>"
	else
		response.write "<table>"
		do until activities.eof
			response.write "<tr><th>" & activities.fields.item("AppDate") & "</th> " &_
					"<td>&nbsp;</td>" &_
					"<th>" & activities.fields.item("Disposition") & "</th></tr>" &_
					"<tr><td colspan=3>" & activities.fields.item("Comment") & "</td></tr>"
			activities.movenext
		loop
		response.write "</table>"
	end if
	set activities = nothing
	set activities_cmd = nothing
end function

class cEnrollments
		private m_userID
		private m_applicationID
		private m_interviewID
		private m_inPER
		private m_inBUR
		private m_inBOI
		private m_inPOC
		private m_inPPI
		private m_inIDA
		private m_inWYO
		private m_inORE
		private m_firstname
		private m_lastname
		private m_ssn
		private m_phone
		private m_altphone
		private m_email
		private m_altemail
		public property get userID()
			userID = m_userID
		end property
		public property let userID(p_userID)
			m_userID = p_userID
		end property

		public property get applicationID()
			applicationID = m_applicationID
		end property
		public property let applicationID(p_applicationID)
			m_applicationID = p_applicationID
		end property

		public property get interviewID()
			interviewID = m_interviewID
		end property
		public property let interviewID(p_interviewID)
			m_interviewID = p_interviewID
		end property

		public property get inPER()
			inPER = m_inPER
		end property
		public property let inPER(p_inPER)
			m_inPER = p_inPER
		end property

		public property get inBUR()
			inBUR = m_inBUR
		end property
		public property let inBUR(p_inBUR)
			m_inBUR = p_inBUR
		end property

		public property get inBOI()
			inBOI = m_inBOI
		end property
		public property let inBOI(p_inBOI)
			m_inBOI = p_inBOI
		end property

		public property get inPOC()
			inPOC = m_inPOC
		end property
		public property let inPOC(p_inPOC)
			m_inPOC = p_inPOC
		end property

		public property get inPPI()
			inPPI = m_inPPI
		end property
		public property let inPPI(p_inPPI)
			m_inPPI = p_inPPI
		end property

		public property get inIDA()
			inIDA = m_inIDA
		end property
		public property let inIDA(p_inIDA)
			m_inIDA = p_inIDA
		end property

		public property get inWYO()
			inWYO = m_inWYO
		end property
		public property let inWYO(p_inWYO)
			m_inWYO = p_inWYO
		end property

		public property get inORE()
			inORE = m_inORE
		end property
		public property let inORE(p_inORE)
			m_inORE = p_inORE
		end property

		public property get firstname()
			firstname = m_firstname
		end property
		public property let firstname(p_firstname)
			m_firstname = p_firstname
		end property

		public property get lastname()
			lastname = m_lastname
		end property
		public property let lastname(p_lastname)
			m_lastname = p_lastname
		end property

		public property get ssn()
			ssn = m_ssn
		end property
		public property let ssn(p_ssn)
			m_ssn = p_ssn
		end property

		public property get phone()
			phone = m_phone
		end property
		public property let phone(p_phone)
			m_phone = p_phone
		end property

		public property get altphone()
			altphone = m_altphone
		end property
		public property let altphone(p_altphone)
			m_altphone = p_altphone
		end property

		public property get email()
			email = m_email
		end property
		public property let email(p_email)
			m_email = p_email
		end property

		public property get altemail()
			altemail = m_altemail
		end property
		public property let altemail(p_altemail)
			m_altemail = p_altemail
		end property



		'#############  Public Functions ##############

		public function LoadInfo()
				dim strSQL
				strSQL = "" &_
				"SELECT tbl_users.userID, tbl_users.applicationID, tbl_users.addressID, " &_
					"tbl_users.firstName, tbl_users.lastName, tbl_users.userPhone, tbl_users.userSPhone, " &_
					"tbl_users.userName, tbl_users.userEmail, tbl_users.userAlternateEmail, tbl_applications.interviewID, " &_
					"tbl_applications.inPER, tbl_applications.inIDA, tbl_applications.inBOI, tbl_applications.inBUR, tbl_applications.inPOC, tbl_applications.inPPI " &_
				"FROM tbl_users " &_
					"RIGHT JOIN tbl_applications ON tbl_users.applicationID=tbl_applications.applicationID " &_
				"WHERE tbl_applications.in" & getTempsCompCode(company_dsn_site) & "='" & applicantid & "';"

				LoadInfo = LoadData (strSQL)
		end function

		'#############  Private Functions ##############
		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			'p_RS.PageSize = m_ItemsPerPage
			p_RS.PageSize = 1
			dim m_PageCount
			m_PageCount = p_RS.PageCount

			dim m_Page
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page

			dim thisOrderTab, id
			if not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page ) then
				with me
					.userID        = p_RS.fields("userID").value 'userID
					.applicationID = p_RS.fields("applicationID").value 'applicationID
					.interviewID   = p_RS.fields("interviewID").value 'interviewID
					.inPER         = p_RS.fields("inPER").value 'inPER
					.inBUR         = p_RS.fields("inBUR").value 'inBUR
					.inBOI         = p_RS.fields("inBOI").value 'inBOI
					.inPOC         = p_RS.fields("inPOC").value 'inPOC
					.inPPI         = p_RS.fields("inPPI").value 'inPPI
					.inIDA         = p_RS.fields("inIDA").value 'inIDA
'					.inWYO         = p_RS.fields("inWYO").value 'inWYO
'					.inORE         = p_RS.fields("inORE").value 'inORE
					.firstname     = p_RS.fields("firstName").value 'firstname
					.lastname      = p_RS.fields("lastName").value 'lastname
					'.ssn           = p_RS.fields("ssn").value 'ssn
					.phone         = p_RS.fields("userPhone").value 'phone
					.altphone      = p_RS.fields("userSPhone").value 'altphone
					.email         = p_RS.fields("userEmail").value 'email
					.altemail      = p_RS.fields("userAlternateEmail").value 'altemail
				end with
			end if
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			set rs = GetRSfromDB(p_strSQL, MySql)
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class












%>