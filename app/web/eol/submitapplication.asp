<%Option Explicit%>
<%
session("add_css") = "submitapplication.asp.css"
session("required_user_level") = 3 'userLevelRegistered

session("additionalHeading") = "<meta http-equiv=""Cache-Control"" content=""No-Cache"">" & chr(13) &_
	"<meta http-equiv=""Cache-Control"" content=""No-Store"">" & chr(13) &_
	"<meta http-equiv=""Pragma"" content=""No-Cache"">" & chr(13) &_
	"<meta http-equiv=""Expires"" content=""0"">" & chr(13)

dim formAction
formAction = request.form("formAction")
if formAction = "submit" then session("no_header") = true

dim whichpart, previouspart, formpart

whichpart = Request.QueryString("whichpart")
previouspart = request.form("previouspart")
formpart = request.form("wheretogo")

if len(formpart) = 0 then 'form hasnt been loaded before
	if len(whichpart) = 0 then 'no querystring request
		whichpart = "general"
	end if
else
	whichpart = formpart
end if

if formAction = "submit" then session("no_header") = true

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->
<%

dim guest_session, save_notice

'Guest must be logged out and a user account created for the applicant to register
noGuestHead = "Are you registered?"
noGuestBody = "<p><span id=""inOrderTo"">In order to <b>Apply Now</b></span> you must first Create A Personnel Plus Account by clicking the Sign Up buttom below.</p><p>&nbsp;</p>" &_
	"<p>if you have already created your account you can <b>Log In</b> and continue with applying ..."

if session("no_header") <> true then response.write "<script type=""text/javascript"" src=""/include/js/submitapplication.js""></script>"

dim page_title
dim aliasNames, heardAboutUs, staffed, who_staffed
dim MiddleName, addressOne, AddressTwo, city, UserState, zipcode, country, mainPhone, altPhone, email, ReeMail, ssn, dob, alienType, alienNumber
dim confirmPassword, uniqueUserID
dim password, emailupdates, desiredWageAmount, minWageAmount, workTypeDesired, maritalStatus, sex, citizen, workAuthProof, workAge, workValidLIcense
dim workLicenseType, workRelocate, workConviction, workConvictionExplain, currentlyEmployed, availableWhen, workCommuteHow, smoker, ssnRE
dim workCommuteDistance, workLicenseState, workLicenseExpire, workLicenseNumber, autoInsurance, eduLevel, additionalInfo, skillsClerical
dim skillsCustomerSvc, referenceNameOne, referencePhoneOne, referenceNameTwo, referencePhoneTwo, referenceNameThree, referencePhoneThree
dim skillsIndustrial, skillsGeneralLabor, skillsConstruction, skillsSkilledLabor, skillsBookkeeping, skillsSales, skillsManagement
dim	skillsTechnical, skillsFoodService, skillsSoftware, skillsSet, employerNameHistOne, jobHistAddOne, jobHistPhoneOne, jobHistCityOne, jobHistStateOne
dim jobHistZipOne, jobHistPayOne, jobHistSupervisorOne, jobDutiesOne, jobHistFromDateOne, JobHistToDateOne, jobReasonOne, employerNameHistTwo, jobHistAddTwo
dim jobHistPhoneTwo, jobHistCityTwo, jobHistStateTwo, jobHistZipTwo, jobHistPayTwo, jobHistSupervisorTwo, jobDutiesTwo, jobHistFromDateTwo, JobHistToDateTwo
dim jobReasonTwo, employerNameHistThree, jobHistAddThree, jobHistPhoneThree, jobHistCityThree, jobHistStateThree, jobHistZipThree, jobHistPayThree, jobHistSupervisorThree
dim jobDutiesThree, jobHistFromDateThree, JobHistToDateThree, jobReasonThree, firstName, lastName, appState

dim agree2applicant, agree2pandp, agree2unemployment, w4signed, w4namediffers
dim middleinit, w4a, w4b, w4c, w4d, w4e, w4f, w4g, w4h, w4more, w4total, w4filing, w4exempt, sql

dim ecFullName, ecAddress, ecPhone, ecDoctor, ecDocPhone

dim addressInfo
Set ssnRE = New RegExp
ssnRE.Pattern = "[()-.<>'$]"
ssnRE.Global = true

select case formAction
case "save"
	Database.Open MySql
	SaveApplication (True)
	Database.Close
case "submit"
	SubmitApplication
end select
	'Check if user has an application and if so load it
	Database.Open MySql
	if applicationId > 0 then
		sql = "SELECT tbl_applications.*, tbl_w4.* " &_
			"FROM (tbl_w4 RIGHT JOIN tbl_users ON tbl_w4.userid = tbl_users.userID) LEFT JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
			"WHERE tbl_applications.applicationId=" & applicationId
		Set dbQuery = Database.Execute(sql)
		if dbQuery.eof then
			createNewApp
		else
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
select case whichpart
case "general"
	page_title = "Page 1 - General Employment Information"
	empapp_general = ""
	app_previous = ""
	app_next = "<a class=""squarebutton"" href=""#"" style=""margin-left: 6px"" onClick=""saveApplication('skills');""><span>... On to Skills &gt;&gt; </span></a>"
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

%>
<div id="empAppNav">
  <ul>
    <li id="t_nav_general" class="<% if whichpart = "general" or whichpart = "" then response.write "selected" %>"><a  href="#" onClick="saveApplication('general');">1. Begin </a></li>
    <li id="t_nav_skills" class="<% if whichpart = "skills" then response.write "selected" %>"><a class="" href="#" onClick="saveApplication('skills');">2. Select Skills </a></li>
    <li id="t_nav_workhist" class="<% if whichpart = "workhist" then response.write "selected" %>"><a class="" href="#" onClick="saveApplication('workhist');">3. Work History </a></li>
    <li id="t_nav_w4form" class="<% if whichpart = "w4form" then response.write "selected" %>"><a class="" href="#" onClick="saveApplication('w4form');">4. Form W4 </a></li>
    <li id="t_nav_contacts" class="<% if whichpart = "contacts" then response.write "selected" %>"><a class="" href="#" onClick="saveApplication('contacts');">5. Contacts </a></li>
    <li id="t_nav_legal" class="<% if whichpart = "legal" then response.write "selected" %>"><a class="" href="#" onClick="saveApplication('legal');">6. The End. </a></li>
  </ul>
</div>
<form class="empapp" name="application" id="application" action="" method="post">
  <%=decorateTop("problemsInApp", "hide marLR10", "Whoops...")%>
  <div id="problemsInAppImage">
    <p>Some problems were found in your application.</p>
	<p id="thisproblem">&nbsp;</p>
    <p>Please review your application for missing or incorrect information and then try submitting it again.</p>
  </div>
  <%=decorateBottom()%> <%=decorateTop("employmentPreferences", "marLR10" & empapp_general, "Employment Information")%>
  <div id="basicInformation">
    <p>
      <label id="ssnLabel" for="ssn" class="fieldIsGood"><span>&nbsp;</span>SSN</label>
      <input type="text" name="ssn" id="ssn" value="<%=ssn%>" tabindex="1" onBlur="check_field('ssn')" class="halfSized">
      <span class="helpText">555-55-5555</span> </p>
    <% if instr(empapp_general, "hide") = 0 then %>
	<script type="text/javascript"><!-- 
					document.application.ssn.focus()
							//--></script> 
    <% end if%>
	<p>
      <label id="dobLabel" for="dob" class="fieldIsGood"><span>&nbsp;</span>Birth Date</label>
      <input type="text" name="dob" id="dob" value="<%=dob%>" tabindex="2" onBlur="check_field('dob')" class="halfSized">
      <span class="helpText">mm/dd/yyyy</span> </p>
    <p>
      <label id="desiredWageAmountLabel" for="desiredWageAmount" class="fieldIsGood"><span>&nbsp;</span>Desired Hourly Salary/Wage:</label>
      <input type="text" id="desiredWageAmount" name="desiredWageAmount" value="<%=desiredWageAmount%>" onBlur="check_field('desiredWageAmount')" tabindex="3">
    </p>
    <p>
      <label id="minWageAmountLabel" for="minWageAmount" class="fieldIsGood"><span>&nbsp;</span>Minimum Hourly Salary/Wage:</label>
      <input type="text" id="minWageAmount" name="minWageAmount" value="<%=minWageAmount%>" onBlur="check_field('minWageAmount')" tabindex="4">
    </p>
    <p>
      <label id="aliasNamesLbl" for="aliasNames" class="fieldIsGood"><span>&nbsp;</span>Alias Names (Include Maiden/prior Maiden Names)</label>
      <input type="text" name="aliasNames" id="aliasNames" value="<%=aliasNames%>" tabindex="5" onBlur="">
      <span class="helpText">&nbsp;</span> </p>
    <ul>
      <li>
        <label id="currentlyEmployedLabel" class="fieldIsGood"><span>&nbsp;</span>Are you currently employed?</label>
      </li>
      <li>
        <input type="radio" name="currentlyEmployed" value="y" class="styled" <% if currentlyEmployed = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li>
        <input type="radio" name="currentlyEmployed" value="n" class="styled" <% if currentlyEmployed = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul>
      <label id="sexLabel" class="fieldIsGood"><span>&nbsp;</span>Are you Male or Female?</label>
      <li>
        <input type="radio" name="sex" value="m" class="styled" <% if sex = "m" then response.write("checked")%>>
      </li>
      <li>Male</li>
      <li>
        <input type="radio" name="sex" value="f" class="styled" <% if sex = "f" then response.write("checked")%>>
      </li>
      <li>Female</li>
    </ul>
    <!--
	<ul>
      <label id="maritalStatusLabel" class="fieldIsGood"><span>&nbsp;</span>Are you married or single?</label>
      <li>
        <input type="radio" name="maritalStatus" value="s" class="styled" <% if maritalStatus = "s" then response.write("checked")%>>
      </li>
      <li>Single, Seperated or Divorced</li>
      <li>
        <input type="radio" name="maritalStatus" value="m" class="styled" <% if maritalStatus = "m" then response.write("checked")%>>
      </li>
      <li>Married or Partnered</li>
    </ul> -->
    <ul>
      <label id="smokerLabel" class="fieldIsGood"><span>&nbsp;</span>Do you smoke?</label>
      <li>
        <input type="radio" name="smoker" value="y" class="styled" <% if smoker = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li>
        <input type="radio" name="smoker" value="n" class="styled" <% if smoker = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul>
      <label id="workTypeDesiredLabel" class="fieldIsGood"><span>&nbsp;</span>What type of work do you prefer?</label>
      <li>
        <input type="radio" name="workTypeDesired" value="f" class="styled" <% if workTypeDesired = "f" then response.write("checked")%>>
      </li>
      <li>Full-Time</li>
      <li>
        <input type="radio" name="workTypeDesired" value="p" class="styled" <% if workTypeDesired = "p" then response.write("checked")%>>
      </li>
      <li>Part-Time</li>
      <li>
        <input type="radio" name="workTypeDesired" value="a" class="styled" <% if workTypeDesired = "a" then response.write("checked")%>>
      </li>
      <li>Any</li>
    </ul>
  </div>
  <!-- <div class="notes">
      <h4> Employment Information </h4>
      <p>Fill in and complete all information on this form. Once completed, you will be enrolled with Personnel Plus and elgible for opportunities that become available.</p>
      <p>The information you provide will be used to identify you, electronically sign your application and to allow you to keep your online profile updated if your situation changes.</p>
      <p class="last">* Your information is protected using high-grade SSL RC4 128 bit secured encryption</p>
    </div> -->
  <div>
    <ul>
      <label id="citizenLabel" class="fieldIsGood"><span>&nbsp;</span>Are you a citizen of the United States?</label>
      <li onClick="javascript:hidediv('AuthType');">
        <input type="radio" name="citizen" value="y" class="styled" <% if citizen = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li onClick="javascript:showdiv('AuthType');">
        <input type="radio" name="citizen" value="n" class="styled" <% if citizen = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <div id="AuthType" <%if citizen <> "n" then response.write("class=" & chr(34) & "hide" & chr(34))%>>
      <ul>
        <label id="alienTypeLabel" class="fieldIsGood"><span>&nbsp;</span>Please Specify, I am:</label>
        <li>
          <input type="radio" name="alienType" value="o" class="styled" <% if alienType = "o" then response.write("checked")%>>
        </li>
        <li>A noncitizen national of the U.S.</li>
        <li>
          <input type="radio" name="alienType" value="p" class="styled" <% if alienType = "p" then response.write("checked")%>>
        </li>
        <li>A lawful permanent resident</li>
        <li>
          <input type="radio" name="alienType" value="a" class="styled" <% if alienType = "a" then response.write("checked")%>>
        </li>
        <li>An alien authorized to work</li>
      </ul>
      <ul>
        <label id="alienNumberLabel" for="alienNumber">Enter your Alien / Admission Number:</label>
        <input name="alienNumber" id="alienNumber" type="text" tabindex="16"  value="<%=alienNumber%>">
      </ul>
    </div>
    <ul>
      <label id="workAuthProofLabel" class="fieldIsGood"><span>&nbsp;</span>Do you have proof of authorization?</label>
      <li>
        <input type="radio" name="workAuthProof" value="y" class="styled" <% if workAuthProof = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li>
        <input type="radio" name="workAuthProof" value="n" class="styled" <% if workAuthProof = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul>
      <label id="workAgeLabel" class="fieldIsGood"><span>&nbsp;</span>Are you 18 years or older?</label>
      <li>
        <input type="radio" name="workAge" value="y" class="styled" <% if workAge = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li>
        <input type="radio" name="workAge" value="n" class="styled" <% if workAge = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul>
      <label id="workValidLicenseLabel" class="fieldIsGood"><span>&nbsp;</span>Do you have a valid Drivers License?</label>
      <li>
        <input type="radio" name="workValidLicense" value="y" onblur="check_field('workValidLicense')" class="styled" <% if workValidLicense = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li>
        <input type="radio" name="workValidLicense" value="n" class="styled" <% if workValidLicense = "n" then response.write("checked")%>>
      </li>
      <li> No</li>
    </ul>
    <ul>
      <label>Do you have a Commercial Drivers License?</label>
      <li>
        <input type="radio" name="workLicenseType" value="n" class="styled" <% if workLicenseType = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
      <li>
        <input type="radio" name="workLicenseType" value="a" class="styled" <% if workLicenseType = "a" then response.write("checked")%>>
      </li>
      <li>CDL-A</li>
      <li>
        <input type="radio" name="workLicenseType" value="b" class="styled" <% if workLicenseType = "b" then response.write("checked")%>>
      </li>
      <li>CDL-B</li>
      <li>
        <input type="radio" name="workLicenseType" value="c" class="styled" <% if workLicenseType = "c" then response.write("checked")%>>
      </li>
      <li>CDL-C</li>
    </ul>
    <ul>
      <label id="autoInsuranceLabel" class="fieldIsGood"><span>&nbsp;</span>Do you have Automobile Insurance?</label>
      <li>
        <input type="radio" name="autoInsurance" value="y" class="styled" <% if autoInsurance = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li>
        <input type="radio" name="autoInsurance" value="n" class="styled" <% if autoInsurance = "n" then response.write("checked")%>>
      </li>
      <li> No</li>
    </ul>
    <ul>
      <label id="workRelocateLabel" class="fieldIsGood"><span>&nbsp;</span>Are you planning to relocate for work?</label>
      <li>
        <input type="radio" name="workRelocate" value="y" class="styled" <% if workRelocate = "y" then response.write("checked")%>>
      </li>
      <li>Yes </li>
      <li>
        <input type="radio" name="workRelocate" value="n" class="styled" <% if workRelocate = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul>
      <li>
        <label id="eduLevelLabel" for="eduLevel" class="fieldIsGood"><span>&nbsp;</span>Highest level of education completed</label>
      </li>
      <li>
        <SELECT name="eduLevel" tabindex="17" >
          <option value="" selected>-- Select One --</option>
          <option value="None">None</option>
          <option value="GED">GED</option>
          <option value="High School Diploma">High School 
          Diploma</option>
          <option value="College Degree">College Degree</option>
          <option value="College (No Degree)">College (No 
          Degree)</option>
          <option value="Graduate School">Graduate Degree</option>
        </SELECT>
      </li>
    </ul>
    <ul>
      <label id="workConvictionLabel" class="fieldIsGood"><span>&nbsp;</span>Have you ever been convicted of a felony or misdemeanor?</label>
      <li onClick="javascript:showdiv('FelonyExplain');">
        <input type="radio" name="workConviction" id="workConviction" value="f" class="styled" <% if workConviction = "y" or workConviction = "f" then response.write("checked")%>>
      </li>
      <li>Yes, a felony.</li>
      <li onClick="javascript:showdiv('FelonyExplain');">
        <input type="radio" name="workConviction" id="workConviction" value="m" class="styled" <% if workConviction = "m" then response.write("checked")%>>
      </li>
      <li>Yes, a misdemeanor</li>
      <li onClick="javascript:hidediv('FelonyExplain');">
        <input type="radio" name="workConviction" value="n" class="styled" <% if workConviction = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul id="FelonyExplain" <%if workConviction <> "y" then response.write("class=" & chr(34) & "hide" & chr(34))%>>
      <label id="workConvictionExplainLabel" for="workConvictionExplain">Please explain your conviction:</label>
      <textarea name="workConvictionExplain" id="workConvictionExplain" rows="2" cols="33"><%=workConvictionExplain%></textarea>
    </ul>
	
    <ul>
      <label id="staffedLabel" class="fieldIsGood"><span>&nbsp;</span>Have you ever worked for a staffing company before?</label>
      <li onClick="javascript:showdiv('staffing_detail');">
        <input type="radio" name="staffed" id="workConviction" value="y" class="styled" <% if staffed = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li onClick="javascript:hidediv('staffing_detail');">
        <input type="radio" name="staffed" value="n" class="styled" <% if staffed = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul id="staffing_detail" <%if staffed <> "y" then response.write("class=" & chr(34) & "hide" & chr(34))%>>
     <% if staffed = "y" then break "here" %>
	 <label id="who_staffedLabel" for="workConvictionExplain">What agencies did those companies send you to:</label>
      <textarea name="who_staffed" id="who_staffed" rows="2" cols="33"><%=who_staffed%></textarea>
    </ul>
	
    <ul>
      <li>
        <label id="additionalInfoLabel" for="additionalInfo">Please include any additional information such as spoken languages, associations, awards, etc.?</label>
      </li>
      <li>
        <textarea name="additionalInfo" id="additionalInfo" rows="3" cols="33" tabindex="18" ><%=additionalInfo%></textarea>
      </li>
    </ul>
    <ul>
      <li>
        <label id="heardAboutUsLbl" for="heardAboutUs">How did you hear about Personnel Plus?</label>
      </li>
      <li>
        <textarea name="heardAboutUs" id="heardAboutUs" rows="3" cols="33" tabindex="18" ><%=heardAboutUs%></textarea>
      </li>
    </ul>
  </div>
  <%=decorateBottom()%> <%=decorateTop("emergencyc", "marLR10" & empapp_contacts, "Emergency Contact")%>
  <fieldset id="emergencycontact" class="w4info">
  <legend>Incase of emergency, who should we contact?</legend>
  <ol>
    <li>
      <label for="ecFullName" class="fieldIsGood"><span>&nbsp;</span>Full Name: </label>
      <input type="text" id="ecFullName" name="ecFullName" value="<%=ecFullName%>" tabindex="19">
    <% if instr(empapp_contacts, "hide") = 0 then %>
	<script type="text/javascript"><!-- 
					document.application.ecFullName.focus()
							//--></script> 
    <% end if%>

    </li>
    <li> &nbsp;
      </label>
    </li>
    <li>
      <label id="ecAddressLbl" for="ecAddress" class="fieldIsGood"><span>&nbsp;</span>Address: </label>
      <input type="text" id="ecAddress" name="ecAddress" value="<%=ecAddress%>" tabindex="20">
    </li>
    <li>
      <label id="ecPhoneLbl" for="ecPhone" class="fieldIsGood"><span>&nbsp;</span>Phone: </label>
      <input type="text" id="ecPhone" name="ecPhone" value="<%=ecPhone%>" tabindex="22">
    </li>
    <li>
      <label id="ecDoctorLbl" for="ecDoctor" class="fieldIsGood"><span>&nbsp;</span>Doctor to Notify: </label>
      <input type="text" id="ecDoctor" name="ecDoctor" value="<%=ecDoctor%>" tabindex="21">
    </li>
    <li>
      <label id="ecDocPhoneLbl" for="ecDocPhone" class="fieldIsGood"><span>&nbsp;</span>Phone: </label>
      <input type="text" id="ecDocPhone" name="ecDocPhone" value="<%=ecDocPhone%>" tabindex="23">
    </li>
  </ol>
  <%=decorateBottom()%> <%=decorateTop("employmentReferences", "marLR10" & empapp_contacts, "References - Give the Names of Three Persons Not Related to You")%>
  <ul>
    <li>
      <label id="referenceNameOneLabel" for="referenceNameOne" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
      <input type="text" id="referenceNameOne" name="referenceNameOne" value="<%=referenceNameOne%>" onblur="check_field('referenceNameOne')" tabindex="19">
    </li>
    <li>
      <label id="referencePhoneOneLabel" for="referencePhoneOne" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
      <input type="text" id="referencePhoneOne" name="referencePhoneOne" value="<%=referencePhoneOne%>" onblur="check_field('referencePhoneOne')" tabindex="20">
    </li>
  </ul>
  <ul>
    <li>
      <label id="referenceNameTwoLabel" for="referenceNameTwo" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
      <input type="text" id="referenceNameTwo" name="referenceNameTwo" value="<%=referenceNameTwo%>" onblur="check_field('referenceNameTwo')" tabindex="21">
    </li>
    <li>
      <label id="referencePhoneTwoLabel" for="referencePhoneTwo" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
      <input type="text" id="referencePhoneTwo" name="referencePhoneTwo" value="<%=referencePhoneTwo%>" onblur="check_field('referencePhoneTwo')" tabindex="22">
    </li>
  </ul>
  <ul>
    <li>
      <label id="referenceNameThreeLabel" for="referenceNameThree" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
      <input type="text" id="referenceNameThree" name="referenceNameThree" value="<%=referenceNameThree%>" onblur="check_field('referenceNameThree')" tabindex="23">
    </li>
    <li>
      <label id="referencePhoneThreeLabel" for="referencePhoneThree" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
      <input type="text" id="referencePhoneThree" name="referencePhoneThree" value="<%=referencePhoneThree%>" onblur="check_field('referencePhoneThree')" tabindex="24">
    </li>
  </ul>
  <%=decorateBottom()%> <%=decorateTop("skillsInformation", "marLR10" & empapp_skills, "Skills: Select your related experience")%>
  <div id="letsScroll">
    <%
		dim getSkills_cmd, Skills, skillItem, skilledIn, i, html
		Set getSkills_cmd = Server.CreateObject ("ADODB.Command")
		With getSkills_cmd
			.ActiveConnection = MySql
			.CommandText = "Select * From list_jobskills Order By keyid ASC"
			.Prepared = true
		End With
		Set Skills = getSkills_cmd.Execute
		i = 0
		html = "<li><input type=" & Chr(34) & "checkbox" & Chr(34) & " name=" & Chr(34) & "Ck_SKILLINDEX" &_
			Chr(34) & " id=" & Chr(34) & "Ck_SKILLINDEX" & Chr(34) & " class=" & Chr(34) & "styled" & Chr(34) & " value=" &_
			Chr(34) & "SKILLVALUE" & Chr(34) & " CHECKED_OR_NOT>SKILLNAME</li>"
			
		do while not Skills.eof
			if Instr(Skills("skillName"), "<p>") > 0 then
				if i > 0 then Response.write "</ul>"
				Response.write Skills("skillName") & "<ul>"
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
				Response.write skillItem
			end if
			Skills.Movenext
		loop 
		
		Response.write "<input type='hidden' value=" & Chr(34) & i & Chr(34) & " name=" & Chr(34) & "totalSkills" & Chr(34) & ">"		
		
		Set getSkills_cmd = Nothing
		Skills.Close()
		 %>
  </div>
  <%=decorateBottom()%> <%=decorateTop("workhistory", "marLRB10" & empapp_workhist, "Most recent employment")%>
  <fieldset id="applicationWorkHistoryOne" class="applicationWorkHistory">
  <legend>Enter your most recent employment information below:</legend>
  <legend>
  <input style="width:2em; display:inline;" type="checkbox" name="workhistNAOne" id="workhistNAOne" tabindex="25" value="na" onclick="thisdoesntapply('One');">
  <label for="workhistNAOne">Check here if this section doesn't apply</label>
  </legend>
  <li>
    <label id="employerNameHistOneLabel" for="employerNameHistOne" class="fieldIsGood">Employer Name</label>
    <input type="text" name="employerNameHistOne" id="employerNameHistOne" tabindex="25" value="<%=employerNameHistOne%>">
      <% if instr(empapp_workhist, "hide") = 0 then %>
	<script type="text/javascript"><!-- 
					document.application.employerNameHistOne.focus()
							//--></script> 
    <% end if%>

  </li>
  <li>
    <label id="jobHistAddOneLabel" for="jobHistAddOne" class="fieldIsGood">Employer Address</label>
    <input type="text" name="jobHistAddOne" id="jobHistAddOne" tabindex="26" value="<%=jobHistAddOne%>">
  </li>
  <li>
    <label id="jobHistCityOneLabel" for="jobHistCityOne" class="fieldIsGood">City</label>
    <input type="text" name="jobHistCityOne" id="jobHistCityOne" tabindex="27" value="<%=jobHistCityOne%>">
  </li>
  <li>
    <label id="jobHistStateOneLabel" for="jobHistStateOne" class="fieldIsGood">State</label>
    <input type="text" name="jobHistStateOne" id="jobHistStateOne" tabindex="28" value="<%=jobHistStateOne%>">
  </li>
  <li>
    <label id="jobHistZipOneLabel" for="jobHistZipOne" class="fieldIsGood">Zip</label>
    <input type="text" name="jobHistZipOne" id="jobHistZipOne" tabindex="29" value="<%=jobHistZipOne%>">
  </li>
  <li>
    <label id="jobHistPayOneLabel" for="jobHistPayOne" class="fieldIsGood">Pay</label>
    <input type="text" name="jobHistPayOne" id="jobHistPayOne" tabindex="30" value="<%=jobHistPayOne%>">
  </li>
  <li>
    <label id="jobHistSupervisorOneLabel" for="jobHistSupervisorOne" class="fieldIsGood">Supervisor</label>
    <input type="text" name="jobHistSupervisorOne" id="jobHistSupervisorOne" tabindex="31" value="<%=jobHistSupervisorOne%>">
  </li>
  <li>
    <label id="jobHistPhoneOneLabel" for="jobHistPhoneOne" class="fieldIsGood">Contact Phone</label>
    <input type="text" name="jobHistPhoneOne" id="jobHistPhoneOne" tabindex="32" value="<%=jobHistPhoneOne%>">
  </li>
  <li>
    <label id="jobHistFromDateOneLabel" for="jobHistFromDateOne" class="fieldIsGood">What date did you start?</label>
    <input type="text" name="jobHistFromDateOne" id="jobHistFromDateOne" tabindex="33" value="<%=jobHistFromDateOne%>">
  </li>
  <li>
    <label id="JobHistToDateOneLabel" for="JobHistToDateOne" class="fieldIsGood">What was your last day?</label>
    <input type="text" name="JobHistToDateOne" id="JobHistToDateOne" tabindex="34" value="<%=JobHistToDateOne%>">
  </li>
  <li class="JobDutiesAndEnd">
    <label id="jobDutiesOneLabel" for="jobDutiesOne" class="fieldIsGood">What were your job duties?</label>
    <textarea type="text" name="jobDutiesOne" id="jobDutiesOne" tabindex="35" ><%=jobDutiesOne%></textarea>
  </li>
  <li class="JobDutiesAndEnd">
    <label id="jobReasonOneLabel" for="jobReasonOne" class="fieldIsGood">Why did the work end?</label>
    <textarea type="text" name="jobReasonOne" id="jobReasonOne" tabindex="36" ><%=jobReasonOne%></textarea>
  </li>
  </ol>
  </fieldset>
  <%=decorateBottom()%> <%=decorateTop("applicationWorkHistoryTwo", "applicationWorkHistory marLRB10" & empapp_workhist, "Second Most Recent")%>
  <fieldset id="applicationWorkHistoryTwo" class="applicationWorkHistory">
  <legend>Enter your second most recent employment information below:</legend>
  <legend>
  <input style="width:2em; display:inline;" type="checkbox" name="workhistNATwo" id="workhistNATwo" tabindex="25" value="na" onclick="thisdoesntapply('Two');">
  <label for="workhistNATwo">Check here if this section doesn't apply</label>
  </legend>
  <ol>
    <li>
      <label id="employerNameHistTwoLabel" for="employerNameHistTwo" class="fieldIsGood">Employer Name</label>
      <input type="text" name="employerNameHistTwo" id="employerNameHistTwo" tabindex="37" value="<%=employerNameHistTwo%>">
    </li>
    <li>
      <label id="jobHistAddTwoLabel" for="jobHistAddTwo" class="fieldIsGood">Employer Address</label>
      <input type="text" name="jobHistAddTwo" id="jobHistAddTwo" tabindex="38" value="<%=jobHistAddTwo%>">
    </li>
    <li>
      <label id="jobHistCityTwoLabel" for="jobHistCityTwo" class="fieldIsGood">City</label>
      <input type="text" name="jobHistCityTwo" id="jobHistCityTwo" tabindex="39" value="<%=jobHistCityTwo%>">
    </li>
    <li>
      <label id="jobHistStateTwoLabel" for="jobHistStateTwo" class="fieldIsGood">State</label>
      <input type="text" name="jobHistStateTwo" id="jobHistStateTwo" tabindex="40" value="<%=jobHistStateTwo%>" >
    </li>
    <li>
      <label id="jobHistZipTwoLabel" for="jobHistZipTwo" class="fieldIsGood">Zip</label>
      <input type="text" name="jobHistZipTwo" id="jobHistZipTwo" tabindex="41" value="<%=jobHistZipTwo%>">
    </li>
    <li>
      <label id="jobHistPayTwoLabel" for="jobHistPayTwo" class="fieldIsGood">Pay</label>
      <input type="text" name="jobHistPayTwo" id="jobHistPayTwo" tabindex="42" value="<%=jobHistPayTwo%>">
    </li>
    <li>
      <label id="jobHistSupervisorTwoLabel" for="jobHistSupervisorTwo" class="fieldIsGood">Supervisor</label>
      <input type="text" name="jobHistSupervisorTwo" id="jobHistSupervisorTwo" tabindex="43" value="<%=jobHistSupervisorTwo%>" >
    </li>
    <li>
      <label id="jobHistPhoneTwoLabel" for="jobHistPhoneTwo" class="fieldIsGood">Contact Phone</label>
      <input type="text" name="jobHistPhoneTwo" id="jobHistPhoneTwo" tabindex="44" value="<%=jobHistPhoneTwo%>" >
    </li>
    <li>
      <label id="jobHistFromDateTwoLabel" for="jobHistFromDateTwo" class="fieldIsGood">What date did you start?</label>
      <input type="text" name="jobHistFromDateTwo" id="jobHistFromDateTwo" tabindex="45" value="<%=jobHistFromDateTwo%>">
    </li>
    <li>
      <label id="JobHistToDateTwoLabel" for="JobHistToDateTwo" class="fieldIsGood">What was your last day?</label>
      <input type="text" name="JobHistToDateTwo" id="JobHistToDateTwo" tabindex="46" value="<%=JobHistToDateTwo%>">
    </li>
    <li class="JobDutiesAndEnd">
      <label id="jobDutiesTwoLabel" for="jobDutiesTwo" class="fieldIsGood">What were your job duties?</label>
      <textarea type="text" name="jobDutiesTwo" id="jobDutiesTwo" tabindex="47" ><%=jobDutiesTwo%></textarea>
    </li>
    <li class="JobDutiesAndEnd">
      <label id="jobReasonTwoLabel" for="jobReasonTwo" class="fieldIsGood">Why did the work end?</label>
      <textarea type="text" name="jobReasonTwo" id="jobReasonTwo" tabindex="48" ><%=jobReasonTwo%></textarea>
    </li>
  </ol>
  </fieldset>
  <%=decorateBottom()%> <%=decorateTop("applicationWorkHistoryThree", "applicationWorkHistory marLRB10" & empapp_workhist, "Third Most Recent")%>
  <fieldset id="applicationWorkHistoryThree" class="applicationWorkHistory">
  <legend>Enter your second most recent employment information below:</legend>
  <legend>
  <input style="width:2em; display:inline;" type="checkbox" name="workhistNAThree" id="workhistNAThree" tabindex="25" value="na" onclick="thisdoesntapply('Three');">
  <label for="workhistNAThree">Check here if this section doesn't apply</label>
  </legend>
  <ol>
    <li>
      <label id="employerNameHistThreeLabel" for="employerNameHistThree" class="fieldIsGood">Employer Name</label>
      <input type="text" name="employerNameHistThree" id="employerNameHistThree" tabindex="49" value="<%=employerNameHistThree%>">
    </li>
    <li>
      <label id="jobHistAddThreeLabel" for="jobHistAddThree" class="fieldIsGood">Employer Address</label>
      <input type="text" name="jobHistAddThree" id="jobHistAddThree" tabindex="50" value="<%=jobHistAddThree%>">
    </li>
    <li>
      <label id="jobHistCityThreeLabel" for="jobHistCityThree" class="fieldIsGood">City</label>
      <input type="text" name="jobHistCityThree" id="jobHistCityThree" tabindex="51" value="<%=jobHistCityThree%>">
    </li>
    <li>
      <label id="jobHistStateThreeLabel" for="jobHistStateThree" class="fieldIsGood"><span>&nbsp;</span>State</label>
      <input type="text" name="jobHistStateThree" id="jobHistStateThree" tabindex="52" value="<%=jobHistStateThree%>">
    </li>
    <li>
      <label id="jobHistZipThreeLabel" for="jobHistZipThree" class="fieldIsGood"><span>&nbsp;</span>Zip</label>
      <input type="text" name="jobHistZipThree" id="jobHistZipThree" tabindex="53" value="<%=jobHistZipThree%>">
    </li>
    <li>
      <label id="jobHistPayThreeLabel" for="jobHistPayThree" class="fieldIsGood"><span>&nbsp;</span>Pay</label>
      <input type="text" name="jobHistPayThree" id="jobHistPayThree" tabindex="54" value="<%=jobHistPayThree%>">
    </li>
    <li>
      <label id="jobHistSupervisorThreeLabel" for="jobHistSupervisorThree" class="fieldIsGood"><span>&nbsp;</span>Supervisor</label>
      <input type="text" name="jobHistSupervisorThree" id="jobHistSupervisorThree" tabindex="55" value="<%=jobHistSupervisorThree%>">
    </li>
    <li>
      <label id="jobHistPhoneThreeLabel" for="jobHistPhoneThree" class="fieldIsGood"><span>&nbsp;</span>Contact Phone</label>
      <input type="text" name="jobHistPhoneThree" id="jobHistPhoneThree" tabindex="56" value="<%=jobHistPhoneThree%>">
    </li>
    <li>
      <label id="jobHistFromDateThreeLabel" for="jobHistFromDateThree" class="fieldIsGood"><span>&nbsp;</span>What date did you start?</label>
      <input type="text" name="jobHistFromDateThree" id="jobHistFromDateThree" tabindex="57" value="<%=jobHistFromDateThree%>">
    </li>
    <li>
      <label id="JobHistToDateThreeLabel" for="JobHistToDateThree" class="fieldIsGood"><span>&nbsp;</span>What was your last day?</label>
      <input type="text" name="JobHistToDateThree" id="JobHistToDateThree" tabindex="58" value="<%=JobHistToDateThree%>">
    </li>
    <li class="JobDutiesAndEnd">
      <label id="jobDutiesThreeLabel" for="jobDutiesThree" class="fieldIsGood"><span>&nbsp;</span>What were your job duties?</label>
      <textarea type="text" name="jobDutiesThree" id="jobDutiesThree" tabindex="59" ><%=jobDutiesThree%></textarea>
    </li>
    <li class="JobDutiesAndEnd">
      <label id="jobReasonThreeLabel" for="jobReasonThree" class="fieldIsGood"><span>&nbsp;</span>Why did the work end?</label>
      <textarea type="text" name="jobReasonThree" id="jobReasonThree" tabindex="60" ><%=jobReasonThree%></textarea>
    </li>
  </ol>
  </fieldset>
  <%=decorateBottom()%> <%=decorateTop("w4Supplement", "marLR10" & empapp_w4form, "Form W-4 Supplemental Information")%>
  <table class="w4">
    <tr>
      <td class="instruct"><strong>A.</strong>&nbsp;Enter “1” for <em>yourself</em> if no one else can claim you as a dependent.</td>
      <td class="exemption"><strong>A.</strong>&nbsp;
        <input type="text" id="w4a" name="w4a" value="<%=w4a%>" tabindex="14"></td>
         <% if instr(empapp_w4form, "hide") = 0 then %>
	<script type="text/javascript"><!-- 
					document.application.w4a.focus()
							//--></script> 
    <% end if%>
 </tr>
    <tr>
      <td class="instruct"><strong>B.</strong>&nbsp;Enter “1” if:
        <ul>
          <li>You are single and have only one job; or</li>
          <li>you are married, have only one job, and your spouse does not work; or</li>
          <li>your wages from a second job or your spouse’s wages (or the total of both) are $1,500 or less.</li>
        </ul></td>
      <td class="exemption"><strong>B.</strong>&nbsp;
        <input type="text" id="w4b" name="w4b" value="<%=w4b%>" tabindex="14"></td>
    </tr>
    <tr>
      <td class="instruct"><strong>C</strong>.&nbsp;Enter “1” for your spouse. But, you may choose to enter “-0-” if you are married and have either a working spouse or more than one job. (Entering “-0-” may help you avoid having too little tax withheld.)</td>
      <td class="exemption"><strong>C.</strong>&nbsp;
        <input type="text" id="w4c" name="w4c" value="<%=w4c%>" tabindex="14"></td>
    </tr>
    <tr>
      <td class="instruct"><strong>D</strong>.&nbsp;Enter number of dependents (other than your spouse or yourself) you will claim on your tax return</td>
      <td class="exemption"><strong>D.</strong>&nbsp;
        <input type="text" id="w4d" name="w4d" value="<%=w4d%>" tabindex="14"></td>
    </tr>
    <tr>
      <td class="instruct"><strong>E</strong>.&nbsp;Enter &ldquo;1&rdquo; if you will file as <strong>head of household</strong> on your tax return (see conditions under Head of household above)</td>
      <td class="exemption"><strong>E.</strong>&nbsp;
        <input type="text" id="w4e" name="w4e" value="<%=w4e%>" tabindex="14"></td>
    </tr>
    <tr>
      <td class="instruct"><strong>F.</strong>&nbsp;Enter &ldquo;1&rdquo; if you have at least $1,800 of child or dependent care expenses for which you plan to claim a credit
        <ul>
          (Note. Do not include child support payments. See Pub. 503, Child and Dependent Care Expenses, for details.)
        </ul></td>
      <td class="exemption"><strong>F.</strong>&nbsp;
        <input type="text" id="w4f" name="w4f" value="<%=w4f%>" tabindex="14"></td>
    </tr>
    <tr>
      <td class="instruct"><strong>G.</strong>&nbsp;Child Tax Credit (including additional child tax credit). See Pub. 972, Child Tax Credit, for more information.
        <ul>
          <li>if your total income will be less than $61,000 ($90,000 if married), enter “2” for each eligible child; then less “1” if you have three or more eligible children.</li>
          <li>if your total income will be between $61,000 and $84,000 ($90,000 and $119,000 if married), enter “1” for each eligible
            child plus “1” additional if you have six or more eligible children.</li>
        </ul></td>
      <td class="exemption"><strong>G.</strong>&nbsp;
        <input type="text" id="w4g" name="w4g" value="<%=w4g%>" tabindex="14"></td>
    </tr>
    <tr>
      <td class="instruct"><strong>H.</strong>&nbsp;Add lines A through G and enter total here. (<strong>Note.</strong> This may be different from the number of exemptions you claim on your tax return.)
      <td class="exemption"><strong>H.</strong>&nbsp;
        <input type="text" id="w4h" name="w4h" value="<%=w4h%>" tabindex="14"></td>
    </tr>
    <tr>
      <td colspan="2">
	  <table class="w4whatifs">
          <tr>
            <td>For accuracy, <strong>complete all worksheets that apply.</strong></td>
            <td><ul>
                <li>If you plan to <strong>itemize or claim adjustments to income</strong> and want to reduce your withholding, see the <strong>Deductions and Adjustments Worksheet</strong> on page 2.</li>
                <li>If you have <strong>more than one job</strong> or are <strong>married and your and your spouse both work</strong> and the combined earnings from all jobs exceed $18,000 ($32,000 if married), see the <strong>Two-Earners/Multiple Jobs Worksheet</strong> on page 2 to avoid having too little tax withheld.</li>
              	<li>If <strong>neither</strong> of the above situations applies, <strong>stop here</strong> and enter the number from line H on line 5 of Form W-4 below.</li>
			  </ul></td>
          </tr>
        </table></td>
    </tr></table>


  <fieldset id="w4oneandtwo" class="w4info">
  <legend>1. Type or print your first name and middle initial: </legend>
      <label for="firstname">First Name</label>
      <input type="text" name="firstname" id="firstname" value="<%=user_firstname%>" disabled/>
      <label for="middleinit">Middle Initial</label>
      <input type="text" name="middleinit" id="middleinit" value="<%=middleinit%>"/>
  </fieldset>
  <fieldset id="w4ssn" class="w4info">
  <legend>2. Your social security number </legend>
      <input type="text" name="" id="" value="<%=ssn%>" disabled/>
  </fieldset>
  <fieldset id="w4info" class="w4info oneandtwo">
  <legend>3. Please select your filing status below: </legend>
  <ol>
    <li>
      <label>Single
      <input type="radio" name="w4filing" id="w4filing" value="0" <% if w4filing=0 then response.write "checked=""checked""" %>/>
      </label>
      <label>Married
      <input type="radio" name="w4filing" id="w4filing" value="1" <% if w4filing=1 then response.write "checked=""checked""" %>/>
      </label>
      <label>Married, but withhold at higher Single rate.
      <input type="radio" name="w4filing" id="w4filing" value="2"  <% if w4filing=2 then response.write "checked=""checked""" %>/>
      </label>
    </li>
  </ol>
  <ol>
    <li style="float:left;"><strong>4.</strong>
	<li style="display:inline">
      <label for="w4namediffers"><input type="checkbox" name="w4namediffers" id="w4namediffers" value="true" <% if w4namediffers = true then response.write "checked=""checked""" %>/> If your last name differs from that shown on your social security card, check here. </label>
    </li>
	 <li>You must call 1-800-772-1213 for a replacement card  
     
    </li>
  </ol>
  </fieldset>

      <table class="w4">
    <tr>
          <td><strong>5.</strong> Total number of allowances you are claiming [from line <strong>H</strong> above <strong>or</strong> from the applicatable worksheet on page 2 </td>
          <td class="exemption"><strong>5.</strong>&nbsp;
        <input type="text" id="w4total" name="w4total" value="<%=w4total%>" tabindex="14"></td>
        </tr>
    <tr>
          <td><strong>6.</strong> Enter any additional dollar[$] amount, if any, you want withheld from each paycheck: </td>
          <td class="exemption"><strong>6.</strong>&nbsp;
        <input type="text" id="w4more" name="w4more" value="<%=w4more%>" tabindex="14"></td>
        </tr>
    <tr>
          <td class="instruct"><strong>7.</strong> I claim exemption from withholding for 2010, and I certify that I meet <strong>both</strong> of the following conditions for exemption.
        <ul>
              <li>Last year I had a right to a refund of <strong>all</strong> federal income tax withheld because I had <strong>no</strong> tax liability <strong>and</strong></li>
              <li>This year I expect a refund of <strong>all</strong> federal income tax withheld because I expect to have <strong>no</strong> tax liability.</li>
            </ul>
        If you meet both conditions, type "Exempt" for line 7.</td>
          <td class="exemption"><strong>7.</strong>&nbsp;
        <input type="text" id="w4exempt" name="w4exempt" value="<% if w4exempt = true then response.write "EXEMPT" %>" tabindex="14"></td>
        </tr>
  </table>
  <fieldset id="w4sign" class="w4info">
  <legend>Electronically complete and sign government form W-4</legend>
  <input type="checkbox" name="w4signed" id="w4signed" value="Sign"/>
  <label for="w4signed">I authorize Personnel Plus to complete my form W4 with the information above and that what I have provided is true and accurate. </label>
  </fieldset>
  <%=decorateBottom()%>
  <!--<%=decorateTop("attachResume", "marLR10", "Attach Resume")%>
    <div>
      <ul>
        <li>
          <label for="File1">Select your resume to upload</label>
          <input name="File1" size="35" type=file>
        </li>
      </ul>
    </div>
    <div class="notes">
      <h4> Stop! </h4>
      <p class="last">* Your information is protected during transmission using high-grade SSL RC4 128 bit secured encryption</p>
    </div>
    <%=decorateBottom()%>-->
  <%

	'if len(agree2pandp)=0 or len(agree2applicant)=0 or len(agree2unemployment)=0 then
	response.write decorateTop("unemploymentLaw", "marLR10" & empapp_legal, "Legal Notices")
		Database.Open MySql
		'
		'if len(agree2unemployment)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='unemployment'") %>
  <h2><%=dbQuery("title")%></h2>
  <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>
  <p>
    <input style="width:2em;" name="agree2unemployment" id="agree2unemployment" value="agree" <% 
				if len(agree2unemployment) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
    I HAVE READ AND I AGREE THAT THE ABOVE DOCUMENT SERVES AS WRITTEN NOTICE OF BEING INFORMED AS REQUIRED IN SECTION 21A (ii).</p>
  <%
		'end if
		
		'if len(agree2pandp)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='pandp'") %>
  <h2><%=dbQuery("title")%></h2>
  <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>
  <p>
    <input style="width:2em;" name="agree2pandp" id="agree2pandp" value="agree" <% 
				if len(agree2pandp) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
    I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S POLICIES AND PROCEDURES</p>
  <%
		'end if
		
		'if len(agree2applicant)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='applicant_agree'") %>
  <h2><%=dbQuery("title")%></h2>
  <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>
  <p>
    <input style="width:2em;" name="agree2applicant" id="agree2applicant" value="agree" <% 
				if len(agree2applicant) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
    I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S APPLICANT AGREEMENT</p>
  <%
		'end if
		
		Database.Close %>
  <%=decorateBottom()%>
  <input id="formAction" name="formAction" type="hidden" class="hidden" value="notset">
  <input id="wheretogo" name="wheretogo" type="hidden" class="hidden" value="">
  <input id="previouspart" name="previouspart" type="hidden" class="hidden" value="<%=whichpart%>">
  <input id="applicationId" name="applicationId" type="hidden" class="hidden" value="<%=applicationId%>">
  <input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">
</form>
<div id="bottomAppNav" class="buttonwrapper">
  <div id="rightAppNav"><%=app_next%></div><%=send_application%>
  <div id="leftAppNav"><%=app_previous%></div>
</div>
<%

Function SaveApplication (saveNotice)

	dim firstName, lastName, email, userID, sql, agree2pandp, agree2unemployment

	firstName = Pcase(user_firstname)
	lastName = Pcase(user_lastname)
	aliasNames = Pcase(request.form("aliasNames"))
	ssn = ssnRE.Replace(request.form("ssn"), "")
	dob = request.form("dob")
	if isDate(dob) then	dob = FormatDateTime(dob, 2)
	email = user_email
	emailupdates = request.form("emailupdates")
	mainPhone = ssnRE.Replace(user_phone, "")
	altPhone = ssnRE.Replace(user_sphone, "")
	addressOne = request.form("addressOne")
	addressTwo = request.form("addressTwo")
	city = request.form("city")
	appState = request.form("appState")
	zipcode = ssnRE.Replace(request.form("zipcode"), "")
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
	citizen = request.form("citizen")
	workAuthProof = request.form("workAuthProof")
	workAge = request.form("workAge")
	workValidLicense = request.form("workValidLicense")
	workLicenseType = request.form("workLicenseType")
	workRelocate = request.form("workRelocate")
	workConviction = request.form("workConviction")
	workConvictionExplain = request.form("workConvictionExplain")
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
	if lcase(trim(request.form("w4exempt"))) = "exempt" then w4exempt = -1
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
	referencePhoneOne = ssnRE.Replace(request.form("referencePhoneOne"), "")
	referenceNameTwo = request.form("referenceNameTwo")
	referencePhoneTwo = ssnRE.Replace(request.form("referencePhoneTwo"), "")
	referenceNameThree = request.form("referenceNameThree")
	referencePhoneThree = ssnRE.Replace(request.form("referencePhoneThree"), "")
	skillsSet = CollectSkills
	employerNameHistOne = request.form("employerNameHistOne")
	jobHistAddOne = request.form("jobHistAddOne")
	jobHistPhoneOne = request.form("jobHistPhoneOne")
		if jobHistPhoneOne <> "na" then jobHistPhoneOne = ssnRE.Replace(jobHistPhoneOne, "")
	jobHistCityOne = request.form("jobHistCityOne")
	jobHistStateOne = request.form("jobHistStateOne")
	jobHistZipOne = ssnRE.Replace(request.form("jobHistZipOne"), "")
	jobHistPayOne = request.form("jobHistPayOne")
	jobHistSupervisorOne = request.form("jobHistSupervisorOne")
	jobDutiesOne = request.form("jobDutiesOne")
	jobHistFromDateOne = request.form("jobHistFromDateOne")
	JobHistToDateOne = request.form("JobHistToDateOne")
	jobReasonOne = request.form("jobReasonOne")
	employerNameHistTwo = request.form("employerNameHistTwo")
	jobHistAddTwo = request.form("jobHistAddTwo")
	jobHistPhoneTwo = request.form("jobHistPhoneTwo")
		if jobHistPhoneTwo <> "na" then jobHistPhoneTwo = ssnRE.Replace(jobHistPhoneTwo, "")
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
		if jobHistPhoneThree <> "na" then jobHistPhoneThree = ssnRE.Replace(jobHistPhoneThree, "")
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
	
	if request.form("agree2unemployment") = "agree" then
		agrees = agrees & "unempAgree=Now(), "
	end if

	if request.form("agree2applicant") = "agree" then
		agrees = agrees & "applicantAgree=Now(), "
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
	
	if saveNotice = true then
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

	dim appLink, msgBody, msgSubject, city, appState, zipcode, deliveryLocation

	appLink = "<a href='/include/system/tools/activity/applications/view/'>View Online Applications</a>" 
	msgBody = user_firstname & " " & user_lastname & "'s application has been updated. "
	msgSubject = "Employment Application:  " & user_lastname & ", " & user_firstname 

	'Determine destination
	Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & zipcode & "'")
	if Not dbQuery.eof then
		deliveryLocation = dbQuery("email")
	else
		deliveryLocation = "twin@personnel.com"
	end if
	
	'Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")

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

Sub createNewApp
		'Execute the INSERT statement and the SELECT @@IDENTITY
		Set addressInfo = Database.execute("SELECT address, addressTwo, city, state, zip " &_
			"FROM tbl_addresses " &_
			"WHERE addressID=" & addressId)
			
		dim qryTxt
		qryTxt = "INSERT INTO tbl_applications (creationDate, modifiedDate, lastName, firstName, addressOne, addressTwo, city, appState, zipcode, userID) " & _
							 "VALUES (now(), " &_
							 "now(), '" &_
							 user_lastname & "', '" &_
							 user_firstname & "', '" &_
							 addressInfo("address") & "', '" &_
							 addressInfo("addressTwo") & "', '" &_
							 addressInfo("city") & "', '" &_
							 addressInfo("state") & "', '" &_
							 addressInfo("zip") & "', '" &_
							 user_id & "'); " & _
							 "SELECT last_insert_id()"
		'response.write qryTxt
		'Response.End()
		Set dbQuery = Database.execute(qryTxt).nextrecordset
		applicationId = CInt(dbQuery(0))
		Database.Execute("Update tbl_users SET applicationId=" & applicationId & " WHERE userID=" & user_id)
		
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

%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
