<%Option Explicit%>
<%
Response.Expires = -1000 'Makes the browser not cache this page
Response.Buffer = true 'Buffers the content so our Response.Redirect will work

session("additionalHeading") = "<meta http-equiv=""Cache-Control"" content=""No-Cache"">" &_
	"<meta http-equiv=""Cache-Control"" content=""No-Store"">" &_
	"<meta http-equiv=""Pragma"" content=""No-Cache"">" &_
	"<meta http-equiv=""Expires"" content=""0"">"
	
session("no_header") = true

session("add_css") = "general.asp.css" 
session("additionalScripting") = "<script type=""text/javascript"" src=""/include/js/resetPassword.js""></script>" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->
<%
dim no_account_found
	no_account_found = get_session("noAccountFound")
	

session_signed_in = false
dim email, LooksGood
email = Replace(request.form("email"), "'", "''")

dim send_reset
send_reset = request.form("submit")
if send_reset = "Send Password Reset" then
	LooksGood = true
	ShowConfirmation
else
	response.write header_response & ie_ifs
	if len(no_account_found) > 0 then

		response.write(decorateTop("noAccount", "marLR10", "Could Not Locate Your Account"))
		response.write(no_account_found)
		response.write(decorateBottom())
		no_account_found = set_session("noAccountFound", "")
	end if
	ShowRequestForm
	
end if

Sub ShowRequestForm

%>
	<%=decorateTop("ResetForm", "marLR10", "Login Name and Password Assistance")%>
    <form name="resetPassword" action="resetPassword.asp" method="post">
    <table>
        <tbody>
        <tr><td colspan="2">Please provide your Email Address or Login Name. An email with a link to reset your password will be sent to the email address associated with your account.</td>
		</tr>
		<tr>
            <td>Username or email:</td>
            <td><input size="255" name="email" value="<%=email%>" type="edit">
        <script type="text/javascript"><!-- 
						document.resetPassword.Email.focus()
							//--></script>
          </td>
          </tr>
		  <tr><td></td><td><input name="submit" value="Send Password Reset" type="submit" class="btn"></td></tr>
      </tbody>
      </table>
  </form>
 <%=decorateBottom()%><%
End Sub

Sub ShowConfirmation
	dim lastNameFirst, msgSubject, msgBody, interest, zipcode, deliveryLocation(2), firstName, lastName
	dim pGuid, resetlink, resetKey
	dim prEmail, prSql, prUser
	
	pGuid = GetGuid()
	'reset key valid, now search for valid username, email or alternate email
	prEmail = Replace(email, "'", "''")
	prEmail = Replace(prEmail, """", """""")
	
	Database.Open MySql

	Database.Execute("insert into tbl_resetrequests (guid, useremail) VALUES ('" & pGuid & "',  '" & email & "'); ")

	
	prSql = "SELECT userName, userEmail, UserAlternateEmail FROM tbl_users " &_
		"WHERE (userName='" & prEmail & "') " &_
		"OR (userEmail='" & prEmail & "') " &_
		"OR (UserAlternateEmail='" & prEmail & "')"
		
	'Break prSql
	Set dbQuery = Database.Execute(prSql)
	
	'if valid username is found, then procede with password reset [this completes account control verification]
	if Not dbQuery.Eof then
	
		response.write header_response & ie_ifs
		response.write decorateTop("ResetForm", "marLR10", "Login Name and Password Assistance")
		
		' check if no registered emails, if so send notice to branch about user issue
		dim blnHasAddress
			blnHasAddress = false
			
		dim sendToAddress
		'check if user has valid email address
		sendToAddress = dbQuery("userEmail")
		if len(sendToAddress) > 0 then
			if Instr(sendToAddress, "@") > 0 And Instr(sendToAddress, ".") > 0 then
				deliveryLocation(0) = trim(lcase(sendToAddress))
				blnHasAddress = true
			end if
		end if
		
		'if len(deliveryLocation) = 0 then
			'if no valid email, check alternate
			sendToAddress = dbQuery("UserAlternateEmail")
			if len(sendToAddress) > 0 then
				if Instr(sendToAddress, "@") > 0 And Instr(sendToAddress, ".") > 0 then
					deliveryLocation(1) = trim(lcase(sendToAddress))
					blnHasAddress = true
				end if
			end if
		'end if

		'if len(deliveryLocation) = 0 then
			'if no alternate see if user name passes for an email address
			sendToAddress = dbQuery("userName") 
			if len(sendToAddress) > 0 then
				if Instr(sendToAddress, "@") > 0 And Instr(sendToAddress, ".") > 0 then
					deliveryLocation(2) = trim(lcase(sendToAddress))
					blnHasAddress = true
				end if
			end if
		'end if
		
		if not blnHasAddress then
			'all else fails send reset request to an office for now
			Set dbQuery = Database.Execute("Select list_zips.email From list_zips Where zip='" & zipcode & "';")
			if Not dbQuery.eof then
				deliveryLocation(0) = dbQuery("email")
			Else
				deliveryLocation(0) = "twinfalls@personnel.com"
			end if
		end if

		prUser = dbQuery("userName")
		'put together reset link
		resetkey = right(pGuid, len(pGuid)-1)
		resetkey = left(resetkey, len(resetkey)-1)
		resetlink = "/include/user/password/change/?resetkey=" & resetkey
		
		'Determine destination
		
		Set dbQuery = Database.Execute("Select subject, body From email_templates Where template='passwordReset'")
		
		msgSubject = dbQuery("subject")
		
		msgBody = Replace(dbQuery("body"), "%username%", prUser)
		msgBody = Replace(msgBody, "%link%", resetlink)
		dim i
		for i = 0 to 2
			' check if all three are same on first loop
			' if so push set iteration to last, this will send one email and end loop
			if i = 0 then 

				' check if the user name is the same as the email or alternate email, if so skip it.
				if deliveryLocation(0) = deliveryLocation(1) or deliveryLocation(0) = deliveryLocation(2) then i = 1
				
				' check if all the same
				if deliveryLocation(0) = deliveryLocation(1) and deliveryLocation(0) = deliveryLocation(2) then	i = 2

			end if
			if len(deliveryLocation(i)) > 0 then
				if Err.Number = 0 then
					Call SendEmail (deliveryLocation(i), account_system_email, msgSubject, msgBody, "")
				else
					Call SendEmail ("debug@personnel.com", account_system_email, "Debug: " & Err.Number & " : " & msgSubject, msgBody, "")
				end if
			end if
		next
		response.write("<div id=" & chr(34) & "betaTesting" & chr(34) & " style=" & chr(34) & "background: url('/include/system/tools/images/testing.png') " &_
				"no-repeat top left; padding-left:11em; height:6.5em" & chr(34) & "><p>" &_
				"<p>Thank you.</p><br><p>An email was sent to the address provided, you should receive instructions in a moment.</p><br><p>" &_
				"<a href=" & Chr(34) & "/userHome.asp" & Chr(34) & ">Click Here to return to sign in...</a></div>")
		
	Else
		'email address wasn't so good, apologize to user for them forgetting password and redirect back to try again
		no_account_found = "<div id='noAccountFound'><p>There was some trouble locating an account. In fact, I couldn't find one at all.</p><br>" &_
						"<p>Enter something else below and we'll try again. It's nothing personal, these things happen!</p></div>"
			
		no_account_found = set_session("noAccountFound", no_account_found)
		
		Response.Redirect("/include/user/resetPassword.asp")
	
	end if
	Database.Close
	Response.write decorateBottom()	
End Sub

%>

<!-- #INCLUDE VIRTUAL='include/core/pageFooter.asp' -->

