<!-- #INCLUDE VIRTUAL='/include/master/html_header.asp' -->
<!-- Revised: 2009.07.18 -->
<!-- Revised: 08.8.2008 -->
<% Session("additionalStyling") = "createAccounts.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/master/html_styles.asp' -->
<!-- #INCLUDE VIRTUAL='/include/master/navi_top_menu.asp' -->
  <script type="text/javascript" src="/include/js/createNewCompany.js"></script>
  <%
Response.Expires = -1000 'Makes the browser not cache this page
Response.Buffer = True 'Buffers the content so our Response.Redirect will work

Session("SignedIn") = false

Dim LooksGood

PostTo = "/include/user/createNewCompany.asp"
errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Informatin'>"

If Request.Form("formAction") = "true" then
	LooksGood = true
	If CheckField("companyname") <> "" Then LooksGood = false
	If CheckField("username") <> "" Then LooksGood = false
	If CheckField("newPassword") <> "" Then LooksGood = false
	If CheckField("firstName") <> "" Then LooksGood = false
	If CheckField("lastName") <> "" Then LooksGood = false
	If CheckField("addressOne") <> "" Then LooksGood = false
	If CheckField("city") <> "" Then LooksGood = false
	If CheckField("email") <> "" Then LooksGood = false
	If CheckPhone(FormatPhone(Request.Form("Pphone"))) <> "" Then LooksGood = false
End If

If LooksGood = true Then 
	CreateCompanyAccount
	DisplayConfirmation
Else
	ShowForm
End If

Sub ShowForm
Dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail

	CompanyName = Request.Form("companyname")
	UserName = Request.Form("userName")
	FirstName = Request.Form("firstName")
	LastName = Request.Form("lastName")
	Title = Request.Form("title")
	AddressOne = Request.Form("addressOne")
	AddressTwo = Request.Form("addressTwo")
	City = Request.Form("city")
	UserState = Request.Form("state")
	ZipCode = Request.Form("zipcode")
	Country = Request.Form("country")
	PrimaryPhone = FormatPhone(Request.Form("Pphone"))
	SecondaryPhone = FormatPhone(Request.Form("Sphone"))
	eMail = Request.Form("email")
	ReeMail = Request.Form("reemail")

%>
  <form method="post" name="createNewCompany" id="createNewCompany" action="<%=PostTo%>">
    <%=decorateTop("problemsInNewCompany", "hide", "Whoops...")%>
    <div id="problemsInNewCompanyBlog">
      <p>Some problems were found in the form below.</p>
      <p>Please review your application for missing or incorrect information and then try submitting it again.</p>
    </div>
    <%=decorateBottom()%> <%=decorateTop("", "", "Company Information")%>
    <div id="basicCompanyInfo">
      <p>
        <label id="companynameLabel" for="companyname" class="<%=CheckField("companyname")%>"><span>&nbsp;</span>Company Name</label>
        <input type="text" name="companyname" id="companyname" size="30" value="<%=companyname%>" tabindex=1>
      </p>
      <script type="text/javascript"><!--
					  document.createNewCompany.companyname.focus()
						//--></script>
      <p>This will be your username and will be kept strictly confidential.</p>
      <p>
        <label for="userName">Your email address</label>
        <input type="text" name="username" size="25" value="<%=UserName%>" tabindex=1>
      </p>
      <p>Pick a password. Passwords must be at least 6 characters long.</p>
      <p>
        <label for="password">Password</label>
        <input type="password" name="password" size="25" value="<%=password%>" tabindex=2>
      </p>
      <p class="formErrMsg">
        <label for="retypedpassword">Retype Password</label>
        <input type="password" name="retypedpassword2" size="25" value="<%=retypedpassword%>" tabindex=3>
      </p>
      <p>
        <label id="addressOneLabel" for="addressOne" class="<%=CheckField("addressOne")%>"><span><br>
        &nbsp;</span>Address</label>
        <input type="text" name="addressOne" size="30" value="<%=AddressOne%>" tabindex=2>
      </p>
      <p>
        <label id="addTwoLabel" for="addressTwo">Address Two</label>
        <input type="text" name="addressTwo" size="30" value="<%=AddressTwo%>" tabindex=3>
      </p>
      <p>
        <label id="CityLabel" for="City" class="<%=CheckField("city")%>"><span class="required">*</span>City</label>
        <input type="text" name="City" size="16" value="<%=City%>" tabindex=4>
      </p>
      <p>
        <label id="stateLabel" for="state" class="<%=CheckField("state")%>"><span class="required">*</span>State</label>
        <select name="state" tabindex=5>
          <option value="ID">ID</option>
          <%=PopulateList("list_locations", "locCode", "locCode", "locCode", UserState)%>
        </select>
      </p>
      <p>
        <label id="zipcodeLabel" for="zipcode" class="<%=CheckField("zipcode")%>"><span class="required">*</span>Zip Code</label>
        <input type="text" name="zipcode" size="15" value="<%=ZipCode%>" tabindex=7>
      </p>
      <p>
        <label id="countryLabel" for="country" class="fieldIsGood"><span class="required">*</span>Country</label>
        <select name="country" tabindex="6">
          <option value="USA">USA</option>
          <option value="CA">Canada</option>
        </select>
      </p>
      <p>
        <label id="PphoneLabel" for="Pphone" class="<%=CheckField("PrimaryPhone")%>"><span class="required">*</span>Phone</label>
        <input type="text" name="Pphone" size="25" value="<%=PrimaryPhone%>" tabindex=8>
      </p>
      <p>
        <label id="SphoneLabel" for="Sphone">Secondary Phone</label>
        <input type="text" name="Sphone" size="25" value="<%=SecondaryPhone%>" tabindex=9>
      </p>
      <p>
        <label id="titleLabel" for="title">Title</label>
        <input type="text" name="title" size="26" value="<%=Title%>" tabindex=10>
      </p>
      <p>
        <label id="nameFLabel" for="firstName" class="<%=CheckField("firstName")%>"><span class="required">*</span>First Name</label>
        <input type="text" name="firstName" size="30" value="<%=FirstName%>" tabindex=11>
      </p>
      <p>
        <label id="nameLLabel" for="lastName" class="<%=CheckField("lastName")%>"><span class="required">*</span>Last Name</label>
        <input type="text" name="lastName" size="26" value="<%=LastName%>" tabindex=13>
      </p>
      <p>
        <label id="emailLabel" for="email" class="<%=CheckField("addressOne")%>"><span class="required">*</span>eMail</label>
        <input type="text" name="email" size="30" value="<%=eMail%>" tabindex=15>
      </p>
      <p>
        <label id="reemailLabel" for="reemail" class="<%=CheckField("email")%>"></label>
        <label id="userNameLabel" for="userName" class="<%=CheckField("username")%>"></label>
<label id="newPasswordLabel" for="newPassword" class="<%=CheckField("newPassword")%>"><span class="required">*</span>Password</label>
        <input name="newPassword" type="password" tabindex=17 value="<%=password%>" size="26">
      </p>
      <p>
        <label id="retypedpasswordLabel"for="retypedpassword" class="<%=CheckField("newPassword")%>"><span class="required">*</span>Retype Password</label>
        <input type="password" name="retypedpassword" size="26" value="<%=rePassword%>" tabindex=18>
      </p>
      <input type="hidden" name="formAction" value="">
      <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.createNewCompany.formAction.value='true';document.createNewCompany.submit();"><span>Complete Enrollment</span></a></div>
    </div>
    <div class="bb">
      <div>
        <div></div>
      </div>
    </div>
  </form>
  <%
End Sub

Function CheckField (formField)
	If Request.Form("formAction") = "true" Then
		Select Case	formField
		Case "companyname"
			If Request.Form("companyname") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "username"
			TempValue = Request.Form("username")
			If TempValue = "" Then
				CheckField = "fieldIsBad"
			ElseIf Len(TempValue) < 5 Then
				CheckField = errImage & " User name cannot be less than 5 characters"
			ElseIf Request.Form("formAction") = "Complete Enrollment" Then
				Database.Open MySql
				Set dbQuery = Database.Execute("Select userName From tbl_users Where userName = '" + request.form("username")+"'")
				Do While Not dbQuery.EOF
					i = i + 1
					dbQuery.Movenext
				Loop
				Database.Close
				If i > 0 Then
					CheckField = errImage & " User name already in use."
				End If
			Else
				CheckField = "fieldIsGood"
			End If
		Case "newPassword"
			TempValue = Request.Form("newPassword")
			If TempValue = "" Then
				CheckField = "fieldIsBad"
			ElseIf TempValue <> Request.Form("retypedpassword") Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "firstName"
			If Request.Form("firstName") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "lastName"
			If Request.Form("lastName") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "addressOne"
			If Request.Form("addressOne") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "city"
			If Request.Form("city") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "state"
			If Request.Form("city") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "zipcode"
			If Request.Form("zipcode") = "" Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		Case "email"
			TempValue = Request.Form("email")
			If TempValue = "" Then
				CheckField = "fieldIsBad"
			ElseIf Instr(TempValue,"@") = 0 Then
				CheckField = "fieldIsBad"
			ElseIf Trim(TempValue) <> Trim(Request.Form("reemail")) Then
				CheckField = "fieldIsBad"
			Else
				CheckField = "fieldIsGood"
			End If
		End Select	
	Else
		CheckField = "fieldIsGood"
	End If
End Function

Function CheckPhone (PhoneNumber)
	If Request.Form("formAction") = "true" Then
		If PhoneNumber = "" Then
			CheckPhone = errImage & " Phone Number Required"
		ElseIf Len(PhoneNumber) < 13 Then
			CheckPhone = errImage & " Not enough numbers"
		ElseIf Len(PhoneNumber) > 13 Then
			CheckPhone = errImage & " Invalid Phone Number"
		Else
			CheckPhone = ""
		End If
	End If
End Function

Sub CreateCompanyAccount
	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql

	'Store date into Database	
	' * Note for Future: Need to sanitize outside information to prevent database injection!
	'
	creationStamp=Now()
	
	sqlInformation = "INSERT INTO tbl_addresses (addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"'" & Request.Form("companyname") & "'," & _
	"'" & Request.Form("addressOne") & "'," & _
	"'" & Request.Form("addressTwo") & "'," & _
	"'" & Request.Form("city") & "'," & _
	"'" & Request.Form("state") & "'," & _
	"'" & Request.Form("zipcode") & "'," & _
	"'" & Request.Form("country") & "'," & _
	"'" & creationStamp & "')"	
	Database.Execute(sqlInformation)
	
	'Retrieve assigned autonumbered addressID (To update table relationships with)
	'
	Set dbQuery = Database.Execute("Select addressID From tbl_addresses WHERE CreationDate=#" & creationStamp & "#")
	addressID = dbQuery("addressID")
	
	sqlInformation = "INSERT INTO tbl_companies (addressID, companyName, companyPhone, companySPhone, CreationDate) VALUES (" & _	
	"'" & addressID & "'," & _
	"'" & Request.Form("companyname") & "'," & _
	"'" & Request.Form("pphone") & "'," & _
	"'" & Request.Form("sphone") & "'," & _
	"'" & creationStamp & "')"	
	Database.Execute(sqlInformation)

	'Retrieve assigned autonumbered companyID (To update table relationships with)
	'
	dbQuery = Database.Execute("Select companyID From tbl_companies WHERE CreationDate=#" & creationStamp & "#")
	companyID=dbQuery("companyID")
	
	sqlInformation = "INSERT INTO tbl_addresses (addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"' '," & "'" & Request.Form("addressOne") & "'," & _
	"'" & Request.Form("addressTwo") & "'," & _
	"'" & Request.Form("city") & "'," & _
	"'" & Request.Form("state") & "'," & _
	"'" & Request.Form("zipcode") & "'," & _
	"'" & Request.Form("country") & "'," & _
	"'" & creationStamp & "')"	
	Database.Execute(sqlInformation)

	Set dbQuery = Database.Execute("Select addressID From tbl_addresses WHERE CreationDate=#" & creationStamp & "# And addressName=' '")
	addressID = dbQuery("addressID")

	sqlInformation = "INSERT INTO tbl_users (addressID, companyID, userName, userPassword, userLevel, userEmail, userPhone, userSPhone, title, firstName, lastName, CreationDate) VALUES (" & _ 
	"'" & addressID & "'," & _
	"'" & companyID & "'," & _
	"'" & Request.Form("username") & "'," & _
	"'" & Request.Form("newPassword") & "'," & _
	"'" & userLevelAdministrator & "'," & _
	"'" & Request.Form("email") & "'," & _
	"'" & FormatPhone(Request.Form("pphone")) & "'," & _
	"'" & FormatPhone(Request.Form("sphone")) & "'," & _
	"'" & Request.Form("title") & "'," & _
	"'" & Request.Form("firstName") & "'," & _
	"'" & Request.Form("lastName") & "'," & _
	"'" & creationStamp & "')"	
	Database.Execute(sqlInformation)

	Set dbQuery = Database.Execute("Select userID From tbl_users WHERE CreationDate=#" & creationStamp & "#")
	userID = dbQuery("userID")
	
	Database.Execute("UPDATE tbl_addresses SET companyID=" & companyID & " WHERE CreationDate=#" & creationStamp & "# And addressName <> ' '" )
	Database.Execute("UPDATE tbl_addresses SET userID=" & userID & " WHERE CreationDate=#" & creationStamp & "# And addressName=''")
	
	Set dbQuery = Database.Execute("Select * From email_templates Where template='newCompanyWelcome'")
	MessageBody = dbQuery("body")
	MessageBody = Replace(MessageBody, "%companyname%", Request.Form("companyname"))
	MessageBody = Replace(MessageBody, "%firstName%", Request.Form("firstName"))
	MessageBody = Replace(MessageBody, "%lastName%", Request.Form("lastName"))
	MessageBody = Replace(MessageBody, "%addressOne%", Request.Form("addressOne"))
	MessageBody = Replace(MessageBody, "%addressTwo%", Request.Form("addressTwo"))
	MessageBody = Replace(MessageBody, "%city%", Request.Form("city"))
	MessageBody = Replace(MessageBody, "%state%", Request.Form("state"))
	MessageBody = Replace(MessageBody, "%zipcode%", Request.Form("zipcode"))
	MessageBody = Replace(MessageBody, "%Pphone%", Request.Form("Pphone"))
	MessageBody = Replace(MessageBody, "%sphone%", Request.Form("sphone"))
	MessageBody = Replace(MessageBody, "%email%", Request.Form("email"))
	MessageBody = Replace(MessageBody, "%username%", Request.Form("username"))
	MessageBody = Replace(MessageBody, "%password%", Request.Form("newPassword"))

	
	SendTo = Request.Form("firstName") & " " & Request.Form("lastName") & "<" & Request.Form("email") & ">"
	SendEmail SendTo, "Peronnel Plus VMS <admin@personnel.com>", dbQuery("subject"), MessageBody
	Set dbQuery = Nothing
	Database.Close
End Sub

Sub DisplayConfirmation
%>
  <div class="enrollmentCompleted bordered">
    <div class="normalTitle">Enrollment Completed</div>
    <div class="padded">
      <table >
        <tr>
          <td><img src="/include/style/images/createUser.jpg"></td>
        </tr>
        <tr>
          <td>Your user account has been created successfully</td>
        </tr>
        <tr>
          <td>An email has been sent to the address you provided containing your account information.</td>
        </tr>
        <tr>
          <td>Click <a style="" href="/userHome.asp">Here</a> to Sign In.</td>
        </tr>
      </table>
    </div>
  </div>
  <%
End Sub
%>
</div>
<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
