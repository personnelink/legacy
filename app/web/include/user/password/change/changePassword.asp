<%Option Explicit%>
<%
session("required_user_level") = 1 'userLevelRegistered
session("window_page_title") = "Change My Password - Personnel Plus"
dim resetKey
resetkey = Replace(Request.QueryString("resetkey"), "'", "''")
resetkey = Replace(resetkey, """", "")

'set password reset flag [in order to allow alternate authenticated access to this utility]
dim intNothing
if len(resetkey) > 0 then 
	dim modifyAction
	modifyAction = "?resetkey=" & resetkey
	gResettingPassword = true
else
	session("noGuestHead") = "Are you registered?"
	session("noGuestBody") = "<p><em>Are you registered?</em></p><br><p>The Guest account password cannot be changed. " &_
		"You can create an account by pressing ""Sign Up"" below and registering or " &_
		"if you have already registed you can use that account to sign in and continue.</p><br><br>"
end if

session("add_css") = "shortForms.asp.css"
session("no_header") = true

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<!-- Revised: 2012.05.01 'password reset scripting -->
<!-- Revised: 2010.06.01 'password reset scripting -->
<!-- Created: 12.15.2008 -->

<% 

if user_id = 367 then
	Response.Expires = -1000 'Makes the browser not cache this page
	Response.Buffer = true 'Buffers the content so our Response.Redirect will work
	
	session_signed_in = false
	Session.Abandon()
	Session.Contents.RemoveAll()

	noGuestHead = set_session("noGuestHead", noGuestHead) 
	noGuestBody = set_session("noGuestBody", noGuestBody)

	Response.Redirect("/include/user/password/change/")
end if

'if session("resetpassword") = "resetting" then
if gResettingPassword = true then
	dim prEmail, prSql

	Database.Open MySql

	'Check if valid reset key exists
	Set dbQuery = Database.Execute("SELECT useremail FROM tbl_resetrequests WHERE guid='{" & resetkey & "}'")

	if Not dbQuery.Eof then
		'reset key valid, now search for valid username, email or alternate email
		prEmail = Replace(dbQuery("useremail"), "'", "''")
		prEmail = Replace(prEmail, """", """""")
		
		prSql = "SELECT userID FROM tbl_users " &_
			"WHERE (userName='" & prEmail & "') " &_
			"OR (userEmail='" & prEmail & "') " &_
			"OR (UserAlternateEmail='" & prEmail & "')"
			
		'Break prSql
		Set dbQuery = Database.Execute(prSql)
		
		'if valid username is found, then procede with password reset [this completes account control verification]
		if Not dbQuery.Eof then
			begin_session(dbQuery("userID"))
		Else
			'email address wasn't so good, apologize to user for them forgetting password and redirect back to try again
			dim no_account_found
			no_account_found = "<div id='noAccountFound'><p>There was some trouble locating an account associated with the address " &_
				"provided. In fact, I couldn't find one at all.</p><p>Please don't hesitate to enter a different address of yours below and we'll try again. " &_
				"It's nothing personal, these things happen!</p></div>"
			
			no_account_found = set_session("noAccountFound", no_account_found)
			
			Response.Redirect("/include/user/password/reset/")
	
		end if
	end if
	Database.Close
end if


const SubmitValue = "Change Password"

dim LooksGood
dim UserName
dim FirstName
dim MiddleName
dim LastName
dim AddressOne
dim AddressTwo
dim City
dim UserState
dim ZipCode
dim Country
dim PrimaryPhone
dim SecondaryPhone
dim eMail
dim ReeMail
dim strSessionPassword

if request.form("formAction") <> "false" then

	Database.Open MySql
	Set dbQuery = Database.Execute("Select userName, userPassword From tbl_users Where userID=" & user_id)
	UserName = dbQuery("userName") 
	dim CantChangeUserName : CantChangeUserName = "ReadOnly"

	if gResettingPassword = true then
		intNothing = set_session("userPassword", "resetting")
	Else
		intNothing = set_session("userPassword", dbQuery("userPassword"))

	end if
	Database.Close
Else
	UserName = request.form("userName")
	currentPassword = request.form("currentPassword")
	newPassword = request.form("newPassword")
	confirmPassword = request.form("confirmPassword")
end if


if request.form("formAction") = "false" and CheckField("password") = "" then
	UpdatePassword		
end if

response.write header_response & ie_ifs
response.Flush()


dim currentPassword
dim newPassword
dim confirmPassword


%>

<%=decorateTop("changePasswordForm", "marLR10", "Change Password")%>
<form id="changePasswordForm" name="changePasswordForm" method="post" action="#<%=modifyAction%>">
	<div id="changePasswordContent">
		<p><label for="userName" class="createUser">User Name</label>
		<input type="text" name="username" size="30" ReadOnly value="<%=UserName%>"></p>
		<p>&nbsp;</p>
		<p<%if get_session("userPassword") = "resetting" then response.write " class=""hideThis"""%>><label for="currentPassword">Current Password</label>
		<input type="password" name="currentPassword" id="currentPassword" size="30" value="<%=currentPassword%>"></p>			
		<p><label for="newPassword">New Password</label>
		<input type="password" name="newPassword" size="30" value="<%=newPassword%>"></p>			
		<p><label for="confirmPassword">Retype New Password</label>
		<input type="password" name="confirmPassword" size="30" value="<%=confirmPassword%>"></p>
		<%=CheckField("password")%>
		<input name="formAction" id="formAction" type="hidden" value="false">
		<input name="Submit" id="Submit" type="submit" class="hide" value="<%=SubmitValue%>"></p>
		<p id="changePasswordButton"><a style="float:right;margin:2em 8em 0 0" class="squarebutton" href="javascript:document.forms['changePasswordForm'].submit();" onclick="document.forms['changePasswordForm'].submit();"><span>Change Password</span></a></p>
		<input type="submit" style="display:none" />
		<script type="text/javascript"><!--
		  document.changePasswordForm.currentPassword.focus()
		   //--></script>
   </div>
</form>
<%=decorateBottom()%>

<%
Function CheckField (formField)
	dim badFieldBegin
	dim badFieldEnd
	
	if request.form("formAction") = "false" then
		badFieldBegin = "<p class=" & Chr(34) & "fieldIsBad" & Chr(34) & "><span>&nbsp;</span>"
		badFieldEnd = "</p>"
		Response.write request.form("Submit")
		strSessionPassword = get_session("userPassword")

		if strSessionPassword = request.form("currentPassword") OR strSessionPassword = "resetting" then
			newPassword = request.form("newPassword")
			confirmPassword = request.form("confirmPassword")
			Select Case	formField
				Case "password"
					if newPassword = "" then
						CheckField = badFieldBegin & "Password is required" & badFieldEnd
					elseif newPassword <> confirmPassword then
						CheckField = badFieldBegin & "Passwords do not match" & badFieldEnd
					Else
						CheckField = ""
					end if
			End Select
		Else
			CheckField = badFieldBegin & "Incorrect or invalid current password" & badFieldEnd
		end if
	end if
End Function

Sub UpdatePassword
	Database.Open MySql
	Database.Execute("Update tbl_users Set userPassword='" & request.form("newPassword") & "' Where userID=" & user_id)
	Database.Close
	intNothing = set_session("homeMessageHeading", "Password Successfully Changed")
	intNothing = set_session("homeMessageBody", "<div id=""passwordChanged""><p>Your user account password was successfully changed.</p>" &_
	"<p>Please remember your password and refraim from giving it to other users. if your password becomes compromised, please change your password" &_
	" immediately or contact your system administrator.</p></div>")
	
	Response.Redirect("/userHome.asp")
End Sub

'clear reset password flag
'session("resetpassword") = ""
gResettingPassword = false
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
