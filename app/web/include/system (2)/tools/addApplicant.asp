<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 07.23.2008 -->
<%
if request.form("Submit") = "Return To Account Home" then Response.Redirect("/userHome.asp")

dim LooksGood

PostTo = "/include/system/tools/activity/forms/addApplicant.asp?Action=1"
LooksGood="true"
if CheckField("username") <> "" then LooksGood = "false"
if CheckField("password") <> "" then LooksGood = "false"
if CheckField("nameF") <> "" then LooksGood = "false"
if CheckField("nameL") <> "" then LooksGood = "false"
if CheckField("addOne") <> "" then LooksGood = "false"
if CheckField("city") <> "" then LooksGood = "false"
if CheckField("email") <> "" then LooksGood = "false"
if CheckPhone(FormatPhone(request.form("Pphone"))) <> "" then LooksGood = "false"

if LooksGood = "true" And request.form("Submit") = "Add Applicant" then 
	CreateUserAccount
	DisplayConfirmation
Else
	ShowForm
end if

Sub ShowForm
dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail

if request.form("Submit") <> "Start Over" then
	UserName = request.form("userName")
	Password = request.form("password")
	RePassword = request.form("retypedpassword")
	FirstName = request.form("nameF")
	LastName = request.form("nameL")
	AddressOne = request.form("addOne")
	AddressTwo = request.form("addTwo")
	City = request.form("city")
	UserState = request.form("state")
	ZipCode = request.form("zipcode")
	Country = request.form("country")
	PrimaryPhone = FormatPhone(request.form("Pphone"))
	SecondaryPhone = FormatPhone(request.form("Sphone"))
	eMail = request.form("email")
	ReeMail = request.form("reemail")
end if

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
	dim TempValue
	Select Case	formField
		Case "username"
			TempValue = request.form("username")
			if TempValue = "" then
				CheckField = "User name is required"
			elseif len(TempValue) < 5 then
				CheckField = "User name must be longer<br>than 5 characters, letters<br>and/or numbers."
			elseif request.form("Submit") = "Add Applicant" then
				Database.Open MySql
				Set dbQuery = Database.Execute("Select userName From tbl_users Where userName = '" + request.form("username")+"'")
				do while not dbQuery.eof
					i = i + 1
					dbQuery.Movenext
				loop
				Database.Close
				if i > 0 then
					CheckField = "User name already taken. <br>Please choose a different one."
				end if
			Else
				CheckField = ""
			end if
		Case "password"
			TempValue = request.form("password")
			if TempValue = "" then
				CheckField = "Password is required"
			elseif TempValue <> request.form("retypedpassword") then
				CheckField = "Passwords do not match"
			Else
				CheckField = ""
			end if
		Case "nameF"
			if request.form("nameF") = "" then
				CheckField = "First name is required"
			Else
				CheckField = ""
			end if
		Case "nameL"
			if request.form("nameL") = "" then
				CheckField = "Last name is required"
			Else
				CheckField = ""
			end if
		Case "addOne"
			if request.form("addOne") = "" then
				CheckField = "Address is required"
			Else
				CheckField = ""
			end if
		Case "city"
			if request.form("city") = "" then
				CheckField = "City Required"
			Else
				CheckField = ""
			end if
		Case "zipcode"
			if request.form("zipcode") = "" then
				CheckField = "Zip Code Required"
			Else
				CheckField = ""
			end if
		Case "email"
			TempValue = request.form("email")
			if TempValue = "" then
				CheckField = "eMail Address Required"
			elseif Instr(TempValue,"@") = 0 then
				CheckField = "Invalid eMail Address"
			elseif Trim(TempValue) <> Trim(request.form("reemail")) then
				CheckField = "eMail Addresses Don't Match"
			Else
				CheckField = ""
			end if
	End Select	
End Function

Function CheckPhone (PhoneNumber)
	if PhoneNumber = "" then
		CheckPhone = "Phone Number Required"
	elseif len(PhoneNumber) < 13 then
		CheckPhone = "Not enough numbers"
	elseif len(PhoneNumber) > 13 then
		CheckPhone = "Invalid Phone Number"
	Else
		CheckPhone = ""
	end if
End Function

Sub CreateUserAccount

	dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql
	' * Note for Future: Need to sanitize outside information to prevent database injection hacking!
	'
	creationStamp=Now()
	sqlInformation = "INSERT INTO tbl_addresses (addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"'APPLICANT'," & _
	"'" & request.form("addOne") & "'," & _
	"'" & request.form("addTwo") & "'," & _
	"'" & request.form("city") & "'," & _
	"'" & request.form("state") & "'," & _
	"'" & request.form("zipcode") & "'," & _
	"'" & request.form("country") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)
	
	'Retrieve assigned autonumbered addressID (To update table relationships with)
	'
	set dbQuery=Database.Execute("Select addressID From tbl_addresses WHERE CreationDate='" & creationStamp & "'")
	
	sqlInformation = "INSERT INTO tbl_users (addressID, userName, userPassword, userLevel, userEmail, userPhone, userSPhone, firstName, lastName, CreationDate) VALUES (" & _ 
	"'" & dbQuery("addressID") & "'," & _
	"'" & request.form("username") & "'," & _
	"'" & request.form("password") & "'," & _
	"'" & userLevelRegistered & "'," & _
	"'" & request.form("email") & "'," & _
	"'" & FormatPhone(request.form("pphone")) & "'," & _
	"'" & FormatPhone(request.form("sphone")) & "'," & _
	"'" & request.form("nameF") & "'," & _
	"'" & request.form("nameL") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)

	set dbQuery=Database.Execute("Select userID From tbl_users WHERE CreationDate='" & creationStamp & "'")
	userID=dbQuery("userID")
	
	set dbQuery=Database.Execute("UPDATE tbl_addresses SET userID=" & userID & " WHERE CreationDate='" & creationStamp & "'")
	
	Set dbQuery = Database.Execute("Select * From email_templates Where template='newUserWelcome'")
	MessageBody = dbQuery("body")
	MessageBody = Replace(MessageBody, "%nameF%", request.form("nameF"))
	MessageBody = Replace(MessageBody, "%nameL%", request.form("nameL"))
	MessageBody = Replace(MessageBody, "%addOne%", request.form("addOne"))
	MessageBody = Replace(MessageBody, "%addTwo%", request.form("addTwo"))
	MessageBody = Replace(MessageBody, "%city%", request.form("city"))
	MessageBody = Replace(MessageBody, "%state%", request.form("state"))
	MessageBody = Replace(MessageBody, "%zipcode%", request.form("zipcode"))
	MessageBody = Replace(MessageBody, "%Pphone%", request.form("Pphone"))
	MessageBody = Replace(MessageBody, "%sphone%", request.form("sphone"))
	MessageBody = Replace(MessageBody, "%email%", request.form("email"))
	MessageBody = Replace(MessageBody, "%username%", request.form("username"))
	MessageBody = Replace(MessageBody, "%password%", request.form("password"))
	
	SendTo = request.form("nameF") & " " & request.form("nameL") & "<" & request.form("email") & ">"
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
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
</body>
</html>
