<%Option Explicit%>
<%
Response.Expires = -1000 'Makes the browser not cache this page
Response.Buffer = true 'Buffers the content so our Response.Redirect will work

session("additionalHeading") = "<meta http-equiv=""Cache-Control"" content=""No-Cache"">" &_
	"<meta http-equiv=""Cache-Control"" content=""No-Store"">" &_
	"<meta http-equiv=""Pragma"" content=""No-Cache"">" &_
	"<meta http-equiv=""Expires"" content=""0"">"

session("no_header") = true
session("add_css") = "./createNewUser.asp.css"
session("additionalScripting") = "<script type=""text/javascript"" src=""/include/js/createNewUser.js""></script>" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->
<%

session_signed_in = false

dim LooksGood, PostTo, errImage

dim Company, UserName, Password, ReTypedPassword, FirstName, MiddleName, LastName, AddressOne, AddressTwo
dim City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, usertype, weekends, taxid

dim sqlrealtionID, rsrelationID, userID, mySmartMail, CreationStamp, sqlInformation

PostTo = "/include/user/create/"
errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Informatin'>"

Company = request.form("Company")
weekends = request.form("weekends")
UserName = request.form("UserName")
Password = request.form("Password")
ReTypedPassword = request.form("ReTypedPassword")
FirstName = request.form("FirstName")
LastName = request.form("LastName")
AddressOne = request.form("AddressOne")
AddressTwo = request.form("AddressTwo")
City = request.form("city")
UserState = request.form("state")
ZipCode = request.form("zipcode")
Country = request.form("Country")
PrimaryPhone = FormatPhone(request.form("Pphone"))
SecondaryPhone = FormatPhone(request.form("Sphone"))
eMail = request.form("email")

if request.QueryString("usertype") = "company" then
	usertype = "company"
else
	usertype = request.form("usertype")
end if

taxid = request.form("taxid")

if request.form("formAction") = "true" then
	LooksGood=true
	if CheckField("UserName") <> "" then LooksGood = false
	if CheckField("Password") <> "" then LooksGood = false
	if CheckField("FirstName") <> "" then LooksGood = false
	if CheckField("LastName") <> "" then LooksGood = false
	if CheckField("AddressOne") <> "" then LooksGood = false
	if CheckField("city") <> "" then LooksGood = false
	if CheckField("email") <> "" then LooksGood = false
	if CheckPhone(FormatPhone(request.form("Pphone"))) <> "" then LooksGood = false
end if

if LooksGood = true then
	CreateUserAccount
	GetSignedIn
Else
	response.write header_response & ie_ifs
	response.Flush()
	ShowForm
end if

Sub ShowForm

dim user_app, user_comp, user_comp_visible
select case usertype
case "applicant"
	user_app = "checked "
	user_comp = ""
	user_comp_visible = "hide"
case "company"
	user_app = ""
	user_comp = "checked"
	user_comp_visible = ""
case else
	user_app = "checked "
	user_comp = ""
	user_comp_visible = "hide"
end select

%>

<form class="createNewUser" name="createNewUser" method="post" action="<%=PostTo%>">
    <%=decorateTop("", "marLR10", "Create a New User ID...")%>
    <fieldset>
        <legend>Please complete the form below. Required fields marked <span class="required">*</span></legend>
        <legend>Name and Contact Information</legend>
        <div class="notes">
            <h4>User ID </h4>
            <p>Use this form to create a unique user id and password.</p>
            <p>You will use this id in the future whenever you access this system, submit or update your information and for application of your electronic signature.</p>
        </div>
        <ol>

            <li>
                <label for="FirstName"><span class="required">*</span> First Name: </label>
                <input type="text" name="FirstName" size="25" value="<%=FirstName%>" tabindex="4"><%=CheckField("FirstName")%>
            </li>
            <li>
                <label for="LastName"><span class="required">*</span> Last Name: </label>
                <input type="text" name="LastName" size="25" value="<%=LastName%>" tabindex="6"><%=CheckField("LastName")%>
            </li>
            <li>
                <label for="email">E-mail: </label>
                <input type="text" name="email" size="25"  maxlength="50" value="<%=email%>" tabindex="6">
            </li>
            <li>
                <label for="Pphone"><span class="required">*</span> Phone: </label>
                <input type="text" name="Pphone" size="25" value="<%=PrimaryPhone%>" tabindex="7">
            </li>
            <li>
                <label for="Sphone">Alt. Phone: </label>
                <input type="text" name="Sphone" size="25" value="<%=SecondaryPhone%>" tabindex="8">
            </li>
            <li>
                <label for="AddressOne"><span class="required">*</span> Address: </label>
                <input type="text" name="AddressOne" size="25" maxlength="30" value="<%=AddressOne%>" tabindex="9"><%=CheckField("Address")%>
            </li>
            <li>
                <label for="AddressTwo">Address Two: </label>
                <input type="text" name="AddressTwo" size="25" maxlength="30" value="<%=AddressTwo%>" tabindex="10">
            </li>
            <li>
                <label for="City"><span class="required">*</span> City: </label>
                <input id="CityField" type="text" name="City" size="15" maxlength="30" value="<%=City%>" tabindex="11"><%=CheckField("City")%>
            </li>
            <li>
                <label for="state"><span class="required">*</span> State: </label>
                <select id="state" name="state" " tabindex="12">
                    <option value="ID">ID</option>
                    <%=PopulateList("list_locations", "locCode", "locCode", "locCode", UserState)%>
                </select>
            </li>
            <li>
                <label for="zipcode"><span class="required">*</span> Zip Code: </label>
                <input id="ZipField" type="text" name="zipcode" size="7" maxlength="10" value="<%=ZipCode%>" tabindex="13">
            </li>
            <li>
                <label for="Country">Country: </label>
                <select name="Country" tabindex="14">
                    <option value="USA">USA</option>
                    <option value="CA">Canada</option>
                </select>
            </li>
        </ol>
    </fieldset>
    <fieldset>
        <legend>New Username and password</legend>
        <ol>
            <li>
                <%=make_input("UserName", "<span class=""required"">*</span> User Name:", UserName, 1, "")%>
                <%=CheckField("UserName")%>
            </li>
            <!-- <p>Make up a unique user name, such as an email address.</p> -->
            <script type="text/javascript">
                document.createNewUser.FirstName.focus()
            </script>
            <li>
                <label for="Password"><span class="required">*</span> Password: </label>
                <input type="Password" name="Password" size="25" value="<%=Password%>" tabindex="16">
                <%=CheckField("Password")%>
            </li>
            <li>
                <label for="ReTypedPassword"><span class="required">*</span> Retype Password: </label>
                <input type="Password" name="ReTypedPassword" size="25" value="<%=ReTypedPassword%>" tabindex="17">
            </li>
        </ol>
    </fieldset>
    <fieldset>
        <legend>Individual or Business</legend>
        <ol>
            <li>
                <label>Account Type</label>
                <label onclick="javascript:hidediv('companyinfo');">
                    <input style="width: 2em;" id="usertype" type="radio" name="usertype" value="applicant" <%=user_app%> tabindex="18">
                    Applicant</label>
                <label onclick="javascript:showdiv('companyinfo');">
                    <input style="width: 2em;" id="usertype" type="radio" name="usertype" value="company" <%=user_comp%> tabindex="19">
                    Company</label>
            </li>
        </ol>
    </fieldset>
    <fieldset id="companyinfo" class="<%=user_comp_visible%>">
        <legend>Company Information</legend>
        <ol>
            <li>
                <label for="Company">Company Name: </label>
                <input type="text" name="Company" id="Company" size="25" value="<%=Company%>" tabindex="20">
            </li>
            <li>
                <label>Week Ends: </label>
                <select name="weekends" id="weekends" tabindex="21">
                    <option value="1">Sunday</option>
                    <option value="2">Monday</option>
                    <option value="3">Tuesday</option>
                    <option value="4">Wednesday</option>
                    <option value="5">Thursday</option>
                    <option value="6">Friday</option>
                    <option value="0">Saturday</option>
                </select>
            </li>
            <li>
                <label for="taxid">
                    Tax Id<br />
                    [EIN or SSN]:
                </label>
                <input id="taxid" type="text" name="taxid" size="25" value="<%=taxid%>" tabindex="22">
            </li>
        </ol>
    </fieldset>
    <div id="createUser" class="buttonwrapper" tabindex="23"><a class="squarebutton" href="javascript:document.createNewUser.formAction.value='true';document.createNewUser.submit();" style="margin-left: 6px" onclick="document.createNewUser.formAction.value='true';document.createNewUser.submit();"><span>Create User... </span></a></div>
    <%=decorateBottom()%>
    <input name="formAction" type="hidden" value="">
</form>
<%
End Sub

Function CheckField (formField)
	if request.form("formAction") = "true" then

	dim TempValue
	Select Case	formField
		Case "UserName"
			TempValue = request.form("UserName")
			if TempValue = "" then
				CheckField = errImage & " User name is required"
			elseif len(TempValue) < 5 then
				CheckField = errImage & " User name must be longer<br>than 5 characters, letters<br>and/or numbers."
			else
				Database.Open MySql
				Set dbQuery = Database.Execute("SELECT UserName FROM tbl_users WHERE UserName = '" & TempValue & "' OR userEmail = '" & TempValue & "' OR userAlternateEmail='"& TempValue & "'")

				if Not dbQuery.eof then
					CheckField = errImage & "The username or email entered is already registered. <br>Please use a different one or contact our offices."
				else
					CheckField = ""
				end if

				set dbQuery = nothing
				Database.Close
			end If
		Case "Password"
			TempValue = request.form("Password")
			if TempValue = "" then
				CheckField = errImage & " Password is required"
			elseif TempValue <> request.form("ReTypedPassword") then
				CheckField = errImage & " Passwords do not match"
			Else
				CheckField = ""
			end if
		Case "FirstName"
			if request.form("FirstName") = "" then
				CheckField = errImage & " First name is required"
			Else
				CheckField = ""
			end if
		Case "LastName"
			if request.form("LastName") = "" then
				CheckField = errImage & " Last name is required"
			Else
				CheckField = ""
			end if
		Case "AddressOne"
			if request.form("AddressOne") = "" then
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

Sub CreateUserAccount
	'On Error Resume Next
	dim SqlAddressInfo, SqlUserInfo

	dim cmd
	set cmd = Server.CreateObject("ADODB.Command")

	with cmd
		.ActiveConnection = MySql
		.CommandText = "INSERT INTO tbl_addresses (addressName, address, AddressTwo, city, state, zip, Country, creationDate) VALUES (" & _
			"''," & _
			insert_string(AddressOne) & "," & _
			insert_string(AddressTwo) & "," & _
			insert_string(city) & "," & _
			insert_string(UserState) & "," & _
			insert_string(zipcode) & "," & _
			insert_string(Country) & "," & _
			"Now());SELECT last_insert_id()"
		.Prepared = false
	end with
	set dbQuery = cmd.Execute.nextrecordset

	dim newAddressId : newAddressId = cdbl(dbQuery(0))

	select case usertype
	case "applicant"
		cmd.CommandText = "INSERT INTO tbl_users (addressID, Company, UserName, userPassword, userLevel, userEmail, notify, userPhone, userSPhone, firstName, lastName, creationDate) VALUES (" & _
			insert_number(newAddressId) & "," &_
			insert_string(Company) & "," &_
			insert_string(UserName) & "," &_
			insert_string(Password) & "," &_
			insert_number(userLevelApplicant) & "," &_
			insert_string(email) & "," &_
			"'-1'," &_
			insert_string(PrimaryPhone) & "," &_
			insert_string(SecondaryPhone) & "," &_
			insert_string(pcase(FirstName)) & "," &_
			insert_string(pcase(LastName)) & "," &_
			"Now())"
		cmd.Execute

	case "company"
		cmd.CommandText = "INSERT INTO tbl_companies (addressID, companyName, companyPhone, companySPhone, weekends, taxid, creationDate) VALUES (" & _
			newAddressId & "," & _
			insert_string(Company) & "," & _
			insert_string(PrimaryPhone) & "," & _
			insert_string(SecondaryPhone) & "," & _
			insert_number(weekends) & ", " & _
			insert_string(taxid) & "," & _
			"Now());select last_insert_id()"

			set dbQuery = cmd.Execute.nextrecordset
			dim newCompanyId : newCompanyId = cdbl(dbQuery(0))

		cmd.CommandText = "INSERT INTO tbl_users (addressID, Company, UserName, userPassword, userLevel, userEmail, notify, userPhone, userSPhone, firstName, lastName, creationDate) VALUES (" & _
			newAddressId & "," & _
			insert_string(Company) & "," & _
			insert_string(UserName) & "," & _
			insert_string(Password) & "," & _
			insert_number(userLevelAdministrator) & "," & _
			insert_string(email) & "," & _
			"'0'," &_
			insert_string(PrimaryPhone) & "," & _
			insert_string(SecondaryPhone) & "," & _
			insert_string(pcase(FirstName)) & "," & _
			insert_string(pcase(LastName)) & "," & _
			"Now());select last_insert_id()"
		set dbQuery = cmd.Execute.nextrecordset

		dim newUserId
			newUserId = cdbl(dbQuery(0))

		with cmd
			.CommandText = "UPDATE tbl_companies SET creator=" & newUserId & " WHERE companyid=" & newCompanyId
			.Execute
		end with

		with cmd
			.CommandText = "UPDATE tbl_users SET companyID=" & newCompanyId & " WHERE userID=" & newUserId
			.Execute
		end with

		msgBody = "This Company: " & Company & " registered online."
		Call SendEmail ("ghaner@personnel.com", "Personnel Plus<online@personnel.com>", "New business registration...", msgBody, "")

	end select

	'Send Confirmation to user
	cmd.CommandText = "SELECT * FROM email_templates WHERE template='newUserWelcome'"
	Set dbQuery = cmd.Execute
	dim msgBody

	msgBody  = dbQuery("body")
	lastNameFirst = LastName & ", " & FirstName
	msgBody  = Replace(msgBody , "%FirstName%", FirstName)
	msgBody  = Replace(msgBody , "%LastName%", LastName)
	msgBody  = Replace(msgBody , "%AddressOne%", AddressOne)
	msgBody  = Replace(msgBody , "%AddressTwo%", AddressTwo)
	msgBody  = Replace(msgBody , "%city%", city)
	msgBody  = Replace(msgBody , "%state%", UserState)
	msgBody  = Replace(msgBody , "%zipcode%", zipcode)
	msgBody  = Replace(msgBody , "%Pphone%", PrimaryPhone)
	msgBody  = Replace(msgBody , "%sphone%", SecondaryPhone)
	msgBody  = Replace(msgBody , "%email%", email)
	msgBody  = Replace(msgBody , "%username%", UserName)
	msgBody  = Replace(msgBody , "%company%", Company)

	dim lastNameFirst, msgSubject, deliveryLocation
	lastNameFirst = LastName & ", " & FirstName

	msgSubject = "Thank you for registering!"

	'Determine destination
	'Set dbQuery = Database.Execute("Select email From list_zips Where zip=" & zipcode)
	'if Not dbQuery.eof then
	'	deliveryLocation = dbQuery("email")
	'Else
	'	deliveryLocation = "twinfalls@personnel.com"
	'end if

	'Call SendEmail (email, "gush@personnel.com", msgSubject, msgBody, "")
	if Err.Number <> 0 then
		'Call SendEmail ("gush@personnel.com", "debug@personnel.com", firstName & " " & lastName & " almost registered online...", msgBody & strErrorMessage & vbLf & vbLf & Server.HTMLEncode(sqlAddressInfo) & vbLf & vbLf & Server.HTMLEncode(sqlUserInfo), "")
	end if
	Set dbQuery = Nothing
	set cmd = Nothing

End Sub

Sub GetSignedIn
	dim Enrollment, Welcome, dbQuery, tempid

	Enrollment = set_session("enrollmentMessage", "true")

	Database.Open MySql
	Set dbQuery = Database.Execute("Select userID From tbl_users Where UserName = '" & request.form("UserName") & "'")
	tempid = dbQuery("userID")
	Set dbQuery = Nothing
	Database.Close
	begin_session(tempid)

	dim web_guide
	web_guide = get_session("webGuide")
	if len(web_guide) = 0 then
		if 	usertype = "applicant" then
			Response.redirect("/include/system/tools/applicant/application/")
		else
			Response.Redirect("/userHome.asp")
		end if
	Else
		Response.Redirect(web_guide)
	end if
End Sub	%>
<!-- #INCLUDE VIRTUAL='include/core/pageFooter.asp' -->
<%
if Err.Number <>0 then
	Resonse.Write Err.Description
end if
%>