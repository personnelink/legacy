<%
dim jobid
jobid = request.form("jobid")
if len(jobid) = 0 then
	jobid = request.querystring("jobid")
end if

dim guest_session, save_notice

'Guest must be logged out and a user account created for the applicant to register
noGuestHead = "Are you registered?"
noGuestBody = "<p><span id=""inOrderTo"">In order to <b>Apply Now</b></span> you must first Create A Personnel Plus Account by clicking the Sign Up buttom below.</p><p>&nbsp;</p>" &_
	"<p>if you have already created your account you can <b>Log In</b> and continue with applying ..."

if session("no_header") <> true then response.write "<script type=""text/javascript"" src=""empapp.1.0.3.js""></script>"

dim page_title
dim aliasNames, heardAboutUs, staffed, who_staffed
dim MiddleName, addressOne, AddressTwo, city, UserState, zipcode, country, mainPhone, altPhone, email, ReeMail, ssn, dob, alienType, alienNumber
dim confirmPassword, uniqueUserID
dim password, emailupdates, desiredWageAmount, minWageAmount, workTypeDesired, maritalStatus, sex, citizen, workAuthProof, workAge, workValidLIcense
dim workLicenseType, workRelocate, workConviction, workConvictionExplain, currentlyEmployed, availableWhen, workCommuteHow, smoker, ssnRE
dim workCommuteDistance, workLicenseState, workLicenseExpire, workLicenseNumber, autoInsurance, eduLevel, additionalInfo, skillsClerical
dim skillsCustomerSvc, referenceNameOne, referencePhoneOne, referenceNameTwo, referencePhoneTwo, referenceNameThree, referencePhoneThree
dim skillsIndustrial, skillsGeneralLabor, skillsConstruction, skillsSkilledLabor, skillsBookkeeping, skillsSales, skillsManagement
dim skillsTechnical, skillsFoodService, skillsSoftware, skillsSet, employerNameHistOne, jobHistAddOne, jobHistPhoneOne, jobHistCityOne, jobHistStateOne
dim jobHistZipOne, jobHistPayOne, jobHistSupervisorOne, jobDutiesOne, jobHistFromDateOne, JobHistToDateOne, jobReasonOne, employerNameHistTwo, jobHistAddTwo
dim jobHistPhoneTwo, jobHistCityTwo, jobHistStateTwo, jobHistZipTwo, jobHistPayTwo, jobHistSupervisorTwo, jobDutiesTwo, jobHistFromDateTwo, JobHistToDateTwo
dim jobReasonTwo, employerNameHistThree, jobHistAddThree, jobHistPhoneThree, jobHistCityThree, jobHistStateThree, jobHistZipThree, jobHistPayThree, jobHistSupervisorThree
dim jobDutiesThree, jobHistFromDateThree, JobHistToDateThree, jobReasonThree, firstName, lastName, appState


' profile namespace




dim alienExpire, i94Admission, passportNumber, issuanceCountry

dim agree2applicant, agree2pandp, agree2noncompete, agree2unemployment, w4signed, agree2safety, agree2drug, agree2sexual, w4namediffers
dim middleinit, w4a, w4b, w4c, w4d, w4e, w4f, w4g, w4h, w4more, w4total, w4filing, w4exempt, sql

dim ecFullName, ecAddress, ecPhone, ecDoctor, ecDocPhone

Set ssnRE = New RegExp
ssnRE.Pattern = "[()-.<>'$]"
ssnRE.Global = true

select case formAction
case "save"
	if user_id <> 367 then 'No Save if Guest
		Database.Open MySql
		SaveApplication (True)
		Database.Close
	end if

case "submit"
	SubmitApplication
end select
	'Check if user has an application and if so load it
	Database.Open MySql
	if applicationId > 0 then
		sql = "SELECT tbl_applications.*, tbl_w4.*, tbl_users.userPhone, tbl_users.userSPhone, tbl_addresses.* " &_
			"FROM ((tbl_w4 RIGHT JOIN tbl_users ON tbl_w4.userid = tbl_users.userID) LEFT JOIN tbl_addresses ON tbl_addresses.addressID=tbl_users.addressID) LEFT JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
			"WHERE tbl_applications.applicationId=" & applicationId
		Set dbQuery = Database.Execute(sql)
		if dbQuery.eof then
			createNewApp
		else
			firstName = Pcase(user_firstname)
			lastName = Pcase(user_lastname)
			email = user_email
			mainPhone = dbQuery("userPhone")
			altPhone = dbQuery("userSPhone")
			addressOne = dbQuery("address")
			addressTwo = dbQuery("addressTwo")
			city = dbQuery("city")
			UserState = dbQuery("state")
			zipcode = dbQuery("zip")
			
			
			aliasNames = dbQuery("aliasNames")
			ssn = dbQuery("ssn")
			dob = dbQuery("dob")
			emailupdates =dbQuery("emailupdates")
			desiredWageAmount = dbQuery("desiredWageAmount")
			minWageAmount = dbQuery("minWageAmount")
			currentlyEmployed = dbQuery("currentlyEmployed")
			workTypeDesired = dbQuery("workTypeDesired")
			maritalStatus = dbQuery("maritalStatus")
			sex = dbQuery("sex")
			smoker = dbQuery("smoker")
			citizen = dbQuery("citizen")
			alienType = dbQuery("alienType")
			alienNumber = dbQuery("alienNumber")
			workAuthProof = dbQuery("workAuthProof")
			workAge = dbQuery("workAge")
			workValidLicense = dbQuery("workValidLicense")
			workLicenseType = dbQuery("workLicenseType")
			workRelocate = dbQuery("workRelocate")
			workConviction = dbQuery("workConviction")
			workConvictionExplain = dbQuery("workConvictionExplain")
			heardAboutUs = dbQuery("heardAboutUs")
			staffed = dbQuery("staffed")
			who_staffed = dbQuery("who_staffed")
			ecFullName = dbQuery("ecFullName")
			ecAddress = dbQuery("ecAddress")
			ecPhone = dbQuery("ecPhone")
			ecDoctor = dbQuery("ecDoctor")
			ecDocPhone = dbQuery("ecDocPhone")
			middleinit = dbQuery("middleinit")
			w4a = dbQuery("a")
			w4b = dbQuery("b")
			w4c = dbQuery("c")
			w4d = dbQuery("d")
			w4e = dbQuery("e")
			w4f = dbQuery("f")
			w4g = dbQuery("g")
			w4h = dbQuery("h")
			w4total = dbQuery("total")
			w4more = dbQuery("more")

			dim exempt_check
			exempt_check = dbQuery("exempt")
			if len(exempt_check) > 0 then
				w4exempt = cbool(exempt_check)
			else
				w4exempt = false
			end if

			w4filing = dbQuery("filing")
			w4namediffers = dbQuery("namediffers")
			availableWhen = dbQuery("availableWhen")
			workCommuteHow = dbQuery("workCommuteHow")
			workCommuteDistance = dbQuery("workCommuteDistance")
			workLicenseState = dbQuery("workLicenseState")
			workLicenseExpire = dbQuery("workLicenseExpire")
			workLicenseNumber = dbQuery("workLicenseNumber")
			autoInsurance = dbQuery("autoInsurance")
			eduLevel = dbQuery("eduLevel")
			additionalInfo = dbQuery("additionalInfo")
			referenceNameOne = dbQuery("referenceNameOne")
			referencePhoneOne = dbQuery("referencePhoneOne")
			referenceNameTwo = dbQuery("referenceNameTwo")
			referencePhoneTwo = dbQuery("referencePhoneTwo")
			referenceNameThree = dbQuery("referenceNameThree")
			referencePhoneThree = dbQuery("referencePhoneThree")
			skillsSet = dbQuery("skillsSet")
			employerNameHistOne = dbQuery("employerNameHistOne")
			jobHistAddOne = dbQuery("jobHistAddOne")
			jobHistPhoneOne = dbQuery("jobHistPhoneOne")
			jobHistCityOne = dbQuery("jobHistCityOne")
			jobHistStateOne = dbQuery("jobHistStateOne")
			jobHistZipOne = dbQuery("jobHistZipOne")
			jobHistPayOne = dbQuery("jobHistPayOne")
			jobHistSupervisorOne = dbQuery("jobHistSupervisorOne")
			jobDutiesOne = dbQuery("jobDutiesOne")
			jobHistFromDateOne = dbQuery("jobHistFromDateOne")
			JobHistToDateOne = dbQuery("JobHistToDateOne")
			jobReasonOne = dbQuery("jobReasonOne")
			employerNameHistTwo = dbQuery("employerNameHistTwo")
			jobHistAddTwo = dbQuery("jobHistAddTwo")
			jobHistPhoneTwo = dbQuery("jobHistPhoneTwo")
			jobHistCityTwo = dbQuery("jobHistCityTwo")
			jobHistStateTwo = dbQuery("jobHistStateTwo")
			jobHistZipTwo = dbQuery("jobHistZipTwo")
			jobHistPayTwo = dbQuery("jobHistPayTwo")
			jobHistSupervisorTwo = dbQuery("jobHistSupervisorTwo")
			jobDutiesTwo = dbQuery("jobDutiesTwo")
			jobHistFromDateTwo = dbQuery("jobHistFromDateTwo")
			JobHistToDateTwo = dbQuery("JobHistToDateTwo")
			jobReasonTwo = dbQuery("jobReasonTwo")
			employerNameHistThree = dbQuery("employerNameHistThree")
			jobHistAddThree = dbQuery("jobHistAddThree")
			jobHistPhoneThree = dbQuery("jobHistPhoneThree")
			jobHistCityThree = dbQuery("jobHistCityThree")
			jobHistStateThree = dbQuery("jobHistStateThree")
			jobHistZipThree = dbQuery("jobHistZipThree")
			jobHistPayThree = dbQuery("jobHistPayThree")
			jobHistSupervisorThree = dbQuery("jobHistSupervisorThree")
			jobDutiesThree = dbQuery("jobDutiesThree")
			jobHistFromDateThree = dbQuery("jobHistFromDateThree")
			JobHistToDateThree = dbQuery("JobHistToDateThree")
			jobReasonThree = dbQuery("jobReasonThree")
			agree2applicant = dbQuery("applicantAgree")
				if isnull(agree2applicant) then agree2applicant = ""
			agree2sexual = dbQuery("sexualAgree")
            	if isnull(agree2sexual) then agree2sexual = ""
			agree2noncompete = dbQuery("noncompeteAgree")
                if isnull(agree2noncompete) then agree2noncompete = ""
            agree2drug = dbQuery("drugAgree")
				if isnull(agree2drug) then agree2drug = ""
			agree2safety = dbQuery("safetyAgree")
				if isnull(agree2safety) then agree2drug = ""
			agree2pandp = dbQuery("pandpAgree")
				if isnull(agree2pandp) then agree2pandp = ""
			agree2unemployment = dbQuery("unempAgree")
				if isnull(agree2unemployment) then agree2unemployment = ""
			w4signed = dbQuery("signed")
				if isnull(w4signed) then w4signed = ""
		end if
	else
		createNewApp
	end if
	Database.Close

dim app_saved
app_saved = get_session("applicationSaved")
if len(app_saved) > 0 then
	response.write(decorateTop("savedApplication", "marLR10", "Application Saved"))
	response.write get_message(app_saved)
	response.write(decorateBottom())
	app_saved = set_session("applicationSaved", "")
end if

dim send_application, app_next, app_previous

dim empapp_general
dim empapp_contacts
dim empapp_skills
dim empapp_w4form
dim empapp_workhist
dim empapp_legal

empapp_general = " hide"
empapp_contacts = " hide"
empapp_skills = " hide"
empapp_w4form = " hide"
empapp_workhist = " hide"
empapp_legal = " hide"

'send_application = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""checkApplication('submit');""><span>... Finished! </span></a>"

leftSideMenu = "<div class=""notes"">" &_
 "<h4> Information </h4>" &_
 "<p>Fill in and complete all information on this form. Once completed, you will be enrolled with Personnel Plus and elgible for opportunities that become available.</p>" &_
 "<p>The information you provide will be used to identify you, electronically sign your application and to allow you to keep your online profile updated if your situation changes.</p>" &_
 "<p class=""last"">* Your information is protected using high-grade SSL RC4 128 bit secured encryption</p>" &_
 "</div>"

dim enrollmentMessage
select case whichpart
case "general"
	page_title = "Page 1 - General Employment Information"
	empapp_general = ""
	app_previous = ""
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('skills');""><span>... On to Skills &gt;&gt; </span></a>"

	enrollmentMessage = get_session("enrollmentMessage")
	if enrollmentMessage = "true" then
		dim enrollmentMessageTxt : enrollmentMessageTxt = ""
			enrollmentMessageTxt = createtop("enrollmentComplete", "marLRB10", "Account Created ...")
			enrollmentMessageTxt = enrollmentMessageTxt &_
				"<div id=""enrollmentCompleteContent""><p><strong>" &_
					"Thanks for registering with us!</strong></p><p>We look forward to working with you, listening to your " &_
					"comments and what you have tell us. <br><br>Your user account has been created successfully and " &_
					"an email sent to you with your account information to keep for your records.</p>" &_
				"</div>" & closeit()

		enrollmentMessage = set_session("enrollmentMessage", "")
	end if
case "skills"
	page_title = "Page 2 - Your skills that you have"
	empapp_skills = ""
	app_previous = "<a class=""squarebutton"" href=""#whichpart=workhist"" style=""margin-left: 6px"" onClick=""saveApplication('general');""><span>&lt;&lt; Go back to Beggining ... </span></a>"
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('workhist');""><span>... On to Work History &gt;&gt; </span></a>"

case "workhist"
	page_title = "Page 3 - Work History Information"
	empapp_workhist = ""
	app_previous = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('skills');""><span>&lt;&lt; Go back to Skills... </span></a>"
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('w4form');""><span>... On to W4 Form &gt;&gt; </span></a>"

case "w4form"
	page_title = "Page 4 - Form W4 Information"
	empapp_w4form = ""
	app_previous = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('workhist');""><span>&lt;&lt; Go back to Work History ... </span></a>"
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('contacts');""><span>... On to Contacts &gt;&gt; </span></a>"

case "contacts"
	page_title = "Page 5 - Other contact's information"
	empapp_contacts = ""
	app_previous = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('w4form');""><span>&lt;&lt; Go back to w4 Form ... </span></a>"
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('legal');""><span>... On to Legal &gt;&gt; </span></a>"

case "legal"
	page_title = "Page 6 - Legal disclosures and information"
	empapp_legal = ""
	app_previous = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('contacts');""><span>&lt;&lt; Go back to Contacts ... </span></a>"
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""checkApplication('submit');""><span>... Finished! </span></a>"

case else
	page_title = "Page 1 - General Employment Information"
	empapp_general = ""
	app_previous = ""
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('skills');""><span>... On to Skills >> </span></a>"
end select

Function SaveApplication (saveNotice)
	dim firstName, lastName, email, userID, sql, agree2pandp, agree2unemployment
    
	firstName = Pcase(request.form("nameF"))
	lastName = Pcase(request.form("nameL"))
	aliasNames = Pcase(request.form("aliasNames"))
	if not isnull(ssn) then ssn = ssnRE.Replace(request.form("ssn"), "")
	dob = request.form("dob")
	if isDate(dob) then	dob = FormatDateTime(dob, 2)
	email = Pcase(request.form("email"))
	emailupdates = request.form("emailupdates")
	if not isnull(user_phone) then mainPhone = ssnRE.Replace(user_phone, "")
	if not isnull(user_sphone) then altPhone = ssnRE.Replace(user_sphone, "")
	addressOne = request.form("addressOne")
	addressTwo = request.form("addressTwo")
	city = request.form("city")
	appState = request.form("appState")
	if not isnull(zipcode) then zipcode = ssnRE.Replace(request.form("zipcode"), "")
	desiredWageAmount = request.form("desiredWageAmount")
	minWageAmount = request.form("minWageAmount")
	sex = request.form("sex")
	maritalStatus = request.form("maritalStatus")
	smoker = request.form("smoker")
	currentlyEmployed = request.form("currentlyEmployed")
	workTypeDesired = request.form("workTypeDesired")
	citizen = request.form("citizen")
	alienType = request.form("alienType") : if len(alienType & "") = 0 then alienType = "p"
	alienNumber = request.form("alienNumber")
	workAuthProof = request.form("workAuthProof")
	workAge = request.form("workAge")
	workValidLicense = request.form("workValidLicense")
	workLicenseType = request.form("workLicenseType")
	workRelocate = request.form("workRelocate")
	workConviction = request.form("workConviction")
	workConvictionExplain = request.form("workConvictionExplain")
	staffed = request.form("staffed")
	who_staffed = request.form("who_staffed")
	ecFullName = request.form("ecFullName")
	ecAddress = request.form("ecAddress")
	ecPhone = request.form("ecPhone")
	ecDoctor = request.form("ecDoctor")
	ecDocPhone = request.form("ecDocPhone")
	middleinit = request.form("middleinit")
	w4namediffers = request.form("w4namediffers")
	w4a = request.form("w4a")
	w4b = request.form("w4b")
	w4c = request.form("w4c")
	w4d = request.form("w4d")
	w4e = request.form("w4e")
	w4f = request.form("w4f")
	w4g = request.form("w4g")
	w4h = request.form("w4h")
	w4more = request.form("w4more")
	w4total = request.form("w4total")
	w4filing = request.form("w4filing")
	w4exempt = request.form("w4exempt")
	w4signed = request.form("w4signed")
	currentlyEmployed = request.form("currentlyEmployed")
	availableWhen = request.form("availableWhen")
	workCommuteHow = request.form("workCommuteHow")
	workCommuteDistance = request.form("workCommuteDistance")
	workLicenseState = request.form("workLicenseState")
	workLicenseExpire = request.form("workLicenseExpire")
	workLicenseNumber = request.form("workLicenseNumber")
	autoInsurance = request.form("autoInsurance")
	eduLevel = request.form("eduLevel")
	additionalInfo = request.form("additionalInfo")
	heardAboutUs = request.form("heardAboutUs")
	referenceNameOne = request.form("referenceNameOne")
	referencePhoneOne = request.form("referencePhoneOne")
	if not isnull(referencePhoneOne) then referencePhoneOne = ssnRE.Replace(referencePhoneOne, "")
	referenceNameTwo = request.form("referenceNameTwo")

	referencePhoneTwo =request.form("referencePhoneTwo")
	if not isnull(referencePhoneTwo) then referencePhoneTwo = ssnRE.Replace(request.form("referencePhoneTwo"), "")

	referenceNameThree = request.form("referenceNameThree")

	referencePhoneThree =request.form("referencePhoneThree")
	if not isnull(referencePhoneThree) then referencePhoneThree = ssnRE.Replace(referencePhoneThree, "")

	skillsSet = CollectSkills
	employerNameHistOne = request.form("employerNameHistOne")
	jobHistAddOne = request.form("jobHistAddOne")

	jobHistPhoneOne = request.form("jobHistPhoneOne")
	if jobHistPhoneOne <> "na" and not isnull(jobHistPhoneOne) then jobHistPhoneOne = ssnRE.Replace(jobHistPhoneOne, "")

	jobHistCityOne = request.form("jobHistCityOne")
	jobHistStateOne = request.form("jobHistStateOne")

	jobHistZipOne = request.form("jobHistZipOne")
	if jobHistZipOne <> "na" and not isnull(jobHistZipOne) then jobHistZipOne = ssnRE.Replace(request.form("jobHistZipOne"), "")

	jobHistPayOne = request.form("jobHistPayOne")
	jobHistSupervisorOne = request.form("jobHistSupervisorOne")
	jobDutiesOne = request.form("jobDutiesOne")
	jobHistFromDateOne = request.form("jobHistFromDateOne")
	JobHistToDateOne = request.form("JobHistToDateOne")
	jobReasonOne = request.form("jobReasonOne")
	employerNameHistTwo = request.form("employerNameHistTwo")
	jobHistAddTwo = request.form("jobHistAddTwo")

	jobHistPhoneTwo = request.form("jobHistPhoneTwo")
	if jobHistPhoneTwo <> "na" and not isnull(jobHistPhoneTwo) then jobHistPhoneTwo = ssnRE.Replace(jobHistPhoneTwo, "")

	jobHistCityTwo = request.form("jobHistCityTwo")
	jobHistStateTwo = request.form("jobHistStateTwo")
	jobHistZipTwo = ssnRE.Replace(request.form("jobHistZipTwo"), "")
	jobHistPayTwo = request.form("jobHistPayTwo")
	jobHistSupervisorTwo = request.form("jobHistSupervisorTwo")
	jobDutiesTwo = request.form("jobDutiesTwo")
	jobHistFromDateTwo = request.form("jobHistFromDateTwo")
	JobHistToDateTwo = request.form("JobHistToDateTwo")
	jobReasonTwo = request.form("jobReasonTwo")
	employerNameHistThree = request.form("employerNameHistThree")
	jobHistAddThree = request.form("jobHistAddThree")

	jobHistPhoneThree = request.form("jobHistPhoneThree")
	if jobHistPhoneThree <> "na"  and not isnull(jobHistPhoneThree) then jobHistPhoneThree = ssnRE.Replace(jobHistPhoneThree, "")

	jobHistCityThree = request.form("jobHistCityThree")
	jobHistStateThree = request.form("jobHistStateThree")
	jobHistZipThree = request.form("jobHistZipThree")
	jobHistPayThree = request.form("jobHistPayThree")
	jobHistSupervisorThree = request.form("jobHistSupervisorThree")
	jobDutiesThree = request.form("jobDutiesThree")
	jobHistFromDateThree = request.form("jobHistFromDateThree")
	JobHistToDateThree = request.form("JobHistToDateThree")
	jobReasonThree = request.form("jobReasonThree")

	dim agrees
	if request.form("agree2pandp") = "agree" then
		agrees = "pandpAgree=Now(), "
	end if

    if request.form("agree2noncompete") = "agree" then
		agrees = agrees & "noncompeteAgree=Now(), "
	end if

	if request.form("agree2unemployment") = "agree" then
		agrees = agrees & "unempAgree=Now(), "
	end if

	if request.form("agree2applicant") = "agree" then
		agrees = agrees & "applicantAgree=Now(), "
	end if

	if request.form("agree2safety") = "agree" then
		agrees = agrees & "safetyAgree=Now(), "
	end if

	if request.form("agree2drug") = "agree" then
		agrees = agrees & "drugAgree=Now(), "
	end if

	if request.form("agree2sexual") = "agree" then
		agrees = agrees & "sexualAgree=Now(), "
	end if
        
	dim signw4
	if w4signed = "Sign" then
		signw4 = "signed=now(), "
	end if

	if instr(lcase(email), "none") > 0 and instr(email, "@") = 0 then email = ""

	sql = "UPDATE tbl_applications SET " &_
		"email=" & insert_string(lcase(email)) & ", " &_
		"firstName=" & insert_string(pcase(firstName)) & ", " &_
		"lastName=" & insert_string(pcase(lastName)) & ", " &_
		"ssn=" & insert_string(ssn) & ", " &_
		"aliasNames=" & insert_string(aliasNames) & ", " &_
		"dob=" & insert_string(dob) & ", " &_
		"mainPhone=" & insert_string(formatPhone(mainPhone)) & ", " &_
		"altPhone=" & insert_string(formatPhone(altPhone)) & ", " &_
		"addressOne=" & insert_string(pcase(addressOne)) & ", " &_
		"addressTwo=" & insert_string(pcase(addressTwo)) & ", " &_
		"city=" & insert_string(pcase(city)) & ", " &_
		"appState=" & insert_string(ucase(appState)) & ", " &_
		"zipcode=" & insert_string(zipcode) & ", " &_
		"emailupdates=" & insert_string(emailupdates) & ", " &_
		"ecFullName=" & insert_string(ecFullName) & ", " &_
		"ecAddress=" & insert_string(ecAddress) & ", " &_
		"ecPhone=" & insert_string(ecPhone) & ", " &_
		"ecDoctor=" & insert_string(ecDoctor) & ", " &_
		"ecDocPhone=" & insert_string(ecDocPhone) & ", " &_
		"desiredWageAmount=" & insert_string(desiredWageAmount) & ", " &_
		"minWageAmount=" & insert_string(minWageAmount) & ", " &_
		"sex=" & insert_string(sex) & ", " &_
		"maritalStatus=" & insert_string(maritalStatus) & ", " &_
		"smoker=" & insert_string(smoker) & ", " &_
		"currentlyEmployed=" & insert_string(currentlyEmployed) & ", " &_
		"workTypeDesired=" & insert_string(workTypeDesired) & ", " &_
		"citizen=" & insert_string(citizen) & ", " &_
		"alienType=" & insert_string(alienType) & ", " &_
		"alienNumber=" & insert_string(alienNumber) & ", " &_
		"workAuthProof=" & insert_string(workAuthProof) & ", " &_
		"workAge=" & insert_string(workAge) & ", " &_
		"workValidLicense=" & insert_string(workValidLicense) & ", " &_
		"workLicenseType=" & insert_string(workLicenseType) & ", " &_
		"autoInsurance=" & insert_string(autoInsurance) & ", " &_
		"workRelocate=" & insert_string(workRelocate) & ", " &_
		"workConviction=" & insert_string(workConviction) & ", " &_
		"workConvictionExplain=" & insert_string(workConvictionExplain) & ", " &_
		"staffed=" & insert_string(staffed) & ", " &_
		"who_staffed=" & insert_string(who_staffed) & ", " &_
		"eduLevel=" & insert_string(eduLevel) & ", " &_
		"referenceNameOne=" & insert_string(pcase(referenceNameOne)) & ", " &_
		"referencePhoneOne=" & insert_string(formatPhone(referencePhoneOne)) & ", " & _
		"referenceNameTwo=" & insert_string(pcase(referenceNameTwo)) & ", " &_
		"referencePhoneTwo=" & insert_string(formatPhone(referencePhoneTwo)) & ", " &_
		"referenceNameThree=" & insert_string(pcase(referenceNameThree)) & ", " &_
		"referencePhoneThree=" & insert_string(formatPhone(referencePhoneThree)) & ", " &_
		"additionalInfo=" & insert_string(additionalInfo) & ", " &_
		"heardAboutUs=" & insert_string(heardAboutUs) & ", " &_
		"skillsSet=" & insert_string(skillsSet) & ", " &_
		"employerNameHistOne=" & insert_string(pcase(employerNameHistOne)) & ", " &_
		"jobHistAddOne=" & insert_string(pcase(jobHistAddOne)) & ", " & _
		"jobHistCityOne=" & insert_string(pcase(jobHistCityOne)) & ", " &_
		"jobHistStateOne=" & insert_string(ucase(jobHistStateOne)) & ", " &_
		"jobHistZipOne=" & insert_string(jobHistZipOne) & ", " &_
		"jobHistPayOne=" & insert_string(jobHistPayOne) & ", " &_
		"jobHistSupervisorOne=" & insert_string(pcase(jobHistSupervisorOne)) & ", " &_
		"jobHistPhoneOne=" & insert_string(formatPhone(jobHistPhoneOne)) & ", " &_
		"jobHistFromDateOne=" & insert_string(jobHistFromDateOne) & ", " & _
		"jobHistToDateOne=" & insert_string(jobHistToDateOne) & ", " &_
		"jobDutiesOne=" & insert_string(jobDutiesOne) & ", " &_
		"jobReasonOne=" & insert_string(jobReasonOne) & ", " &_
		"employerNameHistTwo=" & insert_string(pcase(employerNameHistTwo)) & ", " &_
		"jobHistAddTwo=" & insert_string(pcase(jobHistAddTwo)) & ", " &_
		"jobHistCityTwo=" & insert_string(pcase(jobHistCityTwo)) & ", " &_
		"jobHistStateTwo=" & insert_string(ucase(jobHistStateTwo)) & ", " & _
		"jobHistZipTwo=" & insert_string(jobHistZipTwo) & ", " &_
		"jobHistPayTwo=" & insert_string(jobHistPayTwo) & ", " &_
		"jobHistSupervisorTwo=" & insert_string(pcase(jobHistSupervisorTwo)) & ", " &_
		"jobHistPhoneTwo=" & insert_string(formatPhone(jobHistPhoneTwo)) & ", " &_
		"jobHistFromDateTwo=" & insert_string(jobHistFromDateTwo) & ", " &_
		"jobHistToDateTwo=" & insert_string(JobHistToDateTwo) & ", " &_
		"jobDutiesTwo=" & insert_string(jobDutiesTwo) & ", " &_
		"jobReasonTwo=" & insert_string(jobReasonTwo) & ", " & _
		"employerNameHistThree=" & insert_string(pcase(employerNameHistThree)) & ", " &_
		"jobHistAddThree=" & insert_string(pcase(jobHistAddThree)) & ", " &_
		"jobHistPhoneThree=" & insert_string(formatPhone(jobHistPhoneThree)) & ", " &_
		"jobHistCityThree=" & insert_string(pcase(jobHistCityThree)) & ", " &_
		"jobHistStateThree=" & insert_string(ucase(jobHistStateThree)) & ", " &_
		"jobHistZipThree=" & insert_string(jobHistZipThree) & ", " &_
		"jobHistPayThree=" & insert_string(jobHistPayThree) & ", " & _
		"jobHistSupervisorThree=" & insert_string(pcase(jobHistSupervisorThree)) & ", " &_
		"jobDutiesThree=" & insert_string(jobDutiesThree) & ", " &_
		"jobHistFromDateThree=" & insert_string(jobHistFromDateThree) & ", " &_
		"JobHistToDateThree=" & insert_string(JobHistToDateThree) & ", " &_
		"jobReasonThree=" & insert_string(jobReasonThree) & ", " &_
		agrees &_
		"modifiedDate=Now() " &_
		"WHERE applicationId=" & applicationId &_
	";" &_
	"UPDATE tbl_applications_srch SET " &_
		"additionalInfo=" & insert_string(additionalInfo) & ", " &_
		"skillsSet=" & insert_string(skillsSet) & ", " &_
		"jobDutiesOne=" & insert_string(jobDutiesOne) & ", " &_
		"jobReasonOne=" & insert_string(jobReasonOne) & ", " &_
		"jobDutiesTwo=" & insert_string(jobDutiesTwo) & ", " &_
		"jobReasonTwo=" & insert_string(jobReasonTwo) & ", " & _
		"jobDutiesThree=" & insert_string(jobDutiesThree) & ", " &_
		"jobReasonThree=" & insert_string(jobReasonThree) & " " &_
		"WHERE applicationId=" & applicationId &_
	";" &_
	"UPDATE tbl_w4 SET " &_
		"middleinit=" & insert_string(middleinit) & ", " &_
		"namediffers=" & insert_number(w4namediffers) & ", " &_
		"a=" & insert_number(w4a) & ", " &_
		"b=" & insert_number(w4b) & ", " &_
		"c=" & insert_number(w4c) & ", " &_
		"d=" & insert_number(w4d) & ", " &_
		"e=" & insert_number(w4e) & ", " &_
		"f=" & insert_number(w4f) & ", " &_
		"h=" & insert_number(w4h) & ", " &_
		"total=" & insert_number(w4total) & ", " &_
		"more=" & insert_number(w4more) & ", " &_
		"exempt=" & insert_number(w4exempt) & ", " &_
		signw4 &_
		"filing=" & insert_number(w4filing) & ", " &_
		"g=" & insert_number(w4g) & " " &_
		"WHERE userid=" & user_id

	Database.Execute(sql)

	sql = "UPDATE tbl_addresses SET " &_
		"address=" & insert_string(request.form("addressOne")) & ", " &_
		"addressTwo=" & insert_string(request.form("addressTwo")) & ",  " &_
		"city=" & insert_string(request.form("city")) & ",  " &_
		"state=" & insert_string(request.form("state")) & ",  " &_
		"zip=" & insert_string(request.form("zipcode")) & ",  " &_
		"country=" & insert_string(request.form("country")) & " Where addressID=" & addressId
	set dbQuery=Database.Execute(sql)
	
	sql = "UPDATE tbl_users SET " &_
		"userEmail=" & insert_string(request.form("email")) & ", " &_ 
		"userPhone=" & insert_string(FormatPhone(request.form("pphone"))) & ", " &_
		"userSPhone=" & insert_string(FormatPhone(request.form("sphone"))) & ", " &_
		"title=" & insert_string(request.form("title")) & ", " &_
		"firstName=" & insert_string(request.form("nameF")) & ", " &_ 
		"lastName=" & insert_string(request.form("nameL")) & " " &_
		"WHERE userID=" & user_id
	set dbQuery=Database.Execute(sql)

	
	
	
	if saveNotice then
		session("applicationSaved") = "<div id=" & chr(34) & "applicationSaved" & chr(34) & "><p><span>Your application was successfully saved.</span></p><br>" &_
		"<p>Don't forget your application is not completed and you are not elgible for work until you fill in all the information and submit it online." &_
		" Please remember to return at your convenience to finish and submit your application!</p></div>"
		'break session("applicationSaved")
	end if

End Function

Sub SubmitApplication
	Database.Open MySql
	SaveApplication (false)
	Database.Execute("UPDATE tbl_applications SET submitted='y' WHERE applicationId=" & applicationId)

	if len(jobid) > 0 then
		dim getJobDetails
		Set GetJobDetails = Server.CreateObject("ADODB.Connection")
		'Determine destination
		dim deliveryLocation
		select case lcase(left(jobid, 3))
		case "bur"
			deliveryLocation = "burley@personnel.com"
			GetJobDetails.Open dsnLessTemps(BUR)
			case "boi"
			deliveryLocation = "boise@personnel.com;nampa@personnel.com"
			GetJobDetails.Open dsnLessTemps(BOI)
		case "per"
			deliveryLocation = "twin@personnel.com"
			GetJobDetails.Open dsnLessTemps(PER)
		case else
			deliveryLocation = "twin@personnel.com"
		end select

		dim appLink, msgBody, msgSubject
		dim JobDetails
		Set JobDetails = getJobDetails.Execute("SELECT Def1, Def2 FROM OtherOrders WHERE Reference=" & right(jobid, len(jobid)-3))
		appLink = "<a href='/include/system/tools/activity/applications/view/'>View Online Applications</a>"

		if not JobDetails.eof then
			msgSubject = user_firstname & " " & user_lastname & " submitted an application for """ & JobDetails("Def2") & """"
			msgBody = "<send_as_html>Employment Application completed by " & user_firstname & " " & user_lastname &_
				", in response to Job ID: <b style=""color:red"">" & jobid & "</b><br /><br />" & JobDetails("Def1")
		else
			msgSubject = user_firstname & " " & user_lastname & " submitted an application for " & jobid
			msgBody = "Employment Application completed by " & user_firstname & " " & user_lastname &_
				", in response to job id: " & jobid
		end if

		Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")

		GetJobDetails.Close
		Set JobDetails = nothing
		Set GetJobDetails = nothing

	end if

	Set dbQuery = Database.Execute("SELECT modifiedDate, lastInserted, zipcode FROM tbl_applications WHERE applicationId=" & applicationId)

	if len(jobid) = 0 then
		if not dbQuery.eof then
			dim ModifiedTime, InsertedTime, appzipcode
			ModifiedTime = dbQuery("modifiedDate")
			InsertedTime = dbQuery("lastInserted")
			appzipcode = dbQuery("zipcode")

			if  DateDiff("n", InsertedTime, ModifiedTime) > 0 then
				appLink = "https://www.personnelinc.com/pdfServer/pdfApplication/createApplication.asp?appID=" & applicationId &_
						"&action=inject&update=1"
				msgSubject = user_firstname & " " & user_lastname & " has updated their online application."
				msgBody = user_firstname & " " & user_lastname & " has updated their online application." & vbCrLf & vbCrLf &_
						"You can update their enrollment information by clicking the blue-arrow beside their name from with-in the 'View Applications' tool or you can use this link: " & appLink

				'Determine destination
				Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & appzipcode & "'")
				if Not dbQuery.eof then
					deliveryLocation = dbQuery("email")
				else
					deliveryLocation = "twin@personnel.com"
				end if
				Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")
			end if
		end if
	end if

	Set dbQuery = Nothing
	Database.Close()

	session("no_header") = false
	response.redirect("/userHome.asp?AST=ao")
End Sub

Function CollectSkills
	dim i, Skills, SkillItem

	Skills = "."
	For i = 1 to CInt(request.form("totalSkills"))
		SkillItem = Trim(request.form("Ck_" & i))
		if len(SkillItem) > 0 then Skills = Skills + SkillItem + "."
	Next
	CollectSkills = Skills
End Function

Function CheckField (formField)
	if request.form("formAction") = "true" then

	dim TempValue
	Select Case	formField
		Case "email"
			TempValue = request.form("email")
			Database.Open MySql
			Set dbQuery = Database.Execute("Select email From tbl_users Where email = '" & TempValue & "'")

			if TempValue = "" then
				CheckField = errImage & " User name is required"
			elseif len(TempValue) < 5 then
				CheckField = errImage & " User name must be longer<br>than 5 characters, letters<br>and/or numbers."
			elseif Not dbQuery.eof then
					CheckField = errImage & "Email address already registered. <br>Please use a different one or contact our offices."
			elseif Instr(TempValue,"@") = 0 then
				CheckField = errImage & " Invalid eMail Address"
			Else
				CheckField = ""
			end if
			Set dbQuery = Nothing
			Database.Close
		Case "password"
			TempValue = request.form("password")
			if TempValue = "" then
				CheckField = errImage & " Password is required"
			elseif TempValue <> request.form("retypedpassword") then
				CheckField = errImage & " Passwords do not match"
			Else
				CheckField = ""
			end if
		Case "nameF"
			if request.form("nameF") = "" then
				CheckField = errImage & " First name is required"
			Else
				CheckField = ""
			end if
		Case "nameL"
			if request.form("nameL") = "" then
				CheckField = errImage & " Last name is required"
			Else
				CheckField = ""
			end if
		Case "addOne"
			if request.form("addOne") = "" then
				CheckField = errImage & " Address is required"
			Else
				CheckField = ""
			end if
		Case "city"
			if request.form("city") = "" then
				CheckField = errImage & " City Required"
			Else
				CheckField = ""
			end if
		Case "zipcode"
			if request.form("zipcode") = "" then
				CheckField = errImage & " Zip Code Required"
			Else
				CheckField = ""
			end if
		End Select
		Else
			CheckField = ""
		end if
End Function

dim addressInfo
Sub createNewApp
		'Execute the INSERT statement and the SELECT @@IDENTITY
		Set addressInfo = Database.execute("SELECT address, addressTwo, city, state, zip " &_
			"FROM tbl_addresses " &_
			"WHERE addressID=" & addressId)

		dim qryTxt
		qryTxt = "INSERT INTO tbl_applications (creationDate, modifiedDate, lastName, firstName, addressOne, addressTwo, city, appState, zipcode, userID) " & _
							 "VALUES (now(), " &_
							 "now(), " &_
							 insert_string(user_lastname) & ", " &_
							 insert_string(user_firstname) & ", " &_
							 insert_string(addressInfo("address")) & ", " &_
							 insert_string(addressInfo("addressTwo")) & ", " &_
							 insert_string(addressInfo("city")) & ", " &_
							 insert_string(addressInfo("state")) & ", " &_
							 insert_string(addressInfo("zip")) & ", " &_
							 insert_string(user_id) & "); " & _
							 "SELECT last_insert_id()"
		'response.write qryTxt
		'Response.End()
		Set dbQuery = Database.execute(qryTxt).nextrecordset
		applicationId = CDbl(dbQuery(0))
		Database.Execute("Update tbl_users SET applicationId=" & applicationId & " WHERE userID=" & user_id)

		Database.Execute("INSERT INTO tbl_applications_srch (applicationID) VALUES (" & insert_number(applicationId) & ")")

		'create w4 record
		qryTxt = "INSERT INTO tbl_w4 (userid, created) VALUES ('" & user_id & "', now())"
		Database.Execute(qryTxt)
		Set dbQuery = Nothing
End Sub

Function CheckPhone (PhoneNumber)
	if request.form("formAction") = "true" then
		if PhoneNumber = "" then
			CheckPhone = errImage & " Phone Number Required"
		elseif len(PhoneNumber) < 13 then
			CheckPhone = errImage & " Not enough numbers"
		elseif len(PhoneNumber) > 13 then
			CheckPhone = errImage & " Invalid Phone Number"
		Else
			CheckPhone = ""
		end if
	end if
End Function

sub checked
	response.write "checked=""checked"""
end sub

function presentSkills()
	dim strHoldResponse, skillGroupId

	dim getSkills_cmd, Skills, skillItem, skilledIn, i, html
	Set getSkills_cmd = Server.CreateObject ("ADODB.Command")
	With getSkills_cmd
		.ActiveConnection = MySql
		.CommandText = "Select * From list_jobskills Order By keyid ASC"
		.Prepared = true
	End With
	Set Skills = getSkills_cmd.Execute
	i = 0
	html = "<li><input type=" & Chr(34) & "checkbox"" name=" & Chr(34) & "Ck_SKILLINDEX" &_
		Chr(34) & " id=" & Chr(34) & "Ck_SKILLINDEX"" class=""styled"" value=" &_
		Chr(34) & "SKILLVALUE" & Chr(34) & " CHECKED_OR_NOT>SKILLNAME</li>"

	do while not Skills.eof
		if Instr(Skills("skillName"), "<p>") > 0 then
			'terminate previous list, but not if this is first iteration
			if i > 0 then strHoldResponse = strHoldResponse & "</ul></div>"

			skillGroupId = ClearHTMLTags(lcase(replace(Skills("skillName"), " ", "_")), 2)

			strHoldResponse = strHoldResponse &_
				"<div class=""selectskillgroup"" id=""" & skillGroupId & """ onclick=""showskills('" & skillGroupId & "');"">" &_
					Skills("skillName") &_
				"</div>" &_
				"<div id=""" & skillGroupId & "_list"" class=""hideskillgroup hide""><div onclick=""hideskills('" & skillGroupId & "');"">" & Skills("skillName") & "</div><ul>"
		Else
			i = i + 1
			skillItem = html
			skillItem = Replace(html, "SKILLINDEX", i)
			skillItem = Replace(skillItem, "SKILLVALUE", Skills("skillValue"))
			skillItem = Replace(skillItem, "SKILLNAME", Skills("skillName"))
			if Instr(skillsSet, "." & Skills("skillValue") & ".") > 0 then
				skilledIn = "Checked"
			Else
				skilledIn = ""
			end if
			skillItem = Replace(skillItem, "CHECKED_OR_NOT", skilledIn)
			strHoldResponse = strHoldResponse & skillItem
		end if
		Skills.Movenext
	loop
	presentSkills = strHoldResponse &_
				"</ul></div><input type='hidden' value=" & Chr(34) & i & Chr(34) & " name=" & Chr(34) & "totalSkills" & Chr(34) & ">"

	Set getSkills_cmd = Nothing
	Skills.Close()
end function

function presentNewSkills()
	dim strHoldResponse, skillGroupId

	dim getSkills_cmd, Skills, skillItem, skilledIn, i, html
	Set getSkills_cmd = Server.CreateObject ("ADODB.Command")
	With getSkills_cmd
		.ActiveConnection = MySql
		.CommandText = "SELECT * FROM pplusvms.list_skills_import WHERE keywordid IS NOT NULL ORDER By category ASC, subcategory ASC, skill ASC;"
		.Prepared = true
	End With
	Set Skills = getSkills_cmd.Execute
	i = 0
	html = "<li><input type=" & Chr(34) & "checkbox"" name=" & Chr(34) & "Ck_SKILLINDEX" &_
		Chr(34) & " id=" & Chr(34) & "Ck_SKILLINDEX"" class=""styled"" value=" &_
		Chr(34) & "SKILLVALUE" & Chr(34) & " CHECKED_OR_NOT>SKILLNAME</li>"

	dim strCategory, strSubCategory, strLastCategory, strLastSubCategory, blnFirstLoop, blnCloseSub
	blnFirstLoop = true
	blnCloseSub = false

	do while not Skills.eof
		strCategory = Skills("category")
		strSubCategory = Skills("subcategory")

		if strCategory <> strLastCategory then
			if not blnFirstLoop then
				strHoldResponse = strHoldResponse &_
					"</ul></div></li></ul></div>"
			end if

			skillGroupId = lcase(replace(strCategory, " ", "_")) & i

			skillGroupId = replace(skillGroupId, "/", "")

			strHoldResponse = strHoldResponse &_
				"<div class=""selectskillgroup category"" id=""" & skillGroupId & """ onclick=""showskills('" & skillGroupId & "');""><p>" &_
					strCategory &_
				"</p></div>" &_
				"<div id=""" & skillGroupId & "_list"" class=""hideskillgroup hide category""><div class=""category"" onclick=""hideskills('" & skillGroupId & "');""><p>" & strCategory & "</p></div><ul>"

			strLastCategory = strCategory
			blnCloseSub = false
		end if

		if strSubCategory <> strLastSubCategory then
			if not blnFirstLoop and blnCloseSub then
				strHoldResponse = strHoldResponse &_
					"</ul></div></li>"
			end if

			skillGroupId = lcase(replace(strCategory, " ", "_")) & lcase(replace(strSubCategory, " ", "_"))

			skillGroupId = replace(skillGroupId, "/", "")

			strHoldResponse = strHoldResponse &_
				"<li><div class=""selectskillsubgroup subcategory"" id=""" & skillGroupId & """ onclick=""showskills('" & skillGroupId & "');""><p>" &_
					strSubCategory &_
				"</p></div>" &_
				"<div id=""" & skillGroupId & "_list"" class=""hideskillsubgroup hide subcategory""><div class=""subcategory"" onclick=""hideskills('" & skillGroupId & "');""><p>" & strSubCategory & "</p></div><ul>"

			strLastSubCategory = strSubCategory
			blnCloseSub = true

		end if

		if blnFirstLoop then
			'set 'first loop' flag to false
			blnFirstLoop = false
		end if

		i = i + 1
		skillItem = html
		skillItem = Replace(html, "SKILLINDEX", i)
		skillItem = Replace(skillItem, "SKILLVALUE", Skills("keywordid"))
		skillItem = Replace(skillItem, "SKILLNAME", Skills("skill"))
		if Instr(skillsSet, "." & Skills("keywordid") & ".") > 0 then
			skilledIn = "Checked"
		Else
			skilledIn = ""
		end if
		skillItem = Replace(skillItem, "CHECKED_OR_NOT", skilledIn)
		strHoldResponse = strHoldResponse & skillItem

		strLastCategory = strCategory
		strLastSubCategory = strSubCategory

		Skills.Movenext
	loop
	presentNewSkills = strHoldResponse &_
				"</li></ul></div></ul></div><input type='hidden' value=" & Chr(34) & i & Chr(34) & " name=" & Chr(34) & "totalSkills" & Chr(34) & ">"

	Set getSkills_cmd = Nothing
	Skills.Close()
end function

%>