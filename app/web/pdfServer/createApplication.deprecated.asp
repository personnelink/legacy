<%Option Explicit%>
<!-- Revised: 2009.07.05 -->
<%
session("add_css") = "submitapplication.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff

if request.QueryString("action") = "review" or request.querystring("action") = "inject" or request.queryString("update") = "1" then 
	Session("no_header") = true
end if
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%

Public Function PCase(strInput)
	Dim iPosition  ' Our current position in the string (First character = 1)
	Dim iSpace     ' The position of the next space after our iPosition
	Dim strOutput  ' Our temporary string used to build the function's output

	iPosition = 1
	Do While InStr(iPosition, strInput, " ", 1) <> 0
		iSpace = InStr(iPosition, strInput, " ", 1)
		strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		strOutput = strOutput & LCase(Mid(strInput, iPosition + 1, iSpace - iPosition))
		iPosition = iSpace + 1
	Loop
	strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
	strOutput = strOutput & LCase(Mid(strInput, iPosition + 1))
	PCase = strOutput
End Function

' ------------------------------------------------------------------
'  StripCharacters
' ------------------------------------------------------------------
Function StripCharacters (TextString)
	Dim RegularExpression
	If Len(TextString) > 0 Then
		Set RegularExpression = New RegExp
		RegularExpression.Pattern = "[<>']"
		RegularExpression.Global = True
		If VarType(TextString) = 8 Then
			StripCharacters = RegularExpression.Replace(TextString, "")
		End If
	End If
End Function

Dim	userID, email, mainPhone, altPhone, firstName, lastName, lastNameFirst, addressOne, addressTwo, currentlyEmployed, sex, maritalStatus
Dim city, appState, zipcode, emailupdates, desiredWageAmount, minWageAmount, availableWhen, workCommuteHow
Dim workLicenseState, workLicenseExpire, workLicenseNumber, workCommuteDistance, skillsSet, autoInsurance, applicantName
Dim workTypeDesired, workAuthProof, workAge, workValidLicense, workLicenseType, workRelocate, workConviction
Dim workConvictionExplain, eduLevel, additionalInfo, employerNameHistOne, jobHistAddOne, jobHistPhoneOne, jobHistCityStateZipOne, jobHistSupervisorOne
Dim jobDutiesOne, jobHistFromDateOne, JobHistToDateOne, jobReasonOne, employerNameHistTwo, jobHistAddTwo, jobHistPhoneTwo
Dim jobHistCityStateZipTwo, jobHistSupervisorTwo, jobDutiesTwo, jobHistFromDateTwo, JobHistToDateTwo
Dim jobReasonTwo, employerNameHistThree, jobHistAddThree, jobHistPhoneThree, jobHistCityStateZipThree
Dim jobHistSupervisorThree, jobDutiesThree, jobReasonThree, jobHistFromDateThree, JobHistToDateThree, cityStateZip, completeAddress
Dim Temps, NewApplicant, jobHistPayOne, jobHistPayTwo, jobHistPayThree, ssn, citizen, alienType, alienNumber
Dim whatToDo, ssnRE, insertIdentityInfo, smoker, dob
Dim username, unempAgree, pandpAgree, applicantAgree
dim aliasNames

dim w4a, w4b, w4c, w4d, w4e, w4f, w4g, w4h, w4more, sql
dim w4total, w4exempt, w4filing, w4namediffers
dim ecFullName, ecAddress, ecPhone, ecDoctor, ecDocPhone, middleinit

ApplicationID = Request.Form("appID")
If ApplicationID = "" Then
	ApplicationID = Request.QueryString("appID")
End If

Set ssnRE = New RegExp
ssnRE.Pattern = "[()-.<>'$\s]"
ssnRE.Global = True

'MySql = "Driver={MySQL ODBC 5.1 Driver};Server=x.personnelp	MySql = "DRIVER={MySQL ODBC 3.51 Driver};Server=70.56.159.58;port=6612;Option=35;Database=pplusvms;User ID=online;Password=.SystemUser"
'lus.net;Port=6612;Option=35;Database=pplusvms;User ID=online;Password=.SystemUse"
'MySql = "DRIVER={MySQL ODBC 3.51 Driver};Server=70.56.159.58;port=6612;Option=35;Database=pplusvms;User ID=online;Password=.SystemUser"

'break MySql

Set Database = Server.CreateObject("ADODB.Connection")
Database.Open MySql

If Request.Form("formAction") = "viewprint" Then
	'Dim updateSSN, updateAvailableWhen, updateWorkLicenseState, updateWorkLicenseExpire, updateWorkLicenseNumber
	
	'updateSSN = ssnRE.Replace(Request.Form("ssn"), "") : If Len(updateSSN) > 0 Then updateSSN = " ssn='" & updateSSN & "', "
	'updateWorkLicenseNumber = Request.Form("workLicenseNumber") : If Len(updateWorkLicenseNumber) > 0 Then updateWorkLicenseNumber = " workLicenseNumber='" & updateWorkLicenseNumber & "'"

	'insertIdentityInfo = "UPDATE tbl_applications SET" &_
	'	updateSSN &_
	'	updateWorkLicenseNumber
	'If Right(insertIdentityInfo, 1) = "," Then insertIdentityInfo = Left(insertIdentityInfo, Len(insertIdentityInfo) -1)
	'insertIdentityInfo = insertIdentityInfo & " WHERE applicationID=" & ApplicationID
	'Database.Execute(insertIdentityInfo)
End If

dim mProviders(3, 5), mProviderId

mProviderId = 0

const mpName	  = 0
const mpAddress	  = 1
const mpCityline  = 2
const mpPhone	  = 3
const mpFax		  = 4
const mpOpen 	  = 5


Dim getSite_cmd, getSite, siteAddr, whereWeAre, mailAddress, mailZip, mailCity
Set getSite_cmd = Server.CreateObject ("ADODB.Command")
siteAddr = Request.ServerVariables("REMOTE_ADDR")
siteAddr = Left(siteAddr, Len(siteAddr) - (4 - Instr(Right(siteAddr, 4), ".")))

With getSite_cmd
	.ActiveConnection = MySql
	.CommandText = "SELECT tbl_siteips.site, tbl_siteips.locationId, med_providers.name, med_providers.address, " &_
		"med_providers.phone, med_providers.fax, med_providers.cityandstate, med_providers.openhours " &_
		"FROM tbl_siteips INNER JOIN med_providers ON tbl_siteips.locationId = med_providers.bindtolocationid " &_
		"WHERE remote_addr LIKE '" & siteAddr & "%' " &_
		"ORDER BY med_providers.name, med_providers.address, med_providers.cityandstate;"
	.Prepared = true
End With

Set getSite = getSite_cmd.Execute
if not getSite.eof then
	whereWeAre = getSite("site")
else
	'print getSite_cmd.CommandText
	'break "site determination failed."
end if

do until getSite.eof or mProviderId > 3
	mproviders(mProviderId, mpName)		= getSite("name")
	mproviders(mProviderId, mpAddress)	= getSite("address")
	mproviders(mProviderId, mpCityline)	= getSite("cityandstate")
	mproviders(mProviderId, mpPhone)	= getSite("phone")
	mproviders(mProviderId, mpFax)		= getSite("fax")
	mproviders(mProviderId, mpOpen)		= getSite("openhours")

	mProviderId = mProviderId + 1
	getSite.movenext
loop

Application("getSite_cmd") = Empty 
Application("getSite") = Empty 
Application("siteAddre") = Empty 

'On Error Resume Next
sql = "SELECT tbl_users.addressID, tbl_users.userName, tbl_applications.*, tbl_w4.* " &_
	"FROM (tbl_users RIGHT JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID) LEFT JOIN tbl_w4 ON tbl_users.userID=tbl_w4.userid " &_
	"WHERE (((tbl_applications.applicationID)=" & ApplicationID & "));"

Set dbQuery = Database.Execute(sql)
	If Not dbQuery.EOF Then
		email = dbQuery("email")
		mainPhone = dbQuery("mainPhone")
			if len(mainPhone) > 0 then mainPhone = ssnRE.Replace(mainPhone, "")
		altPhone = dbQuery("altPhone")
			if len(altPhone) > 0 then altPhone = ssnRE.Replace(altPhone, "")
		firstName = PCase(StripCharacters(dbQuery("firstName")))
		lastName = PCase(StripCharacters(dbQuery("lastName")))

		aliasNames = dbQuery("aliasNames")
		ssn = dbQuery("ssn")
			if len(ssn) > 0 then ssn = ssnRE.Replace(ssn, "")
		dob = dbQuery("dob")
		If IsDate(dob) Then dob = FormatDateTime(dob, 2)
		lastNameFirst = lastName & ", " & firstName
		applicantName = firstName & " " & lastName
		
		'Get address
		Dim userAddressId, getUserAddress, addressLine
		userAddressId = dbQuery("addressID")
		If Len(userAddressId) > 0 Then
			Set getUserAddress = Database.Execute("SELECT address, addressTwo, city, state, zip " &_
				"FROM tbl_addresses WHERE addressID=" & userAddressID)
			addressOne = StripCharacters(getUserAddress("address"))
			addressTwo = StripCharacters(getUserAddress("addressTwo"))
			city = PCase(StripCharacters(getUserAddress("city")))
			appState = StripCharacters(getUserAddress("state"))
			zipcode = only_zipcode(getUserAddress("zip"))
			Set getUserAddress = Nothing
		Else
			addressOne = StripCharacters(dbQuery("addressOne"))
			addressTwo = StripCharacters(dbQuery("addressTwo"))
			city = PCase(StripCharacters(dbQuery("city")))
			appState = StripCharacters(dbQuery("appState"))
			zipcode = only_zipcode(dbQuery("zipcode"))
		End If
		
		cityStateZip = city & ", " & appState & " " & zipcode
		If Len(addressTwo) > 0 Then
			completeAddress = addressOne & ", " & addressTwo & ", " & cityStateZip
		Else
			completeAddress = addressOne & ", " & cityStateZip
		End If
		
		emailupdates = StripCharacters(dbQuery("emailupdates"))
		desiredWageAmount = StripCharacters(dbQuery("desiredWageAmount"))
		minWageAmount = StripCharacters(dbQuery("minWageAmount"))
		currentlyEmployed = StripCharacters(dbQuery("currentlyEmployed"))
		maritalStatus = StripCharacters(dbQuery("maritalStatus"))
		sex = StripCharacters(dbQuery("sex"))
		smoker = dbQuery("smoker")
		citizen = dbQuery("citizen")
		alienType = dbQuery("alienType")
		alienNumber = dbQuery("alienNumber")
		workAuthProof = dbQuery("workAuthProof")
		workTypeDesired = StripCharacters(dbQuery("workTypeDesired"))
		workAge = dbQuery("workAge")
		workValidLicense = dbQuery("workValidLicense")
		workLicenseType = dbQuery("workLicenseType")
		autoInsurance = dbQuery("autoInsurance")
		workRelocate = StripCharacters(dbQuery("workRelocate"))
		workConviction = StripCharacters(dbQuery("workConviction"))
		workConvictionExplain = dbQuery("workConvictionExplain")
		
		ecFullName = dbQuery("ecFullName")
		ecAddress = dbQuery("ecAddress")
		ecPhone = dbQuery("ecPhone")
		ecDoctor = dbQuery("ecDoctor")
		ecDocPhone = dbQuery("ecDocPhone")
		w4a = dbQuery("a") : if isnull(w4a) then w4a = 0
		w4b = dbQuery("b") : if isnull(w4b) then w4b = 0
		w4c = dbQuery("c") : if isnull(w4c) then w4c = 0
		w4d = dbQuery("d") : if isnull(w4d) then w4d = 0
		w4e = dbQuery("e") : if isnull(w4e) then w4e = 0
		w4f = dbQuery("f") : if isnull(w4f) then w4f = 0
		w4g = dbQuery("g") : if isnull(w4g) then w4g = 0
		w4h = dbQuery("h") : w4h = w4a + w4b + w4c + w4d + w4e + w4f + w4g
		w4more = dbQuery("more")
		middleinit = dbQuery("middleinit")
		w4total = dbQuery("total")
		w4exempt = dbQuery("exempt")
		w4filing = dbQuery("filing")
		w4namediffers = dbQuery("namediffers")
		
		availableWhen = dbQuery("availableWhen")
		workCommuteHow = dbQuery("workCommuteHow")
		workCommuteDistance = dbQuery("workCommuteDistance")
		workLicenseState = dbQuery("workLicenseState")
		workLicenseExpire = dbQuery("workLicenseExpire")
		workLicenseNumber = dbQuery("workLicenseNumber")
		autoInsurance = dbQuery("autoInsurance")
		
		eduLevel = StripCharacters(dbQuery("eduLevel"))
		additionalInfo = StripCharacters(dbQuery("additionalInfo"))
		skillsSet = dbQuery("skillsSet")
		employerNameHistOne = PCase(StripCharacters(dbQuery("employerNameHistOne")))
		jobHistAddOne = StripCharacters(dbQuery("jobHistAddOne"))
		jobHistPhoneOne = StripCharacters(dbQuery("jobHistPhoneOne"))
		jobHistPayOne = StripCharacters(dbQuery("jobHistPayOne"))
		jobHistCityStateZipOne = StripCharacters(dbQuery("jobHistCityOne")) & ", " & StripCharacters(dbQuery("jobHistStateOne")) & " " & StripCharacters(dbQuery("jobHistZipOne"))
		jobHistSupervisorOne = StripCharacters(dbQuery("jobHistSupervisorOne"))
		jobDutiesOne = dbQuery("jobDutiesOne")
		jobHistFromDateOne = StripCharacters(dbQuery("jobHistFromDateOne"))
		JobHistToDateOne = StripCharacters(dbQuery("JobHistToDateOne"))
		jobReasonOne = dbQuery("jobReasonOne")
		employerNameHistTwo = PCase(StripCharacters(dbQuery("employerNameHistTwo")))
		jobHistAddTwo = StripCharacters(dbQuery("jobHistAddTwo"))
		jobHistPhoneTwo = StripCharacters(dbQuery("jobHistPhoneTwo"))
		jobHistPayTwo = StripCharacters(dbQuery("jobHistPayTwo"))
		jobHistCityStateZipTwo = StripCharacters(dbQuery("jobHistCityTwo")) & ", " & StripCharacters(dbQuery("jobHistStateTwo")) & " " & StripCharacters(dbQuery("jobHistZipTwo"))
		jobHistSupervisorTwo = StripCharacters(dbQuery("jobHistSupervisorTwo"))
		jobDutiesTwo = dbQuery("jobDutiesTwo")
		jobHistFromDateTwo = StripCharacters(dbQuery("jobHistFromDateTwo"))
		JobHistToDateTwo = StripCharacters(dbQuery("JobHistToDateTwo"))
		jobReasonTwo = dbQuery("jobReasonTwo")
		employerNameHistThree = PCase(StripCharacters(dbQuery("employerNameHistThree")))
		jobHistAddThree = StripCharacters(dbQuery("jobHistAddThree"))
		jobHistPhoneThree = StripCharacters(dbQuery("jobHistPhoneThree"))
		jobHistPayThree = StripCharacters(dbQuery("jobHistPayThree"))
		jobHistCityStateZipThree = StripCharacters(dbQuery("jobHistCityThree")) & ", " & StripCharacters(dbQuery("jobHistStateThree")) & " " & StripCharacters(dbQuery("jobHistZipThree"))
		jobHistSupervisorThree = StripCharacters(dbQuery("jobHistSupervisorThree"))
		jobDutiesThree = dbQuery("jobDutiesThree")
		jobHistFromDateThree = StripCharacters(dbQuery("jobHistFromDateThree"))
		JobHistToDateThree = StripCharacters(dbQuery("JobHistToDateThree"))
		jobReasonThree = dbQuery("jobReasonThree")

		pandpAgree = dbQuery("pandpAgree")
		unempAgree = dbQuery("unempAgree")
		applicantAgree = dbQuery("applicantAgree")
		username = dbQuery("userName")
					
	End If
	Database.Close
	On Error Goto 0
	
whatToDo = Request.QueryString("action")
If whatToDo = "review" Then 
		viewApplication ""
ElseIf whatToDo = "inject" Then
	InjectIntoTemps
End If

Sub InjectIntoTemps

	dim insertInfo, name_link, id_link
	Dim sqlApplicant, sqlPR3MSTR, sqlNotesApplicants, sqlAttachment, re, ApplicantID, WhichCompany, checkIfUnique, i, ApplicantID_cmd, EmployeeCode
	Dim Skill, skillsArray, insertionStatus, applicantNote, getExistingNote, UserNumeric9

	'set debug flag'
	Dim debugMode, debugText
	debugMode = cbool(Request.QueryString("debug"))
	if debugMode then debugText = "&debug=1"

	Set Temps = Server.CreateObject("ADODB.Connection")
	WhichCompany = Request.QueryString("company")
	Select Case WhichCompany
	Case "PER"
		Temps.Open dsnLessTemps(PER)
	Case "BUR"
		Temps.Open dsnLessTemps(BUR)
	Case "BOI"
		Temps.Open dsnLessTemps(BOI)
	Case "IDA"
		Temps.Open dsnLessTemps(IDA)
	End Select
	
	Set re = New RegExp
	re.Pattern = "[()-.<>'$]"
	re.Global = True
	
	If workValidLicense = "y" Then UserNumeric9 = -1 Else UserNumeric9 = 0
	
	applicantNote = "%date%......APPLIED IN %city%" & Chr(13) & "    Seeking Work Type:	---" &_
		 Chr(13) & "Shift:{}" &_
		 Chr(13) & "Minimum Wage Accepted:	%wage%" &_
		 Chr(13) & "Valid ID and/or DL:{}"  &_
		 Chr(13) & "Transportation Type:{}" &_
		 Chr(13) & "Commute Distance:{}" & Chr(13) &_
		 Chr(13) & "Worked for other Temp Services: {}" &_
		 Chr(13) & "    If yes, list services: {}" & Chr(13) &_
		 Chr(13) & "Interviewed By: {}" &_
		 Chr(13) &  Chr(13) &_
		 "Work History Verification:"
		applicantNote = Replace(applicantNote, "%date%", Date())
		applicantNote = Replace(applicantNote, "%city%", city)
		applicantNote = Replace(applicantNote, "%wage%", minWageAmount)
		applicantNote = applicantNote & Chr(13) & employerNameHistOne &_
			Chr(13) & employerNameHistTwo &_
			Chr(13) & employerNameHistThree
	
	'Routine to build sql to insert a new record
	Set checkIfUnique = Temps.Execute("Select SSNumber, ApplicantID FROM Applicants WHERE SSNumber='" & ssn & "'")
	If checkIfUnique.EOF Then	
		Do 
			If i = 0 Then
				EmployeeCode = Ucase(Left(lastName, 3)) & Right(ssn, 3)
			Else
				EmployeeCode = Left(EmployeeCode, 5) & Chr(65 + i)
			End If
			Set checkIfUnique = Temps.Execute("Select EmployeeNumber FROM Applicants WHERE EmployeeNumber='" & EmployeeCode & "'")
			i = i + 1
		Loop Until checkIfUnique.EOF
		Set checkIfUnique = Nothing
		
		ApplicantID_cmd = Temps.Execute("SELECT Max(Applicants.ApplicantID) + 1 As MaxApplicantID FROM Applicants")
		ApplicantID = ApplicantID_cmd("MaxApplicantID")
		Set ApplicantID_cmd = Nothing
		
		if len(mainPhone) > 0 then
			mainPhone = re.Replace(mainPhone, "")
		end if
		if len(altPhone) > 0 then
			altPhone = re.Replace(altPhone, "")
		end if
		
		sqlApplicant = "INSERT INTO Applicants (LastnameFirst, Address, City, State, Zip, ApplicantStatus, ApplicantID, " &_
				"Telephone, 2ndTelephone, ShortMemo, EntryDate, DateAvailable, k, AppChangedBy, AppChangedDate, EmployeeNumber, " &_
				"EmailAddress, SSNumber, Sex, MaritalStatus, TaxJurisdiction, UserNumeric9) VALUES (" &_
				insert_string(lastNameFirst) & ", " &_
				insert_string(addressOne) & ", " &_
				insert_string(city) & ", " &_
				insert_string(appState) & ", " &_
				insert_string(zipcode) & ", " &_
				"1, " &	ApplicantID & ", " &_
				insert_string(mainPhone) & ", " &_
				insert_string(altPhone) & ", " &_
				"'Active', " &_
				"#" & Now() & "#, " &_
				insert_string(Date()) & ", " &_
				insert_string(skillsSet) & ", " &_
				insert_string("V-" & user_id) & ", " &_
				"#" & Now() & "#, " &_
				insert_string(EmployeeCode) & ", " &_
				insert_string(email) & ", " &_
				insert_string(ssn) & ", " &_
				insert_string(Ucase(sex)) & ", " &_
				insert_string(Ucase(maritalStatus)) & ", 'ID', " &_
				UserNumeric9 & ")"
		
		sqlPR3MSTR = "INSERT INTO PR3MSTR (EmployeeNumber, Birthdate, Sex, DateHired, MaritalStatus, ActivityStatus, " &_
				"FedExemptions, StateExemptions, " &_
				"EmpChangedBy, EmpChangedDate, TaxJurisdictionTaxPackageId, ApplicantID) " &_
				"VALUES ('" & EmployeeCode & "', " &_
				"#" & dob & "#, '" &_
				Ucase(Sex) & "', " &_
				"#" & Now() & "#, '" &_
				Ucase(maritalStatus) & "', 'A', " &_
				insert_number(w4total) & ", " &_
				insert_number(w4total) & ", " &_
				"'V-" & user_id & "', " &_
				"#" & Now() & "#, 3, " &_
				ApplicantID & ")"
		
		Set checkIfUnique = Temps.Execute("Select Notes FROM NotesApplicants WHERE ApplicantID=" & ApplicantID)
		If checkIfUnique.EOF Then
			sqlNotesApplicants = "INSERT INTO NotesApplicants (ApplicantID, Notes) VALUES (" & ApplicantID & ", '" &	applicantNote & "')"
		End If
'Existing Applicant and user has chosen to update applicant's information and status		
	ElseIf Request.QueryString("update") = "1" Then		
		ApplicantID_cmd = Temps.Execute("SELECT ApplicantID, EmployeeNumber FROM Applicants WHERE SSNumber='" & ssn & "'")
		ApplicantID = ApplicantID_cmd("ApplicantID")
		EmployeeCode = ApplicantID_cmd("EmployeeNumber")
		If isnull(EmployeeCode) or len(EmployeeCode) = 0 then
			Do 
				If i = 0 Then
					EmployeeCode = Ucase(Left(lastName, 3)) & Right(ssn, 3)
				Else
					EmployeeCode = Left(EmployeeCode, 5) & Chr(65 + i)
				End If
				Set checkIfUnique = Temps.Execute("Select EmployeeNumber FROM Applicants WHERE EmployeeNumber='" & EmployeeCode & "'")
				i = i + 1
			Loop Until checkIfUnique.EOF
			Set checkIfUnique = Temps.Execute("UPDATE Applicants SET EmployeeNumber=" & insert_string(EmployeeCode) & "WHERE ApplicantID=" & ApplicantID)
			Set checkIfUnique = Nothing
		end if
		
		if len(mainPhone) > 0 then mainPhone = re.Replace(mainPhone, "")
		if len(altPhone) > 0 then altPhone = re.Replace(altPhone, "")

		if len(addressOne) >30 then addressOne = left(addressOne, 30) 'truncate address if too long
		sqlApplicant = "UPDATE Applicants SET " &_
			"LastnameFirst=" & insert_string(lastNameFirst) & ", " &_
			"Address=" & insert_string(addressOne) & ", " &_
			"City=" & insert_string(city) & ", " &_
			"State=" & insert_string(appState) & ", " &_
			"Zip=" & insert_string(zipcode) & ", " &_
			"ApplicantStatus=1, " &_
			"Telephone=" & insert_string(mainPhone) & ", " &_
			"2ndTelephone=" & insert_string(altPhone) & ", " &_
			"ShortMemo='Active', " &_
			"DateAvailable=#" & Now() & "#, " &_
			"k=" & insert_string(skillsSet) & ", " &_
			"AppChangedBy='V-" & user_id & "', " &_
			"AppChangedDate=#" & Now() & "#, " &_
			"EmailAddress=" & insert_string(email) & ", " &_
			"TaxJurisdiction='ID', " &_
			"MaritalStatus=" & insert_string(Ucase(maritalStatus)) & " " &_
			"WHERE ApplicantID=" & ApplicantID 
		
		Set checkIfUnique = Temps.Execute("Select ApplicantID FROM PR3MSTR WHERE ApplicantID=" & ApplicantID)
		If checkIfUnique.EOF Then

			sqlPR3MSTR = "INSERT INTO PR3MSTR (EmployeeNumber, Birthdate, Sex, DateHired, MaritalStatus, ActivityStatus, " &_
				"FedExemptions, StateExemptions, EmpChangedBy, EmpChangedDate, " &_
				"TaxJurisdictionTaxPackageId, ApplicantID) VALUES ('" & EmployeeCode & "', " &_
				"#" & dob & "#, '" &_
				Ucase(Sex) & "', " &_
				"#" & Now() & "#, '" &_
				Ucase(maritalStatus) & "', 'A', " &_
				insert_number(w4total) & ", " &_
				insert_number(w4total) & ", " &_
				"'V-" & user_id & "', " &_
				"#" & Now() & "#, 3, " &_
				ApplicantID & ")"
		Else
			sqlPR3MSTR = "UPDATE PR3MSTR SET " &_
				"DateHired=#" & Now() & "#, " &_
				"Birthdate=#" & dob & "#, " &_
				"MaritalStatus='" & Ucase(maritalStatus) & "', " &_
				"EmpChangedBy='V-" & user_id & "', " &_
				"EmpChangedDate=#" & Now() & "#, " &_
				"StateExemptions=" & insert_number(w4total) & ", " &_
				"FedExemptions=" & insert_number(w4total) & ", " &_
				"TaxJurisdictionTaxPackageId=3 " &_
				"WHERE ApplicantID=" & ApplicantID 
		End If
		Set checkIfUnique = Nothing

		
		Set checkIfUnique = Temps.Execute("Select ApplicantID FROM NotesApplicants WHERE ApplicantID=" & ApplicantID)
		if checkIfUnique.EOF Then
			sqlNotesApplicants = "INSERT INTO NotesApplicants (ApplicantID, Notes) VALUES (" & ApplicantID & ", '" &	applicantNote & "')"
		else
			getExistingNote = Temps.Execute("SELECT Notes FROM NotesApplicants WHERE ApplicantID=" & ApplicantID)
			dim chk_if
			chk_if = getExistingNote("Notes")
			if instr(chk_if, "Valid ID and/or DL:{") = 0 then
				applicantNote = Replace(chk_if, "'", "''") & Chr(13) & applicantNote
				sqlNotesApplicants = "UPDATE NotesApplicants SET Notes='" & applicantNote & "' WHERE ApplicantID="& ApplicantID
			end if
		end If
		insertionStatus =  "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td><b>Applicant Information Updated</b>.</td></tr>"

'Applicant exisits, present option to update information
	Else
		dim tmpAplicantId
		tmpAplicantId = checkIfUnique("ApplicantID")
		id_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & WhichCompany & "&who=" & tmpAplicantId & """>" & tmpAplicantId & "</a>"

		insertionStatus =   "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td>Applicant [id: " & id_link & " ] already exists in system....</td>" &_
			"</tr><tr><th>&nbsp;</th><td><div class=" & Chr(34) & "alignL" & Chr(34) & " style=" & Chr(34) & "padding:10px 0 10px 0;" &_
			Chr(34) & "> <a class=" & Chr(34) & "squarebutton" & Chr(34) & " href=" & Chr(34) & "https://secure.personnelplus.net/" &_
			"pdfServer/pdfApplication/createApplication.asp?appID=" & ApplicationID & "&action=inject&update=1&company=" & WhichCompany & debugText & Chr(34) & " style=" &_
			Chr(34) & "margin-left: 6px" & Chr(34) & "><span>Update Application and Status</span></a></div></td></tr>"
	End If
		
	'Modify Temps Database
	If Len(sqlApplicant) >0 Then
		If debugMode Then Response.Write(sqlApplicant & "<br><br>")

		'break sqlApplicant
		Temps.Execute(sqlApplicant)
		sqlAttachment = "INSERT INTO Attachments (ApplicantID, Reference, DescriptionOfFile, OriginalName, Extension, [By], [On], Source) VALUES (" &_
			ApplicantID & ", " &_
			Session.SessionID & ", " &_
			"'Application', " &_
			"'" & lastNameFirst & "', " &_
			"'" & WhichCompany & "', " &_
			"'" & user_id & "', #" &_
			Now() & "#, " &_
			"1)"

		Temps.Execute(sqlAttachment)
		viewApplication "attach"
	End If
	
	If Len(sqlPR3MSTR) >0 Then
		If debugMode Then Response.Write(sqlPR3MSTR & "<br><br>")

		'break sqlPR3MSTR
		Temps.Execute(sqlPR3MSTR)
	End If

	If Len(sqlNotesApplicants) >0 Then
		If debugMode Then Response.Write(sqlNotesApplicants & "<br><br>")
		Temps.Execute(sqlNotesApplicants)
	End If
	
	If ApplicantID > 0 Then
		If len(skillsSet & "") > 0 Then skillsArray = Split(skillsSet, ".")
		On Error Resume Next
		For each Skill In skillsArray
			If Len(Skill & "") > 0 AND IsNumeric(Skill) Then
				Set checkIfUnique = Temps.Execute("Select ApplicantId FROM KeysApplicants WHERE ApplicantId=" & ApplicantID & " AND KeywordId=" & Skill)
				If checkIfUnique.EOF Then
					Temps.Execute("INSERT INTO KeysApplicants (ApplicantID, KeywordId) VALUES (" & ApplicantID & ", " & Skill & ")")
				End If
			End If
		Next
		On Error Goto 0
	End If
	Temps.Close 
	
	' <%=decorateTop("doneInsertingApp", "notToShort", "Applicant Application Information")
	'<div id="whatWasInserted"> 
	

	Database.Open MySql
	If ApplicantID > 0 Then
		Database.Execute "UPDATE tbl_applications SET in" & WhichCompany & "=" & ApplicantID & ", lastInserted=Now() WHERE applicationID=" & ApplicationID
	Else
		Database.Execute "UPDATE tbl_applications SET in" & WhichCompany & "=-1 WHERE applicationID=" & ApplicationID
	End If
		Database.Close

	if len(mainPhone) > 0 then mainPhone = re.Replace(mainPhone, "")
	if len(altPhone) > 0 then altPhone = re.Replace(altPhone, "")

	
	name_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & WhichCompany & "&who=" & ApplicantID & """>" & lastNameFirst & "</a>"
	id_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & WhichCompany & "&who=" & ApplicantID & """>" & ApplicantID & "</a>"
	insertInfo = "<div id=""whatWasInserted""><p>The Applicants Application has been inserted into Temps Plus. " &_
		"Review applicants information in Temps for accuracy and edit as necessary.</p>" &_
		"<p>Below is some of the identifying information that was used to create the applicant in Temps:</p>" &_
		"<p>&nbsp;</p>" &_
		"<p>&nbsp;</p>" &_
		"<table>" &_
		"<tr><th>Email Address:&nbsp;</th><td>" & email & "</td></tr>" &_
		"<tr><th>Applicant Name:&nbsp;</th><td>" & lastNameFirst & "</td></tr>" &_
		"<tr><th>Applicant ID:&nbsp;</th><td>" & id_link & "</td></tr>" &_
		"<tr><th>Phone:&nbsp;</th><td>" & mainPhone & " " & altPhone & "</td></tr>" &_
		"<tr><th>Address:&nbsp;</th><td>" & addressOne & "</td></tr>" &_
		"<tr><th></th><td>" & city & ", " & appState & " " & zipcode & "</td></tr>" &_
		insertionStatus &_
		"<tr><th>&nbsp;</th><td></td></tr>" &_
		"<tr><th>&nbsp;</th><td></td></tr>" &_
		"</table></div>"

	insertInfo = set_session("insertInfo", insertInfo)
	
	session("no_header") = false	
	Response.Redirect("/include/system/tools/activity/applications/view/")

End Sub

Sub viewApplication (action)
		Dim signed
		signed = "Electronically Signed by " & firstName & " " & lastName & VbCrLf  &_
			"DN: cn=" & firstName & " " & lastName & ",username=" & username & VbCrLf &_
			 "Date: "

		Dim PDF, Doc, Font, field
		Set PDF = Server.CreateObject("Persits.PDF")

		' Open an existing form
		Set Doc = PDF.OpenDocument( Server.MapPath( "EmploymentApplication.pdf" ) )

		' Create font object
		'Set Font = Doc.Fonts("Helvetica")
		Set Font = Doc.Fonts("Arial")

		' Remove XFA support from it
		Doc.Form.RemoveXFA

		'On Error Resume Next
		
		Set field = Doc.Form.FindField("root[0].applicationP1[0].lastName[0]")
		field.SetFieldValue lastName, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].firstName[0]")
		field.SetFieldValue firstName, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].userPhone[0]")
			if len(mainPhone) > 0 then field.SetFieldValue mainPhone, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].userSPhone[0]")
			if len(altPhone) > 0 then field.SetFieldValue altPhone, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].ssn[0]")
		field.SetFieldValue Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4), Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].date[0]")
		field.SetFieldValue Date(), Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].address[0]")
		field.SetFieldValue addressOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].city[0]")
		field.SetFieldValue city, Font
		'Set field = Doc.Form.FindField("root[0].applicationP1[0].city[1]")
		'field.SetFieldValue city, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].state[0]")
		field.SetFieldValue appState, Font
		'Set field = Doc.Form.FindField("root[0].applicationP1[0].state[1]")
		'field.SetFieldValue appState, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].zip[0]")
		field.SetFieldValue zipcode, Font
		'Set field = Doc.Form.FindField("root[0].applicationP1[0].zip[1]")
		'field.SetFieldValue zipcode, Font
		'Set field = Doc.Form.FindField("root[0].applicationP1[0].addressTwo[0]")
		field.SetFieldValue addressTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].city[0]")
		field.SetFieldValue city, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].state[0]")
		field.SetFieldValue appState, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].zip[0]")
		field.SetFieldValue zipcode, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].desiredWageAmount[0]")
		field.SetFieldValue desiredWageAmount, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].minWageAmount[0]")
		field.SetFieldValue minWageAmount, Font

		Select Case currentlyEmployed
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].employedYes[0]")
			field.SetFieldValue "1", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].employedNo[0]")
			field.SetFieldValue "1", Font
		End Select
		
		Select Case workTypeDesired
		Case "f"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].fulltime[0]")
			field.SetFieldValue "1", Font
		Case "p"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].temporary[0]")
			field.SetFieldValue "1", Font
		Case "a"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].fulltime[0]")
			field.SetFieldValue "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].temporary[0]")
			field.SetFieldValue "1", Font
		End Select

		Select Case smoker
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].smokerYes[0]")
			field.SetFieldValue "1", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].smokerNo[0]")
			field.SetFieldValue "1", Font
		End Select
		
		Select Case workAge
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].eighteenYes[0]")
			field.SetFieldValue "1", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].eighteenNo[0]")
			field.SetFieldValue "1", Font
		End Select
		
		Select Case citizen
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].authorizedYes[0]")
			field.SetFieldValue "1", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].authorizedNo[0]")
			field.SetFieldValue "1", Font
		End Select
'		Set field = Doc.Form.FindField("root[0].applicationP1[0].availableWhen[0]")
'		field.SetFieldValue availableWhen, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].felonyExplain[0]")
			if len(workConvictionExplain) > 0 then field.SetFieldValue workConvictionExplain, Font

		Select Case workConviction
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].felonyYes[0]")
			field.SetFieldValue "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].convictionType[0]")
			field.SetFieldValue "felony", Font
		Case "f"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].felonyYes[0]")
			field.SetFieldValue "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].convictionType[0]")
			field.SetFieldValue "felony", Font
		Case "m"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].felonyYes[0]")
			field.SetFieldValue "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].convictionType[0]")
			field.SetFieldValue "misdemeanor", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].felonyNo[0]")
			field.SetFieldValue "1", Font
		End Select
		
		Select Case workAuthProof
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].authProofYes[0]")
			field.SetFieldValue "1", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].authProofNo[0]")
			field.SetFieldValue "1", Font
		End Select
		
		Set field = Doc.Form.FindField("root[0].applicationP1[0].workCommuteHow[0]")
		if not isnull(workCommuteHow) then field.SetFieldValue workCommuteHow, Font

		Select Case workValidLicense
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].driversYes[0]")
			field.SetFieldValue "1", Font
			Select Case workLicenseType
			Case "n"
				Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseType[0]")
				field.SetFieldValue "Non-Commerical", Font
			Case "a"
				Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseType[0]")
				field.SetFieldValue "CDL-A", Font
			Case "b"
				Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseType[0]")
				field.SetFieldValue "CDL-B", Font
			Case "c"
				Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseType[0]")
				field.SetFieldValue "CDL-C", Font
			Case Else
				Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseType[0]")
				field.SetFieldValue "[none]", Font
			End Select
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].driversNo[0]")
			field.SetFieldValue "1", Font
		End Select

		
		
		Select Case autoInsurance
		Case "y"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].insuranceYes[0]")
			field.SetFieldValue "1", Font
		Case "n"
			Set field = Doc.Form.FindField("root[0].applicationP1[0].insuranceNo[0]")
			field.SetFieldValue "1", Font
		End Select
		
		If Instr(skillsSet, ".16.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].landscaping[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".20.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].delivery[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".88.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].janitorial[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".73.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].warehouse[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".89.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].inventory[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".21.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].security[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".647.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].shippingReceiving[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".202.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cleanup[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".17.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].farm[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".23.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].dairy[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".605.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].sprinkler[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".606.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].floral[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1073.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].yardsGrounds[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".12.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].housekeeping[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".198.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plumber[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1316.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].generalLabor[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".215.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].concreteRough[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".274.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].concreteFinish[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".216.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].carpenterRough[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".220.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].carpenterFinish[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".204.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].framing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".190.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].readBlueprints[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".62.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].roofing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".18.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].painting[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".440.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].electrician[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".229.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].hvac[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".19.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].siding[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1600.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].flagger[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1305.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].generalLaborL[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1608.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].generalLaborM[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1610.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].generalLaborH[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".457.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].machineOperator[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1078.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].forkliftOperator[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".208.") > 0 Then Set field = Doc.Form.FindField("root[0].applicationP1[0].packaging[0]") : field.SetFieldValue  "1", Font
		
		If Instr(skillsSet, ".219.") > 0 Then Set field = Doc.Form.FindField("root[0].applicationP1[0].palletizing[0]") : field.SetFieldValue  "1", Font
		
		If Instr(skillsSet, ".206.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].sanitation[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".24.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].lab[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1003.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].qa[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".42.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].maintenance[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".34.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].electrical[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".418.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].electronics[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".429.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].hydraulics[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".184.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cabinetMaker[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".647.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].industrialShippingReceiving[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".773.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].fishProcessing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1057.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].dieselMechanic[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1042.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].autoMechanic[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".55.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].smallEngineMechanic[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".287.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].machinist[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1082.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].toolDie[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".697.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].millLathe[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".501.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].welder[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".286.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].glazier[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1121.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].skilledLaborOther[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".652.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].assemblyPackaging[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1284.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticMachineOperator[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".665.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticInjection[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".214.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticMolding[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1617.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticMaintenance[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1338.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticCustomerService[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1472.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticQA[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".254.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticPrepRoom[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1285.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticGlueRoom[0]")
			field.SetFieldValue  "1", Font
		End If
		
		'If Instr(skillsSet, ".16.") > 0 Then
		'	Set field = Doc.Form.FindField("root[0].applicationP1[0].plasticOther[0]")
		'	field.SetFieldValue  "1", Font
		'End If
		
		If Instr(skillsSet, ".1115.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceWaitress[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".653.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceLinecook[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".442.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceChef[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1604.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceDishwasher[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1268.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceHostess[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".230.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceSupervisor[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1255.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceBanquet[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1603.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceSanitation[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1119.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].foodserviceWarehouse[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".438.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingCDL[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].classCDL[0]")
			field.SetFieldValue  "CDL-A", Font
		End If
		
		If Instr(skillsSet, ".343.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingCDL[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].classCDL[0]")
			field.SetFieldValue  "CDL-B", Font
		End If
		
		If Instr(skillsSet, ".500.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "Air Brakes", Font
		End If
		
		If Instr(skillsSet, ".558.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "All - TPXS", Font
		End If
		
		If Instr(skillsSet, ".1602.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - H", Font
		End If
		
		If Instr(skillsSet, ".556.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - M", Font
		End If
		
		If Instr(skillsSet, ".500.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "Air Brakes", Font
		End If
		
		If Instr(skillsSet, ".491.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - N", Font
		End If
		
		If Instr(skillsSet, ".493.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - P", Font
		End If
		
		If Instr(skillsSet, ".1633.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - S", Font
		End If
		
		If Instr(skillsSet, ".489.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - T", Font
		End If
		
		If Instr(skillsSet, ".1632.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].drivingEndorcements[0]")
			field.SetFieldValue  "1", Font
			Set field = Doc.Form.FindField("root[0].applicationP1[0].cdlEndorsements[0]")
			field.SetFieldValue  "End - X", Font
		End If
		
		If Instr(skillsSet, ".94.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalReceptionist[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1122.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalSwitchboard[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".267.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clerical[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".207.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalTelephone[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".709.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalWordprocessing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".590.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalDictation[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".852.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalSpeedwriting[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".76.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalTyping[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".360.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalStatisticalTyping[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1614.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalLegalOffice[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".221.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalMedicalOffice[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".97.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalCashier[0]")
			field.SetFieldValue  "1", Font
		End If
				
		If Instr(skillsSet, ".608.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clerical10Key[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".123.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalTeller[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".81.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalDataEntry[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".27.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareWindows[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".600.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalMortgage[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".86.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalFiling[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".613.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalMedicalTerminology[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1399.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalCreditCollection[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".942.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalCustomerService[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1621.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalTitleEscrow[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1208.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].otherSoftware[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".205.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareWord[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".426.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareWordPerfect[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".792.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareExcel[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".95.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].clericalFaxCopier[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1179.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingAR[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1173.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingAP[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".31.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingPayroll[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".187.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingBankRecon[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".84.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingPosting[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".85.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingTrialBalance[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".111.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingFinancialStmntPrep[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".144.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingMonthEndClose[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1609.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingAccounting[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".630.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingTax[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".607.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareQuicken[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".171.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwarePeachtree[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].bookkeepingOther[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".99.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthDentalAssist[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".38.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthCNA[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".203.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthCMA[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".339.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthWardClerk[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".425.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthLabTechnician[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".24.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthGeneralLabor[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".459.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthHousekeeping[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".421.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthRN[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".269.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthDietary[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".288.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].healthLPN[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".289.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalComputerTech[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1394.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalCopierTech[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".722.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalTelecomTech[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".534.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalElectronicsTech[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".134.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalCADD[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".231.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalEngineer[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalType[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalCertificate[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".241.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalTelecommunications[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".987.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].technicalComputerNetwork[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareUsedOne[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareUsedTwo[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].softwareUsedThree[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".260.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesOutside[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".164.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesRoute[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".105.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesTelemarketing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".182.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesMarketing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".183.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesProductDemo[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".247.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesSurvey[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".7.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].salesRetail[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".586.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementAccounting[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1626.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementCPA[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".196.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementHR[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".39.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementPurchasing[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".197.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementPR[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1615.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementInfoSys[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".120.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementSales[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1618.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementTechnical[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".1098.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementQA[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".514.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementConstruction[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".482.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementFarm[0]")
			field.SetFieldValue  "1", Font
		End If
		
		If Instr(skillsSet, ".231.") > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP1[0].managementEngineering[0]")
			field.SetFieldValue  "1", Font
		End If
		
'		Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseState[0]")
'		field.SetFieldValue workLicenseType, Font
'		Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseExpire[0]")
'		field.SetFieldValue workLicenseExpire, Font
'		Set field = Doc.Form.FindField("root[0].applicationP1[0].workLicenseNumber[0]")
'		field.SetFieldValue workLicenseNumber, Font
		Set field = Doc.Form.FindField("root[0].applicationP1[0].workCommuteDistance[0]")
		field.SetFieldValue workRelocate & "; " & workCommuteDistance, Font
		

'		Set field = Doc.Form.FindField("root[0].applicationP1[0].eduLevel[0]")
'		field.SetFieldValue eduLevel, Font
'
'		Set field = Doc.Form.FindField("root[0].applicationP1[0].additionalInfo[0]")
'		field.SetFieldValue additionalInfo, Font

		Set field = Doc.Form.FindField("root[0].applicationP1[0].workCommuteDistance[0]")
		field.SetFieldValue workRelocate & "; " & workCommuteDistance, Font

		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistFromDateOne[0]")
			if len(jobHistFromDateOne) > 0 then field.SetFieldValue jobHistFromDateOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].JobHistToDateOne[0]")
			if len(JobHistToDateOne) > 0 then field.SetFieldValue JobHistToDateOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].employerNameHistOne[0]")
			if len(employerNameHistOne) > 0 then field.SetFieldValue employerNameHistOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistSupervisorOne[0]")
			if len(jobHistSupervisorOne) > 0 then field.SetFieldValue jobHistSupervisorOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistAddOne[0]")
			if len(jobHistAddOne) > 0 then field.SetFieldValue jobHistAddOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistCityStateZipOne[0]")
			if len(jobHistCityStateZipOne) > 0 then field.SetFieldValue jobHistCityStateZipOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistPhoneOne[0]")
			if len(jobHistPhoneOne) > 0 then field.SetFieldValue jobHistPhoneOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobDutiesOne[0]")
			if len(jobDutiesOne) > 0 then field.SetFieldValue jobDutiesOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistPayOne[0]")
			if len(jobHistPayOne) > 0 then field.SetFieldValue jobHistPayOne, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobReasonOne[0]")
			if len(jobReasonOne) > 0 then field.SetFieldValue jobReasonOne, Font

		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistFromDateTwo[0]")
			if len(jobHistFromDateTwo) > 0 then field.SetFieldValue jobHistFromDateTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].JobHistToDateTwo[0]")
			if len(JobHistToDateTwo) > 0 then field.SetFieldValue JobHistToDateTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].employerNameHistTwo[0]")
			if len(employerNameHistTwo) > 0 then field.SetFieldValue employerNameHistTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistSupervisorTwo[0]")
			if len(jobHistSupervisorTwo) > 0 then field.SetFieldValue jobHistSupervisorTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistAddTwo[0]")
			if len(jobHistAddTwo) > 0 then field.SetFieldValue jobHistAddTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistCityStateZipTwo[0]")
			if len(jobHistCityStateZipTwo) > 0 then field.SetFieldValue jobHistCityStateZipTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistPhoneTwo[0]")
			if len(jobHistPhoneTwo) > 0 then field.SetFieldValue jobHistPhoneTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobDutiesTwo[0]")
			if len(jobDutiesTwo) > 0 then field.SetFieldValue jobDutiesTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistPayTwo[0]")
			if len(jobHistPayTwo) > 0 then field.SetFieldValue jobHistPayTwo, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobReasonTwo[0]")
			if len(jobReasonTwo) > 0 then field.SetFieldValue jobReasonTwo, Font

		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistFromDateThree[0]")
			if len(jobHistFromDateThree) > 0 then field.SetFieldValue jobHistFromDateThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].JobHistToDateThree[0]")
			if len(JobHistToDateThree) > 0 then field.SetFieldValue JobHistToDateThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].employerNameHistThree[0]")
			if len(employerNameHistThree) > 0 then field.SetFieldValue employerNameHistThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistSupervisorThree[0]")
			if len(jobHistSupervisorThree) > 0 then field.SetFieldValue jobHistSupervisorThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistAddThree[0]")
			if len(jobHistAddThree) > 0 then field.SetFieldValue jobHistAddThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistCityStateZipThree[0]")
			if len(jobHistCityStateZipThree) > 0 then field.SetFieldValue jobHistCityStateZipThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistPhoneThree[0]")
			if len(jobHistPhoneThree) > 0 then field.SetFieldValue jobHistPhoneThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobDutiesThree[0]")
			if len(jobDutiesThree) > 0 then field.SetFieldValue jobDutiesThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobHistPayThree[0]")
			if len(jobHistPayThree) > 0 then field.SetFieldValue jobHistPayThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].jobReasonThree[0]")
			if len(jobReasonThree) > 0 then field.SetFieldValue jobReasonThree, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].date[0]")
		field.SetFieldValue date(), Font

		'Emergency Contact
		Set field = Doc.Form.FindField("root[0].applicationP2[0].ecFullName[0]")
			if len(ecFullName) > 0 then field.SetFieldValue ecFullName, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].ecAddress[0]")
			if len(ecAddress) > 0 then field.SetFieldValue ecAddress, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].ecPhone[0]")
			if len(ecPhone) > 0 then field.SetFieldValue formatPhone(ecPhone), Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].ecDoctor[0]")
			if len(ecDoctor) > 0 then field.SetFieldValue ecDoctor, Font
		Set field = Doc.Form.FindField("root[0].applicationP2[0].ecDocPhone[0]")
			if len(ecDocPhone) > 0 then field.SetFieldValue formatPhone(ecDocPhone), Font

		'Applicant Application, sign
		If len(applicantAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].applicationP2[0].signature[0]")
				if not isnull(applicantAgree) = true then field.SetFieldValue signed & applicantAgree, Font
		End If

		'Policies
		Set field = Doc.Form.FindField("root[0].policies[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].policies[0].date[0]")
		field.SetFieldValue Date(), Font

		If len(pandpAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].policies[0].signature[0]")
				if not isnull(pandpAgree) = true then field.SetFieldValue signed & pandpAgree, Font
		End If
		
		'Unemployment
		Set field = Doc.Form.FindField("root[0].unemployment[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].unemployment[0].date[0]")
		field.SetFieldValue Date(), Font

		If len(unempAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].unemployment[0].signature[0]")
				if not isnull(unempAgree) = true then field.SetFieldValue signed & unempAgree, Font
		End If

		' Form I9
		Set field = Doc.Form.FindField("root[0].i9[0].lastname[0]")
			if len(lastName) > 0 then field.SetFieldValue lastName, Font
		Set field = Doc.Form.FindField("root[0].i9[0].firstname[0]")
			if len(firstName) > 0 then field.SetFieldValue firstName, Font
		Set field = Doc.Form.FindField("root[0].i9[0].address[0]")
			if len(addressOne) > 0 then field.SetFieldValue addressOne, Font
		Set field = Doc.Form.FindField("root[0].i9[0].city[0]")
			if len(city) > 0 then field.SetFieldValue city, Font
		Set field = Doc.Form.FindField("root[0].i9[0].state[0]")
			if len(appState) > 0 then field.SetFieldValue appState, Font
		Set field = Doc.Form.FindField("root[0].i9[0].zip[0]")
			if len(zipcode) > 0 then field.SetFieldValue zipcode, Font
		Set field = Doc.Form.FindField("root[0].i9[0].dob[0]")
			if len(dob) > 0 then field.SetFieldValue dob, Font
		Set field = Doc.Form.FindField("root[0].i9[0].ssn[0]")
			if len(ssn) = 9 then field.SetFieldValue Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4), Font
		If citizen = "y" Then
			Set field = Doc.Form.FindField("root[0].i9[0].citizen[0]")
			field.SetFieldValue "1", Font
		Else
			If alienType = "p" Then
				Set field = Doc.Form.FindField("root[0].i9[0].LPRAlienNumberCk[0]")
				field.SetFieldValue "1", Font
				Set field = Doc.Form.FindField("root[0].i9[0].LPRAlienNumber[0]")
				if not isnull(alienNumber) then field.SetFieldValue alienNumber, Font
			ElseIf alienType = "a" Then
				Set field = Doc.Form.FindField("root[0].i9[0].alienauthorizedtowork[0]")
				field.SetFieldValue "1", Font
				Set field = Doc.Form.FindField("root[0].i9[0].alienworknumber[0]")
				if not isnull(alienNumber) then field.SetFieldValue alienNumber, Font
			End If
		End If
		Set field = Doc.Form.FindField("root[0].i9[0].date[0]")
		field.SetFieldValue Date(), Font
		Set field = Doc.Form.FindField("root[0].i9[0].certificationdate[0]")
		field.SetFieldValue Date(), Font
		Set field = Doc.Form.FindField("root[0].i9[0].certtitle[0]")
		field.SetFieldValue "Client Services", Font
		Set field = Doc.Form.FindField("root[0].i9[0].businessnameaddress[0]")
		field.SetFieldValue branch_address, Font
		Set field = Doc.Form.FindField("root[0].i9[0].businessdate[0]")
		field.SetFieldValue Date(), Font
		
		' Form W4
		Set field = Doc.Form.FindField("root[0].w4[0].a[0]")
			if len(w4a) > 0 then field.SetFieldValue w4a, Font
		Set field = Doc.Form.FindField("root[0].w4[0].b[0]")
			if len(w4b) > 0 then field.SetFieldValue w4b, Font
		Set field = Doc.Form.FindField("root[0].w4[0].c[0]")
			if len(w4c) > 0 then field.SetFieldValue w4c, Font
		Set field = Doc.Form.FindField("root[0].w4[0].d[0]")
			if len(w4d) > 0 then field.SetFieldValue w4d, Font
		Set field = Doc.Form.FindField("root[0].w4[0].e[0]")
			if len(w4e) > 0 then field.SetFieldValue w4e, Font
		Set field = Doc.Form.FindField("root[0].w4[0].f[0]")
			if len(w4f) > 0 then field.SetFieldValue w4f, Font
		Set field = Doc.Form.FindField("root[0].w4[0].g[0]")
			if len(w4g) > 0 then field.SetFieldValue w4g, Font
		Set field = Doc.Form.FindField("root[0].w4[0].h[0]")
			if len(w4h) > 0 then field.SetFieldValue w4h, Font
		Set field = Doc.Form.FindField("root[0].w4[0].h[1]")
			if not isnull(w4total) then field.SetFieldValue w4total, Font
		Set field = Doc.Form.FindField("root[0].w4[0].more[0]")
			if len(w4more) > 0 then field.SetFieldValue w4more, Font
		
		select case w4filing
		case 0
			Set field = Doc.Form.FindField("root[0].w4[0].filingSingle[0]")
			field.SetFieldValue "1", Font
		case 1
			Set field = Doc.Form.FindField("root[0].w4[0].filingMarried[0]")
			field.SetFieldValue "1", Font
		case 2
			Set field = Doc.Form.FindField("root[0].w4[0].filingAsSingle[0]")
			field.SetFieldValue "1", Font
		end select
		
		if len(w4namediffers) = true then
			Set field = Doc.Form.FindField("root[0].w4[0].namediffers[0]")
		 	field.SetFieldValue "1", Font
		end if

		Set field = Doc.Form.FindField("root[0].w4[0].lastname[0]")
			if len(lastName) > 0 then field.SetFieldValue lastName, Font
		Set field = Doc.Form.FindField("root[0].w4[0].firstname[0]")
			if len(firstName) > 0 then field.SetFieldValue firstName & " " & middleinit, Font
		Set field = Doc.Form.FindField("root[0].w4[0].address[0]")
			if len(addressOne) > 0 then field.SetFieldValue addressOne, Font
		Set field = Doc.Form.FindField("root[0].w4[0].cityStateZip[0]")
			if len(cityStateZip) > 0 then field.SetFieldValue cityStateZip, Font
		Set field = Doc.Form.FindField("root[0].w4[0].ssn3[0]")
			if len(ssn) = 9 then field.SetFieldValue Left(ssn, 3), Font
		Set field = Doc.Form.FindField("root[0].w4[0].ssn2[0]")
			if len(ssn) = 9 then field.SetFieldValue Mid(ssn, 4, 2), Font
		Set field = Doc.Form.FindField("root[0].w4[0].ssn4[0]")
			if len(ssn) = 9 then field.SetFieldValue Right(ssn, 4), Font
		Set field = Doc.Form.FindField("root[0].w4[0].date[0]")
			field.SetFieldValue Date(), Font
		Set field = Doc.Form.FindField("root[0].w4[0].employerinfo[0]")
			field.SetFieldValue branch_address, Font
		Set field = Doc.Form.FindField("root[0].w4[0].office_location[0]")
			field.SetFieldValue company_location_description, Font

		If len(applicantAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].W4[0].signature[0]")
				if not isnull(applicantAgree) = true then field.SetFieldValue signed & applicantAgree, Font
		End If

		'Skills
		Set field = Doc.Form.FindField("root[0].skills[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].skills[0].date[0]")
		field.SetFieldValue Date(), Font


		' Background Check
		Set field = Doc.Form.FindField("root[0].background[0].lastName[0]")
			if len(lastName) > 0 then field.SetFieldValue lastName, Font
		Set field = Doc.Form.FindField("root[0].background[0].firstName[0]")
			if len(firstName) > 0 then field.SetFieldValue firstName, Font
			
		Set field = Doc.Form.FindField("root[0].background[0].aliasNames[0]")
			if len(aliasNames) > 0 then field.SetFieldValue aliasNames, Font
		if len(dob) = 8 and isnumeric(dob) then 'format as date
			dob = left(dob, 2) & "/" & mid(dob, 3, 2) & "/" & right(dob, 4)
		end if

		Set field = Doc.Form.FindField("root[0].background[0].dobM[0]")
			if not isnull(dob) then field.SetFieldValue DatePart("m", dob), Font
		Set field = Doc.Form.FindField("root[0].background[0].dobD[0]")
			if len(dob) > 0 then field.SetFieldValue DatePart("d", dob), Font
		Set field = Doc.Form.FindField("root[0].background[0].dobY[0]")
			if len(dob) > 0 then field.SetFieldValue DatePart("yyyy", dob), Font
			
		Set field = Doc.Form.FindField("root[0].background[0].address[0]")
			if len(addressOne) > 0 then field.SetFieldValue addressOne, Font
		Set field = Doc.Form.FindField("root[0].background[0].city[0]")
			if len(city) > 0 then field.SetFieldValue city, Font
		Set field = Doc.Form.FindField("root[0].background[0].state[0]")
			if len(appState) > 0 then field.SetFieldValue appState, Font
		Set field = Doc.Form.FindField("root[0].background[0].zip[0]")
			if len(zipcode) > 0 then field.SetFieldValue zipcode, Font
		Set field = Doc.Form.FindField("root[0].background[0].ssn3[0]")
			if len(ssn) = 9 then field.SetFieldValue Left(ssn, 3), Font
		Set field = Doc.Form.FindField("root[0].background[0].ssn2[0]")
			if len(ssn) = 9 then field.SetFieldValue Mid(ssn, 4, 2), Font
		Set field = Doc.Form.FindField("root[0].background[0].ssn4[0]")
			if len(ssn) = 9 then field.SetFieldValue Right(ssn, 4), Font
		Set field = Doc.Form.FindField("root[0].background[0].date[0]")
		field.SetFieldValue date(), Font
		
		Set field = Doc.Form.FindField("root[0].background[0].reqAddress[0]")
		field.SetFieldValue replace(branch_address, "Personnel Plus, ", ""), Font

		
		If len(pandpAgree) > 0 and not isnull(pandpAgree) = true then
			Set field = Doc.Form.FindField("root[0].background[0].signature[0]")
				field.SetFieldValue replace(signed, VbCrLf, " ") & pandpAgree, Font
		End If
		
		Set field = Doc.Form.FindField("root[0].background[0].date[0]")
		field.SetFieldValue date(), Font

		'Safety form
		
		'Fill in medical providers for the site
		dim mpId
		for mpId = 0 to mProviderId -1
			Set field = Doc.Form.FindField("root[0].safety[0].mProvider" & mpId + 1 & "[0]")
			if len(mproviders(mpId, mpName)) > 0 then
				field.SetFieldValue mproviders(mpId, mpName), Font
			end if

			Set field = Doc.Form.FindField("root[0].safety[0].mProvider" & mpId + 1 & "Address[0]")
			if len(mproviders(mpId, mpAddress)) > 0 then
				field.SetFieldValue mproviders(mpId, mpAddress), Font
			end if

			Set field = Doc.Form.FindField("root[0].safety[0].mProvider" & mpId + 1 & "Cityline[0]")
			if len(mproviders(mpId, mpCityline)) > 0 then
				field.SetFieldValue mproviders(mpId, mpCityline), Font
			end if

			Set field = Doc.Form.FindField("root[0].safety[0].mProvider" & mpId + 1 & "Phone[0]")
			if len(mproviders(mpId, mpPhone)) > 0 then
				field.SetFieldValue mproviders(mpId, mpPhone), Font
			end if

			Set field = Doc.Form.FindField("root[0].safety[0].mProvider" & mpId + 1 & "Fax[0]")
			if len(mproviders(mpId, mpFax)) > 0 then
				field.SetFieldValue mproviders(mpId, mpFax), Font
			end if
			
			Set field = Doc.Form.FindField("root[0].safety[0].mProvider" & mpId + 1 & "Open[0]")
			if len(mproviders(mpId, mpOpen)) > 0 then
				field.SetFieldValue mproviders(mpId, mpOpen), Font
			end if
		next
				
		'applicant information
		Set field = Doc.Form.FindField("root[0].safety[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].safety[0].date[0]")
		field.SetFieldValue date(), Font
				
		If len(pandpAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].safety[0].signature[0]")
				if not isnull(pandpAgree) = true then field.SetFieldValue signed & pandpAgree, Font
		End If
		
		'Drugs
		Set field = Doc.Form.FindField("root[0].drug[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].drug[0].date[0]")
		field.SetFieldValue date(), Font
		If len(pandpAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].drug[0].signature[0]")
				if not isnull(pandpAgree) = true then field.SetFieldValue signed & pandpAgree, Font
		End If

		If len(pandpAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].drug[0].signature[0]")
				if not isnull(pandpAgree) = true then field.SetFieldValue signed & pandpAgree, Font
		End If

		'Sexual
		Set field = Doc.Form.FindField("root[0].sexual[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].sexual[0].date[0]")
		field.SetFieldValue date(), Font
		If len(pandpAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].sexual[0].signature[0]")
				if not isnull(pandpAgree) = true then field.SetFieldValue signed & pandpAgree, Font
		End If

		'Payroll Depost
		Set field = Doc.Form.FindField("root[0].payroll[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].payroll[0].date[0]")
		field.SetFieldValue date(), Font

		'dearEmployer
		Set field = Doc.Form.FindField("root[0].dearEmployer[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].dearEmployer[0].applicantName[1]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].dearEmployer[0].ssn[0]")
			if len(ssn) > 5 then field.SetFieldValue Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4), Font
		Set field = Doc.Form.FindField("root[0].dearEmployer[0].date[0]")
		field.SetFieldValue Date(), Font
		Set field = Doc.Form.FindField("root[0].dearEmployer[0].mail_to[0]")
		field.SetFieldValue branch_address, Font
		Set field = Doc.Form.FindField("root[0].dearEmployer[0].fax_to[0]")
		field.SetFieldValue branch_fax, Font

		If len(pandpAgree) > 0 Then
			Set field = Doc.Form.FindField("root[0].dearEmployer[0].signature[0]")
				if not isnull(pandpAgree) = true then field.SetFieldValue signed & pandpAgree, Font
		End If

		' Form 8850
		Set field = Doc.Form.FindField("root[0].form8850[0].applicantName[0]")
			if len(applicantName) > 0 then field.SetFieldValue applicantName, Font
		Set field = Doc.Form.FindField("root[0].form8850[0].address[0]")
			if len(addressOne) > 0 then field.SetFieldValue addressOne, Font
		Set field = Doc.Form.FindField("root[0].form8850[0].cityStateZip[0]")
			if len(cityStateZip) > 0 then field.SetFieldValue cityStateZip, Font
		Set field = Doc.Form.FindField("root[0].form8850[0].SSN3[0]")
			if len(ssn) = 9 then field.SetFieldValue Left(ssn, 3), Font
		Set field = Doc.Form.FindField("root[0].form8850[0].SSN2[0]")
			if len(ssn) = 9 then field.SetFieldValue Mid(ssn, 4, 2), Font
		Set field = Doc.Form.FindField("root[0].form8850[0].SSN4[0]")
			if len(ssn) = 9 then field.SetFieldValue  Right(ssn, 4), Font
		
		Set field = Doc.Form.FindField("root[0].form8850[0].areacode[0]")
			if len(mainPhone) > 9 then field.SetFieldValue Left(mainPhone, 3), Font
		Set field = Doc.Form.FindField("root[0].form8850[0].phoneprefix[0]")
			if len(mainPhone) > 6 then field.SetFieldValue Mid(mainPhone, 4, 3), Font
		Set field = Doc.Form.FindField("root[0].form8850[0].phonelast[0]")
			if len(mainPhone) > 6 then field.SetFieldValue  Right(mainPhone, 4), Font
		
		'Save document
		Dim FilenameWithPath, Path, SitePath, FileName, FileNameNoPath, hrefLink, getAttachmentInfo, NewDoc, NewAttachment
		Dim pagesToAttach, pagesToPrint, isItSigned, CurrentPage
		
		select case whereWeAre
		case "nampa"
			SitePath = "\\192.168.4.2\direct$\"
		case "boise"
			SitePath = "\\192.168.3.1\direct$\"
		case "burley"
			SitePath = "\\192.168.2.1\direct$\"
		case else
			SitePath = "\\personnelplus.net.\attached\"
		end select
		'Break SitePath
		
		If action = "attach" Then
			Set getAttachmentInfo = Temps.Execute("SELECT FileId, ApplicantID, Extension FROM Attachments WHERE Reference=" & Session.SessionID)
			'FileNameNoPath = getAttachmentInfo("Extension") & getAttachmentInfo("FileId") & "-ApplicantId" & getAttachmentInfo("ApplicantID") & ".pdf"
			FileNameNoPath = getAttachmentInfo("Extension") & getAttachmentInfo("FileId") & ".pdf"
			'FilenameWithPath = "\\personnelplus.net.\attached\" & "VMS_" & FileNameNoPath
			FilenameWithPath = SitePath & FileNameNoPath
			
			pagesToAttach = "Page1=1; Page2=2; Page3=3; Page4=4; Page5=7; Page6=8; Page7=11; Page8=13; Page9=14; Page10=15; Page11=16; Page12=17; Page13=21; Page14=22;"
			
			Set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToAttach)
			NewDoc.Save FilenameWithPath
			Temps.Execute("UPDATE Attachments SET FileName='\\personnelplus.net.\attached\" & FileNameNoPath & "', Extension='pdf', Reference=0 WHERE Reference=" & Session.SessionID)
			'hrefLink = Replace(FilenameWithPath, " ", "%20")
		Else
			Select Case request.QueryString("giveme")
			Case "mostofit"
				pagesToPrint  = "Page1=1; Page2=2; "
				CurrentPage = 3
				
				'policies and procedures signature [if signed, suppress printing]
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=3; "
					CurrentPage = CurrentPage + 1
				end if
	
				'unemployment policy signature [if signed, suppress printing]
				if IsNull(unempAgree) = True then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=4; "
					CurrentPage = CurrentPage + 1
				end if
				
				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=5; " &_
					"Page" & (CurrentPage + 1) & "=6; " &_
					"Page" & (CurrentPage + 2) & "=7; " &_
					"Page" & (CurrentPage + 3) & "=8; " &_
					"Page" & (CurrentPage + 4) & "=9; " &_
					"Page" & (CurrentPage + 5) & "=10; " &_
					"Page" & (CurrentPage + 6) & "=11; " &_
					"Page" & (CurrentPage + 7) & "=12; "
				
				
				CurrentPage = CurrentPage + 8
	
				'other forms  [if signed, suppress printing]
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint &_
						"Page" & (CurrentPage + 0) & "=13; " &_
						"Page" & (CurrentPage + 1) & "=14; " &_
						"Page" & (CurrentPage + 2) & "=15; "
					
					CurrentPage = CurrentPage + 3
				end if
	
				'pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=16; " &_
				'	"Page" & (CurrentPage + 1) & "=12; "
				'CurrentPage = CurrentPage + 2
				
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=17; "
					CurrentPage = CurrentPage + 1
				end if
	
				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=19; " &_
					"Page" & (CurrentPage + 1) & "=20; " &_
					"Page" & (CurrentPage + 2) & "=21; " &_
					"Page" & (CurrentPage + 3) & "=22; "
					
			case "allofit"
				pagesToPrint  = "Page1=1; " &_
								"Page2=2; " &_	
								"Page3=3; " &_	
								"Page4=4; " &_	
								"Page5=5; " &_	
								"Page6=6; " &_	
								"Page7=7; " &_	
								"Page8=8; " &_	
								"Page9=9; " &_	
								"Page10=10; " &_	
								"Page11=11; " &_	
								"Page12=12; " &_	
								"Page13=13; " &_	
								"Page14=14; " &_	
								"Page15=15; " &_	
								"Page16=16; " &_	
								"Page17=17; " &_	
								"Page18=18; " &_	
								"Page19=19; " &_	
								"Page20=20; " &_	
								"Page21=21; " &_	
								"Page22=22; " 	
			case else
				CurrentPage = 1
				if IsNull(applicantAgree) = True Then
					pagesToPrint  = "Page" & CurrentPage & "=1; Page" & CurrentPage+1 & "=2; "
					CurrentPage = CurrentPage + 2
				end if
				
				
				'policies and procedures signature [if signed, suppress printing]
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=3; "
					CurrentPage = CurrentPage + 1
				end if
	
				'unemployment policy signature [if signed, suppress printing]
				if IsNull(unempAgree) = True then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=4; "
					CurrentPage = CurrentPage + 1
				end if
				
				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=5; " &_
					"Page" & (CurrentPage + 1) & "=6; "
					CurrentPage = CurrentPage + 2
					
				'if IsNull(applicantAgree) = True Then 'w4
					pagesToPrint  = pagesToPrint & "Page" & CurrentPage & "=7; Page" & CurrentPage+1 & "=8; "
					CurrentPage = CurrentPage + 2
				'end if
				
				pagesToPrint = pagesToPrint & "Page" & (CurrentPage) & "=9; " &_
					"Page" & (CurrentPage + 1) & "=10; "
					CurrentPage = CurrentPage + 2
	
				if IsNull(applicantAgree) = True Then
					pagesToPrint  = pagesToPrint & "Page" & CurrentPage & "=11; Page" & CurrentPage+1 & "=12; "
					CurrentPage = CurrentPage + 2
				end if
				
				'other forms  [if signed, suppress printing]
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint &_
						"Page" & (CurrentPage + 0) & "=13; " &_
						"Page" & (CurrentPage + 1) & "=14; " &_
						"Page" & (CurrentPage + 2) & "=15; "
					
					CurrentPage = CurrentPage + 3
				end if
	
				'pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=16; " &_
				'	"Page" & (CurrentPage + 1) & "=12; "
				'CurrentPage = CurrentPage + 2
				
				if IsNull(pandpAgree) = True Then
					pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=17; "
					CurrentPage = CurrentPage + 1
				end if
	
				pagesToPrint = pagesToPrint & "Page" & CurrentPage & "=19; " &_
					"Page" & (CurrentPage + 1) & "=20; " &_
					"Page" & (CurrentPage + 2) & "=21; " &_
					"Page" & (CurrentPage + 3) & "=22; "
				
			end select

			Set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToPrint)
			
			Response.Buffer = true
			Response.Clear()
			Response.ContentType = "application/pdf"
			Response.AddHeader "Content-Type", "application/pdf"
			Response.AddHeader "Content-Disposition", "attachment;filename=" & Chr(34)&  lastName & ", " & firstName & ".pdf" & Chr(34)
			Response.BinaryWrite NewDoc.SaveToMemory
			Set Doc = Nothing
			Set Pdf = Nothing
			Session("noHeaders") = false
			Response.End
		End If
End Sub	%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
