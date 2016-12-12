<%Option Explicit%>
<%
session("add_css") = "./empapp.1.0.2.css"
session("required_user_level") = 3 'userLevelRegistered

session("additionalHeading") = "<meta http-equiv=""Cache-Control"" content=""No-Cache"">" &_
	"<meta http-equiv=""Cache-Control"" content=""No-Store"">" &_
	"<meta http-equiv=""Pragma"" content=""No-Cache"">" &_
	"<meta http-equiv=""Expires"" content=""0"">"

session("noGuestHead") = "Are you registered?"
session("noGuestBody") = "<p><em>Are you registered?</em></p><br><p>You need a user account to complete the employment application. " &_
	"You can create an account by pressing ""Sign Up"" below and registering or " &_
	"if you have already registed you can use that account to sign in and continue.</p><br><br>"

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
<!-- #include file='empapp.doStuff.asp' -->

<div id="empAppNav">
    <ul>
        <li id="t_nav_general" class="<% if whichpart = "general" or whichpart = "" then response.write "selected" %>"><a href="#" onclick="saveApplication('general');">1. Begin </a></li>
        <li id="t_nav_skills" class="<% if whichpart = "skills" then response.write "selected" %>"><a class="" href="#" onclick="saveApplication('skills');">2. Select Skills </a></li>
        <li id="t_nav_workhist" class="<% if whichpart = "workhist" then response.write "selected" %>"><a class="" href="#" onclick="saveApplication('workhist');">3. Work History </a></li>
        <li id="t_nav_w4form" class="<% if whichpart = "w4form" then response.write "selected" %>"><a class="" href="#" onclick="saveApplication('w4form');">4. Form W4 </a></li>
        <li id="t_nav_contacts" class="<% if whichpart = "contacts" then response.write "selected" %>"><a class="" href="#" onclick="saveApplication('contacts');">5. Contacts </a></li>
        <li id="t_nav_legal" class="<% if whichpart = "legal" then response.write "selected" %>"><a class="" href="#" onclick="saveApplication('legal');">6. The End. </a></li>
    </ul>
</div>
<form class="empapp" name="application" id="application" method="post">
    <%

    %>
    <%=decorateTop("problemsInApp", "hide marLR10", "Whoops...")%>
    <div id="problemsInAppImage">
        <p>Some problems were found in your application.</p>
        <p id="thisproblem">&nbsp;</p>
        <p>Please review your application for missing or incorrect information and then try submitting it again.</p>
    </div>
    <%=decorateBottom()%>
    <%=enrollmentMessageTxt%>
    <%=decorateTop("employmentPreferences", "marLR10" & empapp_general, "Employment Information")%>
    <div id="basicInformation">
	
      <p>
        <label for="nameF">First Name</label>
        <input type="text" id="nameF" name="nameF" size="30" value="<%=firstName%>">
      </p>
      <p>
        <label for="nameL">Last Name</label>
        <input type="text" id="nameL" name="nameL" size="30" value="<%=lastName%>">
      </p>
		<p>
        <label for="email">Email</label>
        <input type="text" id="email" name="email" size="30" value="<%=email%>">
      </p>
      <p>
        <label for="Pphone">Phone</label>
        <input type="text" id="Pphone" name="pphone" size="30" value="<%=mainPhone%>">
      </p>
      <p>
        <label for="Sphone">Other Phone</label>
        <input type="text" id="Sphone" name="sphone" size="30" value="<%=altPhone%>">
      </p>
      <p>
        <label for="addOne">Address</label>
        <input type="text" id="addressOne" name="addressOne" size="30" value="<%=addressOne%>">
      </p>
      <p>
        <label for="addTwo">Address Two</label>
        <input type="text" id="addressTwo" name="addressTwo" size="30" value="<%=addressTwo%>">
      </p>
      <p>
        <label for="City">City</label>
        <input type="text" id="City" name="City" size="20" value="<%=City%>">
     </p>
     <p>
        <label for="state">State</label></td></tr><tr><td>
        <select id="state" name="state" class="styled">
          <option value="ID">ID</option>
          <%=PopulateList("list_locations", "locCode", "locName", "locCode", UserState)%>
        </select></p>
    <p>
        <label for="zipcode">Zip Code</label>
        <input type="text" id="zipcode" name="zipcode" autocomplete="off" size="19" value="<%=zipcode%>">
      </p>
	<p>
		<label for="country">Country</label></td></tr><tr><td>
        <select id="country" name="country" class="styled">
          <option value="USA">USA</option>
          <option value="CA">CA</option>
        </select>
      </p>
        <p>
            <label id="ssnLabel" for="ssn" class="fieldIsGood"><span>&nbsp;</span>SSN</label>
            <input type="text" name="ssn" id="ssn" value="<%=ssn%>" tabindex="1" onblur="check_field(this.name)" class="halfSized" required="required" autocomplete="off">
            <span class="helpText">555-55-5555</span>
        </p>
        <% if instr(empapp_general, "hide") = 0 then %>
        <script type="text/javascript"><!--
    document.application.ssn.focus()
    //--></script>
        <% end if%>
        <p>
            <label id="dobLabel" for="dob" class="fieldIsGood"><span>&nbsp;</span>Birth Date</label>
            <input type="text" name="dob" id="dob" value="<%=dob%>" tabindex="2" onblur="check_field(this.name)" class="halfSized" autocomplete="off">
            <span class="helpText">mm/dd/yyyy</span>
        </p>
        <p>
            <label id="desiredWageAmountLabel" for="desiredWageAmount" class="fieldIsGood"><span>&nbsp;</span>Desired Hourly Salary/Wage:</label>
            <input type="text" id="desiredWageAmount" name="desiredWageAmount" value="<%=desiredWageAmount%>" onblur="check_field(this.name)" tabindex="3">
        </p>
        <p>
            <label id="minWageAmountLabel" for="minWageAmount" class="fieldIsGood"><span>&nbsp;</span>Minimum Hourly Salary/Wage:</label>
            <input type="text" id="minWageAmount" name="minWageAmount" value="<%=minWageAmount%>" onblur="check_field(this.name)" tabindex="4">
        </p>
        <p>
  
        </p>
        <p>

            <label id="aliasNamesLabel" for="aliasNames" class="fieldIsGood"><span>&nbsp;</span>Alias Names</label>
            <input type="text" name="aliasNames" id="aliasNames" value="<%=aliasNames%>" onblur="check_field(this.name)" tabindex="5" autocomplete="off">
            <span class="helpText"><span class="morehelpText">Include all nick names and maiden or prior married names.<br>
                Enter none or n/a if this does not apply to you.
            </span>
        </p>
		
		<p>
        <ul>
            <li>
                <label id="currentlyEmployedLabel" class="fieldIsGood"><span>&nbsp;</span>Are you currently employed?</label>
            </li>
            <li>
                <input type="radio" name="currentlyEmployed" value="y" class="" <% if currentlyEmployed = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li>
                <input type="radio" name="currentlyEmployed" value="n" class="" <% if currentlyEmployed = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>

            <li>
                <label id="sexLabel" class="fieldIsGood"><span>&nbsp;</span>Are you Male or Female?</label>
                <input type="radio" name="sex" value="m" class="" <% if sex = "m" then response.write("checked")%>>
            </li>
            <li>Male</li>
            <li>
                <input type="radio" name="sex" value="f" class="" <% if sex = "f" then response.write("checked")%>>
            </li>
            <li>Female</li>
        </ul>
		</p>
		<p>
        <!--
	<ul>
      <label id="maritalStatusLabel" class="fieldIsGood"><span>&nbsp;</span>Are you married or single?</label>
      <li>
        <input type="radio" name="maritalStatus" value="s" class="" <% if maritalStatus = "s" then response.write("checked")%>>
      </li>
      <li>Single, Seperated or Divorced</li>
      <li>
        <input type="radio" name="maritalStatus" value="m" class="" <% if maritalStatus = "m" then response.write("checked")%>>
      </li>
      <li>Married or Partnered</li>
    </ul> -->
        <ul>

            <li>
                <label id="smokerLabel" class="fieldIsGood"><span>&nbsp;</span>Do you smoke?</label>
                <input type="radio" name="smoker" value="y" class="" <% if smoker = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li>
                <input type="radio" name="smoker" value="n" class="" <% if smoker = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>

            <li>
                <label id="workTypeDesiredLabel" class="fieldIsGood"><span>&nbsp;</span>What type of work do you prefer?</label>
                <input type="radio" name="workTypeDesired" value="f" class="" <% if workTypeDesired = "f" then response.write("checked")%>>
            </li>
            <li>Full-Time</li>
            <li>
                <input type="radio" name="workTypeDesired" value="p" class="" <% if workTypeDesired = "p" then response.write("checked")%>>
            </li>
            <li>Part-Time</li>
            <li>
                <input type="radio" name="workTypeDesired" value="a" class="" <% if workTypeDesired = "a" then response.write("checked")%>>
            </li>
            <li>Any</li>
        </ul>
		</p>
    </div>
    <div>
		<p>
        <ul>
            <li>
                <label id="citizenLabel" class="fieldIsGood"><span>&nbsp;</span>Are you a citizen of the United States?</label>

                <input type="radio" name="citizen" value="y" class="" <% if citizen = "y" then response.write("checked") %> onclick="javascript: hidediv('AuthType');">
            </li>
            <li>Yes</li>
            <li onclick="javascript:showdiv('AuthType');">
                <input type="radio" name="citizen" value="n" class="" <% if citizen = "n" then response.write("checked") %>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <div id="AuthType" style="" <%if citizen <> "n" then response.write("class=""hide""") %>>

            <ul style="width: 70%; float: right; clear: none;">
                <li>
                    <label id="alienTypeLabel" class="fieldIsGood" style="text-align: left;"><span>&nbsp;</span>Please Specify, I am:</label></li>
                <li>
                    <input type="radio" name="alienType" value="o" class="" <% if alienType = "o" then response.write("checked")%>>A noncitizen national of the U.S.</li>
                <li>
                    <input type="radio" name="alienType" value="p" class="" <% if alienType = "p" then response.write("checked")%>>A lawful permanent resident</li>
                <li>
                    <input type="radio" name="alienType" value="a" class="" <% if alienType = "a" then response.write("checked")%>>An alien authorized to work</li>
                <li>
                    <label id="alienNumberLabel" for="alienNumber" class="alignL" style="width: 28em">Your Alien Registration Number/USCIS Number:</label>
                    <input name="alienNumber" id="alienNumber" type="text" tabindex="16" class="halfSized clearleft alignL" value="<%=alienNumber%>">
                </li>
                <li class="center"><em>-- OR --</em></li>
                <li>
                    <label id="lbli94Admission" for="i94Admission" class="alignL">Your I-94 Admission Number:</label>
                    <input name="i94Admission" id="i94Admission" type="text" tabindex="16" class="halfSized clearleft alignL" value="<%=i94Admission%>">
                </li>
                <li>
                    <label id="lblalienExpire" for="alienExpire" class="alignL">Expiration Date, if applicatable:</label>
                    <input name="alienExpire" id="alienExpire" type="text" tabindex="16" class="halfSized clearleft alignL" value="<%=alienExpire%>">
                </li>
                <li>If you obtained your admission number from CBP in connection with your arrival in the United States, include the following:</li>
                <li>
                <li>
                    <label id="lblpassportNumber" for="passportNumber" class="alignL" style="width: 28em">Your Alien Registration Number/USCIS Number:</label>
                    <input name="passportNumber" id="passportNumber" type="text" tabindex="16" class="halfSized clearleft alignL" value="<%=passportNumber%>" autocomplete="off">
                </li>
                <li>
                    <label id="issuanceCountry" for="issuanceCountryissuanceCountry" class="alignL">Your I-94 Admission Number:</label>
                    <input name="issuanceCountry" id="issuanceCountryissuanceCountryissuanceCountry" type="text" tabindex="16" class="halfSized clearleft alignL" autocomplete="off" value="<%=issuanceCountry%>">
                </li>
            </ul>
        </div>
		</p>
		<p>
        <ul>

            <li>
                <label id="workAuthProofLabel" class="fieldIsGood"><span>&nbsp;</span>Do you have proof of authorization?</label>
                <input type="radio" name="workAuthProof" value="y" class="" <% if workAuthProof = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li>
                <input type="radio" name="workAuthProof" value="n" class="" <% if workAuthProof = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>
            <li>
                <label id="workAgeLabel" class="fieldIsGood"><span>&nbsp;</span>Are you 18 years or older?</label>

                <input type="radio" name="workAge" value="y" class="" <% if workAge = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li>
                <input type="radio" name="workAge" value="n" class="" <% if workAge = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>

            <li>
                <label id="workValidLicenseLabel" class="fieldIsGood"><span>&nbsp;</span>Do you have a valid Drivers License?</label>
                <input type="radio" name="workValidLicense" value="y" onblur="check_field('workValidLicense')" class="" <% if workValidLicense = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li>
                <input type="radio" name="workValidLicense" value="n" class="" <% if workValidLicense = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>
            <li>
                <label>Do you have a Commercial Drivers License?</label>

                <input type="radio" name="workLicenseType" value="n" class="" <% if workLicenseType = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
            <li>
                <input type="radio" name="workLicenseType" value="a" class="" <% if workLicenseType = "a" then response.write("checked")%>>
            </li>
            <li>CDL-A</li>
            <li>
                <input type="radio" name="workLicenseType" value="b" class="" <% if workLicenseType = "b" then response.write("checked")%>>
            </li>
            <li>CDL-B</li>
            <li>
                <input type="radio" name="workLicenseType" value="c" class="" <% if workLicenseType = "c" then response.write("checked")%>>
            </li>
            <li>CDL-C</li>
        </ul>
		</p>
		<p>
        <ul>
            <li>
                <label id="autoInsuranceLabel" class="fieldIsGood"><span>&nbsp;</span>Do you have Automobile Insurance?</label>

                <input type="radio" name="autoInsurance" value="y" class="" <% if autoInsurance = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li>
                <input type="radio" name="autoInsurance" value="n" class="" <% if autoInsurance = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>
            <li>
                <label id="workRelocateLabel" class="fieldIsGood"><span>&nbsp;</span>Are you planning to relocate for work?</label>

                <input type="radio" name="workRelocate" value="y" class="" <% if workRelocate = "y" then response.write("checked")%>>
            </li>
            <li>Yes </li>
            <li>
                <input type="radio" name="workRelocate" value="n" class="" <% if workRelocate = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul>
            <li>
                <label id="eduLevelLabel" for="eduLevel" class="fieldIsGood"><span>&nbsp;</span>Highest level of education completed</label>
            </li>
            <li>
				<% dim selectText : selectText = " selected=""selected""" %>
				
                <select id="eduLevel" name="eduLevel" tabindex="17">
                    <option value="">-- Select One --</option>
                    <option value="None"<%if eduLevel = "None" then response.write selectText%>>None</option>
                    <option value="High School Diploma"<%if eduLevel = "High School Diploma" then response.write selectText%>>High School Diploma</option>
                    <option value="GED"<%if eduLevel = "GED" then response.write selectText%>>GED</option>
                    <option value="College (No Degree)"<%if eduLevel = "College (No Degree)" then response.write selectText%>>College (No Degree)</option>
                    <option value="Associates"<%if eduLevel = "Associates" then response.write selectText%>>Associates</option>
                    <option value="Bachelors"<%if eduLevel = "Bachelors" then response.write selectText%>>Bachelors</option>
                    <option value="Masters"<%if eduLevel = "Masters" then response.write selectText%>>Masters</option>
                    <option value="Doctorate"<%if eduLevel = "Doctorate" then response.write selectText%>>Doctorate</option>
                </select>
            </li>
        </ul>
		</p>
		<p>
        <ul>
            <li onclick="javascript:showdiv('FelonyExplain');">
                <label id="workConvictionLabel" class="fieldIsGood"><span>&nbsp;</span>Have you ever been convicted of a felony or misdemeanor?</label>
                <input type="radio" name="workConviction" id="workConvictionf" value="f" class="" <% if workConviction = "y" or workConviction = "f" then response.write("checked")%>>
            </li>
            <li>Yes, a felony</li>
            <li onclick="javascript:showdiv('FelonyExplain');">
                <input type="radio" name="workConviction" id="workConvictionm" value="m" class="" <% if workConviction = "m" then response.write("checked")%>>
            </li>
            <li>Yes, a misdemeanor</li>
            <li onclick="javascript:hidediv('FelonyExplain');">
                <input type="radio" name="workConviction" value="n" class="" <% if workConviction = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul id="FelonyExplain" <% if workConviction <> "y" then response.write("class=""hide""") %>>
            <li>
                <label id="workConvictionExplainLabel" for="workConvictionExplain">Please explain your conviction:</label>
                <textarea name="workConvictionExplain" id="workConvictionExplain" rows="2" cols="33"><%=workConvictionExplain%></textarea>
            </li>
        </ul>
		</p>
		<p>

        <ul>
            <li onclick="javascript:showdiv('staffing_detail');">
                <label id="staffedLabel" class="fieldIsGood"><span>&nbsp;</span>Have you ever worked for a staffing service before?</label>

                <input type="radio" name="staffed" id="staffed" value="y" class="" <% if staffed = "y" then response.write("checked")%>>
            </li>
            <li>Yes</li>
            <li onclick="javascript:hidediv('staffing_detail');">
                <input type="radio" name="staffed" value="n" class="" <% if staffed = "n" then response.write("checked")%>>
            </li>
            <li>No</li>
        </ul>
		</p>
		<p>
        <ul id="staffing_detail" <%if staffed <> "y" then response.write("class=" & chr(34) & "hide" & chr(34))%>>
            <li>
                <label id="who_staffedLabel" for="who_staffed">To which companies did those services send you:</label>
                <textarea name="who_staffed" id="who_staffed" rows="2" cols="33"><%=who_staffed%></textarea>
            </li>
        </ul>
		</p>
		<p>

        <ul>
            <li>
                <label id="additionalInfoLabel" for="additionalInfo">Please include any additional information such as spoken languages, associations, awards, etc...</label>
            </li>
            <li>
                <textarea name="additionalInfo" id="additionalInfo" rows="3" cols="33" tabindex="18"><%=additionalInfo%></textarea>
            </li>
        </ul>
		</p>
		<p>
        <ul>
            <li>
                <label id="heardAboutUsLbl" for="heardAboutUs">How did you hear about Personnel Plus?</label>
            </li>
		
            <li>
                <textarea name="heardAboutUs" id="heardAboutUs" rows="3" cols="33" tabindex="18"><%=heardAboutUs%></textarea>
            </li>
        </ul>
		</p>
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
            <li></li>
            <li>
                <label id="ecAddressLbl" for="ecAddress" class="fieldIsGood"><span>&nbsp;</span>Address: </label>
                <input type="text" id="ecAddress" name="ecAddress" value="<%=ecAddress%>" tabindex="20">
            </li>
            <li>
                <label id="ecPhoneLbl" for="ecPhone" class="fieldIsGood"><span>&nbsp;</span>Phone: </label>
                <input type="tel" id="ecPhone" name="ecPhone" value="<%=ecPhone%>" tabindex="21">
            </li>
            <li>
                <label id="ecDoctorLbl" for="ecDoctor" class="fieldIsGood"><span>&nbsp;</span>Doctor to Notify: </label>
                <input type="text" id="ecDoctor" name="ecDoctor" value="<%=ecDoctor%>" tabindex="22">
            </li>
            <li>
                <label id="ecDocPhoneLbl" for="ecDocPhone" class="fieldIsGood"><span>&nbsp;</span>Phone: </label>
                <input type="tel" id="ecDocPhone" name="ecDocPhone" value="<%=ecDocPhone%>" tabindex="23">
            </li>
        </ol>
    </fieldset>
    <%=decorateBottom()%> <%=decorateTop("employmentReferences", "marLR10" & empapp_contacts, "References - Names of Three Persons Not Related to You")%>
    <ul>
        <li>
            <label id="referenceNameOneLabel" for="referenceNameOne" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
            <input type="text" id="referenceNameOne" name="referenceNameOne" value="<%=referenceNameOne%>" onblur="check_field('referenceNameOne')" tabindex="24">
        </li>
        <li>
            <label id="referencePhoneOneLabel" for="referencePhoneOne" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
            <input type="text" id="referencePhoneOne" name="referencePhoneOne" value="<%=referencePhoneOne%>" onblur="check_field('referencePhoneOne')" tabindex="25">
        </li>
    </ul>
    <ul>
        <li>
            <label id="referenceNameTwoLabel" for="referenceNameTwo" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
            <input type="text" id="referenceNameTwo" name="referenceNameTwo" value="<%=referenceNameTwo%>" onblur="check_field('referenceNameTwo')" tabindex="26">
        </li>
        <li>
            <label id="referencePhoneTwoLabel" for="referencePhoneTwo" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
            <input type="text" id="referencePhoneTwo" name="referencePhoneTwo" value="<%=referencePhoneTwo%>" onblur="check_field('referencePhoneTwo')" tabindex="27">
        </li>
    </ul>
    <ul>
        <li>
            <label id="referenceNameThreeLabel" for="referenceNameThree" class="fieldIsGood"><span>&nbsp;</span>First/Last Name</label>
            <input type="text" id="referenceNameThree" name="referenceNameThree" value="<%=referenceNameThree%>" onblur="check_field('referenceNameThree')" tabindex="28">
        </li>
        <li>
            <label id="referencePhoneThreeLabel" for="referencePhoneThree" class="fieldIsGood"><span>&nbsp;</span>Contact Phone #</label>
            <input type="text" id="referencePhoneThree" name="referencePhoneThree" value="<%=referencePhoneThree%>" onblur="check_field('referencePhoneThree')" tabindex="29">
        </li>
    </ul>
    <%=decorateBottom()%>
    <!--  <%=decorateTop("skillsInformationOld", "marLR10" & empapp_skills, "Skills: Select your related experience")%>
<div id="letsScroll">
         rem presentSkills() 'old list_jobskills table
		</div>

	<%=decorateBottom()%>	-->
    <%=decorateTop("skillsInformation", "marLR10" & empapp_skills, "Skills: Select your related experience <span style=""color:red"">(at least 3 required)</span>")%>
    <div id="letsScrollMore">
        <%=presentNewSkills()%>
    </div>
    <%=decorateBottom()%>

    <%=decorateTop("workhistory", "marLRB10" & empapp_workhist, "Most recent employment")%>
    <fieldset id="applicationWorkHistoryOne" class="applicationWorkHistory">
        <legend>Enter your most recent employment information below:</legend>
        <!--<label for="workhistNAOne" style="width: 32em; margin-bottom: 0.6em; font-weight: bold;">
            <input style="width: 2em; display: inline;" type="checkbox" name="workhistNAOne" id="workhistNAOne" tabindex="25" value="na" onclick="thisdoesntapply('One');">
            Check here if this section doesn't apply</label>-->
        <ol>
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
                <textarea name="jobDutiesOne" id="jobDutiesOne" tabindex="35"><%=jobDutiesOne%></textarea>
            </li>
            <li class="JobDutiesAndEnd">
                <label id="jobReasonOneLabel" for="jobReasonOne" class="fieldIsGood">Why did the work end?</label>
                <textarea name="jobReasonOne" id="jobReasonOne" tabindex="36"><%=jobReasonOne%></textarea>
            </li>
        </ol>
    </fieldset>
    <%=decorateBottom()%>

    <%=decorateTop("applicationWorkHistoryTwo", "applicationWorkHistory marLRB10" & empapp_workhist, "Second Most Recent")%>
    <fieldset id="applicationWorkHistoryTwo" class="applicationWorkHistory">
        <legend>Enter your second most recent employment information below:</legend>
        <label for="workhistNATwo" style="width: 32em; margin-bottom: 0.6em; font-weight: bold;">
            <input style="width: 2em; display: inline;" type="checkbox" name="workhistNATwo" id="workhistNATwo" tabindex="25" value="na" onclick="thisdoesntapply('Two');">
            Check here if this section doesn't apply</label>

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
                <input type="text" name="jobHistStateTwo" id="jobHistStateTwo" tabindex="40" value="<%=jobHistStateTwo%>">
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
                <input type="text" name="jobHistSupervisorTwo" id="jobHistSupervisorTwo" tabindex="43" value="<%=jobHistSupervisorTwo%>">
            </li>
            <li>
                <label id="jobHistPhoneTwoLabel" for="jobHistPhoneTwo" class="fieldIsGood">Contact Phone</label>
                <input type="text" name="jobHistPhoneTwo" id="jobHistPhoneTwo" tabindex="44" value="<%=jobHistPhoneTwo%>">
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
                <textarea name="jobDutiesTwo" id="jobDutiesTwo" tabindex="47"><%=jobDutiesTwo%></textarea>
            </li>
            <li class="JobDutiesAndEnd">
                <label id="jobReasonTwoLabel" for="jobReasonTwo" class="fieldIsGood">Why did the work end?</label>
                <textarea name="jobReasonTwo" id="jobReasonTwo" tabindex="48"><%=jobReasonTwo%></textarea>
            </li>
        </ol>
    </fieldset>
    <%=decorateBottom()%>


    <%=decorateTop("applicationWorkHistoryThree", "applicationWorkHistory marLRB10" & empapp_workhist, "Third Most Recent")%>
    <fieldset id="applicationWorkHistoryThree" class="applicationWorkHistory">
        <legend>Enter your third most recent employment information below:</legend>
        <label for="workhistNAThree" style="width: 32em; margin-bottom: 0.6em; font-weight: bold;">
            <input style="width: 2em; display: inline;" type="checkbox" name="workhistNAThree" id="workhistNAThree" tabindex="25" value="na" onclick="thisdoesntapply('Three');">
            Check here if this section doesn't apply</label>
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
                <textarea name="jobDutiesThree" id="jobDutiesThree" tabindex="59"><%=jobDutiesThree%></textarea>
            </li>
            <li class="JobDutiesAndEnd">
                <label id="jobReasonThreeLabel" for="jobReasonThree" class="fieldIsGood"><span>&nbsp;</span>Why did the work end?</label>
                <textarea name="jobReasonThree" id="jobReasonThree" tabindex="60"><%=jobReasonThree%></textarea>
            </li>
        </ol>
    </fieldset>
    <%=decorateBottom()%> <%=decorateTop("w4Supplement", "marLR10" & empapp_w4form, "Form W-4 Supplemental Information")%>
    <table class="w4">
        <tr>
            <td class="instruct"><strong>A.</strong>&nbsp;Enter "1" for <em>yourself</em> if no one else can claim you as a dependent.</td>
            <td class="exemption"><strong>A.</strong>&nbsp;
        <input type="text" id="w4a" name="w4a" value="<%=w4a%>" tabindex="14"></td>
            <% if instr(empapp_w4form, "hide") = 0 then %>
            <script type="text/javascript"><!--
    document.application.w4a.focus()
    //--></script>
            <% end if%>
        </tr>
        <tr>
            <td class="instruct"><strong>B.</strong>&nbsp;Enter "1" if:
        <ul>
            <li>You are single and have only one job; or</li>
            <li>you are married, have only one job, and your spouse does not work; or</li>
            <li>your wages from a second job or your spouse's wages (or the total of both) are $1,500 or less.</li>
        </ul>
            </td>
            <td class="exemption"><strong>B.</strong>&nbsp;
        <input type="text" id="w4b" name="w4b" value="<%=w4b%>" tabindex="14" onblur="addw4lines()"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>C</strong>.&nbsp;Enter "1" for your spouse. But, you may choose to enter "-0-" if you are married and have either a working spouse or more than one job. (Entering "-0-" may help you avoid having too little tax withheld.)</td>
            <td class="exemption"><strong>C.</strong>&nbsp;
        <input type="text" id="w4c" name="w4c" value="<%=w4c%>" tabindex="14" onblur="addw4lines()"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>D</strong>.&nbsp;Enter number of dependents (other than your spouse or yourself) you will claim on your tax return</td>
            <td class="exemption"><strong>D.</strong>&nbsp;
        <input type="text" id="w4d" name="w4d" value="<%=w4d%>" tabindex="14" onblur="addw4lines()"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>E</strong>.&nbsp;Enter &ldquo;1&rdquo; if you will file as <strong>head of household</strong> on your tax return (see conditions under Head of household above)</td>
            <td class="exemption"><strong>E.</strong>&nbsp;
        <input type="text" id="w4e" name="w4e" value="<%=w4e%>" tabindex="14" onblur="addw4lines()"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>F.</strong>&nbsp;Enter &ldquo;1&rdquo; if you have at least $1,800 of child or dependent care expenses for which you plan to claim a credit
        <ul>
            <li>(Note. Do not include child support payments. See Pub. 503, Child and Dependent Care Expenses, for details.)
            </li>
        </ul>
            </td>
            <td class="exemption"><strong>F.</strong>&nbsp;
        <input type="text" id="w4f" name="w4f" value="<%=w4f%>" tabindex="14" onblur="addw4lines()"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>G.</strong>&nbsp;Child Tax Credit (including additional child tax credit). See Pub. 972, Child Tax Credit, for more information.
        <ul>
            <li>if your total income will be less than $61,000 ($90,000 if married), enter "2" for each eligible child; then less "1" if you have three or more eligible children.</li>
            <li>if your total income will be between $61,000 and $84,000 ($90,000 and $119,000 if married), enter "1" for each eligible
            child plus "1" additional if you have six or more eligible children.</li>
        </ul>
            </td>
            <td class="exemption"><strong>G.</strong>&nbsp;
        <input type="text" id="w4g" name="w4g" value="<%=w4g%>" tabindex="14" onblur="addw4lines()"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>H.</strong>&nbsp;Add lines A through G and enter total here. (<strong>Note.</strong>
            This may be different from the number of exemptions you claim on your tax return.)
      <td class="exemption"><strong>H.</strong>&nbsp;
        <input type="text" id="w4h" name="w4h" value="<%=w4h%>" tabindex="14" readonly></td>
        </tr>
        <tr>
            <td colspan="2">
                <table class="w4whatifs">
                    <tr>
                        <td>For accuracy, <strong>complete all worksheets that apply.</strong></td>
                        <td>
                            <ul>
                                <li>If you plan to <strong>itemize or claim adjustments to income</strong> and want to reduce your withholding, see the <strong>Deductions and Adjustments Worksheet</strong> on page 2.</li>
                                <li>If you have <strong>more than one job</strong> or are <strong>married and your and your spouse both work</strong> and the combined earnings from all jobs exceed $18,000 ($32,000 if married), see the <strong>Two-Earners/Multiple Jobs Worksheet</strong> on page 2 to avoid having too little tax withheld.</li>
                                <li>If <strong>neither</strong> of the above situations applies, <strong>stop here</strong> and enter the number from line H on line 5 of Form W-4 below.</li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <fieldset id="w4oneandtwo" class="w4info">
        <legend>1. Type or print your first name and middle initial: </legend>
        <label for="firstname">First Name</label>
        <input type="text" name="firstname" id="firstname" value="<%=user_firstname%>" disabled />
        <label for="middleinit">Middle Initial</label>
        <input type="text" name="middleinit" id="middleinit" value="<%=middleinit%>" />
    </fieldset>
    <fieldset id="w4ssn" class="w4info">
        <legend>2. Your social security number </legend>
        <input type="text" name="" id="" value="<%=ssn%>" disabled />
    </fieldset>
    <fieldset id="w4info" class="w4info oneandtwo">
        <legend id="w4filingLabel">3. Please select your filing status below: </legend>
        <ol>
            <li>
                <label>
                    Single
      <input type="radio" name="w4filing" id="w4filings" value="0" onblur="check_field('w4filing');" <% if w4filing=0 then response.write "checked=""checked""" %> />
                </label>
                <label>
                    Married
      <input type="radio" name="w4filing" id="w4filingm" value="1" onblur="check_field('w4filing');" <% if w4filing=1 then response.write "checked=""checked""" %> />
                </label>
                <label>
                    Married, but withhold at higher Single rate.
      <input type="radio" name="w4filing" id="w4filingms" value="2" onblur="check_field('w4filing');" <% if w4filing=2 then response.write "checked=""checked""" %> />
                </label>
            </li>
        </ol>
        <ol>
            <li style="float: left;"><strong>4.</strong>
            <li style="display: inline">
                <label for="w4namediffers">
                    <input type="checkbox" name="w4namediffers" id="w4namediffers" value="1" <% if w4namediffers = 1 then response.write "checked=""checked""" %> />
                    If your last name differs from that shown on your social security card, check here.
                </label>
            </li>
            <li>You must call 1-800-772-1213 for a replacement card
            </li>
        </ol>
    </fieldset>

    <table class="w4">
        <tr>
            <td id="w4totalLabel"><strong>5.</strong> Total number of allowances you are claiming [from line <strong>H</strong> above <strong>or</strong> from the applicatable paper worksheet on actual paper W4 page 2]</td>
            <td class="exemption"><strong>5.</strong>&nbsp;
        <input type="text" id="w4total" name="w4total" value="<%=w4total%>" tabindex="14" onblur="check_field('w4total')"></td>
        </tr>
        <tr>
            <td><strong>6.</strong> Enter any additional dollar[$] amount, if any, you want withheld from each paycheck: </td>
            <td class="exemption"><strong>6.</strong>&nbsp;
        <input type="text" id="w4more" name="w4more" value="<%=w4more%>" tabindex="14"></td>
        </tr>
        <tr>
            <td class="instruct"><strong>7.</strong> I claim exemption from withholding for 2012, and I certify that I meet <strong>both</strong> of the following conditions for exemption.
        <ul>
            <li>Last year I had a right to a refund of <strong>all</strong> federal income tax withheld because I had <strong>no</strong> tax liability <strong>and</strong></li>
            <li>This year I expect a refund of <strong>all</strong> federal income tax withheld because I expect to have <strong>no</strong> tax liability.</li>
        </ul>
                If you meet both conditions, type "Exempt" for line 7.</td>
            <td class="exemption"><strong>7.</strong>&nbsp;
        <input type="checkbox" id="w4exempt" name="w4exempt" value="-1" <% if cbool(w4exempt) then response.write "checked=""checked""" %> tabindex="14" onchange="w4really()"></td>
        </tr>
    </table>
    <fieldset id="w4sign" class="w4info">
        <legend>Electronically complete and sign government form W-4</legend>
        <input type="checkbox" name="w4signed" id="w4signed" value="Sign" />
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

	'if len(agree2pandp)=0 or len(agree2applicant)=0 or len(agree2unemployment)=0 or len(agree2safety)=0 or len(agree2drug)=0 or len(agree2sexual)=0 then
	response.write decorateTop("unemploymentLaw", "marLR10" & empapp_legal, "Legal Stuff")
		Database.Open MySql
		'
		'if len(agree2unemployment)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='unemployment'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2unemploymentLabel">
        <input style="width: 2em;" name="agree2unemployment" id="agree2unemployment" value="agree" <%
				if len(agree2unemployment) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE THAT THE IDAHO STATE LEGISLATION AND PERSONNEL PLUS POLICIES, AS OUTLINED ON THIS DOCUMENT, WILL APPLY TO HIS/HER EMPLOYMENT WITH PERSONNEL PLUS &amp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ACCEPTANCE OF SUCH IS A CONDITION OF EMPLOYMENT WITH PERSONNEL PLUS.
    </p>
    <%
		'end if

		'if len(agree2pandp)=0 then

			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='pandp'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2pandpLabel">
        <input style="width: 2em;" name="agree2pandp" id="agree2pandp" value="agree" <%
				if len(agree2pandp) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S POLICIES AND PROCEDURES.
    </p>
    
    <%
            Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='noncompete'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2noncompeteLabel">
        <input style="width: 2em;" name="agree2noncompete" id="agree2noncompete" value="agree" <%
				if len(agree2noncompete) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS, INC.'S NON-COMPETE AGREEMENT.
    </p>
    <%
		'end if

		'if len(agree2safety)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='safety'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2safetyLabel">
        <input style="width: 2em;" name="agree2safety" id="agree2safety" value="agree" <%
				if len(agree2safety) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S SAFETY POLICY AND PROCEDURES.
    </p>
    <%
		'end if

		'if len(agree2drug)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='drug_free'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2drugLabel">
        <input style="width: 2em;" name="agree2drug" id="agree2drug" value="agree" <%
				if len(agree2drug) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S ALCOHOL AND DRUG-FREE WORKPLACE POLICY.
    </p>
    <%
		'end if

		'if len(agree2sexual)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='sexual'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2sexualLabel">
        <input style="width: 2em;" name="agree2sexual" id="agree2sexual" value="agree" <%
				if len(agree2sexual) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S SEXUAL HARASSMENT POLICY.
    </p>
    <%
		'end if

		'if len(agree2applicant)=0 then
			Set dbquery = Database.Execute("Select title, verbiage From lst_verbiage Where shortname='applicant_agree'") %>
    <h2><%=dbQuery("title")%></h2>
    <div class="legalVerbiage"><%=dbQuery("verbiage")%> </div>

    <p id="agree2applicantLabel">
        <input style="width: 2em;" name="agree2applicant" id="agree2applicant" value="agree" <%
				if len(agree2applicant) > 0 then response.write "checked=""checked"" disabled " %>type="checkbox">
        I HAVE READ AND I AGREE TO BE BOUND BY PERSONNEL PLUS INC.'S APPLICANT AGREEMENT.
    </p>
    <%
		'end if

		Database.Close %>
    <%=decorateBottom()%>
    <input id="formAction" name="formAction" type="hidden" class="hidden" value="notset">
    <input id="wheretogo" name="wheretogo" type="hidden" class="hidden" value="">
    <input id="jobid" name="jobid" type="hidden" class="hidden" value="<%=jobid%>">
    <input id="previouspart" name="previouspart" type="hidden" class="hidden" value="<%=whichpart%>">
    <input id="applicationId" name="applicationId" type="hidden" class="hidden" value="<%=applicationId%>">
    <input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">
</form>
<div id="bottomAppNav" class="buttonwrapper">
    <div id="rightAppNav"><%=app_next%></div>
    <%=send_application%>
    <div id="leftAppNav"><%=app_previous%></div>
</div>

<% noSocial = true %>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->