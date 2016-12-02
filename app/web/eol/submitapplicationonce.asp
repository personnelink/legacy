<%Option Explicit%>
<% session("additionalHeading") = "<meta http-equiv=" & Chr(34) & "Cache-Control" & Chr(34) & " content=" & Chr(34) & "No-Cache" & Chr(34) & ">" & chr(13) &_
	"<meta http-equiv=" & Chr(34) & "Cache-Control" & Chr(34) & " content=" & Chr(34) & "No-Store" & Chr(34) & ">" & chr(13) &_
	"<meta http-equiv=" & Chr(34) & "Pragma" & Chr(34) & " content=" & Chr(34) & "No-Cache" & Chr(34) & ">" & chr(13) &_
	"<meta http-equiv=" & Chr(34) & "Expires" & Chr(34) & " content=" & Chr(34) & "0" & Chr(34) & ">" & chr(13) %>
	
<!-- #INCLUDE VIRTUAL='/include/core/html_header.asp' -->
<!-- Revised: 2.16.2009 -->
<% session("add_css") = "submitapplication.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/html_styles.asp' -->
<!--[if gte IE 7]>
<style>
form#application * input, form#application * label, form#application * select {float:left;margin-top:0;}

</style>
<![endif]-->
<!-- #INCLUDE VIRTUAL='/include/core/navi_top_menu.asp' -->
  <script type="text/javascript" src="/include/js/submitapplication.js"></script>
  <% 
dim MiddleName, addressOne, AddressTwo, city, UserState, zipcode, country, mainPhone, altPhone, email, ReeMail, ssn, dob, alienType, alienNumber

dim emailupdates, desiredWageAmount, minWageAmount, workTypeDesired, maritalStatus, sex, citizen, workAuthProof, workAge, workValidLIcense
dim workLicenseType, workRelocate, workConviction, workConvictionExplain, currentlyEmployed, availableWhen, workCommuteHow, smoker, ssnRE
dim workCommuteDistance, workLicenseState, workLicenseExpire, workLicenseNumber, autoInsurance, eduLevel, additionalInfo, skillsClerical
dim skillsCustomerSvc, referenceNameOne, referencePhoneOne, referenceNameTwo, referencePhoneTwo, referenceNameThree, referencePhoneThree
dim skillsIndustrial, skillsGeneralLabor, skillsConstruction, skillsSkilledLabor, skillsBookkeeping, skillsSales, skillsManagement
Dim	skillsTechnical, skillsFoodService, skillsSoftware, skillsSet, employerNameHistOne, jobHistAddOne, jobHistPhoneOne, jobHistCityOne, jobHistStateOne
dim jobHistZipOne, jobHistPayOne, jobHistSupervisorOne, jobDutiesOne, jobHistFromDateOne, JobHistToDateOne, jobReasonOne, employerNameHistTwo, jobHistAddTwo
dim jobHistPhoneTwo, jobHistCityTwo, jobHistStateTwo, jobHistZipTwo, jobHistPayTwo, jobHistSupervisorTwo, jobDutiesTwo, jobHistFromDateTwo, JobHistToDateTwo
dim jobReasonTwo, employerNameHistThree, jobHistAddThree, jobHistPhoneThree, jobHistCityThree, jobHistStateThree, jobHistZipThree, jobHistPayThree, jobHistSupervisorThree
dim jobDutiesThree, jobHistFromDateThree, JobHistToDateThree, jobReasonThree, firstName, lastName, formAction, appState

Set ssnRE = New RegExp
ssnRE.Pattern = "[ ()-.<>'$]"
ssnRE.Global = true

formAction = request.form("formAction")
if formAction = "save" then
	SaveApplication
elseif formAction = "submit" then
	SubmitApplication
end if

if Request.QueryString("debug") = 1 then 
' 	Dummy data for debugging
	email = "ghaner@personnel.com"
	firstName = "Gus"
	lastName = "Zaney"
	ssn = "555-55-5555"
	dob = "10/12/1977"
	emailupdates = "y"
	mainPhone = "(208)733-7300"
	altPhone = "(208)733-7300"
	addressOne = "111 Filer Ave"
	addressTwo = "Filer/Washington"
	city = "Twin Falls"
	appState = "ID"
	zipcode = "83301"
	desiredWageAmount = "$8.00"
	minWageAmount = "$7.00"
	currentlyEmployed = "n"
	workTypeDesired = "f"
	maritalStatus = "s"
	sex = "m"
	smoker = "n"
	citizen = "n"
	alienType = "p"
	alienNumber = "IA254239K"
	workAuthProof = "y"
	workAge = "y"
	workValidLicense = "y"
	workLicenseType = "b"
	workRelocate = "y"
	workConviction = "y"
	workConvictionExplain = "Burglarized senior citizens home and stole her salt-shaker"
	availableWhen = "Now"
	workCommuteHow = "Car"
	workCommuteDistance = "Any"
	workLicenseState = "ID"
	workLicenseExpire = "2012"
	autoInsurance = "y"
	eduLevel = "GED"
	additionalInfo = "C.p.r., first aid, aed, abdomal thrust"
	referenceNameOne = "Jayme Ketterling"
	referencePhoneOne = "208-410-9000"
	referenceNameTwo = "Rachael Simson"
	referencePhoneTwo = "208-316-5291"
	referenceNameThree = "Aaron Gupton"
	referencePhoneThree = "208-212-5012"
	skillsSet = ""
	employerNameHistOne = "Chili's Restaurant"
	jobHistAddOne = "1880 BLue Lakes Blvd N"
	jobHistPhoneOne = "208-734-1167"
	jobHistCityOne = "Twin Falls"
	jobHistStateOne = "Id"
	jobHistZipOne = "83301"
	jobHistPayOne = "$13.00/hour"
	jobHistSupervisorOne = "Mulva"
	jobDutiesOne = "Cash Register, Customer Service"
	jobHistFromDateOne = "12-2000"
	JobHistToDateOne = "5-2001"
	jobReasonOne = "Went to work at MVRS."
	employerNameHistTwo = "Johnny Corerners"
	jobHistAddTwo = "156 Somewheres Ave"
	jobHistPhoneTwo = "555.555.5555"
	jobHistCityTwo = "Twin Falls"
	jobHistStateTwo = "ID"
	jobHistZipTwo = "83301"
	jobHistPayTwo = "$13.00/hour"
	jobHistSupervisorTwo = "Ted"
	jobDutiesTwo = "Don't Remember"
	jobHistFromDateTwo = "5/2006"
	JobHistToDateTwo = "7/2008"
	jobReasonTwo = "Couldn't smoke"
	employerNameHistThree = "Wendys Old Fashioned Hamburgers"
	jobHistAddThree = "818 BLUE LAKES BLVD."
	jobHistPhoneThree = "555.555.5555"
	jobHistCityThree = "TWIN FALLS"
	jobHistStateThree = "Idaho"
	jobHistZipThree = "83301"
	jobHistPayThree = "$240,000"
	jobHistSupervisorThree = "Bob Nutting"
	jobDutiesThree = "Lots of different Stuff"
	jobHistFromDateThree = "12/2007"
	JobHistToDateThree = "12/2008"
	jobReasonThree = "Advancement Oppurtunity"
Else
	email = Request.Cookies("application") ("email")
	firstName = Request.Cookies("application") ("firstName")
	lastName = Request.Cookies("application") ("lastName")
	ssn = ssnRE.Replace(Request.Cookies("application") ("ssn"), "")
	dob = Request.Cookies("application") ("dob")
	emailupdates = Request.Cookies("application") ("emailupdates")
	mainPhone = ssnRE.Replace(Request.Cookies("application") ("mainPhone"), "")
	altPhone = ssnRE.Replace(Request.Cookies("application") ("altPhone"), "")
	addressOne = Request.Cookies("application") ("addressOne")
	addressTwo = Request.Cookies("application") ("addressTwo")
	city = Request.Cookies("application") ("city")
	appState = Request.Cookies("application") ("appState")
	zipcode = Request.Cookies("application") ("zipcode")
	desiredWageAmount = Request.Cookies("application") ("desiredWageAmount")
	minWageAmount = Request.Cookies("application") ("minWageAmount")
	workTypeDesired = Request.Cookies("application") ("workTypeDesired")
	sex = Request.Cookies("application") ("sex")
	maritalStatus = Request.Cookies("application") ("maritalStatus")
	smoker = Request.Cookies("application") ("smoker")
	citizen = Request.Cookies("application") ("citizen")
	alienType = Request.Cookies("application") ("alienType")
	alienNumber = Request.Cookies("application") ("alienNumber")
	workAuthProof = Request.Cookies("application") ("workAuthProof")
	workAge = Request.Cookies("application") ("workAge")
	workValidLicense = Request.Cookies("application") ("workValidLicense")
	workLicenseType = Request.Cookies("application") ("workLicenseType")
	workRelocate = Request.Cookies("application") ("workRelocate")
	workConviction = Request.Cookies("application") ("workConviction")
	workConvictionExplain = Request.Cookies("application") ("workConvictionExplain")
	currentlyEmployed = Request.Cookies("application") ("currentlyEmployed")
	availableWhen = Request.Cookies("application") ("availableWhen")
	workCommuteHow = Request.Cookies("application") ("workCommuteHow")
	workCommuteDistance = Request.Cookies("application") ("workCommuteDistance")
	workLicenseState = Request.Cookies("application") ("workLicenseState")
	workLicenseExpire = Request.Cookies("application") ("workLicenseExpire")
	autoInsurance = Request.Cookies("application") ("autoInsurance")
	eduLevel = Request.Cookies("application") ("eduLevel")
	additionalInfo = Request.Cookies("application") ("additionalInfo")
	referenceNameOne = Request.Cookies("application") ("referenceNameOne")
	referencePhoneOne = Request.Cookies("application") ("referencePhoneOne")
	referenceNameTwo = Request.Cookies("application") ("referenceNameTwo")
	referencePhoneTwo = Request.Cookies("application") ("referencePhoneTwo")
	referenceNameThree = Request.Cookies("application") ("referenceNameThree")
	referencePhoneThree = Request.Cookies("application") ("referencePhoneThree")
	skillsSet = Request.Cookies("application") ("skillsSet")
	employerNameHistOne = Request.Cookies("application") ("employerNameHistOne")
	jobHistAddOne = Request.Cookies("application") ("jobHistAddOne")
	jobHistPhoneOne = Request.Cookies("application") ("jobHistPhoneOne")
	jobHistCityOne = Request.Cookies("application") ("jobHistCityOne")
	jobHistStateOne = Request.Cookies("application") ("jobHistStateOne")
	jobHistZipOne = Request.Cookies("application") ("jobHistZipOne")
	jobHistPayOne = Request.Cookies("application") ("jobHistPayOne")
	jobHistSupervisorOne = Request.Cookies("application") ("jobHistSupervisorOne")
	jobDutiesOne = Request.Cookies("application") ("jobDutiesOne")
	jobHistFromDateOne = Request.Cookies("application") ("jobHistFromDateOne")
	JobHistToDateOne = Request.Cookies("application") ("JobHistToDateOne")
	jobReasonOne = Request.Cookies("application") ("jobReasonOne")
	employerNameHistTwo = Request.Cookies("application") ("employerNameHistTwo")
	jobHistAddTwo = Request.Cookies("application") ("jobHistAddTwo")
	jobHistPhoneTwo = Request.Cookies("application") ("jobHistPhoneTwo")
	jobHistCityTwo = Request.Cookies("application") ("jobHistCityTwo")
	jobHistStateTwo = Request.Cookies("application") ("jobHistStateTwo")
	jobHistZipTwo = Request.Cookies("application") ("jobHistZipTwo")
	jobHistPayTwo = Request.Cookies("application") ("jobHistPayTwo")
	jobHistSupervisorTwo = Request.Cookies("application") ("jobHistSupervisorTwo")
	jobDutiesTwo = Request.Cookies("application") ("jobDutiesTwo")
	jobHistFromDateTwo = Request.Cookies("application") ("jobHistFromDateTwo")
	JobHistToDateTwo = Request.Cookies("application") ("JobHistToDateTwo")
	jobReasonTwo = Request.Cookies("application") ("jobReasonTwo")
	employerNameHistThree = Request.Cookies("application") ("employerNameHistThree")
	jobHistAddThree = Request.Cookies("application") ("jobHistAddThree")
	jobHistPhoneThree = Request.Cookies("application") ("jobHistPhoneThree")
	jobHistCityThree = Request.Cookies("application") ("jobHistCityThree")
	jobHistStateThree = Request.Cookies("application") ("jobHistStateThree")
	jobHistZipThree = Request.Cookies("application") ("jobHistZipThree")
	jobHistPayThree = Request.Cookies("application") ("jobHistPayThree")
	jobHistSupervisorThree = Request.Cookies("application") ("jobHistSupervisorThree")
	jobDutiesThree = Request.Cookies("application") ("jobDutiesThree")
	jobHistFromDateThree = Request.Cookies("application") ("jobHistFromDateThree")
	JobHistToDateThree = Request.Cookies("application") ("JobHistToDateThree")
	jobReasonThree = Request.Cookies("application") ("jobReasonThree")
end if

if len(session("applicationSaved")) > 0 then
	response.write(decorateTop("savedApplication", "marLR10", "Application Saved"))
	response.write(session("applicationSaved"))
	response.write(decorateBottom())
	session("applicationSaved") = ""
end if
%>
  <form name="application" id="application" action="" method="post">
    <%=decorateTop("problemsInApp", "hide marLR10", "Whoops...")%>
    <div id="problemsInAppImage">
      <p>Some problems were found in the form below.</p>
      <p>Please review your application for missing or incorrect information and then try submitting it again.</p>
    </div>
    <%=decorateBottom()%> <%=decorateTop("basicInfo", "marLR10", "Basic Information")%>
    <div id="basicInformation">
      <p>
        <label id="emailLabel" for="email" class="fieldIsGood"><span>&nbsp;</span>Contact email address</label>
        <input type="text" name="email" id="email" size="25" value="<%=email%>" tabindex="1">
      </p>
      <script type="text/javascript"><!-- 
						document.application.email.focus()
							//--></script>
      <p>
        <label id="firstNameLabel" for="firstName" class="fieldIsGood"><span>&nbsp;</span>First Name</label>
        <input type="text" name="firstName" size="25" value="<%=firstName%>" tabindex="2">
      </p>
      <p>
        <label id="lastNameLabel" for="lastName" class="fieldIsGood"><span>&nbsp;</span>Last Name</label>
        <input type="text" name="lastName" size="25" value="<%=lastName%>" tabindex="3">
      </p>
      <p>
        <label id="ssnLabel" for="ssn" class="fieldIsGood"><span>&nbsp;</span>SSN</label>
        <input type="text" name="ssn" id="ssn" value="<%=ssn%>" tabindex="4" onBlur="formatsocial('ssn')" class="halfSized">
		<span class="helpText">555-55-5555</span>
	</p>
      <p>
        <label id="dobLabel" for="dob" class="fieldIsGood"><span>&nbsp;</span>Date of Birth</label>
        <input type="text" name="dob" id="dob" value="<%=dob%>" tabindex="5" onBlur="formatsocial('dob')" class="halfSized">
		<span class="helpText">mm/dd/yyyy</span>
      </p>
      <p>
        <label id="mainPhoneLabel" for="mainPhone" class="fieldIsGood"><span>&nbsp;</span>Phone</label>
        <input type="text" name="mainPhone" id="mainPhone" value="<%=mainPhone%>" tabindex="6" onBlur="formatphone('Pphone')" class="halfSized">
		<span class="helpText">(555)555-5555</span>
      </p>
      <p>
        <label id="altPhoneLabel" for="altPhone">Alternate Phone</label>
        <input type="text" name="altPhone" size="25" value="<%=altPhone%>" tabindex="7" class="halfSized">
		<span class="helpText">(555)555-5555</span>
      </p>
      <p>
        <label id="addressOneLabel" for="addressOne" class="fieldIsGood"><span>&nbsp;</span>Address</label>
        <input type="text" name="addressOne" size="25" value="<%=addressOne%>" tabindex="8">
      </p>
      <p>
        <label id="addressTwoLabel" for="addressTwo">Address Two</label>
        <input type="text" name="addressTwo" size="25" value="<%=AddressTwo%>" tabindex="9">
      </p>
      <p>
        <label id="cityLabel" for="city" class="fieldIsGood"><span>&nbsp;</span>City</label>
        <input type="text" name="city" size="15" value="<%=city%>" tabindex="10" class="halfSized">
      </p>
      <p>
        <label id="appStateLabel" for="State">State</label>
        <select name="appState" tabindex="11" class="notstyled">
          <option value="ID">ID</option>
          <%=PopulateList("list_locations", "locCode", "locCode", "locCode", appState)%>
        </select>
      </p>
      <p>
        <label id="zipcodeLabel" for="zipcode" class="fieldIsGood"><span>&nbsp;</span>Zip Code</label>
        <input type="text" name="zipcode" size="7" value="<%=zipcode%>" tabindex="12">
      </p>
      <p>
        <label id="countryLabel" for="country">Country</label>
        <select name="country" tabindex="13">
          <option value="USA">USA</option>
          <option value="CA">Canada</option>
        </select>
      </p>
    </div>
    <div class="notes">
      <h4> Online Employment App </h4>
      <p>Fill in and complete all information on this form. Once completed, select the submit button at the bottom of the page and then stop by your nearest location to finish and sign your application.</p>
      <p class="last">* All information is protected during transmission using high-grade SSL RC4 128 bit secured encryption</p>
    </div>
    <div id="secureShield"> </div>
    <%=decorateBottom()%> <%=decorateTop("employmentPreferences", "marLR10", "Employment Information")%>
    <p>
      <label id="desiredWageAmountLabel" for="desiredWageAmount" class="fieldIsGood"><span>&nbsp;</span>Desired Salary/Wage:</label>
      <input type="text" id="desiredWageAmount" name="desiredWageAmount" value="<%=desiredWageAmount%>" tabindex="14">
    </p>
    <p>
      <label id="minWageAmountLabel" for="minWageAmount" class="fieldIsGood"><span>&nbsp;</span>Minimum Salary/Wage:</label>
      <input type="text" id="minWageAmount" name="minWageAmount" value="<%=minWageAmount%>" tabindex="15">
    </p>
    <ul>
      <li><label id="currentlyEmployedLabel" class="fieldIsGood"><span>&nbsp;</span>Are you currently employed?</label></li>
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
    </ul>
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
        <input type="radio" name="workValidLicense" value="y" class="styled" <% if workValidLicense = "y" then response.write("checked")%>>
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
      <label id="workConvictionLabel" class="fieldIsGood"><span>&nbsp;</span>Have you ever been convicted of a felony?</label>
      <li onClick="javascript:showdiv('FelonyExplain');">
        <input type="radio" name="workConviction" id="workConviction" value="y" class="styled" <% if workConviction = "y" then response.write("checked")%>>
      </li>
      <li>Yes</li>
      <li onClick="javascript:hidediv('FelonyExplain');">
        <input type="radio" name="workConviction" value="n" class="styled" <% if workConviction = "n" then response.write("checked")%>>
      </li>
      <li>No</li>
    </ul>
    <ul id="FelonyExplain" <%if workConviction <> "y" then response.write("class=" & chr(34) & "hide" & chr(34))%>>
      <label id="workConvictionExplaiLabeln" for="workConvictionExplain">Please explain your felony conviction:</label>
      <textarea name="workConvictionExplain" id="workConvictionExplain" rows="2" cols="33"><%=workConvictionExplain%></textarea>
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
      <li>
        <label id="additionalInfoLabel" for="additionalInfo">Please include any additional information such as spoken languages, associations, awards, etc.?</label>
      </li>
      <li>
        <textarea name="additionalInfo" id="additionalInfo" rows="3" cols="33" tabindex="18" ><%=additionalInfo%></textarea>
      </li>
    </ul>
    <%=decorateBottom()%> <%=decorateTop("employmentReferences", "marLR10", "References - Give the Names of Three Persons Not Related to You")%>
    <ul>
      <li>
        <label id="referenceNameOneLabel" for="referenceNameOne" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
        <input type="text" id="referenceNameOne" name="referenceNameOne" value="<%=referenceNameOne%>" tabindex="19">
      </li>
      <li>
        <label id="referencePhoneOneLabel" for="referencePhoneOne" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
        <input type="text" id="referencePhoneOne" name="referencePhoneOne" value="<%=referencePhoneOne%>" tabindex="20">
      </li>
    </ul>
    <ul>
      <li>
        <label id="referenceNameTwoLabel" for="referenceNameTwo" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
        <input type="text" id="referenceNameTwo" name="referenceNameTwo" value="<%=referenceNameTwo%>" tabindex="21">
      </li>
      <li>
        <label id="referencePhoneTwoLabel" for="referencePhoneTwo" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
        <input type="text" id="referencePhoneTwo" name="referencePhoneTwo" value="<%=referencePhoneTwo%>" tabindex="22">
      </li>
    </ul>
    <ul>
      <li>
        <label id="referenceNameThreeLabel" for="referenceNameThree" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
        <input type="text" id="referenceNameThree" name="referenceNameThree" value="<%=referenceNameThree%>" tabindex="23">
      </li>
      <li>
        <label id="referencePhoneThreeLabel" for="referencePhoneThree" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
        <input type="text" id="referencePhoneThree" name="referencePhoneThree" value="<%=referencePhoneThree%>" tabindex="24">
      </li>
    </ul>
    <%=decorateBottom()%> <%=decorateTop("skillsInformation", "marLR10", "Skills: Select your related experience")%>
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
    <%=decorateBottom()%> <%=decorateTop("applicationWorkHistoryOne", "applicationWorkHistory marLR10", "Most recent employment")%>
    <p>
      <label id="employerNameHistOneLabel" for="employerNameHistOne" class="fieldIsGood"><span>&nbsp;</span>Employer Name</label>
      <input type="text" name="employerNameHistOne" id="employerNameHistOne" tabindex="25" value="<%=employerNameHistOne%>">
    </p>
    <p>
      <label id="jobHistAddOneLabel" for="jobHistAddOne" class="fieldIsGood"><span>&nbsp;</span>Employer Address</label>
      <input type="text" name="jobHistAddOne" id="jobHistAddOne" tabindex="26" value="<%=jobHistAddOne%>">
    </p>
    <ul>
      <li>
        <label id="jobHistCityOneLabel" for="jobHistCityOne" class="fieldIsGood"><span>&nbsp;</span>City</label>
        <input type="text" name="jobHistCityOne" id="jobHistCityOne" tabindex="27" value="<%=jobHistCityOne%>">
      </li>
      <li>
        <label id="jobHistStateOneLabel" for="jobHistStateOne" class="fieldIsGood"><span>&nbsp;</span>State</label>
        <input type="text" name="jobHistStateOne" id="jobHistStateOne" tabindex="28" value="<%=jobHistStateOne%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistZipOneLabel" for="jobHistZipOne" class="fieldIsGood"><span>&nbsp;</span>Zip</label>
        <input type="text" name="jobHistZipOne" id="jobHistZipOne" tabindex="29" value="<%=jobHistZipOne%>">
      </li>
      <li>
        <label id="jobHistPayOneLabel" for="jobHistPayOne" class="fieldIsGood"><span>&nbsp;</span>Pay</label>
        <input type="text" name="jobHistPayOne" id="jobHistPayOne" tabindex="30" value="<%=jobHistPayOne%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistSupervisorOneLabel" for="jobHistSupervisorOne" class="fieldIsGood"><span>&nbsp;</span>Supervisor</label>
        <input type="text" name="jobHistSupervisorOne" id="jobHistSupervisorOne" tabindex="31" value="<%=jobHistSupervisorOne%>">
      </li>
      <li>
        <label id="jobHistPhoneOneLabel" for="jobHistPhoneOne" class="fieldIsGood"><span>&nbsp;</span>Contact Phone</label>
        <input type="text" name="jobHistPhoneOne" id="jobHistPhoneOne" tabindex="32" value="<%=jobHistPhoneOne%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistFromDateOneLabel" for="jobHistFromDateOne" class="fieldIsGood"><span>&nbsp;</span>What date did you start?</label>
        <input type="text" name="jobHistFromDateOne" id="jobHistFromDateOne" tabindex="33" value="<%=jobHistFromDateOne%>">
      </li>
      <li>
        <label id="JobHistToDateOneLabel" for="JobHistToDateOne" class="fieldIsGood"><span>&nbsp;</span>What was your last day?</label>
        <input type="text" name="JobHistToDateOne" id="JobHistToDateOne" tabindex="34" value="<%=JobHistToDateOne%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobDutiesOneLabel" for="jobDutiesOne" class="fieldIsGood"><span>&nbsp;</span>What were your job duties?</label>
        <textarea type="text" name="jobDutiesOne" id="jobDutiesOne" tabindex="35" ><%=jobDutiesOne%></textarea>
      </li>
      <li>
        <label id="jobReasonOneLabel" for="jobReasonOne" class="fieldIsGood"><span>&nbsp;</span>Why did the work end?</label>
        <textarea type="text" name="jobReasonOne" id="jobReasonOne" tabindex="36" ><%=jobReasonOne%></textarea>
      </li>
    </ul>
    <%=decorateBottom()%> <%=decorateTop("applicationWorkHistoryTwo", "applicationWorkHistory marLR10", "Second Most Recent")%>
    <p>
      <label id="employerNameHistTwoLabel" for="employerNameHistTwo" class="fieldIsGood"><span>&nbsp;</span>Employer Name</label>
      <input type="text" name="employerNameHistTwo" id="employerNameHistTwo" tabindex="37" value="<%=employerNameHistTwo%>">
    </p>
    <p>
      <label id="jobHistAddTwoLabel" for="jobHistAddTwo" class="fieldIsGood"><span>&nbsp;</span>Employer Address</label>
      <input type="text" name="jobHistAddTwo" id="jobHistAddTwo" tabindex="38" value="<%=jobHistAddTwo%>">
    </p>
    <ul>
      <li>
        <label id="jobHistCityTwoLabel" for="jobHistCityTwo" class="fieldIsGood"><span>&nbsp;</span>City</label>
        <input type="text" name="jobHistCityTwo" id="jobHistCityTwo" tabindex="39" value="<%=jobHistCityTwo%>">
      </li>
      <li>
        <label id="jobHistStateTwoLabel" for="jobHistStateTwo" class="fieldIsGood"><span>&nbsp;</span>State</label>
        <input type="text" name="jobHistStateTwo" id="jobHistStateTwo" tabindex="40" value="<%=jobHistStateTwo%>" >
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistZipTwoLabel" for="jobHistZipTwo" class="fieldIsGood"><span>&nbsp;</span>Zip</label>
        <input type="text" name="jobHistZipTwo" id="jobHistZipTwo" tabindex="41" value="<%=jobHistZipTwo%>">
      </li>
      <li>
        <label id="jobHistPayTwoLabel" for="jobHistPayTwo" class="fieldIsGood"><span>&nbsp;</span>Pay</label>
        <input type="text" name="jobHistPayTwo" id="jobHistPayTwo" tabindex="42" value="<%=jobHistPayTwo%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistSupervisorTwoLabel" for="jobHistSupervisorTwo" class="fieldIsGood"><span>&nbsp;</span>Supervisor</label>
        <input type="text" name="jobHistSupervisorTwo" id="jobHistSupervisorTwo" tabindex="43" value="<%=jobHistSupervisorTwo%>" >
      </li>
      <li>
        <label id="jobHistPhoneTwoLabel" for="jobHistPhoneTwo" class="fieldIsGood"><span>&nbsp;</span>Contact Phone</label>
        <input type="text" name="jobHistPhoneTwo" id="jobHistPhoneTwo" tabindex="44" value="<%=jobHistPhoneTwo%>" >
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistFromDateTwoLabel" for="jobHistFromDateTwo" class="fieldIsGood"><span>&nbsp;</span>What date did you start?</label>
        <input type="text" name="jobHistFromDateTwo" id="jobHistFromDateTwo" tabindex="45" value="<%=jobHistFromDateTwo%>">
      </li>
      <li>
        <label id="JobHistToDateTwoLabel" for="JobHistToDateTwo" class="fieldIsGood"><span>&nbsp;</span>What was your last day?</label>
        <input type="text" name="JobHistToDateTwo" id="JobHistToDateTwo" tabindex="46" value="<%=JobHistToDateTwo%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobDutiesTwoLabel" for="jobDutiesTwo" class="fieldIsGood"><span>&nbsp;</span>What were your job duties?</label>
        <textarea type="text" name="jobDutiesTwo" id="jobDutiesTwo" tabindex="47" ><%=jobDutiesTwo%></textarea>
      </li>
      <li>
        <label id="jobReasonTwoLabel" for="jobReasonTwo" class="fieldIsGood"><span>&nbsp;</span>Why did the work end?</label>
        <textarea type="text" name="jobReasonTwo" id="jobReasonTwo" tabindex="48" ><%=jobReasonTwo%></textarea>
      </li>
    </ul>
    <%=decorateBottom()%> <%=decorateTop("applicationWorkHistoryThree", "applicationWorkHistory marLR10", "Third Most Recent")%>
    <p>
      <label id="employerNameHistThreeLabel" for="employerNameHistThree" class="fieldIsGood"><span>&nbsp;</span>Employer Name</label>
      <input type="text" name="employerNameHistThree" id="employerNameHistThree" tabindex="49" value="<%=employerNameHistThree%>">
    </p>
    <p>
      <label id="jobHistAddThreeLabel" for="jobHistAddThree" class="fieldIsGood"><span>&nbsp;</span>Employer Address</label>
      <input type="text" name="jobHistAddThree" id="jobHistAddThree" tabindex="50" value="<%=jobHistAddThree%>">
    </p>
    <ul>
      <li>
        <label id="jobHistCityThreeLabel" for="jobHistCityThree" class="fieldIsGood"><span>&nbsp;</span>City</label>
        <input type="text" name="jobHistCityThree" id="jobHistCityThree" tabindex="51" value="<%=jobHistCityThree%>">
      </li>
      <li>
        <label id="jobHistStateThreeLabel" for="jobHistStateThree" class="fieldIsGood"><span>&nbsp;</span>State</label>
        <input type="text" name="jobHistStateThree" id="jobHistStateThree" tabindex="52" value="<%=jobHistStateThree%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistZipThreeLabel" for="jobHistZipThree" class="fieldIsGood"><span>&nbsp;</span>Zip</label>
        <input type="text" name="jobHistZipThree" id="jobHistZipThree" tabindex="53" value="<%=jobHistZipThree%>">
      </li>
      <li>
        <label id="jobHistPayThreeLabel" for="jobHistPayThree" class="fieldIsGood"><span>&nbsp;</span>Pay</label>
        <input type="text" name="jobHistPayThree" id="jobHistPayThree" tabindex="54" value="<%=jobHistPayThree%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistSupervisorThreeLabel" for="jobHistSupervisorThree" class="fieldIsGood"><span>&nbsp;</span>Supervisor</label>
        <input type="text" name="jobHistSupervisorThree" id="jobHistSupervisorThree" tabindex="55" value="<%=jobHistSupervisorThree%>">
      </li>
      <li>
        <label id="jobHistPhoneThreeLabel" for="jobHistPhoneThree" class="fieldIsGood"><span>&nbsp;</span>Contact Phone</label>
        <input type="text" name="jobHistPhoneThree" id="jobHistPhoneThree" tabindex="56" value="<%=jobHistPhoneThree%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobHistFromDateThreeLabel" for="jobHistFromDateThree" class="fieldIsGood"><span>&nbsp;</span>What date did you start?</label>
        <input type="text" name="jobHistFromDateThree" id="jobHistFromDateThree" tabindex="57" value="<%=jobHistFromDateThree%>">
      </li>
      <li>
        <label id="JobHistToDateThreeLabel" for="JobHistToDateThree" class="fieldIsGood"><span>&nbsp;</span>What was your last day?</label>
        <input type="text" name="JobHistToDateThree" id="JobHistToDateThree" tabindex="58" value="<%=JobHistToDateThree%>">
      </li>
    </ul>
    <ul>
      <li>
        <label id="jobDutiesThreeLabel" for="jobDutiesThree" class="fieldIsGood"><span>&nbsp;</span>What were your job duties?</label>
        <textarea type="text" name="jobDutiesThree" id="jobDutiesThree" tabindex="59" ><%=jobDutiesThree%></textarea>
      </li>
      <li>
        <label id="jobReasonThreeLabel" for="jobReasonThree" class="fieldIsGood"><span>&nbsp;</span>Why did the work end?</label>
        <textarea type="text" name="jobReasonThree" id="jobReasonThree" tabindex="60" ><%=jobReasonThree%></textarea>
      </li>
    </ul>
    <%=decorateBottom()%> <%=decorateTop("legalNotice", "marLR10", "Legal Notice")%>
    <p>I agree that my employment with Personnel Plus may be terminated at any time with liability to me for wages or salary except such as may have been earned at the date of such termination. I understand that my compensation from Personnel Plus shall be limited to the duration of any temporary assignment hereunder. I agree that if at any time I sustain a work-related injury, I will submit myself to a drug/alcohol test and to an examination by a physician of the company's selection.</p>
    <%=decorateBottom()%>
    <input id="formAction" name="formAction" type="hidden" class="hidden" value="notset">
  </form>
  <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="#" style="margin-left: 6px" onClick="checkApplication();"><span>Send Application Now!</span></a></div>
  <%
  
Sub SaveApplication
	'This Sub Disabled and Not being called; left for future developement
	
	Response.Cookies("application") ("email") = StripIt(request.form("email"))
	Response.Cookies("application") ("firstName") = StripIt(request.form("firstName"))
	Response.Cookies("application") ("lastName") = StripIt(request.form("lastName"))
	Response.Cookies("application") ("mainPhone") = StripIt(request.form("mainPhone"))
	Response.Cookies("application") ("altPhone") = StripIt(request.form("altPhone"))
	Response.Cookies("application") ("addressOne") = StripIt(request.form("addressOne"))
	Response.Cookies("application") ("addressTwo") = StripIt(request.form("addressTwo"))
	Response.Cookies("application") ("city") = StripIt(request.form("city"))
	Response.Cookies("application") ("appState") = StripIt(request.form("appState"))
	Response.Cookies("application") ("zipcode") = StripIt(request.form("zipcode"))
	Response.Cookies("application") ("emailupdates") = StripIt(request.form("emailupdates"))
	Response.Cookies("application") ("desiredWageAmount") = StripIt(request.form("desiredWageAmount"))
	Response.Cookies("application") ("minWageAmount") = StripIt(request.form("minWageAmount"))
	Response.Cookies("application") ("sex") = StripIt(request.form("sex"))
	Response.Cookies("application") ("maritalStatus") = StripIt(request.form("maritalStatus"))
	Response.Cookies("application") ("currentlyEmployed") = StripIt(request.form("currentlyEmployed"))
	Response.Cookies("application") ("workTypeDesired") = StripIt(request.form("workTypeDesired"))
	Response.Cookies("application") ("citizen") = StripIt(request.form("citizen"))
	Response.Cookies("application") ("alienType") = StripIt(request.form("alienType"))
	Response.Cookies("application") ("alienNumber") = StripIt(request.form("alienNumber"))
	Response.Cookies("application") ("workAuthProof") = StripIt(request.form("workAuthProof"))
	Response.Cookies("application") ("workAge") = StripIt(request.form("workAge"))
	Response.Cookies("application") ("workValidLicense") = StripIt(request.form("workValidLicense"))
	Response.Cookies("application") ("workLicenseType") = StripIt(request.form("workLicenseType"))
	Response.Cookies("application") ("workRelocate") = StripIt(request.form("workRelocate"))
	Response.Cookies("application") ("workConviction") = StripIt(request.form("workConviction"))
	Response.Cookies("application") ("workConvictionExplain") = StripIt(request.form("workConvictionExplain"))
	Response.Cookies("application") ("currentlyEmployed") = StripIt(request.form("currentlyEmployed"))
	Response.Cookies("application") ("availableWhen") = StripIt(request.form("availableWhen"))
	Response.Cookies("application") ("workCommuteHow") = StripIt(request.form("workCommuteHow"))
	Response.Cookies("application") ("workCommuteDistance") = StripIt(request.form("workCommuteDistance"))
	Response.Cookies("application") ("workLicenseState") = StripIt(request.form("workLicenseState"))
	Response.Cookies("application") ("workLicenseExpire") = StripIt(request.form("workLicenseExpire"))
	Response.Cookies("application") ("autoInsurance") = StripIt(request.form("autoInsurance"))
	Response.Cookies("application") ("eduLevel") = StripIt(request.form("eduLevel"))
	Response.Cookies("application") ("additionalInfo") = StripIt(request.form("additionalInfo"))
	Response.Cookies("application") ("referenceNameOne") = StripIt(request.form("referenceNameOne"))
	Response.Cookies("application") ("referencePhoneOne") = StripIt(request.form("referencePhoneOne"))
	Response.Cookies("application") ("referenceNameTwo") = StripIt(request.form("referenceNameTwo"))
	Response.Cookies("application") ("referencePhoneTwo") = StripIt(request.form("referencePhoneTwo"))
	Response.Cookies("application") ("referenceNameThree") = StripIt(request.form("referenceNameThree"))
	Response.Cookies("application") ("referencePhoneThree") = StripIt(request.form("referencePhoneThree"))
	Response.Cookies("application") ("skillsClerical") = StripIt(SkilledIn("skillsClerical"))
	Response.Cookies("application") ("skillsCustomerSvc") = StripIt(SkilledIn("skillsCustomerSvc"))
	Response.Cookies("application") ("skillsIndustrial") = StripIt(SkilledIn("skillsIndustrial"))
	Response.Cookies("application") ("skillsGeneralLabor") = StripIt(SkilledIn("skillsGeneralLabor"))
	Response.Cookies("application") ("skillsConstruction") = StripIt(SkilledIn("skillsConstruction"))
	Response.Cookies("application") ("skillsSkilledLabor") = StripIt(SkilledIn("skillsSkilledLabor"))
	Response.Cookies("application") ("skillsBookkeeping") = StripIt(SkilledIn("skillsBookkeeping"))
	Response.Cookies("application") ("skillsSales") = StripIt(SkilledIn("skillsSales"))
	Response.Cookies("application") ("skillsManagement") = StripIt(SkilledIn("skillsManagement"))
	Response.Cookies("application") ("skillsTechnical") = StripIt(SkilledIn("skillsTechnical"))
	Response.Cookies("application") ("skillsFoodService") = StripIt(SkilledIn("skillsFoodService"))
	Response.Cookies("application") ("skillsSoftware") = StripIt(SkilledIn("skillsSoftware"))
	Response.Cookies("application") ("employerNameHistOne") = StripIt(request.form("employerNameHistOne"))
	Response.Cookies("application") ("jobHistAddOne") = StripIt(request.form("jobHistAddOne"))
	Response.Cookies("application") ("jobHistPhoneOne") = StripIt(request.form("jobHistPhoneOne"))
	Response.Cookies("application") ("jobHistCityOne") = StripIt(request.form("jobHistCityOne"))
	Response.Cookies("application") ("jobHistStateOne") = StripIt(request.form("jobHistStateOne"))
	Response.Cookies("application") ("jobHistZipOne") = StripIt(request.form("jobHistZipOne"))
	Response.Cookies("application") ("jobHistPayOne") = StripIt(request.form("jobHistPayOne"))
	Response.Cookies("application") ("jobHistSupervisorOne") = StripIt(request.form("jobHistSupervisorOne"))
	Response.Cookies("application") ("jobDutiesOne") = StripIt(request.form("jobDutiesOne"))
	Response.Cookies("application") ("jobHistFromDateOne") = StripIt(request.form("jobHistFromDateOne"))
	Response.Cookies("application") ("JobHistToDateOne") = StripIt(request.form("JobHistToDateOne"))
	Response.Cookies("application") ("jobReasonOne") = StripIt(request.form("jobReasonOne"))
	Response.Cookies("application") ("employerNameHistTwo") = StripIt(request.form("employerNameHistTwo"))
	Response.Cookies("application") ("jobHistAddTwo") = StripIt(request.form("jobHistAddTwo"))
	Response.Cookies("application") ("jobHistPhoneTwo") = StripIt(request.form("jobHistPhoneTwo"))
	Response.Cookies("application") ("jobHistCityTwo") = StripIt(request.form("jobHistCityTwo"))
	Response.Cookies("application") ("jobHistStateTwo") = StripIt(request.form("jobHistStateTwo"))
	Response.Cookies("application") ("jobHistZipTwo") = StripIt(request.form("jobHistZipTwo"))
	Response.Cookies("application") ("jobHistPayTwo") = StripIt(request.form("jobHistPayTwo"))
	Response.Cookies("application") ("jobHistSupervisorTwo") = StripIt(request.form("jobHistSupervisorTwo"))
	Response.Cookies("application") ("jobDutiesTwo") = StripIt(request.form("jobDutiesTwo"))
	Response.Cookies("application") ("jobHistFromDateTwo") = StripIt(request.form("jobHistFromDateTwo"))
	Response.Cookies("application") ("JobHistToDateTwo") = StripIt(request.form("JobHistToDateTwo"))
	Response.Cookies("application") ("jobReasonTwo") = StripIt(request.form("jobReasonTwo"))
	Response.Cookies("application") ("employerNameHistThree") = StripIt(request.form("employerNameHistThree"))
	Response.Cookies("application") ("jobHistAddThree") = StripIt(request.form("jobHistAddThree"))
	Response.Cookies("application") ("jobHistPhoneThree") = StripIt(request.form("jobHistPhoneThree"))
	Response.Cookies("application") ("jobHistCityThree") = StripIt(request.form("jobHistCityThree"))
	Response.Cookies("application") ("jobHistStateThree") = StripIt(request.form("jobHistStateThree"))
	Response.Cookies("application") ("jobHistZipThree") = StripIt(request.form("jobHistZipThree"))
	Response.Cookies("application") ("jobHistPayThree") = StripIt(request.form("jobHistPayThree"))
	Response.Cookies("application") ("jobHistSupervisorThree") = StripIt(request.form("jobHistSupervisorThree"))
	Response.Cookies("application") ("jobDutiesThree") = StripIt(request.form("jobDutiesThree"))
	Response.Cookies("application") ("jobHistFromDateThree") = StripIt(request.form("jobHistFromDateThree"))
	Response.Cookies("application") ("JobHistToDateThree") = StripIt(request.form("JobHistToDateThree"))
	Response.Cookies("application") ("jobReasonThree") = StripIt(request.form("jobReasonThree"))

	session("applicationSaved") = "Your application has been saved. The application is not complete until you fill in all the information and submit it online."
End Sub

Sub SubmitApplication
	On Error Resume Next
	dim firstName, lastName, lastNameFirst, email, userID, sqlSubmitApplication, interest

	firstName = Pcase(StripIt(request.form("firstName")))
	lastName = Pcase(StripIt(request.form("lastName")))
	ssn = ssnRE.Replace(request.form("ssn"), "")
	dob = FormatDateTime(request.form("dob"), 2)
	email = StripIt(request.form("email"))
	emailupdates = StripIt(request.form("emailupdates"))
	mainPhone = ssnRE.Replace(request.form("mainPhone"), "")
	altPhone = ssnRE.Replace(request.form("altPhone"), "")
	addressOne = StripIt(request.form("addressOne"))
	addressTwo = StripIt(request.form("addressTwo"))
	city = StripIt(request.form("city"))
	appState = StripIt(request.form("appState"))
	zipcode = ssnRE.Replace(request.form("zipcode"), "")
	desiredWageAmount = StripIt(request.form("desiredWageAmount"))
	minWageAmount = StripIt(request.form("minWageAmount"))
	sex = StripIt(request.form("sex"))
	maritalStatus = StripIt(request.form("maritalStatus"))
	smoker = StripIt(request.form("smoker"))
	currentlyEmployed = StripIt(request.form("currentlyEmployed"))
	workTypeDesired = StripIt(request.form("workTypeDesired"))
	citizen = StripIt(request.form("citizen"))
	alienType = StripIt(request.form("alienType")) : if len(alienType & "") = 0 then alienType = "p"
	alienNumber = StripIt(request.form("alienNumber"))
	citizen = StripIt(request.form("citizen"))
	workAuthProof = StripIt(request.form("workAuthProof"))
	workAge = StripIt(request.form("workAge"))
	workValidLicense = StripIt(request.form("workValidLicense"))
	workLicenseType = StripIt(request.form("workLicenseType"))
	workRelocate = StripIt(request.form("workRelocate"))
	workConviction = StripIt(request.form("workConviction"))
	workConvictionExplain = StripIt(request.form("workConvictionExplain"))
	currentlyEmployed = StripIt(request.form("currentlyEmployed"))
	availableWhen = StripIt(request.form("availableWhen"))
	workCommuteHow = StripIt(request.form("workCommuteHow"))
	workCommuteDistance = StripIt(request.form("workCommuteDistance"))
	workLicenseState = StripIt(request.form("workLicenseState"))
	workLicenseExpire = StripIt(request.form("workLicenseExpire"))
	autoInsurance = StripIt(request.form("autoInsurance"))
	eduLevel = StripIt(request.form("eduLevel"))
	additionalInfo = StripIt(request.form("additionalInfo"))
	referenceNameOne = StripIt(request.form("referenceNameOne"))
	referencePhoneOne = ssnRE.Replace(request.form("referencePhoneOne"), "")
	referenceNameTwo = StripIt(request.form("referenceNameTwo"))
	referencePhoneTwo = ssnRE.Replace(request.form("referencePhoneTwo"), "")
	referenceNameThree = StripIt(request.form("referenceNameThree"))
	referencePhoneThree = ssnRE.Replace(request.form("referencePhoneThree"), "")
	skillsSet = CollectSkills
	employerNameHistOne = StripIt(request.form("employerNameHistOne"))
	jobHistAddOne = StripIt(request.form("jobHistAddOne"))
	jobHistPhoneOne = ssnRE.Replace(request.form("jobHistPhoneOne"), "")
	jobHistCityOne = StripIt(request.form("jobHistCityOne"))
	jobHistStateOne = StripIt(request.form("jobHistStateOne"))
	jobHistZipOne = ssnRE.Replace(request.form("jobHistZipOne"), "")
	jobHistPayOne = StripIt(request.form("jobHistPayOne"))
	jobHistSupervisorOne = StripIt(request.form("jobHistSupervisorOne"))
	jobDutiesOne = StripIt(request.form("jobDutiesOne"))
	jobHistFromDateOne = StripIt(request.form("jobHistFromDateOne"))
	JobHistToDateOne = StripIt(request.form("JobHistToDateOne"))
	jobReasonOne = StripIt(request.form("jobReasonOne"))
	employerNameHistTwo = StripIt(request.form("employerNameHistTwo"))
	jobHistAddTwo = StripIt(request.form("jobHistAddTwo"))
	jobHistPhoneTwo = ssnRE.Replace(request.form("jobHistPhoneTwo"), "")
	jobHistCityTwo = StripIt(request.form("jobHistCityTwo"))
	jobHistStateTwo = StripIt(request.form("jobHistStateTwo"))
	jobHistZipTwo = ssnRE.Replace(request.form("jobHistZipTwo"), "")
	jobHistPayTwo = StripIt(request.form("jobHistPayTwo"))
	jobHistSupervisorTwo = StripIt(request.form("jobHistSupervisorTwo"))
	jobDutiesTwo = StripIt(request.form("jobDutiesTwo"))
	jobHistFromDateTwo = StripIt(request.form("jobHistFromDateTwo"))
	JobHistToDateTwo = StripIt(request.form("JobHistToDateTwo"))
	jobReasonTwo = StripIt(request.form("jobReasonTwo"))
	employerNameHistThree = StripIt(request.form("employerNameHistThree"))
	jobHistAddThree = StripIt(request.form("jobHistAddThree"))
	jobHistPhoneThree = ssnRE.Replace(request.form("jobHistPhoneThree"), "")
	jobHistCityThree = StripIt(request.form("jobHistCityThree"))
	jobHistStateThree = StripIt(request.form("jobHistStateThree"))
	jobHistZipThree = StripIt(request.form("jobHistZipThree"))
	jobHistPayThree = StripIt(request.form("jobHistPayThree"))
	jobHistSupervisorThree = StripIt(request.form("jobHistSupervisorThree"))
	jobDutiesThree = StripIt(request.form("jobDutiesThree"))
	jobHistFromDateThree = StripIt(request.form("jobHistFromDateThree"))
	JobHistToDateThree = StripIt(request.form("JobHistToDateThree"))
	jobReasonThree = StripIt(request.form("jobReasonThree"))

	sqlSubmitApplication = "INSERT INTO tbl_applications (email, firstName, lastName, ssn, dob, mainPhone, altPhone, addressOne, addressTwo, " & _
	"city, appState, zipcode, emailupdates, desiredWageAmount, minWageAmount, sex, maritalStatus, smoker, currentlyEmployed, workTypeDesired, " &_
	"citizen, alienType, alienNumber, workAuthProof, workAge, workValidLicense, workLicenseType, autoInsurance, " & _
	"workRelocate, workConviction, workConvictionExplain, eduLevel, referenceNameOne, referencePhoneOne," & _
	" referenceNameTwo, referencePhoneTwo, referenceNameThree, referencePhoneThree, additionalInfo, skillsSet, employerNameHistOne, jobHistAddOne," & _
	" jobHistCityOne, jobHistStateOne, jobHistZipOne, jobHistPayOne, jobHistSupervisorOne, jobHistPhoneOne, jobHistFromDateOne," & _
	" JobHistToDateOne, jobDutiesOne, jobReasonOne, employerNameHistTwo, jobHistAddTwo, jobHistCityTwo, jobHistStateTwo," & _
	" jobHistZipTwo, jobHistPayTwo, jobHistSupervisorTwo, jobHistPhoneTwo, jobHistFromDateTwo, JobHistToDateTwo, jobDutiesTwo, jobReasonTwo," & _
	" employerNameHistThree, jobHistAddThree, jobHistPhoneThree, jobHistCityThree, jobHistStateThree, jobHistZipThree, jobHistPayThree," & _
	" jobHistSupervisorThree, jobDutiesThree, jobHistFromDateThree, JobHistToDateThree, jobReasonThree, creationDate, modifiedDate, submitted) VALUES (" & _ 
	"'" & email & _
	"', '" & firstName & _
	"', '" & lastName & _
	"', '" & ssn & _
	"', '" & dob & _
	"', '" & mainPhone & _
	"', '" & altPhone & _
	"', '" & addressOne & _
	"', '" & addressTwo & _
	"', '" & city & _
	"', '" & appState & _
	"', '" & zipcode & _
	"', '" & emailupdates & _
	"', '" & desiredWageAmount & _
	"', '" & minWageAmount & _
	"', '" & sex & _
	"', '" & maritalStatus & _
	"', '" & smoker & _
	"', '" & currentlyEmployed & _
	"', '" & workTypeDesired & _
	"', '" & citizen & _
	"', '" & alienType & _
	"', '" & alienNumber & _
	"', '" & workAuthProof & _
	"', '" & workAge & _
	"', '" & workValidLicense & _
	"', '" & workLicenseType & _
	"', '" & autoInsurance & _
	"', '" & workRelocate & _
	"', '" & workConviction & _
	"', '" & workConvictionExplain & _
	"', '" & eduLevel & _
	"', '" & referenceNameOne & _
	"', '" & referencePhoneOne & _
	"', '" & referenceNameTwo & _
	"', '" & referencePhoneTwo & _
	"', '" & referenceNameThree & _
	"', '" & referencePhoneThree & _
	"', '" & additionalInfo & _
	"', '" & skillsSet & _
	"', '" & employerNameHistOne & _
	"', '" & jobHistAddOne & _
	"', '" & jobHistCityOne & _
	"', '" & jobHistStateOne & _
	"', '" & jobHistZipOne & _
	"', '" & jobHistPayOne & _
	"', '" & jobHistSupervisorOne & _
	"', '" & jobHistPhoneOne & _
	"', '" & jobHistFromDateOne & _
	"', '" & JobHistToDateOne & _
	"', '" & jobDutiesOne & _
	"', '" & jobReasonOne & _
	"', '" & employerNameHistTwo & _
	"', '" & jobHistAddTwo & _
	"', '" & jobHistCityTwo & _
	"', '" & jobHistStateTwo & _
	"', '" & jobHistZipTwo & _
	"', '" & jobHistPayTwo & _
	"', '" & jobHistSupervisorTwo & _
	"', '" & jobHistPhoneTwo & _
	"', '" & jobHistFromDateTwo & _
	"', '" & JobHistToDateTwo & _
	"', '" & jobDutiesTwo & _
	"', '" & jobReasonTwo & _
	"', '" & employerNameHistThree & _
	"', '" & jobHistAddThree & _
	"', '" & jobHistPhoneThree & _
	"', '" & jobHistCityThree & _
	"', '" & jobHistStateThree & _
	"', '" & jobHistZipThree & _
	"', '" & jobHistPayThree & _
	"', '" & jobHistSupervisorThree & _
	"', '" & jobDutiesThree & _
	"', '" & jobHistFromDateThree & _
	"', '" & JobHistToDateThree & _
	"', '" & jobReasonThree & _
	"', Now()" &_
	", Now(), 'y')"
	
	Database.Open MySql
	Database.Execute(sqlSubmitApplication)

	dim applicationId, thisApplication, appLink, msgBody, msgSubject, city, appState, zipcode, deliveryLocation, mySmartMail
	
	applicationId = Database.Execute("Select LAST_INSERT_ID()")
	
	lastNameFirst = lastName & ", " & firstName

	thisApplication = applicationId("LAST_INSERT_ID()")
	msgSubject = lastNameFirst
	interest = Request.QueryString("jobid")
	if len(interest & "") > 0 then
		msgSubject = msgSubject & " is interested in JobOrder: " & interest
	Else
		msgSubject = "Application submitted for: " & msgSubject
	end if
		
	'Determine destination
	Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & zipcode & "'")
	if Not dbQuery.eof then
		deliveryLocation = dbQuery("email")
	Else
		deliveryLocation = "twinfalls@personnel.com"
	end if
	
	if Err.Number = 0 then
		msgBody = firstName & " " & lastName & " has completed the application online." & vbLf & vbLf & "Use the 'View Applications' link after logging in to Personnel Plus's website if you’d like to go to a place where you can view all of the online apps and possibly even review, or insert, this person’s."
		Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")
	Else
		dim objErrorInfo, errorTrapContents, strErrorMessage
		
		msgBody = firstName & " " & lastName & " thinks that the application that was filled out was successful, however do too some issue the server through it away instead and so here's some of the stuff Gus needs in order to manually stitch them into the system and to use with eventually figuring out why the server copped an attitude with this person." & vbLf & vbLf
		strErrorMessage = "At " & Now & " the following errors occurred on " & _
		  "the page " & request.serverVariables("SCRIPT_NAME") & _
		  ": " & Err.description
		msgSubject = firstName & " " & lastName & " almost applied online, but the application crashed..."
		msgBody = msgBody & strErrorMessage & vbLf & vbLf & Server.HTMLEncode(sqlSubmitApplication)
		Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")
	end if

	Set dbQuery = Nothing
	Database.Close()
	On Error GoTo 0
	Response.Redirect("http://www.personnelplus-inc.com/include/content/home.asp?AST=ao")
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
