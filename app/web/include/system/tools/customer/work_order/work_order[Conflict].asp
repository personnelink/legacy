<%
session("add_css") = "./work_order.asp.css"
session("page_title") = "Work Order"
session("no-auth") = false
session("window_page_title") = "Order Candidates - Personnel Plus"

dim formAction
formAction = Request.Form("formAction")

if formAction = "send" then session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<script type="text/javascript">

function sendInfo(){	
	document.opportunityform.formAction.value='send';
	document.opportunityform.submit();
}
</script>
<% 
If formAction = "send" Then
	
	
	dim rf_company
	dim rf_name
	dim rd_phone
	dim rf_email
	dim rd_address
	dim rf_city
	dim rf_state
	dim rf_zip
	dim rf_jobtitle
	
	rf_company = request.form("company")
	rf_name = request.form("name")
	rf_phone = request.form("phone")
	rf_email = request.form("email")
	rf_address = request.form("address")
	rf_city = request.form("city")
	rf_state = request.form("state")
	rf_zip = request.form("zip")
	
	rf_jobtitle = request.form("jobtitle")
	rf_salaryrange = request.form("salaryrange")
	rf_education = request.form("education")
	rf_experience = request.form("experience")
	rf_description = request.form("description")
	rf_contacttime = request.form("contacttime")
	
	Database.Open MySql
	
	dim deliveryLocation
	Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & rf_zip & "'")
	if Not dbQuery.eof then
		deliveryLocation = dbQuery("email")
	Else
		deliveryLocation = "twinfalls@personnel.com"
	end if

	Set dbQuery = Database.Execute("Select subject, body From email_templates Where template='findCandidate'")

	dim msgSubject
	msgSubject = dbQuery("subject")
	msgSubject = replace(msgSubject, "%jobtitle%", rf_jobtitle)
	
	dim msgBody
	msgBody = dbQuery("body")
	msgBody = replace(msgBody, "%company%", rf_company)
	msgBody = replace(msgBody, "%name%", rf_name)
	msgBody = replace(msgBody, "%phone%", rf_phone)
	msgBody = replace(msgBody, "%email%", rf_email)
	msgBody = replace(msgBody, "%address%", rf_address)
	msgBody = replace(msgBody, "%city%", rf_city)
	msgBody = replace(msgBody, "%state%", rf_state)
	msgBody = replace(msgBody, "%zip%", rf_zip)

	msgBody = replace(msgBody, "%jobtitle%", rf_jobtitle)
	msgBody = replace(msgBody, "%salaryrange%", rf_salaryrange)
	msgBody = replace(msgBody, "%education%", rf_education)
	msgBody = replace(msgBody, "%experience%", rf_experience)
	msgBody = replace(msgBody, "%description%", rf_description)
	msgBody = replace(msgBody, "%contacttime%", rf_contacttime)
	
	msgBody = Server.HTMLEncode(msgBody)
	if Err.Number = 0 then
		Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")
	else
		Call SendEmail ("debug@personnel.com", system_email, "Debug: " & Err.Number & " : " & msgSubject, msgBody, "")
	end if
	 
	Set dbQuery = Nothing
	Response.Redirect("/include/content/home.asp?AST=lc")
End If

leftSideMenu = "" &_
	"<div class=""notes"" style=""margin-top:1em;"">" &_
      "<h4> Candidates! </h4>" &_
      "<p class=""last"">* Not just a staffing agency, your total staffing solution</p>" &_
    "</div>"

%>
  <%=decorateTop("locateCandidate", "", "Order Candidates")%>
  
  <div id="employmentopportunity">
    <div  class="notes" id="instructions" style="float:right;width:24em;margin:2em 3em"><p>Use this form  to submit work requests.</p><p>Once submitted, a work order will be dispatched to the nearest branch office for processing.</p>

<p style="color:red"><i>In case of Fire-Police-Ambulance emergencies, DIAL 911.</i></p>

<p>You will receive an email with the Work Order number and be contacted by a member of our team. If you have any questions, please <a href="/include/content/contact.asp" alt="Contact Us">contact us</a>.</p>
</div>
    <form name="opportunityform" id="opportunityform" method="post" action="<%=aspPageName%>">
     
	  <input name="formAction" value="submit" type="hidden">
	  <table border="0" cellpadding="0" cellspacing="4">
	    <tbody>
	      <tr>
	        <td><strong>Your Information</strong></td>
          </tr>
          <tr>
            <td>Supervisor's Name:</td></tr><tr>
            <td><input name="name" id="name" size="38" maxlength="50" type="text" /></td>
          </tr>
          <tr>
            <td>Worksite Address:</td></tr><tr>
            <td><input name="address" id="address" size="38" maxlength="75" type="text" /></td>
          </tr>
          <tr>
            <td>City:</td></tr><tr>
            <td>
			
			<input name="city" id="city" size="38" maxlength="50" type="text" /></td>
          </tr>
          <tr>
            <td>State: </td></tr><tr>
            <td valign="top" align="left"><select name="state">
                <option value="AL">Alabama</option>
                <option value="AK">Alaska</option>
                <option value="AZ">Arizona</option>
                <option value="AR">Arkansas</option>
                <option value="CA">California</option>
                <option value="CO">Colorado</option>
                <option value="CT">Connecticut</option>
                <option value="DE">Delaware</option>
                <option value="DC">District of Columbia</option>
                <option value="FL">Florida</option>
                <option value="GA">Georgia</option>
                <option value="HI">Hawaii</option>
                <option value="ID" selected="selected">Idaho</option>
                <option value="IL">Illinois</option>
                <option value="IN">Indiana</option>
                <option value="IA">Iowa</option>
                <option value="KS">Kansas</option>
                <option value="KY">Kentucky</option>
                <option value="LA">Louisiana</option>
                <option value="ME">Maine</option>
                <option value="MD">Maryland</option>
                <option value="MA">Massachusetts</option>
                <option value="MI">Michigan</option>
                <option value="MN">Minnesota</option>
                <option value="MS">Mississippi</option>
                <option value="MO">Missouri</option>
                <option value="MT">Montana</option>
                <option value="NE">Nebraska</option>
                <option value="NV">Nevada</option>
                <option value="NH">New Hampshire</option>
                <option value="NJ">New Jersey</option>
                <option value="NM">New Mexico</option>
                <option value="NY">New York</option>
                <option value="NC">North Carolina</option>
                <option value="ND">North Dakota</option>
                <option value="OH">Ohio</option>
                <option value="OK">Oklahoma</option>
                <option value="OR">Oregon</option>
                <option value="PA">Pennsylvania</option>
                <option value="RI">Rhode Island</option>
                <option value="SC">South Carolina</option>
                <option value="SD">South Dakota</option>
                <option value="TN">Tennessee</option>
                <option value="TX">Texas</option>
                <option value="UT">Utah</option>
                <option value="VT">Vermont</option>
                <option value="VA">Virginia</option>
                <option value="WA">Washington</option>
                <option value="WV">West Virginia</option>
                <option value="WI">Wisconsin</option>
                <option value="WY">Wyoming</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Zip:</td></tr><tr>
            <td><input name="zip" id="zip" size="8" maxlength="12" type="text" /></td>
          </tr>
          <tr>
            <td>Email Address:</td></tr><tr>
            <td><input name="email" id="email" size="38" maxlength="50" type="text" /></td>
          </tr>
          <tr>
            <td>Phone Number:</td></tr><tr>
            <td><input name="phone" id="phone" size="15" maxlength="15" type="text" />
            </td>
          </tr>
        </tbody>
      </table><br>
	  <table border="0" cellpadding="0" cellspacing="4">
        <tbody>
          <tr>
            <td colspan="2"><strong>Open Position Information</strong></td>
          </tr>
          <tr>
            <td>Job Title:</td></tr><tr>
            <td><input name="jobtitle" id="jobtitle" size="38" maxlength="50" type="text" /></td>
          </tr>
          <tr>
            <td>Salary Range:</td></tr><tr>
            <td><input name="salaryrange" id="salaryrange" size="38" maxlength="50" type="text" /></td>
          </tr>
          <tr>
            <td>Required Education:</td></tr><tr>
            <td><select name="education">
                <option value="High School">High School</option>
                <option value="Associate Degree">Associate Degree</option>
                <option value="Bachelor Degree">Bachelor Degree</option>
                <option value="Master's Degree">Master's Degree</option>
                <option value="None Required">None Required</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Experience Level:</td></tr><tr>
            <td><select name="experience">
                <option value="Entry Level">Entry Level</option>
                <option value="One Year">One Year</option>
                <option value="Two Years">Two Years</option>
                <option value="Three Years">Three Years</option>
                <option value="Four Years">Four Years</option>
                <option value="Five or More Years">Five or More Years</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Description of Position:</td></tr><tr>
            <td><textarea name="description" cols="33" rows="5" id="description" onkeydown="limitText(this,500);" onkeyup="limitText(this,500);"></textarea></td>
          </tr>
          <tr>
            <td>Best Time to Contact You:</td></tr><tr>
            <td><input name="contacttime" id="contacttime" size="38" maxlength="50" type="text" /></td>
          </tr>
          <tr>
            <td valign="top" align="left">&nbsp;</td></tr><tr>
            <td colspan="5" valign="top" align="left"><label>
	  <div class="buttonwrapper" style="padding:1em .5em 1em 0;"> <a class="squarebutton" href="#" onclick="sendInfo();" style="margin:.25em 1em .25em"><span>Send Work Order</span></a></div>
            </label></td>
          </tr>
        </tbody>
      </table>
    </form>
  </div>
  <%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
