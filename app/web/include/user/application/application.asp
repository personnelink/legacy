<% FormPostTo = "/user/application/application.asp" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
    <!-- #include virtual="/Connections/VMS.asp" -->
    <%

const linkImgRequisition = "<img style='border:none;' src='/include/style/images/ico_requisition.gif'>"

Select Case request.form("Submit")
Case "Return To Account Home" 
	Response.Redirect("/userHome.asp")
Case "Save Application"
	saveApplication
Case Else
	showApplicationForm
End Select


if CheckForm = true And request.form("Submit") = "Create Requisition" then 
	CreateRequisition
	ShowRequisitions
elseif CheckForm = true And request.form("Submit") = "Update Requisition" then
	UpdateRequisition
	ShowRequisitions
end if


Sub showApplicationForm

dim skills
dim skills_numRows

Set skills = Server.CreateObject("ADODB.Recordset")
With skills
	.ActiveConnection = MySql
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
End With
skills_numRows = 0

dim states
dim states_numRows

Set states = Server.CreateObject("ADODB.Recordset")
With states
	.ActiveConnection = MySql
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
End With
states_numRows = 0

dim offices
dim offices_numRows

Set offices = Server.CreateObject("ADODB.Recordset")
With offices
	.ActiveConnection = MySql
	.Source = "SELECT * FROM list_offices ORDER BY office ASC"
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
	.Open()
End With
offices_numRows = 0 

Set workPreferences = Server.CreateObject("ADODB.Recordset")
With workPreferences
	.ActiveConnection = MySql
	.Source = "SELECT * FROM tbl_applicantPreferences WHERE userID = " & user_id
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
	.Open()
End With
workPreferences_numRows = 0 

Set userApplication = Server.CreateObject("ADODB.Recordset")
With userApplication	
	.ActiveConnection = MySql
	.Source = "SELECT * FROM tbl_applications WHERE userID = " & user_id
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
	.Open()
End With

if userApplication.eof = true then
	Database.Open MySql
	Database.Execute("INSERT INTO tbl_applications(userID) Values('" & user_id & "')")
	Database.Execute("INSERT INTO tbl_applicationPreferences(userID) Values('" & user_id & "')")
	Database.Close
	userApplication.Requery
	workPreferences.Requery
end if


if request.form("firstLoad") <> "false" Or request.form("submit") = "Revert Back" then
	whichOffice = workPreferences.Fields.Item("whichOffice").Value
	otherLocation = workPreferences.Fields.Item("otherLocation").Value
	workTypeDesired = workPreferences.Fields.Item("workTypeDesired").Value
	workAuth = workPreferences.Fields.Item("workAuth").Value
	workAuthProof = workPreferences.Fields.Item("workAuthProof").Value
	workAge = workPreferences.Fields.Item("workAge").Value
	desiredWageAmount = workPreferences.Fields.Item("desiredWageAmount").Value
	minWageAmount = workPreferences.Fields.Item("minWageAmount").Value
	commuteDistance = workPreferences.Fields.Item("commuteDistance").Value
	workValidLicense = workPreferences.Fields.Item("workValidLicense").Value
	workLicenseType = workPreferences.Fields.Item("workLicenseType").Value
	workRelocate = workPreferences.Fields.Item("workRelocate").Value
	workConviction = workPreferences.Fields.Item("workConviction").Value
	workConvictionExplain = workPreferences.Fields.Item("workConvictionExplain").Value
	eduLevel = workPreferences.Fields.Item("eduLevel").Value
	preferred = workPreferences.Fields.Item("preferred").Value
	additionalInfo = workPreferences.Fields.Item("additionalInfo").Value
	referenceNameOne = workPreferences.Fields.Item("referenceNameOne").Value
	referencePhoneOne = workPreferences.Fields.Item("referencePhoneOne").Value
	referenceNameTwo = workPreferences.Fields.Item("referenceNameTwo").Value
	referencePhoneTwo = workPreferences.Fields.Item("referencePhoneTwo").Value
	referenceNameThree = workPreferences.Fields.Item("referenceNameThree").Value
	referencePhoneThree = workPreferences.Fields.Item("referencePhoneThree").Value
	skillsClerical = userApplication.Fields.Item("skillsClerical").Value
	skillsCustomerSvc = userApplication.Fields.Item("skillsCustomerSvc").Value
	skillsIndustrial = userApplication.Fields.Item("skillsIndustrial").Value
	skillsGeneralLabor = userApplication.Fields.Item("skillsGeneralLabor").Value
	skillsConstruction = userApplication.Fields.Item("skillsConstruction").Value
	skillsSkilledLabor = userApplication.Fields.Item("skillsSkilledLabor").Value
	skillsBookkeeping = userApplication.Fields.Item("skillsBookkeeping").Value
	skillsSales = userApplication.Fields.Item("skillsSales").Value
	skillsManagement = userApplication.Fields.Item("skillsManagement").Value
	skillsTechnical = userApplication.Fields.Item("skillsTechnical").Value
	skillsTechnical = userApplication.Fields.Item("skillsTechnical").Value
	skillsSoftware = userApplication.Fields.Item("skillsSoftware").Value
	jobObjective = userApplication.Fields.Item("jobObjective").Value
	jobHistTitleOne = userApplication.Fields.Item("jobHistTitleOne").Value
	jobHistCpnyOne = userApplication.Fields.Item("jobHistCpnyOne").Value
	jobHistPhoneOne = userApplication.Fields.Item("jobHistPhoneOne").Value
	jobHistCityOne = userApplication.Fields.Item("jobHistCityOne").Value
	jobHistStateOne = userApplication.Fields.Item("jobHistStateOne").Value
	jobDutiesOne = userApplication.Fields.Item("jobDutiesOne").Value
	jobHistSMonthOne = DatePart("m", userApplication.Fields.Item("jobHistFromDateOne").Value)
	jobHistSYearOne = DatePart("yyyy", userApplication.Fields.Item("jobHistFromDateOne").Value)
	jobHistEMonthOne = DatePart("m", userApplication.Fields.Item("JobHistToDateOne").Value)
	jobHistEYearOne = DatePart("yyyy", userApplication.Fields.Item("JobHistToDateOne").Value)
	jobReasonOne = userApplication.Fields.Item("jobReasonOne").Value
	jobOtherReasonOne = userApplication.Fields.Item("jobOtherReasonOne").Value
	jobHistTitleTwo = userApplication.Fields.Item("jobHistTitleTwo").Value
	jobHistCpnyTwo = userApplication.Fields.Item("jobHistCpnyTwo").Value
	jobHistPhoneTwo = userApplication.Fields.Item("jobHistPhoneTwo").Value
	jobHistCityTwo = userApplication.Fields.Item("jobHistCityTwo").Value
	jobHistStateTwo = userApplication.Fields.Item("jobHistStateTwo").Value
	jobDutiesTwo = userApplication.Fields.Item("jobDutiesTwo").Value
	jobHistSMonthTwo = DatePart("m", userApplication.Fields.Item("jobHistFromDateTwo").Value)
	jobHistSYearTwo = DatePart("yyyy", userApplication.Fields.Item("jobHistFromDateTwo").Value)
	jobHistEMonthTwo = DatePart("m", userApplication.Fields.Item("JobHistToDateTwo").Value)
	jobHistEYearTwo = DatePart("yyyy", userApplication.Fields.Item("JobHistToDateTwo").Value)
	jobReasonTwo = userApplication.Fields.Item("jobReasonTwo").Value
	jobOtherReasonTwo = userApplication.Fields.Item("jobOtherReasonTwo").Value
	jobHistTitleThree = userApplication.Fields.Item("jobHistTitleThree").Value
	jobHistCpnyThree = userApplication.Fields.Item("jobHistCpnyThree").Value
	jobHistPhoneThree = userApplication.Fields.Item("jobHistPhoneThree").Value
	jobHistCityThree = userApplication.Fields.Item("jobHistCityThree").Value
	jobHistStateThree = userApplication.Fields.Item("jobHistStateThree").Value
	jobDutiesThree = userApplication.Fields.Item("jobDutiesThree").Value
	jobHistSMonthThree = DatePart("m", userApplication.Fields.Item("jobHistFromDateThree").Value)
	jobHistSYearThree = DatePart("yyyy", userApplication.Fields.Item("jobHistFromDateThree").Value)
	jobHistEMonthThree = DatePart("m", userApplication.Fields.Item("JobHistToDateThree").Value)
	jobHistEYearThree = DatePart("yyyy", userApplication.Fields.Item("JobHistToDateThree").Value)
	jobReasonThree = userApplication.Fields.Item("jobReasonThree").Value
	jobOtherReasonThree = userApplication.Fields.Item("jobOtherReasonThree").Value
Else
	whichOffice = request.form("whichOffice")
	otherLocation = request.form("otherLocation")
	workTypeDesired = request.form("workTypeDesired")
	workAuth = request.form("workAuth")
	workAuthProof = request.form("workAuthProof")
	workAge = request.form("workAge")
	commuteDistance = request.form("commuteDistance")
	desiredWageAmount = request.form("desiredWageAmount")
	minWageAmount = request.form("minWageAmount")
	workValidLicense = request.form("workValidLicense")
	workLicenseType = request.form("workLicenseType")
	workRelocate = request.form("workRelocate")
	workConviction = request.form("workConviction")
	workConvictionExplain = request.form("workConvictionExplain")
	eduLevel = request.form("eduLevel")
	preferred = request.form("preferred")
	additionalInfo = request.form("additionalInfo")
	referenceNameOne = request.form("referenceNameOne")
	referencePhoneOne = request.form("referencePhoneOne")
	referenceNameTwo = request.form("referenceNameTwo")
	referencePhoneTwo = request.form("referencePhoneTwo")
	referenceNameThree = request.form("referenceNameThree")
	referencePhoneThree = request.form("referencePhoneThree")
	skillsClerical = request.form("skillsClerical")
	skillsCustomerSvc = request.form("skillsCustomerSvc")
	skillsIndustrial = request.form("skillsIndustrial")
	skillsGeneralLabor = request.form("skillsGeneralLabor")
	skillsConstruction = request.form("skillsConstruction")
	skillsSkilledLabor = request.form("skillsSkilledLabor")
	skillsBookkeeping = request.form("skillsBookkeeping")
	skillsSales = request.form("skillsSales")
	skillsManagement = request.form("skillsManagement")
	skillsTechnical = request.form("skillsTechnical")
	skillsFoodService = request.form("skillsFoodService")
	skillsSoftware = request.form("skillsSoftware")
	jobObjective = request.form("jobObjective")
	jobHistTitleOne = request.form("jobHistTitleOne")
	jobHistCpnyOne = request.form("jobHistCpnyOne")
	jobHistPhoneOne = request.form("jobHistPhoneOne")
	jobHistCityOne = request.form("jobHistCityOne")
	jobHistStateOne = request.form("jobHistStateOne")
	jobDutiesOne = request.form("jobDutiesOne")
	jobHistSMonthOne = request.form("jobHistSMonthOne")
	jobHistSYearOne = request.form("jobHistSYearOne")
	jobHistEMonthOne = request.form("jobHistEMonthOne")
	jobHistEYearOne = request.form("jobHistEYearOne")
	jobReasonOne = request.form("jobReasonOne")
	jobOtherReasonOne = request.form("jobOtherReasonOne")
	jobHistTitleTwo = request.form("jobHistTitleTwo")
	jobHistCpnyTwo = request.form("jobHistCpnyTwo")
	jobHistPhoneTwo = request.form("jobHistPhoneTwo")
	jobHistCityTwo = request.form("jobHistCityTwo")
	jobHistStateTwo = request.form("jobHistStateTwo")
	jobDutiesTwo = request.form("jobDutiesTwo")
	jobHistSMonthTwo = request.form("jobHistSMonthTwo")
	jobHistSYearTwo = request.form("jobHistSYearTwo")
	jobHistEMonthTwo = request.form("jobHistEMonthTwo")
	jobHistEYearTwo = request.form("jobHistEYearTwo")
	jobReasonTwo = request.form("jobReasonTwo")
	jobOtherReasonTwo = request.form("jobOtherReasonTwo")
	jobHistTitleThree = request.form("jobHistTitleThree")
	jobHistCpnyThree = request.form("jobHistCpnyThree")
	jobHistPhoneThree = request.form("jobHistPhoneThree")
	jobHistCityThree = request.form("jobHistCityThree")
	jobHistStateThree = request.form("jobHistStateThree")
	jobDutiesThree = request.form("jobDutiesThree")
	jobHistSMonthThree = request.form("jobHistSMonthThree")
	jobHistSYearThree = request.form("jobHistSYearThree")
	jobHistEMonthThree = request.form("jobHistEMonthThree")
	jobHistEYearThree = request.form("jobHistEYearThree")
	jobReasonThree = request.form("jobReasonThree")
	jobOtherReasonThree = request.form("jobOtherReasonThree")
end if

%>
    <div class="sideMargin border" style="width:600;margin-left:0;margin-bottom:10;padding-left:10;padding-right:10">
      <div class="normalTitle" style="margin-left:-10;margin-right:-10;margin-bottom:10;">Online Application</div>
      <FORM name="applyDirect" method="post" action="<%=FormPostTo%>">
        <label for="offices">Select the office that is nearest to you.</label>
        <SELECT style="margin-bottom:5px" NAME="offices" SIZE="1">
          <OPTION VALUE="">-----Select Office-----</OPTION>
          <%
					do while not offices.eof %>
          <OPTION VALUE="<%=offices.Fields.Item("contact").Value%>"<%if offices.Fields.Item("contact").Value = whichOffice then response.write(" Selected")%>><%=offices.Fields.Item("office").Value%></OPTION>
          <%
						offices.Movenext
					loop 
					offices.Close %>
          <OPTION VALUE="twin@personnel.com">Other Location</OPTION>
        </SELECT>
        <br>
        if Other, please tell us where you are located?
        <input style="margin-bottom:5px" type="text" name="other_location" size="20" maxlength="75">
        <div class="normalTitle" style="margin-left:-10;margin-right:-10;margin-bottom:10;">Personal Information &amp; Preferences</div>
        <label for="workTypeDesired">What type of work do you prefer?</label>
        <select style="margin-bottom:5px" size="1" name="workTypeDesired">
          <option value="">-- Select One --</option>
          <option value="FT"<%if workTypeDesired = "FT" then response.write(" Selected")%>>Full-Time</option>
          <option value="PT"<%if workTypeDesired = "PT" then response.write(" Selected")%>>Part-Time</option>
        </select>
        <br>
        <label for="workAuth">Are you authorized to work in the U.S?</label>
        <select style="margin-bottom:5px" size="1" name="workAuth">
          <option value="">-- Select One --</option>
          <option value="Yes"<%if workAuth  = "Yes" then response.write(" Selected")%>>Yes</option>
          <option value="No"<%if workAuth  = "No" then response.write(" Selected")%>>No</option>
        </select>
        <br>
        <label for="workAuthProof">Do you have proof of authorization?</label>
        <select style="margin-bottom:5px" size="1" name="workAuthProof">
          <option value="">-- Select One --</option>
          <option value="Yes"<%if workAuthProof  = "Yes" then response.write(" Selected")%>>Yes</option>
          <option value="No"<%if workAuthProof  = "Yes" then response.write(" Selected")%>>No</option>
        </select>
        <br>
        <label for="workAge">Are you 18 years or older?</label>
        <select style="margin-bottom:5px" size="1" name="workAge">
          <option value="">-- Select One --</option>
          <option value="Yes"<%if workAge  = "Yes" then response.write(" Selected")%>>Yes</option>
          <option value="No"<%if workAge  = "Yes" then response.write(" Selected")%>>No</option>
        </select>
        <br>
        <label for="desiredWageAmount">What is your desired Salary or Wage? $</label>
        <INPUT style="margin-bottom:5px" NAME="desiredWageAmount" TYPE="text" MAXLENGTH="20" SIZE="7" value="<%=desiredWageAmount%>">
        <br>
        <label for="minWageAmount">What is the Minimum Salary or Wage that you are willing to start at? $</label>
        <INPUT style="margin-bottom:5px" NAME="minWageAmount" TYPE="text" MAXLENGTH="20" SIZE="7" value="<%=minWageAmount%>">
        <br>
        <label for="commuteDistance">How far are you willing to commute for work?</label>
        <INPUT style="margin-bottom:5px" NAME="commuteDistance" TYPE="text" MAXLENGTH="20" SIZE="7" value="<%=commuteDistance%>">
        <br>
        <label for="workValidLicense">Do you have a valid Drivers License?</label>
        <select style="margin-bottom:5px" size="1" name="workValidLicense">
          <option value="">-- Select One --</option>
          <option value="Yes"<%if workValidLicense  = "Yes" then response.write(" Selected")%>>Yes</option>
          <option value="No"<%if workValidLicense  = "Yes" then response.write(" Selected")%>>No</option>
        </select>
        <br>
        <label for="workLicenseType">What type of Commercial License, if any, do you have? (optional)</label>
        <select style="margin-bottom:5px" size="1" name="workLicenseType">
          <option value="" selected>-- Select One --</option>
          <option value="none"<%if workLicenseType  = "CDL-C" then response.write(" Selected")%>>None</option>
          <option value="CDL-C"<%if workLicenseType  = "CDL-C" then response.write(" Selected")%>>CDL-C</option>
          <option value="CDL-B"<%if workLicenseType  = "CDL-B" then response.write(" Selected")%>>CDL-B</option>
          <option value="CDL-A"<%if workLicenseType  = "CDL-A" then response.write(" Selected")%>>CDL-A</option>
        </select>
        <br>
        <label for="workRelocate">Are you planning to relocate for work?</label>
        <select style="margin-bottom:5px"  size="1" name="workRelocate">
          <option value="">-- Select One --</option>
          <option value="N/A"<%if workRelocate  = "N/A" then response.write(" Selected")%>>N/A - I already reside in Idaho</option>
          <option value="Yes"<%if workRelocate  = "Yes" then response.write(" Selected")%>>Yes - I would move to Idaho for work reasons</option>
          <option value="No"<%if workRelocate  = "No" then response.write(" Selected")%>>No - But I'd like to find work in my own state</option>
        </select>
        <br>
        <label for="workConviction">Have you ever been convicted of a felony?</label>
        <select style="margin-bottom:5px" size="1" name="workConviction">
          <option value="">-- Select One --</option>
          <option value="Yes"<%if workRelocate  = "Yes" then response.write(" Selected")%>>Yes - I have been convicted of a felony in the U.S.</option>
          <option value="No"<%if workRelocate  = "No" then response.write(" Selected")%>>No - I have never been convicted of a felony	in the U.S.</option>
        </select>
        <br>
        <label for="workConvictionExplain">if you have been convicted of a felony, please explain the circumstances?</label>
        <textarea style="margin-bottom:5px" name="workConvictionExplain" rows="2" cols="83"><%=workConvictionExplain%></textarea>
        <br>
        <label for="eduLevel">What is the Highest level of education that you completed?</label>
        <SELECT style="margin-bottom:5px" name="eduLevel">
          <option value="" selected>-- Select One --</option>
          <option value="None"<%if eduLevel  = "None" then response.write(" Selected")%>>None</option>
          <option value="GED"<%if eduLevel  = "GED" then response.write(" Selected")%>>GED</option>
          <option value="High School Diploma"<%if eduLevel  = "High School Diploma" then response.write(" Selected")%>>High School	Diploma</option>
          <option value="College Degree"<%if eduLevel  = "College Degree" then response.write(" Selected")%>>College Degree</option>
          <option value="College (No Degree)"<%if eduLevel  = "College (No Degree)" then response.write(" Selected")%>>College (No Degree)</option>
          <option value="Graduate School"<%if eduLevel  = "Graduate School" then response.write(" Selected")%>>Graduate Degree</option>
        </SELECT>
        <br>
        <label for="preferred">Do you have a Preferred employer and job title? <span style="color:#808080">(optional)</span></label>
        <TEXTAREA cols="83" rows="3" name="preferred"><%=preferred%></TEXTAREA>
        <br>
        <label for="additionalInfo">Is there any additional information you wnat to include? (spoken languages, associations, awards...) <span style="color:#808080">(optional)</span></label>
        <TEXTAREA cols="83" rows="3" name="additionalInfo"><%=additionalInfo%></TEXTAREA>
        <br>
        <TABLE style="width:605px;padding:0;border:none" >
          <tr>
            <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="12"></td>
          </tr>
          <tr>
            <td colspan="4" align="center"><strong>Please list three Work References below.</strong></td>
          </tr>
          <tr>
            <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="6"></td>
          </tr>
          <tr>
            <td align="right">First/Last Name:&nbsp;&nbsp;</td>
            <td><input type="text" name="referenceNameOne" size="30" maxlength="255" value="<%=referenceNameOne%>"></td>
            <td align="right">Contact Phone #:&nbsp;&nbsp;</td>
            <td align="left"><input type="text" name="referencePhoneOne" size="20" maxlength="20" value="<%=referencePhoneOne%>"></td>
          </tr>
          <tr>
            <td align="right">First/Last Name:&nbsp;&nbsp;</td>
            <td><input type="text" name="referenceNameTwo" size="30" maxlength="255" value="<%=referenceNameTwo%>"></td>
            <td align="right">Contact Phone #:&nbsp;&nbsp;</td>
            <td align="left"><input type="text" name="referencePhoneTwo" size="20" maxlength="20" value="<%=referencePhoneTwo%>"></td>
          </tr>
          <tr>
            <td align="right">First/Last Name:&nbsp;&nbsp;</td>
            <td><input type="text" name="referenceNameThree" size="30" maxlength="255" value="<%=referenceNameThree%>"></td>
            <td align="right">Contact Phone #:&nbsp;&nbsp;</td>
            <td align="left"><input type="text" name="referencePhoneThree" size="20" maxlength="20" value="<%=referencePhoneThree%>"></td>
          </tr>
          <tr>
            <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="12"></td>
          </tr>
        </table>
        </td>
        </tr>
        <tr>
          <td colspan="2" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="12"></td>
        </tr>
        </table>
        <div class="normalTitle" style="margin-left:-10;margin-right:-10;margin-bottom:10;">Skills &amp; Work History</div>
        <TABLE style="width:605px;padding:0;border:none" >
          <tr>
            <td colspan="2" align="center"><span style="font:small">To select more than one skill, press and hold the [CTRL] key while clicking with your mouse.</span></td>
          </tr>
          <tr>
            <td colspan="2" align="center" width="100%"><table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                  <td align="center" width="25%"><strong>Clerical</strong></td>
                  <td align="center" width="25%"><strong>Customer Service</strong></td>
                  <td align="center" width="25%"><strong>Industrial</strong></td>
                  <td align="center" width="25%"><strong>General Labor</strong></td>
                </tr>
                <tr>
                  <td align="center" valign="top"><select multiple size="6" name="skillsClerical">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT clerical FROM list_skills WHERE clerical IS NOT NULL ORDER BY clerical ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("clerical").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsClerical, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td align="center" valign="top"><select multiple size="6" name="skillsCustomerSvc">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT customerService FROM list_skills WHERE customerService IS NOT NULL ORDER BY customerService ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("customerService").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsCustomerSvc, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td align="center" valign="top"><select multiple size="6" name="skillsIndustrial">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT industrial FROM list_skills WHERE industrial IS NOT NULL ORDER BY industrial ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("industrial").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsIndustrial, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td align="center" valign="top"><select multiple size="6" name="skillsGeneralLabor">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT generalLabor FROM list_skills WHERE generalLabor IS NOT NULL ORDER BY generalLabor ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("generalLabor").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsGeneralLabor, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td align="center"><strong>Construction</strong></td>
                  <td align="center"><strong>Skilled Labor</strong></td>
                  <td align="center"><strong>Bookkeeping</strong></td>
                  <td align="center"><strong>Sales</strong></td>
                </tr>
                <tr>
                  <td align="center" valign="top"><select multiple size="6" name="skillsConstruction">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT construction FROM list_skills WHERE construction IS NOT NULL ORDER BY construction ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("construction").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsConstruction, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td valign="top" align="center"><select multiple size="6" name="skillsSkilledLabor">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT skilledLabor FROM list_skills WHERE skilledLabor IS NOT NULL ORDER BY skilledLabor ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("skilledLabor").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsSkilledLabor, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td valign="top" align="center"><select multiple size="6" name="skillsBookkeeping">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT bookkeeping FROM list_skills WHERE bookkeeping IS NOT NULL ORDER BY bookkeeping ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("bookkeeping").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsBookkeeping, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td valign="top" align="center"><select multiple size="6" name="skillsSales">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT sales FROM list_skills WHERE sales IS NOT NULL ORDER BY sales ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("sales").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsSales, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td align="center"><strong>Management</strong></td>
                  <td align="center"><strong>Technical</strong></td>
                  <td align="center"><strong>Food Service</strong></td>
                  <td align="center"><strong>Software Used</strong></td>
                </tr>
                <tr>
                  <td align="center" valign="top"><select multiple size="6" name="skillsManagement">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT management FROM list_skills WHERE management IS NOT NULL ORDER BY management ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("management").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsManagement, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td align="center" valign="top"><select multiple size="6" name="skillsTechnical">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT technical FROM list_skills WHERE technical IS NOT NULL ORDER BY technical ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("technical").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsTechnical, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td align="center" valign="top"><select multiple size="6" name="skillsFoodService">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT foodService FROM list_skills WHERE foodService IS NOT NULL ORDER BY foodService ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("foodService").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsFoodService, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                  <td valign="top" align="center"><select multiple size="6" name="skillsSoftware">
                      <option value="Chose None">- Select all that apply -</option>
                      <%
						skills.Source = "SELECT software FROM list_skills WHERE software IS NOT NULL ORDER BY software ASC"
						skills.Open
						do while not skills.eof
							skill = skills.Fields.Item("software").Value %>
                      <OPTION VALUE="<%=skill%>"<%if Instr(skillsSoftware, skill) > 0 then response.write(" Selected")%>><%=skill%></OPTION>
                      <%
							skills.Movenext
						loop
						skills.Close %>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><strong>Job Objective(s) and Work Summary</strong></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><TEXTAREA cols="83" rows="3" name="jobObjective"><%=jobObjective%></TEXTAREA>
                  </td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="20"></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><strong>Present or most recent employer</strong> </td>
                </tr>
                <tr>
                  <td colspan="4" align="center" width="100%"><table cellpadding="2" cellspacing="0">
                      <tr>
                        <td align="right" width="50%"> Job Title: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="60" maxlength="50" name="jobHistTitleOne" value="<%=jobHistTitleOne%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> Company Name: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="60" maxlength="50" name="jobHistCpnyOne" value="<%=jobHistCpnyOne%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> Phone #: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="12" maxlength="15" name="jobHistPhoneOne" value="<%=jobHistPhoneOne%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> City: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="14" maxlength="30" name="jobHistCityOne" value="<%=jobHistCityOne%>">
                          State:
                          <SELECT style="margin-bottom:5px" NAME="jobHistStateOne">
                            <option value="Chose None">----</option>
                            <%
						states.Source = "SELECT locCode, locName FROM list_locations WHERE display = 'Y' ORDER BY locName ASC"
						states.Open
						do while not states.eof
                            selectedState = states.Fields.Item("locCode").Value %>
							<OPTION VALUE="<%=selectedState%>"<%if selectedState = jobHistStateOne then response.write(" Selected")%>><%=states.Fields.Item("locName").Value%></OPTION>
                            <%
							states.Movenext
						loop
						states.Close %>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td align="right" width="50%" valign="top">Job Duties: </td>
                        <td><TEXTAREA style="margin-bottom:5px" cols="43" rows="2" name="jobDutiesOne"><%=jobDutiesOne%></TEXTAREA></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%">From Date:
                          <SELECT style="margin-bottom:5px" name="jobHistSMonthOne" style="font-size: 9pt;">
                          <option value="" selected>----</option>
                          <%
		For i = 1 to 12 %>
                          <option value="<%=i%>"<%if i = jobHistSMonthOne then response.write(" Selected")%>><%=MonthName(i)%></option>
                          <%
		Next %>
                          </SELECT>
                          <SELECT style="margin-bottom:5px" name="jobHistSYearOne" style="font-size: 9pt;">
                          <option value="" selected>----</option>
                          <%
		For i = Year(Date) to 1969 Step -1 %>
                          <option value="<%=i%>"<%if i = jobHistSYearOne then response.write(" Selected")%>><%=i%></option>
                          <%
		Next %>
                          </SELECT>
                          &nbsp;&nbsp; </td>
                        <td>To Date:
                          <SELECT style="margin-bottom:5px" name="jobHistEMonthOne" style="font-size: 9pt;">
                          <option value="" selected>----</option>
                          <%
		For i = 1 to 12 %>
                          <option value="<%=i%>"<%if i = jobHistSYearOne then response.write(" Selected")%>><%=MonthName(i)%></option>
                          <%
		Next %>
                          </SELECT>
                          <SELECT style="margin-bottom:5px" name="jobHistEYearOne" style="font-size: 9pt;">
                          <option value="" selected>----</option>
                          <%
		For i = Year(Date) to 1969 Step -1 %>
                          <option value="<%=i%>"<%if i = jobHistSYearOne then response.write(" Selected")%>><%=i%></option>
                          <%
		Next %>
                          </SELECT>
                        </td>
                      </tr>
                      <tr>
                        <td align="right" width="50%">Reason For Leaving: </td>
                        <td><SELECT style="margin-bottom:5px" name="jobReasonOne">
                            <option value="None"<%if jobReasonOne = "None" then response.write(" Selected")%>>- Select Reason -</option>
                            <option value="Assignment ended"<%if jobReasonOne = "Assignment ended" then response.write(" Selected")%>>Assignment ended</option>
                            <option value="Relocated"<%if jobReasonOne = "Relocated" then response.write(" Selected")%>>Relocated</option>
                            <option value="Found a better job"<%if jobReasonOne = "Found a better job" then response.write(" Selected")%>>Found a better Job</option>
                            <option value="Layoff"<%if jobReasonOne = "Layoff" then response.write(" Selected")%>>Layoff</option>
                            <option value="Medical / Health"<%if jobReasonOne = "Medical / Health" then response.write(" Selected")%>>Medical / Health</option>
                            <option value="Terminated"<%if jobReasonOne = "Terminated" then response.write(" Selected")%>>Terminated</option>
                            <option value="Other"<%if jobReasonOne = "Other" then response.write(" Selected")%>>* Other Reason -&gt;</option>
                          </SELECT>
                          &nbsp;<em>Other Reason</em>:
                          <input style="margin-bottom:5px" type="text" name="jobOtherReasonOne" size="60" maxlength="255">
                        </td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="20"></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><strong>2nd most recent employer </strong> </td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><table cellpadding="2" cellspacing="0">
                      <tr>
                        <td align="right" width="50%"> Job Title: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="60" maxlength="50" name="jobHistTitleTwo" value="<%=jobHistTitleTwo%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> Company Name: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="60" maxlength="50" name="jobHistCpnyTwo" value="<%=jobHistCpnyTwo%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> Phone #: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="12" maxlength="15" name="jobHistPhoneTwo" value="<%=jobHistPhoneTwo%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> City: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="14" maxlength="30" name="jobHistCityTwo" value="<%=jobHistCityTwo%>">
                          State:
                          <SELECT style="margin-bottom:5px" NAME="jobHistStateTwo">
                            <option value="Chose None">----</option>
                            <%
						states.Source = "SELECT locCode, locName FROM list_locations WHERE display = 'Y' ORDER BY locName ASC"
						states.Open
						do while not states.eof 
							workState = states.Fields.Item("locCode").Value %>
                            <OPTION VALUE="<%=workState%>"<%if workState = jobHistStateTwo then response.write(" Selected")%>><%=states.Fields.Item("locName").Value%></OPTION>
                            <%
							states.Movenext
						loop
						states.Close %>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td align="right" width="50%" valign="top">Job Duties: </td>
                        <td><TEXTAREA style="margin-bottom:5px" cols="43" rows="2" name="jobDutiesTwo"><%=jobDutiesTwo%></TEXTAREA></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%">From Date:
                          <SELECT style="margin-bottom:5px" name="jobHistSMonthTwo" style="font-size: 9pt;">
                          <option value="">----</option>
                          <%
		For i = 1 to 12 %>
                          <option value="<%=i%>"<%if i = jobHistSMonthTwo then response.write(" Selected")%>><%=MonthName(i)%></option>
                          <%
		Next %>
                          </SELECT>
                          <SELECT style="margin-bottom:5px" name="jobHistSYearTwo" style="font-size: 9pt;">
                          <option value="Chose None">----</option>
                          <%
		For i = Year(Date) to 1969 Step -1 %>
                          <option value="<%=i%>"<%if i = jobHistSYearTwo then response.write(" Selected")%>><%=i%></option>
                          <%
		Next %>
                          </SELECT>
                          &nbsp;&nbsp; </td>
                        <td>To Date:
                          <SELECT style="margin-bottom:5px" name="jobHistEMonthTwo" style="font-size: 9pt;">
                          <option value="">----</option>
                          <%
		For i = 1 to 12 %>
                          <option value="<%=i%>"<%if i = jobHistEMonthTwo then response.write(" Selected")%>><%=MonthName(i)%></option>
                          <%
		Next %>
                          </SELECT>
                          <SELECT style="margin-bottom:5px" name="jobHistEYearTwo" style="font-size: 9pt;">
                          <option value="">----</option>
                          <%
		For i = Year(Date) to 1969 Step -1 %>
                          <option value="<%=i%>"<%if i = jobHistEYearTwo then response.write(" Selected")%>><%=i%></option>
                          <%
		Next %>
                          </SELECT>
                        </td>
                      </tr>
                      <tr>
                        <td align="right" width="50%">Reason For Leaving: </td>
                        <td><SELECT style="margin-bottom:5px" name="jobReasonTwo">
                            <option value="None"<%if jobReasonTwo = "None" then response.write(" Selected")%>>- Select Reason -</option>
                            <option value="Assignment ended"<%if jobReasonTwo = "Assignment ended" then response.write(" Selected")%>>Assignment ended</option>
                            <option value="Relocated"<%if jobReasonTwo = "Relocated" then response.write(" Selected")%>>Relocated</option>
                            <option value="Found a better job"<%if jobReasonTwo = "Found a better job" then response.write(" Selected")%>>Found a better Job</option>
                            <option value="Layoff"<%if jobReasonTwo = "Layoff" then response.write(" Selected")%>>Layoff</option>
                            <option value="Medical / Health"<%if jobReasonTwo = "Medical / Health" then response.write(" Selected")%>>Medical / Health</option>
                            <option value="Terminated"<%if jobReasonTwo = "Terminated" then response.write(" Selected")%>>Terminated</option>
                            <option value="Other"<%if jobReasonTwo = "Other" then response.write(" Selected")%>>* Other Reason -&gt;</option>
                          </SELECT>
                          &nbsp;<em>Other Reason</em>:
                          <input style="margin-bottom:5px" type="text" name="jobOtherReasonTwo" size="60" maxlength="255" value="<%=jobOtherReasonTwo%>">
                        </td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="20"></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><strong>3rd most recent employer</strong> </td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><table cellpadding="2" cellspacing="0">
                      <tr>
                        <td align="right" width="50%"> Job Title: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="60" maxlength="50" name="jobHistTitleThree" value="<%=jobHistTitleThree%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> Company Name: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="60" maxlength="50" name="jobHistCpnyThree" value="<%=jobHistCpnyThree%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> Phone #: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="12" maxlength="15" name="jobHistPhoneThree" value="<%=jobHistPhoneThree%>"></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%"> City: </td>
                        <td><INPUT style="margin-bottom:5px" type="text" size="14" maxlength="30" name="jobHistCityThree" value="<%=jobHistCityThree%>">
                          State:
                          <SELECT style="margin-bottom:5px" NAME="jobHistStateTwo">
                            <option value="Chose None">----</option>
                            <%
						states.Source = "SELECT locCode, locName FROM list_locations WHERE display = 'Y' ORDER BY locName ASC"
						states.Open
						do while not states.eof 
                            workState = states.Fields.Item("locCode").Value %>
							<OPTION VALUE="<%=workState%>"<%if workState = jobHistStateTwo then response.write(" Selected")%>><%=states.Fields.Item("locName").Value%></OPTION>
                            <%
							states.Movenext
						loop
						states.Close %>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td align="right" width="50%" valign="top">Job Duties: </td>
                        <td><TEXTAREA style="margin-bottom:5px" cols="43" rows="2" name="jobDutiesThree"><%=jobDutiesThree%></TEXTAREA></td>
                      </tr>
                      <tr>
                        <td align="right" width="50%">From Date:
                          <SELECT style="margin-bottom:5px" name="jobHistSMonthThree" style="font-size: 9pt;">
                          <option value="Chose None">----</option>
                          <%
		For i = 1 to 12 %>
                          <option value="<%=i%>"<%if i = jobHistSMonthThree then response.write(" Selected")%>><%=MonthName(i)%></option>
                          <%
		Next %>
                          </SELECT>
                          <SELECT style="margin-bottom:5px" name="jobHistSYearThree" style="font-size: 9pt;">
                          <option value="Chose None">----</option>
                          <%
		For i = Year(Date) to 1969 Step -1 %>
                          <option value="<%=i%>"<%if i = jobHistSYearThree then response.write(" Selected")%>><%=i%></option>
                          <%
		Next %>
                          </SELECT>
                        </td>
                        <td>To Date:
                          <SELECT style="margin-bottom:5px" name="jobHistEMonthThree" style="font-size: 9pt;">
                          <option value="">----</option>
                          <%
		For i = 1 to 12 %>
                          <option value="<%=i%>"<%if i = jobHistEMonthThree then response.write(" Selected")%>><%=MonthName(i)%></option>
                          <%
		Next %>
                          </SELECT>
                          <SELECT style="margin-bottom:5px" name="jobHistEYearThree" style="font-size: 9pt;">
                          <option value="">----</option>
                          <%
		For i = Year(Date) to 1969 Step -1 %>
                          <option value="<%=i%>"<%if i = jobHistEYearThree then response.write(" Selected")%>><%=i%></option>
                          <%
		Next %>
                          </SELECT>
                        </td>
                      </tr>
                      <tr>
                        <td align="right" width="50%">Reason For Leaving: </td>
                        <td><SELECT style="margin-bottom:5px" name="jobReasonThree">
                            <option value="None"<%if jobReasonThree = "None" then response.write(" Selected")%>>- Select Reason -</option>
                            <option value="Assignment ended"<%if jobReasonThree = "Assignment ended" then response.write(" Selected")%>>Assignment ended</option>
                            <option value="Relocated"<%if jobReasonThree = "Relocated" then response.write(" Selected")%>>Relocated</option>
                            <option value="Found a better job"<%if jobReasonThree = "Found a better job" then response.write(" Selected")%>>Found a better Job</option>
                            <option value="Layoff"<%if jobHistSYearOne = "Layoff" then response.write(" Selected")%>>Layoff</option>
                            <option value="Medical / Health"<%if jobReasonThree = "Medical / Health" then response.write(" Selected")%>>Medical / Health</option>
                            <option value="Terminated"<%if jobReasonThree = "Terminated" then response.write(" Selected")%>>Terminated</option>
                            <option value="Other"<%if jobReasonThree = "Other" then response.write(" Selected")%>>* Other Reason -&gt;</option>
                          </SELECT>
                          &nbsp;<em>Other Reason</em>:
                          <input style="margin-bottom:5px" type="text" name="jobOtherReasonThree" size="60" maxlength="255" value="<%=jobOtherReasonThree%>">
                        </td>
                      </tr>
                    </table></td>
                </tr>
                <!-- END Work Hist 3 -->
                <tr>
                  <td colspan="4" align="center"><img src="/include/content/images/legacy/img/spacer.gif" alt="" width="2" height="12"></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td colspan="2" align="center" valign="top"><span style="font-size:9px">I agree that my employment with Personnel Plus may be terminated at any time with liability to me for wages or salary except such as may have been earned at the date of such termination. I understand that my compensation from Personnel Plus shall be limited to the duration of any temporary assignment hereunder. I agree that if at any time I sustain a work-related injury, I will submit myself to a drug/alcohol test and to an examination by a physician of the company's selection. </span> </td>
          </tr>
        </TABLE>
        <p style="text-align:center"> <br>
          <input type="hidden" name="firstLoad" value="false">
          <INPUT TYPE="submit" name="submit" class="normalbtn" VALUE="Return To Account Home">
          <INPUT TYPE="submit" name="submit" class="normalbtn" VALUE="Revert Back">
          <INPUT TYPE="submit" name="submit" class="normalbtn" VALUE="Save Application">
        </p>
        <br>
        </td>
        </tr>
      </FORM>
      </table>
    </div>
    <%
End Sub

Sub saveApplication
	whichOffice = request.form("whichOffice")
	otherLocation = request.form("otherLocation")
	workTypeDesired = request.form("workTypeDesired")
	workAuth = request.form("workAuth")
	workAuthProof = request.form("workAuthProof")
	workAge = request.form("workAge")
	commuteDistance = request.form("commuteDistance")
	desiredWageAmount = request.form("desiredWageAmount")
	minWageAmount = request.form("minWageAmount")
	workValidLicense = request.form("workValidLicense")
	workLicenseType = request.form("workLicenseType")
	workRelocate = request.form("workRelocate")
	workConviction = request.form("workConviction")
	workConvictionExplain = request.form("workConvictionExplain")
	eduLevel = request.form("eduLevel")
	preferred = request.form("preferred")
	additionalInfo = request.form("additionalInfo")
	referenceNameOne = request.form("referenceNameOne")
	referencePhoneOne = request.form("referencePhoneOne")
	referenceNameTwo = request.form("referenceNameTwo")
	referencePhoneTwo = request.form("referencePhoneTwo")
	referenceNameThree = request.form("referenceNameThree")
	referencePhoneThree = request.form("referencePhoneThree")
	skillsClerical = request.form("skillsClerical")
	skillsCustomerSvc = request.form("skillsCustomerSvc")
	skillsIndustrial = request.form("skillsIndustrial")
	skillsGeneralLabor = request.form("skillsGeneralLabor")
	skillsConstruction = request.form("skillsConstruction")
	skillsSkilledLabor = request.form("skillsSkilledLabor")
	skillsBookkeeping = request.form("skillsBookkeeping")
	skillsSales = request.form("skillsSales")
	skillsManagement = request.form("skillsManagement")
	skillsTechnical = request.form("skillsTechnical")
	skillsFoodService = request.form("skillsFoodService")
	skillsSoftware = request.form("skillsSoftware")
	jobObjective = request.form("jobObjective")
	jobHistTitleOne = request.form("jobHistTitleOne")
	jobHistCpnyOne = request.form("jobHistCpnyOne")
	jobHistPhoneOne = request.form("jobHistPhoneOne")
	jobHistCityOne = request.form("jobHistCityOne")
	jobHistStateOne = request.form("jobHistStateOne")
	jobDutiesOne = request.form("jobDutiesOne")
	jobHistSMonthOne = request.form("jobHistSMonthOne")
	jobHistSYearOne = request.form("jobHistSYearOne")
	jobHistEMonthOne = request.form("jobHistEMonthOne")
	jobHistEYearOne = request.form("jobHistEYearOne")
	jobReasonOne = request.form("jobReasonOne")
	jobOtherReasonOne = request.form("jobOtherReasonOne")
	jobHistTitleTwo = request.form("jobHistTitleTwo")
	jobHistCpnyTwo = request.form("jobHistCpnyTwo")
	jobHistPhoneTwo = request.form("jobHistPhoneTwo")
	jobHistCityTwo = request.form("jobHistCityTwo")
	jobHistStateTwo = request.form("jobHistStateTwo")
	jobDutiesTwo = request.form("jobDutiesTwo")
	jobHistSMonthTwo = request.form("jobHistSMonthTwo")
	jobHistSYearTwo = request.form("jobHistSYearTwo")
	jobHistEMonthTwo = request.form("jobHistEMonthTwo")
	jobHistEYearTwo = request.form("jobHistEYearTwo")
	jobReasonTwo = request.form("jobReasonTwo")
	jobOtherReasonTwo = request.form("jobOtherReasonTwo")
	jobHistTitleThree = request.form("jobHistTitleThree")
	jobHistCpnyThree = request.form("jobHistCpnyThree")
	jobHistPhoneThree = request.form("jobHistPhoneThree")
	jobHistCityThree = request.form("jobHistCityThree")
	jobHistStateThree = request.form("jobHistStateThree")
	jobDutiesThree = request.form("jobDutiesThree")
	jobHistSMonthThree = request.form("jobHistSMonthThree")
	jobHistSYearThree = request.form("jobHistSYearThree")
	jobHistEMonthThree = request.form("jobHistEMonthThree")
	jobHistEYearThree = request.form("jobHistEYearThree")
	jobReasonThree = request.form("jobReasonThree")
	jobOtherReasonThree = request.form("jobOtherReasonThree")
	
	sqlInformation = "Update tbl_applicantPreferences Set whichOffice='" & _
	Replace(whichOffice, "'", "''") & "', otherLocation='" & _
	Replace(otherLocation, "'", "''") & "', workTypeDesired='" & _
	Replace(workTypeDesired, "'", "''") & "', workAuth='" & _
	Replace(workAuth, "'", "''") & "', workAuthProof='" & _
	Replace(workAuthProof, "'", "''") & "', workAge='" & _
	Replace(workAge, "'", "''") & "', wageType='" & _
	Replace(wageType, "'", "''") & "', desiredWageAmount='" & _
	Replace(desiredWageAmount, "'", "''") & "', minWageAmount='" & _
	Replace(minWageAmount, "'", "''") & "', commuteDistance='" & _
	Replace(commuteDistance, "'", "''") & "', workValidLicense='" & _
	Replace(workValidLicense, "'", "''") & "', workLicenseType='" & _
	Replace(workLicenseType, "'", "''") & "', workRelocate='" & _
	Replace(workRelocate, "'", "''") & "', workConviction='" & _
	Replace(workConviction, "'", "''") & "', workConvictionExplain='" & _
	Replace(workConvictionExplain, "'", "''") & "', eduLevel='" & _
	Replace(eduLevel, "'", "''") & "', preferred='" & _
	Replace(preferred, "'", "''") & "', additionalInfo='" & _
	Replace(additionalInfo, "'", "''") & "', referenceNameOne='" & _
	Replace(referenceNameOne, "'", "''") & "', referencePhoneOne='" & _
	Replace(referencePhoneOne, "'", "''") & "', referenceNameTwo='" & _
	Replace(referenceNameTwo, "'", "''") & "', referencePhoneTwo='" & _
	Replace(referencePhoneTwo, "'", "''") & "', referenceNameThree='" & _
	Replace(referenceNameThree, "'", "''") & "', referencePhoneThree='" & _
	Replace(referencePhoneThree, "'", "''") & "', dateCreated='" & _
	Now() & "' Where userID=" & user_id
	
	Database.Open MySql
	Database.Execute(sqlInformation)
	Database.Close
End Sub %>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
