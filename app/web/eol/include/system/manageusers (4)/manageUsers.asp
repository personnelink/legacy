<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
<!-- Revised: 07.23.2008 -->
<% 
'---- App Directory and Native Image Constants
FormPostTo = "/tools/system/manageusers/manageUsers.asp?Action="
%>
<SCRIPT language="JavaScript">
<!--
function confirmDelete(sheetID)
{
 var where_to= confirm("Do you really want to delete selected user(s)?");
 if (where_to== true)
 {
   window.location="/tools/system/manageusers/manageUsers.asp?Action=3";
 }
}
//-->
</SCRIPT>
<%

Const linkImgUser = "<img style='border:none;' src='/include/style/images/ico_user.gif'>"

Dim LooksGood

LooksGood = true
If CheckField("username") <> "" Then LooksGood = false
If CheckField("password") <> "" Then LooksGood = false
If CheckField("nameF") <> "" Then LooksGood = false
If CheckField("nameL") <> "" Then LooksGood = false

If LooksGood = true And Request.Form("formAction") = "Create User" Then 
	CreateUserAccount
	ShowUsers
ElseIf LooksGood = true And Request.Form("formAction") = "Update User" Then
	UpdateUserAccount
	ShowUsers
End If

If Request.Form("task") = "Delete Selected" Then DeleteUsers

Select Case Trim(Request.QueryString("Action")) 
	Case remove
		DeleteUsers
		ShowUsers
	Case manage
		ShowUsers
	Case Else
		ShowUserForm
End Select

Sub ShowUsers
	Dim ID, DisplayName, i, UserID, CompanyUsers(), PPlusTemps()

	dLink = "<a href='/tools/system/manageusers/manageUsers.asp?Action=" & view & "&amp;UserID="
	DisplayName = 0
	UserID = 1
	Email = 2
	Database.Open MySql
	
	i = CountRecords("userID", "tbl_users", "companyID=" & Session("companyID"))
	Redim CompanyUsers(i, 2)
	
	Set dbQuery = Database.Execute("Select userID, userEmail From tbl_users Where companyID=" & Session("companyID")) 
	i = 0
	If dbQuery.EOF = True Then NoUsers = True
	Do While Not dbQuery.EOF
		ID = dbQuery("userID")
		CompanyUsers(i, DisplayName) = GetName(ID)
		CompanyUsers(i, userID) = ID & "'>"
		CompanyUsers(i, Email) = GetEmail(ID)
		i = i + 1
		dbQuery.Movenext
	Loop
	%>
<form action="<%=FormPostTo & remove%>" method="post" name="taskaccount">
	<div class="bordered">
		<div class="normalTitle" style="margin-bottom:0;">Manage User Accounts</div>
		<div class="pageSubContent">
			<table>
				<tr>
					<td width='3%'></td>
					<td width='30%'></td>
					<td width='3%'></td>
					<td width='30%'></td>
					<td width='3%'></td>
					<td width='30%'></td>
				</tr>
				<tr>
					<%
				For i = 0 to ubound(CompanyUsers) - 1
					If x > 2 Then 
						x = 0
						Response.Write("</tr><tr></tr><tr>")
					End If
					x = x + 1 
					Response.Write("<td valign='top'><input class='borNone' type='checkbox' name='checkUser" & CompanyUsers(i, userID) & linkImgUser)
					Response.Write("</td><td valign='top'>" & dLink & CompanyUsers(i, userID))
					Response.Write(CompanyUsers(i, DisplayName) & "<br>" & "<span class='tiny'>" & CompanyUsers(i, Email) & "</span></a></td><br>")
				Next
				If NoUsers = True Then
					Response.Write("<td>No Users Found, Click Add Users Below To Get Started.</td>")
				End If
				%>
				</tr>
			</table>
		</div>
	</div>
	<input type="hidden" name="formAction" value="">
	<p>To Manage a User, Click on There Account Above</p>
	<div class="buttonwrapper" style="padding:10px 0 10px 0;"><a class="squarebutton" href="<%=FormPostTo & add%>" onclick="document.manageUser.formAction.value='<%=SubmitValue%>'" style="margin-left: 6px"><span>Add User</span></a><a class="squarebutton" href="<%=FormPostTo & remove%>" onclick="document.taskaction.formAction.value='remove';document.taskaction.submit()"><span>Delete Selected</span></a></div>
</form>
<%
	Set dbQuery = Nothing
	Database.Close
	
	TheEnd
End Sub

Sub ShowUserForm
Dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail


Submit = Request.Form("formAction")
If Submit = "Update User" Or Submit = "Revert Back" Then
	SubmitValue = "Update User"
	ResetValue = "Revert Back"
Else
	SubmitValue = "Create User"
	ResetValue = "Start Over"
End If

If Request.Form("UserNameReadOnly") = "true" Then CantChangeUserName = "ReadOnly"

If Request.Form("task") = "Delete Selected" Then ShowUsers

If Request.QueryString("action") = add Then
	If Request.Form("formAction") <> "Start Over" Then
		Title = Request.Form("title")
		Department = Request.Form("department")
		CompanyName = Request.Form("companyname")
		FirstName = Request.Form("nameF")
		LastName = Request.Form("nameL")
		PrimaryPhone = FormatPhone(Request.Form("Pphone"))
		SecondaryPhone = FormatPhone(Request.Form("Sphone"))
		eMail = Request.Form("email")
		ReeMail = Request.Form("reemail")
		AddressOne = Request.Form("addOne")
		AddressTwo = Request.Form("addTwo")
		City = Request.Form("city")
		UserState = Request.Form("state")
		ZipCode = Request.Form("zipcode")
		Country = Request.Form("country")
		UserName = Request.Form("userName")
		Password = Request.Form("password")
		UserLevel = Request.Form("security")
		ConfirmPassword = Request.Form("retypedpassword")
		
	End If
ElseIf Request.QueryString("action") = view Then
	SubmitValue = "Update User"
	ResetValue = "Revert Back"
	
	Database.Open MySql
	Set dbQuery = Database.Execute("Select * From tbl_users Where userID=" & Request.QueryString("UserID"))
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
	If Not dbQuery.EOF Then
		AddressOne = dbQuery("address")
		AddressTwo = dbQuery("addressTwo")
		City = dbQuery("city")
		UserState = dbQuery("state")
		ZipCode = dbQuery("zip")
		Country = dbQuery("country")
	End If
	Database.Close
ElseIf Request.QueryString("action") = "" Then
	ShowUsers
End If

If userLevel =< userLevelAdministrator Then
	SecurityLowScope = UserLevelSupervisor / 2
	SecurityHighScope = UserLevelAdministrator * 2
ElseIf userLevel =< userLevelPPlusAdministrator Then
	SecurityLowScope = UserLevelPPlusStaff / 2
	SecurityHighScope = UserLevelPPlusAdministrator * 2
End If
%>
<form name="manageUser" method="post" action="<%=FormPostTo & add%>">
	<div class="bordered">
		<div class="normalTitle">User Account Profile Information</div>
		<div class="pageSubContent">
			<p><img src="/include/style/images/createUser.jpg" style="padding:15px"></p>
			<p>
				<label for="title">Title</label>
				<input type="text" name="title" size="30" value="<%=Title%>">
			</p>
			<p class="formErrMsg"><%=CheckField("title")%>&nbsp;</p>
			<p>
				<label for="nameF">First Name</label>
				<input type="text" name="nameF" size="30" value="<%=FirstName%>">
			</p>
			<p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameF")%>&nbsp;</p>
			<p>
				<label for="nameL">Last Name</label>
				<input type="text" name="nameL" size="30" value="<%=LastName%>">
			</p>
			<p class="formErrMsg"><%=CheckField("nameL")%>&nbsp;</p>
			<p>
				<label for="Pphone">Phone</label>
				<input type="text" name="Pphone" size="30" value="<%=PrimaryPhone%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="Sphone">Alt. Phone</label>
				<input type="text" name="Sphone" size="30" value="<%=SecondaryPhone%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="email">eMail</label>
				<input type="text" name="email" size="30" value="<%=eMail%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="reemail">Second eMail</label>
				<input type="text" name="reemail" size="30" value="<%=AlternateeMail%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="department">Department</label>
				<select name="department">
					<option value="000">Not Assigned to a Department</option>
					<%=PopulateList("tbl_departments Where companyID=" & Session("companyID"), "departmentID", "name", "Order By name", Department)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="addOne">Address</label>
				<input type="text" name="addOne" size="30" value="<%=AddressOne%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="addTwo">Address Two</label>
				<input type="text" name="addTwo" size="30" value="<%=AddressTwo%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="City">City</label>
				<input type="text" name="City" size="20" value="<%=City%>">
			</p>
			<p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
			<label for="state">State</label>
			<select name="state">
				<option value="ID">ID</option>
				<%=PopulateList("list_locations", "locCode", "locCode", "locCode", UserState)%>
			</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="zipcode">Zip Code</label>
				<input type="text" name="zipcode" size="19" value="<%=ZipCode%>">
			</p>
			<p>
			<p class="formErrMsg">&nbsp;</p>
			<p><label for="country">Country</label>
			<select name="country" value="<%=Country%>">
				<option value="USA">USA</option>
				<option value="CA">CA</option>
			</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<div class="normalTitle" style="margin-bottom:10;">User Security Information</div>
			<p>
				<label for="userName">User Name</label>
				<input type="text" name="username" size="30" <%=CantChangeUserName%> value="<%=UserName%>">
			</p>
			<p class="formErrMsg"><%=CheckField("username")%>&nbsp;</p>
			<p>
				<label for="security">Security Level</label>
				<select name="security">
					<%=PopulateList("list_security Where userlevel > " & SecurityLowScope & " and userlevel < " & SecurityHighScope, "userlevel", "displayname", "Order By userlevel", UserLevel)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="password">Password</label>
				<input type="password" name="password" size="30" value="<%=Password%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="retypedpassword">Retype Password</label>
				<input type="password" name="retypedpassword" size="30" value="<%=ConfirmPassword%>">
			</p>
			<p class="formErrMsg"><%=CheckField("password")%>&nbsp;</p>
			<%
				If CantChangeUserName <> "" Then Response.Write("<input name='UserNameReadOnly' type='hidden' value='true'>")	%>
			<input name="userID" type="hidden" value="<%=Request.QueryString("UserID")%>">
			<input name="address" type="hidden" value="<%=addressID%>">
			<input name="formAction" type="hidden" value="">
		</div>
	</div>
	<div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:;" onclick="document.manageUser.formAction.value='<%=SubmitValue%>';document.manageUser.submit();" style="margin-left: 6px"><span><%=SubmitValue%></span></a> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.manageUser.formAction.value='<%=ResetValue%>';document.manageUser.submit();"><span><%=ResetValue%></span></a> <a class="squarebutton" href="<%=FormPostTo & manage%>"><span>Return To Manage Users</span></a> </div>
	</div>
</form>
<%
End Sub

Function CheckField (formField)
	If Request.QueryString("action") <> view Then
		Select Case	formField
			Case "username"
				TempValue = Request.Form("username")
				If TempValue = "" Then
					CheckField = "User name is required"
				ElseIf Len(TempValue) < 5 Then
					CheckField = "User name cannot be less than 5 characters"
				ElseIf Request.Form("formAction") = "Create User" Then
					Database.Open MySql
					Set dbQuery = Database.Execute("Select userName From tbl_users Where userName = '" + request.form("username")+"'")
					Do While Not dbQuery.EOF
						i = i + 1
						dbQuery.Movenext
					Loop
					Database.Close
					If i > 0 Then
						CheckField = "User name already taken, please choose a different one."
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
	End If
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
	"'Personnel'," & _
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
	
	sqlInformation = "INSERT INTO tbl_users (addressID, companyID, userName, userPassword, userLevel, departmentID, userEmail, userAlternateeMail, userPhone, userSPhone" & _
	", title, firstName, lastName, CreationDate) VALUES (" & _ 
	"'" & dbQuery("addressID") & "'," & _
	"'" & Session("companyID") & "'," & _
	"'" & Request.Form("username") & "'," & _
	"'" & Request.Form("password") & "'," & _
	"'" & Request.Form("security") & "'," & _
	"'" & Request.Form("department") & "'," & _
	"'" & Request.Form("email") & "'," & _
	"'" & Request.Form("reemail") & "'," & _
	"'" & FormatPhone(Request.Form("pphone")) & "'," & _
	"'" & FormatPhone(Request.Form("sphone")) & "'," & _
	"'" & Request.Form("title") & "'," & _
	"'" & Request.Form("nameF") & "'," & _
	"'" & Request.Form("nameL") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)

	set dbQuery=Database.Execute("Select userID From tbl_users WHERE CreationDate=#" & creationStamp & "#")
	userID=dbQuery("userID")
	
	set dbQuery=Database.Execute("UPDATE tbl_addresses SET userID=" & userID & " WHERE CreationDate=#" & creationStamp & "#")
	Database.Close
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub UpdateUserAccount
	Database.Open MySql
	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID

	sqlInformation = "Update tbl_addresses Set address='" & Request.Form("addOne") & "', addressTwo='" & Request.Form("addTwo") & "', city='" & Request.Form("city") & _
	"', state='" & Request.Form("state") & "', zip='" & Request.Form("zipcode") & "', country='" & Request.Form("country") & "' Where addressID=" & _
	Request.Form("address")
	set dbQuery=Database.Execute(sqlInformation)
	
	sqlInformation = "Update tbl_users Set userName='" & Request.Form("username") & "', userPassword='" & Request.Form("password") & "', userLevel=" & _
	Request.Form("security") & ", departmentID=" & Request.Form("department") & ", userEmail='" & Request.Form("email") & "', userAlternateeMail='" & _
	Request.Form("reemail") & "', userPhone='" & FormatPhone(Request.Form("pphone")) & "', userSPhone='" & FormatPhone(Request.Form("sphone")) & _
	"', title='" & Request.Form("title") & "', firstName='" & Request.Form("nameF") & "', lastName='" & _
	Request.Form("nameL") & "' Where userID=" & Request.Form("userID")
	set dbQuery=Database.Execute(sqlInformation)

	Database.Close
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub DeleteUsers

	Dim ID, DisplayName, i, UserID, UsersToAxe(), PPlusTemps()
	UserID = 1
	Database.Open MySql
	i = CountRecords("userID", "tbl_users", "companyID=" & Session("companyID"))
	Redim UsersToAxe(i)
	
	Set dbQuery = Database.Execute("Select userID, firstName, lastName From tbl_users Where companyID=" & Session("companyID")) 
	i = 0
	Do While Not dbQuery.EOF
		UsersToAxe(i) = dbQuery("userID")
		If Request.Form("checkUser" & UsersToAxe(i)) = "on" Then
			AxedUsers = AxedUsers & dbQuery("firstName") & " " & " " & dbQuery("lastName") & "; "
		End If
		i = i + 1
		dbQuery.Movenext
	Loop

	For i = 0 To UBound(UsersToAxe)
		If Request.Form("checkUser" & UsersToAxe(i)) = "on" Then
			Database.Execute("Delete From tbl_users Where userID=" & UsersToAxe(i))
			Database.Execute("Delete From tbl_addresses Where userID=" & UsersToAxe(i))
			Database.Execute("Delete From tbl_messages Where userID=" & UsersToAxe(i))
			'Database.Execute("Delete From tbl_jobRequisitions Where userID=" & UsersToAxe(i))
			'Database.Execute("Delete From tbl_timesheets Where userID=" & UsersToAxe(i))
		End If
	Next
	Set dbQuery = Nothing
	Database.Close
	If Len(AxedUsers) > 0 Then
		%>
<div style="float:right; width:635px;border: 1px solid #97A4B3;margin-bottom:10;">
	<div class="normalTitle">User Account(s) Deleted</div>
	<p style="text-align:left; margin-bottom:20;padding:20;">The following users and all related information (less Time Data and Job Requisitions) have been removed from the system:<br>
		<br>
		<%=AxedUsers%> 
</div>
<%
	End If
End Sub
%>
<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
