<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
<!-- Revised: 07.23.2008 -->
<%
If Request.Form("Submit") = "Return To Account Home" Then Response.Redirect("/userHome.asp")

Dim LooksGood

PostTo = "/include/system/tools/activity/forms/addApplicant.asp?Action=1"
LooksGood="true"
If CheckField("username") <> "" Then LooksGood = "false"
If CheckField("password") <> "" Then LooksGood = "false"
If CheckField("nameF") <> "" Then LooksGood = "false"
If CheckField("nameL") <> "" Then LooksGood = "false"
If CheckField("addOne") <> "" Then LooksGood = "false"
If CheckField("city") <> "" Then LooksGood = "false"
If CheckField("email") <> "" Then LooksGood = "false"
If CheckPhone(FormatPhone(Request.Form("Pphone"))) <> "" Then LooksGood = "false"

If LooksGood = "true" And Request.Form("Submit") = "Add Applicant" Then 
	CreateUserAccount
	DisplayConfirmation
Else
	ShowForm
End If

Sub ShowForm
Dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail

If Request.Form("Submit") <> "Start Over" Then
	UserName = Request.Form("userName")
	Password = Request.Form("password")
	RePassword = Request.Form("retypedpassword")
	FirstName = Request.Form("nameF")
	LastName = Request.Form("nameL")
	AddressOne = Request.Form("addOne")
	AddressTwo = Request.Form("addTwo")
	City = Request.Form("city")
	UserState = Request.Form("state")
	ZipCode = Request.Form("zipcode")
	Country = Request.Form("country")
	PrimaryPhone = FormatPhone(Request.Form("Pphone"))
	SecondaryPhone = FormatPhone(Request.Form("Sphone"))
	eMail = Request.Form("email")
	ReeMail = Request.Form("reemail")
End If

%>
<form method="post" action="<%=PostTo%>">
	<div class="sideMargin border" style="margin-left:0">
		<div>
			<div class="normalTitle">Add New Applicant</div>
			<div class="divided">
				<p style="text-align:center"><img src="/include/style/images/createUser.jpg" style="padding-left:15px;padding-bottom:15px;"></p>
			</div>
			<div class="divided center">
				<p class="formErrMsg">&nbsp;</p>
				<p>
					<label for="userName" class="createUser">Enter a Username</label>
					<input type="text" name="username" size="25" value="<%=UserName%>" tabindex=1>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("username")%>&nbsp;</p>
			</div>
			<div class="divided center" style="padding-left:25px">
				<p class="formErrMsg">&nbsp;</p>
				<p>
					<label for="password" class="createUser">Password</label>
					<input type="password" name="password" size="25" value="<%=Password%>" tabindex=2>
				</p>
				<p>
					<label for="retypedpassword" class="createUser">Retype Password</label>
					<input type="password" name="retypedpassword" size="25" value="<%=RePassword%>" tabindex=3>
				</p>
				<p class="formErrMsg"><%=CheckField("password")%>&nbsp;</p>
			</div>
		</div>
		<div>
			<div class="normalTitle" style="margin-bottom:10;">Profile Information</div>
			<div class="divided center" style="padding-left:90">
				<p>
					<label for="nameF" class="createUser">First Name</label>
					<input type="text" name="nameF" size="25" value="<%=FirstName%>" tabindex=4>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameF")%>&nbsp;</p>
				<p>
					<label for="addOne" class="createUser">Address</label>
					<input type="text" name="addOne" size="25" value="<%=AddressOne%>" tabindex=7>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("addOne")%>&nbsp;</p>
				<p>
					<label for="City" class="createUser">City/State</label>
					<input type="text" name="City" size="15" value="<%=City%>" tabindex=9>
					<select name="state" tabindex="9">
						<option value="ID">ID</option>
						<%=PopulateList("list_locations", "locCode", "locCode", "locCode", UserState)%>
					</select>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("city")%>&nbsp;</p>
				<p>
					<label for="zipcode" class="createUser">Zip Code</label>
					<input type="text" name="zipcode" size="7" value="<%=ZipCode%>" tabindex=11>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("zipcode")%>&nbsp;</p>
			</div>
			<div class="divided center" style="padding-left:25px">
				<p>
					<label for="nameL" class="createUser">Last Name</label>
					<input type="text" name="nameL" size="25" value="<%=LastName%>" tabindex=5>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameL")%>&nbsp;</p>
				<p>&nbsp;</p>
				<p class="formErrMsg">&nbsp;</p>
				<p>&nbsp;</p>
				<p>
					<label for="addTwo" class="createUser">Address Two</label>
					<input type="text" name="addTwo" size="25" value="<%=AddressTwo%>" tabindex=8>
				</p>
				<p class="formErrMsg">&nbsp;</p>
				<p>
					<label for="Country" class="createUser">Country</label>
					<input type="text" name="Country" size="25" value="<%=Country%>" tabindex=12>
				</p>
			</div>
		</div>
		<div>
			<div class="normalTitle" style="margin-bottom:10;">Contact Information</div>
			<div class="divided center" style="padding-left:90">
				<p>
					<label for="Pphone" class="createUser">Phone</label>
					<input type="text" name="Pphone" size="25" value="<%=PrimaryPhone%>" tabindex=13>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckPhone(PrimaryPhone)%>&nbsp;</p>
				<p>
					<label for="Sphone" class="createUser">Alt. Phone</label>
					<input type="text" name="Sphone" size="25" value="<%=SecondaryPhone%>" tabindex=14>
				</p>
				<p class="formErrMsg" style="padding-left:85px;">&nbsp;</p>
			</div>
			<div class="divided center" style="padding-left:25px">
				<p>
					<label for="email" class="createUser">eMail</label>
					<input type="text" name="email" size="25" value="<%=eMail%>" tabindex=15>
				</p>
				<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("email")%>&nbsp;</p>
				<p>
					<label for="reemail" class="createUser">ReType eMail</label>
					<input type="text" name="reemail" size="25" value="<%=ReeMail%>" tabindex=16>
				</p>
			</div>
		</div>
	</div>
	<div class="sideMargin" style="margin-top:15px;margin-left:0">
		<p class="center">
			<input name="Submit" id="Submit" type="submit" class="normalbtn" value="Return To Account Home" tabindex=19>
			<input name="Submit" id="Submit" type="submit" class="normalbtn" value="Start Over" tabindex=18>
			<input name="Submit" id="Submit" type="submit" class="normalbtn" value="Add Applicant" tabindex=17>
		</p>
	</div>
	</div>
</form>
<%
End Sub

Function CheckField (formField)
	Dim TempValue
	Select Case	formField
		Case "username"
			TempValue = Request.Form("username")
			If TempValue = "" Then
				CheckField = "User name is required"
			ElseIf Len(TempValue) < 5 Then
				CheckField = "User name must be longer<br>than 5 characters, letters<br>and/or numbers."
			ElseIf Request.Form("Submit") = "Add Applicant" Then
				Database.Open MySql
				Set dbQuery = Database.Execute("Select userName From tbl_users Where userName = '" + request.form("username")+"'")
				Do While Not dbQuery.EOF
					i = i + 1
					dbQuery.Movenext
				Loop
				Database.Close
				If i > 0 Then
					CheckField = "User name already taken. <br>Please choose a different one."
				End If
			Else
				CheckField = ""
			End If
		Case "password"
			TempValue = Request.Form("password")
			If TempValue = "" Then
				CheckField = "Password is required"
			ElseIf TempValue <> Request.Form("retypedpassword") Then
				CheckField = "Passwords do not match"
			Else
				CheckField = ""
			End If
		Case "nameF"
			If Request.Form("nameF") = "" Then
				CheckField = "First name is required"
			Else
				CheckField = ""
			End If
		Case "nameL"
			If Request.Form("nameL") = "" Then
				CheckField = "Last name is required"
			Else
				CheckField = ""
			End If
		Case "addOne"
			If Request.Form("addOne") = "" Then
				CheckField = "Address is required"
			Else
				CheckField = ""
			End If
		Case "city"
			If Request.Form("city") = "" Then
				CheckField = "City Required"
			Else
				CheckField = ""
			End If
		Case "zipcode"
			If Request.Form("zipcode") = "" Then
				CheckField = "Zip Code Required"
			Else
				CheckField = ""
			End If
		Case "email"
			TempValue = Request.Form("email")
			If TempValue = "" Then
				CheckField = "eMail Address Required"
			ElseIf Instr(TempValue,"@") = 0 Then
				CheckField = "Invalid eMail Address"
			ElseIf Trim(TempValue) <> Trim(Request.Form("reemail")) Then
				CheckField = "eMail Addresses Don't Match"
			Else
				CheckField = ""
			End If
	End Select	
End Function

Function CheckPhone (PhoneNumber)
	If PhoneNumber = "" Then
		CheckPhone = "Phone Number Required"
	ElseIf Len(PhoneNumber) < 13 Then
		CheckPhone = "Not enough numbers"
	ElseIf Len(PhoneNumber) > 13 Then
		CheckPhone = "Invalid Phone Number"
	Else
		CheckPhone = ""
	End If
End Function

Sub CreateUserAccount

	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql
	' * Note for Future: Need to sanitize outside information to prevent database injection hacking!
	'
	creationStamp=Now()
	sqlInformation = "INSERT INTO tbl_addresses (addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"'APPLICANT'," & _
	"'" & Request.Form("addOne") & "'," & _
	"'" & Request.Form("addTwo") & "'," & _
	"'" & Request.Form("city") & "'," & _
	"'" & Request.Form("state") & "'," & _
	"'" & Request.Form("zipcode") & "'," & _
	"'" & Request.Form("country") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)
	
	'Retrieve assigned autonumbered addressID (To update table relationships with)
	'
	set dbQuery=Database.Execute("Select addressID From tbl_addresses WHERE CreationDate=#" & creationStamp & "#")
	
	sqlInformation = "INSERT INTO tbl_users (addressID, userName, userPassword, userLevel, userEmail, userPhone, userSPhone, firstName, lastName, CreationDate) VALUES (" & _ 
	"'" & dbQuery("addressID") & "'," & _
	"'" & Request.Form("username") & "'," & _
	"'" & Request.Form("password") & "'," & _
	"'" & userLevelRegistered & "'," & _
	"'" & Request.Form("email") & "'," & _
	"'" & FormatPhone(Request.Form("pphone")) & "'," & _
	"'" & FormatPhone(Request.Form("sphone")) & "'," & _
	"'" & Request.Form("nameF") & "'," & _
	"'" & Request.Form("nameL") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)

	set dbQuery=Database.Execute("Select userID From tbl_users WHERE CreationDate=#" & creationStamp & "#")
	userID=dbQuery("userID")
	
	set dbQuery=Database.Execute("UPDATE tbl_addresses SET userID=" & userID & " WHERE CreationDate=#" & creationStamp & "#")
	
	Set dbQuery = Database.Execute("Select * From email_templates Where template='newUserWelcome'")
	MessageBody = dbQuery("body")
	MessageBody = Replace(MessageBody, "%nameF%", Request.Form("nameF"))
	MessageBody = Replace(MessageBody, "%nameL%", Request.Form("nameL"))
	MessageBody = Replace(MessageBody, "%addOne%", Request.Form("addOne"))
	MessageBody = Replace(MessageBody, "%addTwo%", Request.Form("addTwo"))
	MessageBody = Replace(MessageBody, "%city%", Request.Form("city"))
	MessageBody = Replace(MessageBody, "%state%", Request.Form("state"))
	MessageBody = Replace(MessageBody, "%zipcode%", Request.Form("zipcode"))
	MessageBody = Replace(MessageBody, "%Pphone%", Request.Form("Pphone"))
	MessageBody = Replace(MessageBody, "%sphone%", Request.Form("sphone"))
	MessageBody = Replace(MessageBody, "%email%", Request.Form("email"))
	MessageBody = Replace(MessageBody, "%username%", Request.Form("username"))
	MessageBody = Replace(MessageBody, "%password%", Request.Form("password"))
	
	SendTo = Request.Form("nameF") & " " & Request.Form("nameL") & "<" & Request.Form("email") & ">"
	SendEmail SendTo, "Peronnel Plus VMS <admin@personnel.com>", dbQuery("subject"), MessageBody
	Set dbQuery = Nothing
	Database.Close
End Sub

Sub DisplayConfirmation
%>
<div class="mainPage center">
	<div id="signIn" style="width:400;margin-top:50;margin-bottom:50;">
		<div class="normalTitle">User Account Created</div>
		<div style="width:20%; border:none; margin-top:5px;float:left;"> <img src="/include/style/images/createUser.jpg" style="padding:15px;padding-top:0;"> </div>
		<div style="width:70%; border:none; margin-top:0;float:right;padding:10;">
			<p class="center">Your user account has been created successfully</p>
			<p>&nbsp;</p>
			<p class="center;">An email has been sent to the address you provided containing your account information.</p>
		</div>
		<div style="width:100%; float:top;border-top: 1px solid #97A4B3;padding-top:10;">
			<p class="center">Click <a style="color:#0066CC; text-decoration:underline" href="/userHome.asp">Here</a> to Sign In.</p>
		</div>
	</div>
</div>
<%
End Sub
%>
<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
</body>
</html>
