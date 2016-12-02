<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
    <!-- Revised: 07.23.2008 -->
    <% 
'---- App Directory and Native Image Constants
FormPostTo = "/user/manageProfile.asp"
const linkImgUser = "<img style='border:none;' src='/include/style/images/ico_user.gif'>"
const SubmitValue = "Update Profile"
const ResetValue = "Undo Changes"
const GoBackValue = "Return To Account Home"

dim LooksGood, UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail

if request.form("Submit") = GoBackValue then Response.Redirect("/userHome.asp")

if request.form("Submit") = ResetValue Or request.form("FirstLoad") <> "false" then
	Database.Open MySql
	Set dbQuery = Database.Execute("Select * From tbl_users Where userID=" & user_id)
	Title = dbQuery("title")
	Department = dbQuery("departmentID")
	UserLevel = dbQuery("userLevel")
	UserName = dbQuery("userName") : CantChangeUserName = "ReadOnly"
	Password = dbQuery("userPassword")
	ConfirmPassword = Password
	FirstName = dbQuery("firstName")
	LastName = dbQuery("lastName")
	PrimaryPhone = dbQuery("userPhone")
	SecondaryPhone = dbQuery("userSPhone")
	eMail = dbQuery("userEmail")
	AlternateeMail = dbQuery("userAlternateEmail")
	addressID = dbQuery("addressID")
	
	Set dbQuery = Database.Execute("Select * From tbl_addresses Where addressID=" & addressID)
	if Not dbQuery.eof then
		AddressOne = dbQuery("address")
		AddressTwo = dbQuery("addressTwo")
		City = dbQuery("city")
		UserState = dbQuery("state")
		ZipCode = dbQuery("zip")
		Country = dbQuery("country")
	end if
	Database.Close
Else
		Title = request.form("title")
		Department = request.form("department")
		CompanyName = request.form("companyname")
		FirstName = request.form("nameF")
		LastName = request.form("nameL")
		PrimaryPhone = FormatPhone(request.form("Pphone"))
		SecondaryPhone = FormatPhone(request.form("Sphone"))
		eMail = request.form("email")
		ReeMail = request.form("reemail")
		AddressOne = request.form("addOne")
		AddressTwo = request.form("addTwo")
		City = request.form("city")
		UserState = request.form("state")
		ZipCode = request.form("zipcode")
		Country = request.form("country")
		UserName = request.form("userName")
		Password = request.form("password")
		UserLevel = request.form("security")
		ConfirmPassword = request.form("retypedpassword")
end if

if request.form("FirstLoad") = "false" then
	LooksGood="true"
	if CheckField("username") <> "" then LooksGood = "false"
	if CheckField("password") <> "" then LooksGood = "false"
	if CheckField("nameF") <> "" then LooksGood = "false"
	if CheckField("nameL") <> "" then LooksGood = "false"
	
	if LooksGood = "true" And request.form("Submit") = SubmitValue then
		UpdateProfile
		ShowConfirmation
	end if
end if

%>
    <form name="profileInfo" method="post" action="<%=FormPostTo%>">
      <input type="hidden" name="formAction" >
      <%=decorateTop("accountForm", "marLR10", "Account Profile Information")%>
      <div class="divided">
        <p class="v h"><img src="/include/style/images/createUser.jpg" style="padding-left:10"></p>
      </div>
      <div class="divided">
        <p>
          <label for="title" class="createUser">Title</label>
          <input type="text" name="title" size="30" value="<%=Title%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("title")%>&nbsp;</p>
        <p>
          <label for="nameF" class="createUser">First Name</label>
          <input type="text" name="nameF" size="30" value="<%=FirstName%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameF")%>&nbsp;</p>
        <p>
          <label for="Pphone" class="createUser">Phone</label>
          <input type="text" name="Pphone" size="30" value="<%=PrimaryPhone%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="Sphone" class="createUser">Alt. Phone</label>
          <input type="text" name="Sphone" size="30" value="<%=SecondaryPhone%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;">&nbsp;</p>
        <p>
          <label for="email" class="createUser">eMail</label>
          <input type="text" name="email" size="30" value="<%=eMail%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="reemail" class="createUser">Second eMail</label>
          <input type="text" name="reemail" size="30" value="<%=AlternateeMail%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
      </div>
      <div class="divided">
        <p>
          <label for="department" class="createUser">Department</label>
          <select name="department" style="width:170;">
            <option value="000">Not Assigned to a Department</option>
            <%=PopulateList("tbl_departments Where companyID=" & companyId, "departmentID", "name", "Order By name", Department)%>
          </select>
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="nameL" class="createUser">Last Name</label>
          <input type="text" name="nameL" size="30" value="<%=LastName%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameL")%>&nbsp;</p>
        <p>
          <label for="addOne" class="createUser">Address</label>
          <input type="text" name="addOne" size="30" value="<%=AddressOne%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="addTwo" class="createUser">Address Two</label>
          <input type="text" name="addTwo" size="30" value="<%=AddressTwo%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="City" class="createUser">City/State</label>
          <input type="text" name="City" size="20" value="<%=City%>">
          <select name="state" class="createUser">
            <option value="ID">ID</option>
            <%=PopulateList("list_locations", "locCode", "locCode", "locCode", UserState)%>
          </select>
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="zipcode" class="createUser">Zip Code</label>
          <input type="text" name="zipcode" size="19" value="<%=ZipCode%>">
          <select name="country" value="<%=Country%>">
            <option value="USA">USA</option>
            <option value="CA">CA</option>
          </select>
        </p>
        <p class="formErrMsg">&nbsp;</p>
      </div>
      <%=decorateBottom()%> <%=decorateTop("accountSecurityForm", "marLR10", "Security Information")%>
      <div class="sideMargin">
        <div class="normalTitle" style="margin-bottom:10;">
          <p style="text-align:center"></p>
        </div>
        <div class="divided">
          <p>
            <label for="userName" class="createUser">User Name</label>
            <input type="text" name="username" size="30" ReadOnly value="<%=UserName%>">
          </p>
          <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("username")%></p>
        </div>
        <div class="divided">
          <p>
            <label for="password" class="createUser">Password</label>
            <input type="password" name="password" size="30" value="<%=Password%>">
          </p>
          <p>
            <label for="retypedpassword" class="createUser">Retype Password</label>
            <input type="password" name="retypedpassword" size="30" value="<%=ConfirmPassword%>">
          </p>
          <p class="formErrMsg"><%=CheckField("password")%>&nbsp;</p>
        </div>
      </div>
      <%=decorateBottom()%>
      <div class="buttonwrapper" style="padding:10px 0 10px 0;">
      <a class="squarebutton" href="javascript:document.profileInfo.formAction.value='true';document.createNewUser.submit();" style="margin-left: 6px" onclick="document.profileInfo.formAction.value='true';document.profileInfo.submit();"><span>Update</span></a> <a class="squarebutton" href="/userHome.asp" onclick="history.back();"><span>Go Back</span></a>
    </form>
  <%
Function CheckField (formField)
	if request.form("FirstLoad") = "false" then
		Select Case	formField
			Case "username"
				TempValue = request.form("username")
				if TempValue = "" then
					CheckField = "User name is required"
				elseif len(TempValue) < 5 then
					CheckField = "User name cannot be less than 5 characters"
				elseif request.form("Submit") = "Create User" then
					Database.Open MySql
					Set dbQuery = Database.Execute("Select userName From tbl_users Where userName = '" + request.form("username")+"'")
					do while not dbQuery.eof
						i = i + 1
						dbQuery.Movenext
					loop
					Database.Close
					if i > 0 then
						CheckField = "User name already taken, please choose a different one."
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
	end if
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

Sub UpdateProfile
	Database.Open MySql
	dim sqlrealtionID, rsrelationID, addressID, userID, companyID

	sqlInformation = "Update tbl_addresses Set address='" & request.form("addOne") & "', addressTwo='" & request.form("addTwo") & "', city='" & request.form("city") & _
	"', state='" & request.form("state") & "', zip='" & request.form("zipcode") & "', country='" & request.form("country") & "' Where addressID=" & _
	addressId
	set dbQuery = Database.Execute(sqlInformation)
	
	sqlInformation = "Update tbl_users Set userPassword='" & request.form("password") & "', userEmail='" & request.form("email") & "', userAlternateeMail='" & _
	request.form("reemail") & "', userPhone='" & FormatPhone(request.form("pphone")) & "', userSPhone='" & FormatPhone(request.form("sphone")) & _
	"', title='" & request.form("title") & "', firstName='" & request.form("nameF") & "', lastName='" & _
	request.form("nameL") & "' Where userID=" & user_id
	set dbQuery=Database.Execute(sqlInformation)

	Database.Close
End Sub

Sub ShowConfirmation %>
  <div class="sideMargin border bottommargin">
    <div class="normalTitle">Account Profile Updated</div>
    <p style="text-align:left; margin-bottom:10;margin-left:10;margin-right:10;"> Your Acount Profile Was Successfully Updated.</p>
  </div>
  <%
End Sub
%>
  <!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
