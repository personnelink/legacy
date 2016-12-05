<%Option Explicit%>
<%
session("add_css") = "submitapplication.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff

dim debug_mode
if request.queryString("debug") = "1" then debug_mode = true

dim isservice
if request.queryString("isservice") = "true" then isservice = true

dim responseHTML 'service response text

if request.QueryString("action") = "review" or request.querystring("action") = "inject" or request.queryString("update") = "1" or isservice then 
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

'siteAddr = Left(siteAddr, Len(siteAddr) - (4 - Instr(Right(siteAddr, 4), ".")))
siteAddr = Left(siteAddr, 9)

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

if isservice then response.write "<!-- [AppId:" & ApplicationID & "] -->"

Set dbQuery = Database.Execute(sql)
	dim inTemps(6)
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
		
		'PER = 0, BUR = 1, BOI = 2, IDA = 3
		inTemps(PER) = dbQuery("inPER")
		inTemps(BUR) = dbQuery("inBUR")
		inTemps(BOI) = dbQuery("inBOI")
		inTemps(IDA) = dbQuery("inIDA")					
		inTemps(PPI) = dbQuery("inPPI")					
		inTemps(POC) = dbQuery("inPOC")					
	End If
	Database.Close
	On Error Goto 0
	
whatToDo = Request.QueryString("action")
If whatToDo = "review" Then 
		viewApplication ""
ElseIf whatToDo = "inject" Then
	dim WhichCompany
	WhichCompany = Request.QueryString("company")
	if len(WhichCompany) = 0 then 'iterate all companies
		dim i
		for i = 0 to 6
			if inTemps(i) > 0 then
				Select Case WhichCompany
				Case PER
					WhichCompany = "PER"
				Case BUR
					WhichCompany = "BUR"
				Case BOI
					WhichCompany = "BOI"
				Case IDA
					WhichCompany = "IDA"
				Case PPI
					WhichCompany = "PPI"
				Case POC
					WhichCompany = "POC"
				End Select
			end if
			if len(WhichCompany) > 0 then InjectIntoTemps
		next
	else
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
	if debug_mode then print "Running as service: Starting 'Inject'"

	dim insertInfo, name_link, id_link
	Dim sqlApplicant, sqlPR3MSTR, sqlNotesApplicants, sqlAttachment, re, ApplicantID, checkIfUnique, i, ApplicantID_cmd, EmployeeCode
	Dim Skill, skillsArray, insertionStatus, applicantNote, getExistingNote, UserNumeric9

	'set debug flag'
	Dim debugMode, debugText
	debugMode = cbool(Request.QueryString("debug"))
	if debugMode then debugText = "&debug=1"

	Set Temps = Server.CreateObject("ADODB.Connection")
	Temps.Open dsnLessTemps(getTempsDSN(WhichCompany))
	attached_stub_directory = lcase(WhichCompany) & "\"
	
	Set re = New RegExp
	re.Pattern = "[()-.<>'$]"
	re.Global = True
	
	If workValidLicense = "y" Then UserNumeric9 = -1 Else UserNumeric9 = 0
	
	applicantNote = "%date%......APPLIED IN %city%" & Chr(13) &_
		 Chr(13) & "Minimum Wage Accepted:	%wage%" &_
		 Chr(13) & "Worked for other Temp Services: {}" &_
		 Chr(13) & "    If yes, list services: {}" & Chr(13) &_
		 Chr(13) & "Interviewed By: {}" &_
		 Chr(13) &  Chr(13) &_
		 "Work History Verification:"
		applicantNote = Replace(applicantNote, "%date%", Date())
		applicantNote = Replace(applicantNote, "%city%", city)
		applicantNote = Replace(applicantNote, "%wage%", minWageAmount)
		applicantNote = applicantNote & vbCrLf & employerNameHistOne &_
			vbCrLf & employerNameHistTwo &_
			vbCrLf & employerNameHistThree
	
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
		
		InsertUpdateActivity ApplicantID, lastNameFirst, WhichCompany

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

		if isservice then 
			'use ajax style link
			insertionStatus =   "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td>Applicant [id: " & id_link & " ] already exists in system...</td>" &_
				"</tr><tr><th>&nbsp;</th><td><div class=" & Chr(34) & "alignL" & Chr(34) & " style=" & Chr(34) & "padding:10px 0 10px 0;" &_
				Chr(34) & "> <a class=" & Chr(34) & "squarebutton" & Chr(34) & " href=""javascript:;"" onclick=""action.inject('appID=" &_
				ApplicationID & "&action=inject&update=1&company=" & WhichCompany & debugText & "')"" style=" &_
				Chr(34) & "margin-left: 6px" & Chr(34) & "><span>Update Enrollment?</span></a></div></td></tr>"
		else
			'use legacy style link
			insertionStatus =   "<tr><th>&nbsp;</th><td>&nbsp;</td></tr><tr><th></th><td>Applicant [id: " & id_link & " ] already exists in system...</td>" &_
				"</tr><tr><th>&nbsp;</th><td><div class=" & Chr(34) & "alignL" & Chr(34) & " style=" & Chr(34) & "padding:10px 0 10px 0;" &_
				Chr(34) & "> <a class=" & Chr(34) & "squarebutton" & Chr(34) & " href=" & Chr(34) & "/" &_
				"pdfServer/pdfApplication/createApplication.asp?appID=" & ApplicationID & "&action=inject&update=1&company=" & WhichCompany & debugText & Chr(34) & " style=" &_
				Chr(34) & "margin-left: 6px" & Chr(34) & "><span>Update Enrollment?</span></a></div></td></tr>"
		end if
	end If
		
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
	
	'tweak verbiage based on update status
	dim close_link : close_link = "<span class=""close_link"" onclick=""action.close();"">[ close ]</span>"
	if instr(insertionStatus, "already exists in system") > 0 then
		insertInfo = close_link & "<p><em style=""color:red;"">Existing enrollment found</em>.</p><p>Below is some of the applicants identifying information that was used:</p>" &_
			"<table style=""margin-top:0.6em;"">" &_
			"<tr><th>Email Address:&nbsp;</th><td>" & email & "</td></tr>" &_
			"<tr><th>Applicant Name:&nbsp;</th><td>" & lastNameFirst & "</td></tr>" &_
			"<tr><th>Applicant ID:&nbsp;</th><td>" & id_link & "</td></tr>" &_
			"<tr><th>Phone:&nbsp;</th><td>" & mainPhone & " " & altPhone & "</td></tr>" &_
			"<tr><th>Address:&nbsp;</th><td>" & addressOne & "</td></tr>" &_
			"<tr><th></th><td>" & city & ", " & appState & " " & zipcode & "</td></tr>" &_
			insertionStatus &_
			"</table>"	
	else
		insertInfo = close_link & "<p>Applicant has been enrolled. Review applicants information for accuracy.</p>" &_
			"<p>Below is some of the applicants identifying information that was used:</p>" &_
			"<table style=""margin-top:0.6em;"">" &_
			"<tr><th>Email Address:&nbsp;</th><td>" & email & "</td></tr>" &_
			"<tr><th>Applicant Name:&nbsp;</th><td>" & lastNameFirst & "</td></tr>" &_
			"<tr><th>Applicant ID:&nbsp;</th><td>" & id_link & "</td></tr>" &_
			"<tr><th>Phone:&nbsp;</th><td>" & mainPhone & " " & altPhone & "</td></tr>" &_
			"<tr><th>Address:&nbsp;</th><td>" & addressOne & "</td></tr>" &_
			"<tr><th></th><td>" & city & ", " & appState & " " & zipcode & "</td></tr>" &_
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
		responseHTML = responseHTML & insertInfo
	end if
end sub

sub setFieldAndValue(pdfDoc, field_name, field_value)
		dim field
		Set field = pdfDoc.Form.FindField("root[0]." & field_name & "[0]")
		'print "root[0]." & field_name & "[0]"
		field.SetFieldValue field_value, pdfDoc.Fonts("Arial")
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

sub print_f_wWidth_and_font(Doc, Page, text, x, y, width, height, fontsize)

		dim pdf
		Set pdf = Server.CreateObject("Persits.PDF")

		dim canvas
		Set canvas = Doc.Pages(page).Canvas
		
		dim font
		Set Font = Doc.Fonts("Arial")
		
		dim param
		Set param = pdf.CreateParam("x=" & x & ";y=" & y & ";height=" & height & ";width=" & width & "; size=" & fontsize & ";")

    param("x") = x
    ''Param("y") = y - 263 * 1 'what is 263?
    param("y") = y
      
    ' Draw text on canvas
    Canvas.DrawText text, param, Font      

end sub

sub print_f_wWidth(Doc, Page, text, x, y, width, height)
	print_f_wWidth_and_font Doc, page, text, x, y, 196, 196, 11 

end sub

sub print_f(Doc, page, text, x, y)
	print_f_wWidth Doc, page, text, x, y, 196, 196

end sub
 
Sub viewApplication (action)		
	
		Dim PDF, Doc, field, Page
		Set PDF = Server.CreateObject("Persits.PDF")

		' Open an existing form
		Set Doc = PDF.OpenDocument( Server.MapPath( "EmploymentApplication.pdf" ) )

				
	' Remove XFA support from it
		Doc.Form.RemoveXFA


		' Create font object
		'Set Font = Doc.Fonts("Helvetica")
		
		dim font
		Set Font = Doc.Fonts("Arial")

		Dim signed
		signed = "Electronically Signed by " & firstName & " " & lastName & VbCrLf  &_
			"DN: cn=" & firstName & " " & lastName & ",username=" & username & VbCrLf &_
			 "Date: "

	
		setFieldAndValue Doc, "applicationP1[0].lastName", lastName
		setFieldAndValue Doc, "applicationP1[0].firstName", firstName
		
		if len(mainPhone) > 0 then
			setFieldAndValue Doc, "applicationP1[0].userPhone", mainPhone
		end if
		
		if len(altPhone) > 0 then

			setFieldAndValue Doc, "applicationP1[0].userSPhone", altPhone
		end if
		
		setFieldAndValue Doc, "applicationP1[0].ssn", Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4)
		setFieldAndValue Doc, "applicationP1[0].date", Date()
		setFieldAndValue Doc, "applicationP1[0].address", addressOne
		setFieldAndValue Doc, "applicationP1[0].city", city
		'setFieldAndValue Doc, "city[1]")
		'field.SetFieldValue city
		setFieldAndValue Doc, "applicationP1[0].state", appState
		'setFieldAndValue Doc, "state[1]")
		'field.SetFieldValue appState
		setFieldAndValue Doc, "applicationP1[0].zip", zipcode
		'setFieldAndValue Doc, "zip[1]")
		'field.SetFieldValue zipcode
		'setFieldAndValue Doc, "addressTwo", addressTwo
		setFieldAndValue Doc, "applicationP1[0].city", city
		setFieldAndValue Doc, "applicationP1[0].state", appState
		setFieldAndValue Doc, "applicationP1[0].zip", zipcode
		setFieldAndValue Doc, "applicationP1[0].desiredWageAmount", desiredWageAmount
		setFieldAndValue Doc, "applicationP1[0].minWageAmount", minWageAmount

		Select Case currentlyEmployed
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].employedYes", "1"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].employedNo", "1"
		End Select
		
		Select Case workTypeDesired
		Case "f"
			setFieldAndValue Doc, "applicationP1[0].fulltime", "1"
		Case "p"
			setFieldAndValue Doc, "applicationP1[0].temporary", "1"
		Case "a"
			setFieldAndValue Doc, "applicationP1[0].fulltime", "1"

			setFieldAndValue Doc, "applicationP1[0].temporary", "1"
		End Select

		Select Case smoker
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].smokerYes", "1"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].smokerNo", "1"
		End Select
		
		Select Case workAge
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].eighteenYes", "1"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].eighteenNo", "1"
		End Select
		
		Select Case citizen
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].authorizedYes", "1"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].authorizedNo", "1"
		End Select
'		setFieldAndValue Doc, "availableWhen", 
'		field.SetFieldValue availableWhen
		if len(workConvictionExplain) > 0 then
			setFieldAndValue Doc, "applicationP1[0].felonyExplain", workConvictionExplain
		end if

		Select Case workConviction
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].felonyYes", "1"
			setFieldAndValue Doc, "applicationP1[0].convictionType", "felony"
		Case "f"
			setFieldAndValue Doc, "applicationP1[0].felonyYes", "1"
			setFieldAndValue Doc, "applicationP1[0].convictionType", "felony"
		Case "m"
			setFieldAndValue Doc, "applicationP1[0].felonyYes", "1"
			setFieldAndValue Doc, "applicationP1[0].convictionType", "misdemeanor"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].felonyNo", "1"
		End Select
		
		Select Case workAuthProof
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].authProofYes", "1"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].authProofNo", "1"
		End Select
		
		if not isnull(workCommuteHow) then
			setFieldAndValue Doc, "applicationP1[0].workCommuteHow", workCommuteHow
		end if

		Select Case workValidLicense
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].driversYes", "1"
			Select Case workLicenseType
			Case "n"
				setFieldAndValue Doc, "applicationP1[0].workLicenseType", "Non-Commerical"
			Case "a"
				setFieldAndValue Doc, "applicationP1[0].workLicenseType", "CDL-A"
			Case "b"
				setFieldAndValue Doc, "applicationP1[0].workLicenseType", "CDL-B"
			Case "c"
				setFieldAndValue Doc, "applicationP1[0].workLicenseType", "CDL-C"
			Case Else
				setFieldAndValue Doc, "applicationP1[0].workLicenseType", "[none]"
			End Select
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].driversNo", "1"
		End Select

		Select Case autoInsurance
		Case "y"
			setFieldAndValue Doc, "applicationP1[0].insuranceYes", "1"
		Case "n"
			setFieldAndValue Doc, "applicationP1[0].insuranceNo", "1"
		End Select
		
		If Instr(skillsSet, ".16.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].landscaping", "1"
		End If
		
		If Instr(skillsSet, ".20.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].delivery", "1"
		End If
		
		If Instr(skillsSet, ".88.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].janitorial", "1"
		End If
		
		If Instr(skillsSet, ".73.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].warehouse", "1"
		End If
		
		If Instr(skillsSet, ".89.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].inventory", "1"
		End If
		
		If Instr(skillsSet, ".21.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].security", "1"
		End If
		
		If Instr(skillsSet, ".647.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].shippingReceiving", "1"
		End If
		
		If Instr(skillsSet, ".202.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].cleanup", "1"
		End If
		
		If Instr(skillsSet, ".17.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].farm", "1"
		End If
		
		If Instr(skillsSet, ".23.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].dairy", "1"
		End If
		
		If Instr(skillsSet, ".605.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].sprinkler", "1"
		End If
		
		If Instr(skillsSet, ".606.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].floral", "1"
		End If
		
		If Instr(skillsSet, ".1073.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].yardsGrounds", "1"
		End If
		
		If Instr(skillsSet, ".12.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].housekeeping", "1"
		End If
		
		If Instr(skillsSet, ".198.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plumber", "1"
		End If
		
		If Instr(skillsSet, ".1316.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].generalLabor", "1"
		End If
		
		If Instr(skillsSet, ".215.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].concreteRough", "1"
		End If
		
		If Instr(skillsSet, ".274.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].concreteFinish", "1"
		End If
		
		If Instr(skillsSet, ".216.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].carpenterRough", "1"
		End If
		
		If Instr(skillsSet, ".220.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].carpenterFinish", "1"
		End If
		
		If Instr(skillsSet, ".204.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].framing", "1"
		End If
		
		If Instr(skillsSet, ".190.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].readBlueprints", "1"
		End If
		
		If Instr(skillsSet, ".62.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].roofing", "1"
		End If
		
		If Instr(skillsSet, ".18.") > 0 Then

			setFieldAndValue Doc, "applicationP1[0].painting", "1"
		End If
		
		If Instr(skillsSet, ".440.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].electrician", "1"
		End If
		
		If Instr(skillsSet, ".229.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].hvac", "1"
		End If
		
		If Instr(skillsSet, ".19.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].siding", "1"
		End If
		
		If Instr(skillsSet, ".1600.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].flagger", "1"
		End If
		
		If Instr(skillsSet, ".1305.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].generalLaborL", "1"
		End If
		
		If Instr(skillsSet, ".1608.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].generalLaborM", "1"
		End If
		
		If Instr(skillsSet, ".1610.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].generalLaborH", "1"
		End If
		
		If Instr(skillsSet, ".457.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].machineOperator", "1"
		End If
		
		If Instr(skillsSet, ".1078.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].forkliftOperator", "1"
		End If
		
		If Instr(skillsSet, ".208.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].packaging", "1"
		end if
		
		If Instr(skillsSet, ".219.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].palletizing", "1"
		end if
		
		If Instr(skillsSet, ".206.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].sanitation", "1"
		End If
		
		If Instr(skillsSet, ".24.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].lab", "1"
		End If
		
		If Instr(skillsSet, ".1003.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].qa", "1"
		End If
		
		If Instr(skillsSet, ".42.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].maintenance", "1"
		End If
		
		If Instr(skillsSet, ".34.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].electrical", "1"
		End If
		
		If Instr(skillsSet, ".418.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].electronics", "1"
		End If
		
		If Instr(skillsSet, ".429.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].hydraulics", "1"
		End If
		
		If Instr(skillsSet, ".184.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].cabinetMaker", "1"
		End If
		
		If Instr(skillsSet, ".647.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].industrialShippingReceiving", "1"
		End If
		
		If Instr(skillsSet, ".773.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].fishProcessing", "1"
		End If
		
		If Instr(skillsSet, ".1057.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].dieselMechanic", "1"
		End If
		
		If Instr(skillsSet, ".1042.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].autoMechanic", "1"
		End If
		
		If Instr(skillsSet, ".55.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].smallEngineMechanic", "1"
		End If
		
		If Instr(skillsSet, ".287.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].machinist", "1"
		End If
		
		If Instr(skillsSet, ".1082.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].toolDie", "1"
		End If
		
		If Instr(skillsSet, ".697.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].millLathe", "1"
		End If
		
		If Instr(skillsSet, ".501.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].welder", "1"
		End If
		
		If Instr(skillsSet, ".286.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].glazier", "1"
		End If
		
		If Instr(skillsSet, ".1121.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].skilledLaborOther", "1"
		End If
		
		If Instr(skillsSet, ".652.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].assemblyPackaging", "1"
		End If
		
		If Instr(skillsSet, ".1284.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticMachineOperator", "1"
		End If
		
		If Instr(skillsSet, ".665.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticInjection", "1"
		End If
		
		If Instr(skillsSet, ".214.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticMolding", "1"
		End If
		
		If Instr(skillsSet, ".1617.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticMaintenance", "1"
		End If
		
		If Instr(skillsSet, ".1338.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticCustomerService", "1"
		End If
		
		If Instr(skillsSet, ".1472.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticQA", "1"
		End If
		
		If Instr(skillsSet, ".254.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticPrepRoom", "1"
		End If
		
		If Instr(skillsSet, ".1285.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].plasticGlueRoom", "1"
		End If
		
		'If Instr(skillsSet, ".16.") > 0 Then
		'	setFieldAndValue Doc, "plasticOther", 
		'	field.SetFieldValue  "1"
		'End If
		
		If Instr(skillsSet, ".1115.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceWaitress", "1"
		End If
		
		If Instr(skillsSet, ".653.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceLinecook", "1"
		End If
		
		If Instr(skillsSet, ".442.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceChef", "1"
		End If
		
		If Instr(skillsSet, ".1604.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceDishwasher", "1"
		End If
		
		If Instr(skillsSet, ".1268.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceHostess", "1"
		End If
		
		If Instr(skillsSet, ".230.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceSupervisor", "1"
		End If
		
		If Instr(skillsSet, ".1255.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceBanquet", "1"
		End If
		
		If Instr(skillsSet, ".1603.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceSanitation", "1"
		End If
		
		If Instr(skillsSet, ".1119.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].foodserviceWarehouse", "1"
		End If
		
		If Instr(skillsSet, ".438.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingCDL", "1"
			setFieldAndValue Doc, "applicationP1[0].classCDL", "CDL-A"
		End If
		
		If Instr(skillsSet, ".343.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingCDL", "1"
			setFieldAndValue Doc, "applicationP1[0].classCDL", "CDL-B"
		End If
		
		If Instr(skillsSet, ".500.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "Air Brakes"
		End If
		
		If Instr(skillsSet, ".558.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "All - TPXS"
		End If
		
		If Instr(skillsSet, ".1602.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - H"
		End If
		
		If Instr(skillsSet, ".556.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - M"
		End If
		
		If Instr(skillsSet, ".500.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "Air Brakes"
		End If
		
		If Instr(skillsSet, ".491.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - N"
		End If
		
		If Instr(skillsSet, ".493.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - P"
		End If
		
		If Instr(skillsSet, ".1633.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - S"
		End If
		
		If Instr(skillsSet, ".489.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - T"
		End If
		
		If Instr(skillsSet, ".1632.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].drivingEndorcements", "1"
			setFieldAndValue Doc, "applicationP1[0].cdlEndorsements", "End - X"
		End If
		
		If Instr(skillsSet, ".94.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalReceptionist", "1"
		End If
		
		If Instr(skillsSet, ".1122.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalSwitchboard", "1"
		End If
		
		If Instr(skillsSet, ".267.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clerical", "1"
		End If
		
		If Instr(skillsSet, ".207.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalTelephone", "1"
		End If
		
		If Instr(skillsSet, ".709.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalWordprocessing", "1"
		End If
		
		If Instr(skillsSet, ".590.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalDictation", "1"
		End If
		
		If Instr(skillsSet, ".852.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalSpeedwriting", "1"
		End If
		
		If Instr(skillsSet, ".76.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalTyping", "1"
		End If
		
		If Instr(skillsSet, ".360.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalStatisticalTyping", "1"
		End If
		
		If Instr(skillsSet, ".1614.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalLegalOffice", "1"
		End If
		
		If Instr(skillsSet, ".221.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalMedicalOffice", "1"
		End If
		
		If Instr(skillsSet, ".97.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalCashier", "1"
		End If
				
		If Instr(skillsSet, ".608.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clerical10Key", "1"
		End If
		
		If Instr(skillsSet, ".123.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalTeller", "1"
		End If
		
		If Instr(skillsSet, ".81.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalDataEntry", "1"
		End If
		
		If Instr(skillsSet, ".27.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareWindows", "1"
		End If
		
		If Instr(skillsSet, ".600.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalMortgage", "1"
		End If
		
		If Instr(skillsSet, ".86.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalFiling", "1"
		End If
		
		If Instr(skillsSet, ".613.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalMedicalTerminology", "1"
		End If
		
		If Instr(skillsSet, ".1399.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalCreditCollection", "1"
		End If
		
		If Instr(skillsSet, ".942.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalCustomerService", "1"
		End If
		
		If Instr(skillsSet, ".1621.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalTitleEscrow", "1"
		End If
		
		If Instr(skillsSet, ".1208.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].otherSoftware", "1"
		End If
		
		If Instr(skillsSet, ".205.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareWord", "1"
		End If
		
		If Instr(skillsSet, ".426.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareWordPerfect", "1"
		End If
		
		If Instr(skillsSet, ".792.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareExcel", "1"
		End If
		
		If Instr(skillsSet, ".95.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].clericalFaxCopier", "1"
		End If
		
		If Instr(skillsSet, ".1179.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingAR", "1"
		End If
		
		If Instr(skillsSet, ".1173.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingAP", "1"
		End If
		
		If Instr(skillsSet, ".31.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingPayroll", "1"
		End If
		
		If Instr(skillsSet, ".187.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingBankRecon", "1"
		End If
		
		If Instr(skillsSet, ".84.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingPosting", "1"
		End If
		
		If Instr(skillsSet, ".85.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingTrialBalance", "1"
		End If
		
		If Instr(skillsSet, ".111.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingFinancialStmntPrep", "1"
		End If
		
		If Instr(skillsSet, ".144.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingMonthEndClose", "1"
		End If
		
		If Instr(skillsSet, ".1609.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingAccounting", "1"
		End If
		
		If Instr(skillsSet, ".630.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingTax", "1"
		End If
		
		If Instr(skillsSet, ".607.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareQuicken", "1"
		End If
		
		If Instr(skillsSet, ".171.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwarePeachtree", "1"
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].bookkeepingOther", "1"
		End If
		
		If Instr(skillsSet, ".99.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthDentalAssist", "1"
		End If
		
		If Instr(skillsSet, ".38.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthCNA", "1"
		End If
		
		If Instr(skillsSet, ".203.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthCMA", "1"
		End If
		
		If Instr(skillsSet, ".339.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthWardClerk", "1"
		End If
		
		If Instr(skillsSet, ".425.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthLabTechnician", "1"
		End If
		
		If Instr(skillsSet, ".24.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthGeneralLabor", "1"
		End If
		
		If Instr(skillsSet, ".459.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthHousekeeping", "1"
		End If
		
		If Instr(skillsSet, ".421.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthRN", "1"
		End If
		
		If Instr(skillsSet, ".269.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthDietary", "1"
		End If
		
		If Instr(skillsSet, ".288.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].healthLPN", "1"
		End If
		
		If Instr(skillsSet, ".289.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalComputerTech", "1"
		End If
		
		If Instr(skillsSet, ".1394.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalCopierTech", "1"
		End If
		
		If Instr(skillsSet, ".722.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalTelecomTech", "1"
		End If
		
		If Instr(skillsSet, ".534.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalElectronicsTech", "1"
		End If
		
		If Instr(skillsSet, ".134.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalCADD", "1"
		End If
		
		If Instr(skillsSet, ".231.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalEngineer", "1"
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalType", "1"
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalCertificate", "1"
		End If
		
		If Instr(skillsSet, ".241.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalTelecommunications", "1"
		End If
		
		If Instr(skillsSet, ".987.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].technicalComputerNetwork", "1"
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareUsedOne", "1"
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareUsedTwo", "1"
		End If
		
		If Instr(skillsSet, ".-1.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].softwareUsedThree", "1"
		End If
		
		If Instr(skillsSet, ".260.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesOutside", "1"
		End If
		
		If Instr(skillsSet, ".164.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesRoute", "1"
		End If
		
		If Instr(skillsSet, ".105.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesTelemarketing", "1"
		End If
		
		If Instr(skillsSet, ".182.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesMarketing", "1"
		End If
		
		If Instr(skillsSet, ".183.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesProductDemo", "1"
		End If
		
		If Instr(skillsSet, ".247.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesSurvey", "1"
		End If
		
		If Instr(skillsSet, ".7.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].salesRetail", "1"
		End If
		
		If Instr(skillsSet, ".586.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementAccounting", "1"
		End If
		
		If Instr(skillsSet, ".1626.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementCPA", "1"
		End If
		
		If Instr(skillsSet, ".196.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementHR", "1"
		End If
		
		If Instr(skillsSet, ".39.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementPurchasing", "1"
		End If
		
		If Instr(skillsSet, ".197.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementPR", "1"
		End If
		
		If Instr(skillsSet, ".1615.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementInfoSys", "1"
		End If
		
		If Instr(skillsSet, ".120.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementSales", "1"
		End If
		
		If Instr(skillsSet, ".1618.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementTechnical", "1"
		End If
		
		If Instr(skillsSet, ".1098.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementQA", "1"
		End If
		
		If Instr(skillsSet, ".514.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementConstruction", "1"
		End If
		
		If Instr(skillsSet, ".482.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementFarm", "1"
		End If
		
		If Instr(skillsSet, ".231.") > 0 Then
			setFieldAndValue Doc, "applicationP1[0].managementEngineering", "1"
		End If
		
'		setFieldAndValue Doc, "workLicenseState", 
'		field.SetFieldValue workLicenseType
'		setFieldAndValue Doc, "workLicenseExpire", 
'		field.SetFieldValue workLicenseExpire
'		setFieldAndValue Doc, "workLicenseNumber", 
'		field.SetFieldValue workLicenseNumber
		setFieldAndValue Doc, "applicationP1[0].workCommuteDistance", workRelocate & "; " & workCommuteDistance
		

'		setFieldAndValue Doc, "eduLevel", 
'		field.SetFieldValue eduLevel
'
'		setFieldAndValue Doc, "additionalInfo", 
'		field.SetFieldValue additionalInfo

		setFieldAndValue Doc, "applicationP1[0].workCommuteDistance", workRelocate & "; " & workCommuteDistance

		if len(jobHistFromDateOne) > 0 then
			setFieldAndValue Doc, "applicationP2[0].jobHistFromDateOne", jobHistFromDateOne
		end if
		if len(JobHistToDateOne) > 0 then setFieldAndValue Doc, "applicationP2[0].JobHistToDateOne", JobHistToDateOne
		if len(employerNameHistOne) > 0 then setFieldAndValue Doc, "applicationP2[0].employerNameHistOne", employerNameHistOne
		if len(jobHistSupervisorOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistSupervisorOne", jobHistSupervisorOne
		if len(jobHistAddOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistAddOne", jobHistAddOne
		if len(jobHistCityStateZipOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistCityStateZipOne", jobHistCityStateZipOne
		if len(jobHistPhoneOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistPhoneOne", jobHistPhoneOne
		if len(jobDutiesOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobDutiesOne", jobDutiesOne
		if len(jobHistPayOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistPayOne", jobHistPayOne
		if len(jobReasonOne) > 0 then setFieldAndValue Doc, "applicationP2[0].jobReasonOne", jobReasonOne

		if len(jobHistFromDateTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistFromDateTwo", jobHistFromDateTwo
		if len(JobHistToDateTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].JobHistToDateTwo", JobHistToDateTwo
		if len(employerNameHistTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].employerNameHistTwo", employerNameHistTwo
		if len(jobHistSupervisorTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistSupervisorTwo", jobHistSupervisorTwo
		if len(jobHistAddTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistAddTwo", jobHistAddTwo
		if len(jobHistCityStateZipTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistCityStateZipTwo", jobHistCityStateZipTwo
		if len(jobHistPhoneTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistPhoneTwo", jobHistPhoneTwo
		if len(jobDutiesTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobDutiesTwo", jobDutiesTwo
		if len(jobHistPayTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistPayTwo", jobHistPayTwo
		if len(jobReasonTwo) > 0 then setFieldAndValue Doc, "applicationP2[0].jobReasonTwo", jobReasonTwo

		if len(jobHistFromDateThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistFromDateThree", jobHistFromDateThree
		if len(JobHistToDateThree) > 0 then setFieldAndValue Doc, "applicationP2[0].JobHistToDateThree", JobHistToDateThree
		if len(employerNameHistThree) > 0 then setFieldAndValue Doc, "applicationP2[0].employerNameHistThree", employerNameHistThree
		if len(jobHistSupervisorThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistSupervisorThree", jobHistSupervisorThree
		if len(jobHistAddThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistAddThree", jobHistAddThree
		if len(jobHistCityStateZipThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistCityStateZipThree", jobHistCityStateZipThree
		if len(jobHistPhoneThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistPhoneThree", jobHistPhoneThree
		if len(jobDutiesThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobDutiesThree", jobDutiesThree
		if len(jobHistPayThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobHistPayThree", jobHistPayThree
		if len(jobReasonThree) > 0 then setFieldAndValue Doc, "applicationP2[0].jobReasonThree", jobReasonThree

		print_f Doc, 2, date(), 442, 130 'setFieldAndValue Doc, "applicationP2[0].date", date()

		'Emergency Contact
		if len(ecFullName) > 0 then setFieldAndValue Doc, "applicationP2[0].ecFullName", ecFullName
		if len(ecAddress) > 0 then setFieldAndValue Doc, "applicationP2[0].ecAddress", ecAddress
		if len(ecPhone) > 0 then setFieldAndValue Doc, "applicationP2[0].ecPhone", formatPhone(ecPhone)
		if len(ecDoctor) > 0 then setFieldAndValue Doc, "applicationP2[0].ecDoctor", ecDoctor
		if len(ecDocPhone) > 0 then setFieldAndValue Doc, "applicationP2[0].ecDocPhone", formatPhone(ecDocPhone)

		dim dx, nx, sx, sy, ndy, x, y, w, h, f, p
		
		'Applicant Application, sign
				sx = 56
				sy = 142
				w = 296
				h = 64
				f = 8
				p = 2

		if len(applicantAgree) > 0 Then
			if not isnull(applicantAgree) = true then
				'setFieldAndValue Doc, "applicationP2[0].signature", signed & applicantAgree
				print_f_wWidth_and_font Doc, p, signed & applicantAgree, sx, sy, w, h, f
			end if
		end If

		'Policies
			nx = 32
			ndy = 59
			p = 3 ' page 3

		if len(applicantName) > 0 then
			'setFieldAndValue Doc, "policies[0].applicantName", applicantName
			print_f Doc, p, applicantName, nx, ndy

		end if
		'setFieldAndValue Doc, "policies[0].date", Date()
			dx = 472
		print_f Doc, p, date(), dx, ndy


			sx = 265
			sy = 72
		if len(pandpAgree) > 0 and isnull(pandpAgree) = false then
			'setFieldAndValue Doc, "policies[0].signature", signed & pandpAgree

				print_f_wWidth_and_font Doc, p, signed & pandpAgree, sx, sy, w, h, f
		end If
		
		'Unemployment
		p = 4
		dim iMidPage
		iMidPage = 392
		
		if len(applicantName) > 0 then
			'setFieldAndValue Doc, "unemployment[0].applicantName", applicantName
			print_f Doc, p, applicantName, nx, ndy
			print_f Doc, p, applicantName, nx, ndy + iMidPage
		end if
		'setFieldAndValue Doc, "unemployment[0].date", Date()
		print_f Doc, p, date(), dx, ndy + iMidPage
		print_f Doc, p, date(), dx, ndy

		If len(unempAgree) > 0 Then
			if not isnull(unempAgree) = true then
				''setFieldAndValue Doc, "unemployment[0].signature", signed & unempAgree
				print_f_wWidth_and_font Doc, p, signed & unempAgree, sx, sy + iMidPage, w, h, f
				print_f_wWidth_and_font Doc, p, signed & unempAgree, sx, sy, w, h, f
			end if
		End If

		' Form I9
		if len(lastName) > 0 then setFieldAndValue Doc, "i9[0].lastname", lastName
		if len(firstName) > 0 then setFieldAndValue Doc, "i9[0].firstname", firstName
		if len(addressOne) > 0 then setFieldAndValue Doc, "i9[0].address", addressOne
		if len(city) > 0 then setFieldAndValue Doc, "i9[0].city", city
		if len(appState) > 0 then setFieldAndValue Doc, "i9[0].state", appState
		if len(zipcode) > 0 then setFieldAndValue Doc, "i9[0].zip", zipcode
		if len(dob) > 0 then setFieldAndValue Doc, "i9[0].dob", dob
		if len(ssn) = 9 then setFieldAndValue Doc, "i9[0].ssn", Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4)
		If citizen = "y" Then
			setFieldAndValue Doc, "i9[0].citizen", "1"
		Else
			If alienType = "p" Then
				setFieldAndValue Doc, "i9[0].LPRAlienNumberCk", "1"
				if not isnull(alienNumber) then 
					setFieldAndValue Doc, "i9[0].LPRAlienNumber", alienNumber
				end if
			elseif alienType = "a" Then
				setFieldAndValue Doc, "i9[0].alienauthorizedtowork", "1"
				if not isnull(alienNumber) then 
					setFieldAndValue Doc, "i9[0].alienworknumber", alienNumber
				end if
			end If
		end If
		setFieldAndValue Doc, "i9[0].date", Date()
		setFieldAndValue Doc, "i9[0].certificationdate", Date()
		setFieldAndValue Doc, "i9[0].certtitle", "Client Services"
		setFieldAndValue Doc, "i9[0].businessnameaddress", branch_address
		setFieldAndValue Doc, "i9[0].businessdate", Date()
		
		' Form W4
		p = 7
		if len(w4a) > 0 then setFieldAndValue Doc, "w4[0].a", w4a
		if len(w4b) > 0 then setFieldAndValue Doc, "w4[0].b", w4b
		if len(w4c) > 0 then setFieldAndValue Doc, "w4[0].c", w4c
		if len(w4d) > 0 then setFieldAndValue Doc, "w4[0].d", w4d
		if len(w4e) > 0 then setFieldAndValue Doc, "w4[0].e", w4e
		if len(w4f) > 0 then setFieldAndValue Doc, "w4[0].f", w4f
		if len(w4g) > 0 then setFieldAndValue Doc, "w4[0].g", w4g
		if len(w4h) > 0 then setFieldAndValue Doc, "w4[0].h", w4h
		if not isnull(w4total) then
			Set field = Doc.Form.FindField("root[0].w4[0].h[1]")
			field.SetFieldValue w4total, Font
		end if	
		
		if len(w4more) > 0 then
			setFieldAndValue Doc, "w4[0].more", w4more
		end if
		
		select case w4filing
		case 0
			setFieldAndValue Doc, "w4[0].filingSingle", "1"
		case 1
			setFieldAndValue Doc, "w4[0].filingMarried", "1"
		case 2
			setFieldAndValue Doc, "w4[0].filingAsSingle", "1"
		end select
		
		if len(w4namediffers) = true then
			setFieldAndValue Doc, "w4[0].namediffers", "1"
		end if

		if len(lastName) > 0 then setFieldAndValue Doc, "w4[0].lastname", lastName
		if len(firstName) > 0 then setFieldAndValue Doc, "w4[0].firstname", firstName & " " & middleinit
		if len(addressOne) > 0 then setFieldAndValue Doc, "w4[0].address", addressOne
		if len(cityStateZip) > 0 then setFieldAndValue Doc, "w4[0].cityStateZip", cityStateZip
		if len(ssn) = 9 then
			setFieldAndValue Doc, "w4[0].ssn3", Left(ssn, 3)
			setFieldAndValue Doc, "w4[0].ssn2", Mid(ssn, 4, 2)
			setFieldAndValue Doc, "w4[0].ssn4", Right(ssn, 4)
		end if
			
		setFieldAndValue Doc, "w4[0].date", Date()
		setFieldAndValue Doc, "w4[0].employerinfo", branch_address
		setFieldAndValue Doc, "w4[0].office_location", company_location_description

		If len(applicantAgree) > 0 and isnull(applicantAgree) = false then

				x = 194
				y = 87
				print_f_wWidth_and_font Doc, p, signed & applicantAgree, x, y, w, h, f

			''setFieldAndValue Doc, "w4[0].signature", signed & applicantAgree
		End If

		'Skills
		if len(applicantName) > 0 then setFieldAndValue Doc, "skills[0].applicantName", applicantName
		setFieldAndValue Doc, "skills[0].date", Date()


		' Background Check
		p = 11
		
		if len(lastName) > 0 then setFieldAndValue Doc, "background[0].lastName", lastName
		if len(firstName) > 0 then setFieldAndValue Doc, "background[0].firstName", firstName
		if len(aliasNames) > 0 then setFieldAndValue Doc, "background[0].aliasNames", aliasNames
		if len(dob) = 8 and isnumeric(dob) then 'format as date
			dob = left(dob, 2) & "/" & mid(dob, 3, 2) & "/" & right(dob, 4)
		end if

		if not isnull(dob) then
			if len(dob) > 0 then
				setFieldAndValue Doc, "background[0].dobM", DatePart("m", dob)
				setFieldAndValue Doc, "background[0].dobD", DatePart("d", dob)
				setFieldAndValue Doc, "background[0].dobY", DatePart("yyyy", dob)
			end if	
		end if
		
		if len(addressOne) > 0 then setFieldAndValue Doc, "background[0].address", addressOne
		if len(city) > 0 then setFieldAndValue Doc, "background[0].city", city
		if len(appState) > 0 then setFieldAndValue Doc, "background[0].state", appState
		if len(zipcode) > 0 then setFieldAndValue Doc, "background[0].zip", zipcode
		if len(ssn) = 9 then
			setFieldAndValue Doc, "background[0].ssn3", Left(ssn, 3)
			setFieldAndValue Doc, "background[0].ssn2", Mid(ssn, 4, 2)
			setFieldAndValue Doc, "background[0].ssn4", Right(ssn, 4)
		end if
		
		x = 400
		y = 472
		print_f Doc, p, date, x, y
		'setFieldAndValue Doc, "background[0].date", date()
		
		setFieldAndValue Doc, "background[0].reqAddress", replace(branch_address, "Personnel Plus, ", "")

		If len(pandpAgree) > 0 and isnull(pandpAgree) = false then
			w = 388
			f = 6
			x = 30
			y = 468
			print_f_wWidth_and_font Doc, p, replace(signed, VbCrLf, " ") & pandpAgree, x, y, w, h, f

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
		p = 13
		if len(applicantName) > 0 then
			print_f Doc, p, applicantName, nx, ndy
		end if	
		print_f Doc, p, date(), dx, ndy
				
		If len(pandpAgree) > 0 and isnull(pandpAgree) = false then
				print_f_wWidth_and_font Doc, p, signed & pandpAgree, sx, sy, w, h, f
		End If
		
		'Drugs
		p = 14
		if len(applicantName) > 0 then
			print_f Doc, p, applicantName, nx, ndy
		end if
		
		If len(pandpAgree) > 0 and isnull(pandpAgree) = false then
				print_f_wWidth_and_font Doc, p, signed & pandpAgree, sx, sy, w, h, f
		End If
		print_f Doc, p, date(), dx, ndy

		'Sexual
		p = 15
		if len(applicantName) > 0 then
			print_f Doc, p, applicantName, nx, ndy
		end if
		if len(pandpAgree) > 0 and isnull(pandpAgree) = false then 
				print_f_wWidth_and_font Doc, p, signed & pandpAgree, sx, sy, w, h, f
		End If
		print_f Doc, p, date(), dx, ndy
		
		'Payroll Depost
		p = 16
		if len(applicantName) > 0 then
			print_f Doc, p, applicantName, nx, ndy
		end if
		print_f Doc, p, date(), dx, ndy

		'dearEmployer
		p = 17
		if len(applicantName) > 0 then
			setFieldAndValue Doc, "dearEmployer[0].applicantName", applicantName
			print_f Doc, p, applicantName, nx, ndy
		end if
			
		if len(ssn) > 5 then setFieldAndValue Doc, "dearEmployer[0].ssn", Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4)
		print_f Doc, p, date(), dx, ndy
		setFieldAndValue Doc, "dearEmployer[0].mail_to", branch_address
		setFieldAndValue Doc, "dearEmployer[0].fax_to", branch_fax

		If len(pandpAgree) > 0 and isnull(pandpAgree) = false then
			print_f_wWidth_and_font Doc, p, signed & pandpAgree, sx, sy, w, h, f
		End If

		' Form 8850
		p = 18
		if len(applicantName) > 0 then setFieldAndValue Doc, "form8850[0].applicantName", applicantName
		if len(addressOne) > 0 then setFieldAndValue Doc, "form8850[0].address", addressOne
		setFieldAndValue Doc, "form8850[0].cityStateZip", cityStateZip
		if len(ssn) = 9 then
			setFieldAndValue Doc, "form8850[0].SSN3", Left(ssn, 3)
			setFieldAndValue Doc, "form8850[0].SSN2", Mid(ssn, 4, 2)
			setFieldAndValue Doc, "form8850[0].SSN4", Right(ssn, 4)
		end if
		
		if len(mainPhone) > 9 then
			setFieldAndValue Doc, "form8850[0].areacode", Left(mainPhone, 3)
		end if
		
		if len(mainPhone) > 6 then
			setFieldAndValue Doc, "form8850[0].phoneprefix", Mid(mainPhone, 4, 3)
			setFieldAndValue Doc, "form8850[0].phonelast", Right(mainPhone, 4)
		end if
		
		'Save document
		Dim FilenameWithPath, Path, SitePath, FileName, FileNameNoPath, hrefLink, getAttachmentInfo, NewDoc, NewAttachment
		Dim pagesToAttach, pagesToPrint, isItSigned, CurrentPage, aCopy
		
		select case whereWeAre
		case "nampa"
			SitePath = "\\192.168.4.2\direct$\"
		case "boise"
			SitePath = "\\192.168.3.2\direct$\"
		case "burley"
			SitePath = "\\192.168.2.2\direct$\"
		case else
			SitePath = "\\personnelplus.net.\attached\"
		end select
		'Break SitePath
		
		If action = "attach" Then
			Set getAttachmentInfo = Temps.Execute("SELECT FileId, ApplicantID, Extension FROM Attachments WHERE Reference=" & Session.SessionID)
			'FileNameNoPath = getAttachmentInfo("Extension") & getAttachmentInfo("FileId") & "-ApplicantId" & getAttachmentInfo("ApplicantID") & ".pdf"
			FileNameNoPath = getAttachmentInfo("Extension") & getAttachmentInfo("FileId") & ".pdf"
			'FilenameWithPath = "\\personnelplus.net.\attached\" & "VMS_" & FileNameNoPath
			FilenameWithPath = SitePath & attached_stub_directory & FileNameNoPath
			
			pagesToAttach = "Page1=1; Page2=2; Page3=3; Page4=4; Page5=7; Page6=8; Page7=11; Page8=13; Page9=14; Page10=15; Page11=16; Page12=17; Page13=21; Page14=22;"
			
			Set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToAttach)
			NewDoc.Save FilenameWithPath
			Temps.Execute("UPDATE Attachments SET FileName='\\personnelplus.net.\attached\" & attached_stub_directory & FileNameNoPath & "', Extension='pdf', Reference=0 WHERE Reference=" & Session.SessionID)
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
				aCopy = " [copy]"

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
				aCopy = " [copy]"

			case "justapp"
				pagesToPrint  = "Page1=1; " &_
								"Page2=2; " 
				aCopy = " [copy]"

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
				
			if IsNull(applicantAgree) = True Then 'w4
				pagesToPrint  = pagesToPrint & "Page" & CurrentPage & "=7; Page" & CurrentPage+1 & "=8; "
				CurrentPage = CurrentPage + 2
			end if
			
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
			
			aCopy = " [un-signed pages]"
		end select

			Set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToPrint)
			
			Response.Buffer = true
			Response.Clear()
			Response.ContentType = "application/pdf"
			Response.AddHeader "Content-Type", "application/pdf"
			Response.AddHeader "Content-Disposition", "attachment;filename=" & Chr(34)&  lastName & ", " & firstName & aCopy & ".pdf" & Chr(34)
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

sub InsertUpdateActivity(m_app_id, m_LastnameFirst, m_site)
	const DispTypeCode = 3 'Disposistion status for 'TookPlace'
	Const ApptType = -1 'System Activity Type for 'Initial Interview'
	
	dim strWhatWasDone
		strWhatWasDone = "" &_
			"Applicant Information Updated by " &_
			"VMS User " & user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
	
	dim cmd
	set cmd = Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(m_site))
		.CommandText =	"" &_
			"INSERT INTO Appointments " &_
				"(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, ContactId, Entered, EnteredBy, LocationId)" &_
				"VALUES (" &_
					"#" & Date() & "#, " & _
					insert_number(m_app_id) & ", " &_
					insert_string(strWhatWasDone) & ", " &_
					insert_string("{Anyone}") & ", " &_
					insert_number(ApptType) & ", " &_
					insert_number(DispTypeCode) & ", 0, " &_
					"#" & Date() & "#, " & _
					insert_string(tUser_id) & ", 1" &_
				")"
		cmd.Execute()
	end with
	set cmd = nothing
end sub

%>


