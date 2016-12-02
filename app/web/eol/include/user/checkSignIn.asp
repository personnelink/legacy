<%
Response.Expires = -1000 'Makes the browser not cache this page
Response.Buffer = true 'Buffers the content so our Response.Redirect will work

dim errImage, LoginCookie, formSignInAction

errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Informatin'>"

if session("SignedIn") <> "true" then
	'response.write(request.form("signinbtn"))
	dim qsUsername, qsSecret
	qsUsername = replace(request.QueryString("username"), "'", "''")
	qsUsername = replace(qsUsername, """", """""")

	qsSecret   = replace(request.QueryString("password"), "'", "''")
	qsSecret   = replace(qsSecret, """", """""""")
	
	'break qsUsername & " " & qsSecret & "<br>"
	
	if len(qsUsername) > 0 and len(qsSecret) > 0 Then
		formSignInAction = "Sign In"
	else
		formSignInAction = request.form("formSignInAction")
	end if
	
	if formSignInAction = "Sign In" And CheckVMSLogin("password") = "" And CheckVMSLogin("username") = "" then 
		session("SignedIn") = "true"
		SetSession
		dim referringURL, referringQuery
		referringURL = request.serverVariables("URL")
		referringQuery = request.serverVariables("QUERY_STRING")
		if len(Trim(referringQuery)) > 0 then 
			referringURL = referringURL & "?" & referringQuery
			Response.Redirect(referringURL)
		Elseif session("userID") ="367" then
			SetSession
		Else
			ShowVMSLogin
			Response.End
		end if
	end if
end if

Sub ShowVMSLogin 
	dim Username, Password, LoginPreference, SavedLogin, x
	
	'if request.form("signinbtn") <> "Sign In" then 
		UserName = request.form("username")
		Password = request.form("password")
	'end if
	
	dim SubmitOnce, noGuest
	noGuest = len(session("noGuestBody"))
	if noGuest > 0 then
		SubmitOnce = "<div id=""betaTesting"" style=""background: url('" & imageURL & "/include/system/tools/images/testing.png')" &_
			"no-repeat top left; padding-left:11em; height:6.5em" & chr(34) & "><p>" &_
			session("noGuestBody") & "</div>"
		
		response.write(decorateTop("SubmitOnce", "marLRB10", ""))
		response.write(SubmitOnce)
		response.write(decorateBottom())
	end if

%>
<script type="text/javascript">
function signInGuest() {
	document.forms['SignIn'].username.value="Guest";
	document.forms['SignIn'].password.value="guest";
	document.forms['SignIn'].formSignInAction.value="Sign In";
	document.forms['SignIn'].submit();
}
</script>
<%=decorateTop("", "marLRB10 checkSignIn", "Create A Personnel Plus Account?")%>

      <p> Access options, view job listings and keep your application and resume updated!</p>
      <p><input id="signUpAccountButton" type="submit" value="Sign Up" class="btn" onclick="document.location='/include/user/create/';"></p>
<%=decorateBottom()%>
<%=decorateTop("getSignedIn", "marLRB10 checkSignIn", "Log in to your account.")%>
    <form name="SignIn" id="SignIn" method="post" action="">
      <p>Username:<br>
        <input class="credential" type="text" id="username" name="username" size="38" value="<%=UserName%>">
        <br />
        <span style="font-style:italic; color:#999999">(This is typically your email address)</span></p>
      <p class="formErrMsg"><%=CheckVMSLogin("username")%>&nbsp;</p>
      <p>Password:<br >
        <input class="credential" type="password" name="password" size="38" value="<%=Password%>"></p>
      <p class="formErrMsg"><%=CheckVMSLogin("password")%></p>
     <p><input name="signinbtn" value="Log In" type="submit" class="btn" onclick="document.forms['SignIn'].formSignInAction.value='Sign In';document.forms['SignIn'].submit();"></p>
	 <p><a href="/include/user/resetPassword.asp">Forgot my username or password?</a></p>
	 <p>&nbsp;</p>
	<input type="hidden" value="" name="formSignInAction" /><%
	dim formRepostKey
	for x = 1 to Request.Form.count() 
        formRepostKey = Request.Form.key(x)
		Select Case formRepostKey
		Case "password"
			'Dont repost password
		Case "username"
			'Dont repost username
		Case "formSignInAction"
			'Dont repost formSignInAction
		Case "signinbtn"
			'Dont repost formSignInAction
			
		Case Else
			response.write "<input name=""" & formRepostKey & """ value=""" &_
			Request.Form.item(x) & """ type=""hidden"" />" 
    	End Select
	next
%></form><%
response.write(decorateBottom())
		
if len(session("noGuestBody") & "") > 0 then
	session("noGuestBody") = ""
Else
'	guestVerbiage = "<p>Continue without signing in and create an account later.</p>" &_
'		"<p id=""guestButton""><a class=""squarebutton" & Chr(34) &_
'		" href=""javascript:document.forms['SignIn'].username.value='Guest';" &_
'		"document.forms['SignIn'].password.value='guest';document.forms['SignIn'].submit();" & Chr(34) &_
'		" onclick=""document.forms.password.value='guest'; document.forms['SignIn'].submit();" & Chr(34) &_
'		"><span> Continue as a guest </span></a></p>"
		
	dim guestVerbiage
	guestVerbiage = "<p>Continue without signing in and create an account later.</p>" &_
		"<p><input id=""signInGuestButton"" value=""Continue as a guest"" type=""button"" class=""btn"" onclick=""signInGuest();return true;""></p>"
	
	response.write decorateTop("", "marLRB10 checkSignIn", "Continue without creating an account.")
	response.write(guestVerbiage)
	response.write(decorateBottom())
end if

%>
 
  <script type="text/javascript"><!-- 
document.SignIn.username.focus() //--></script>
  <!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
<%
End Sub

Function CheckVMSLogin (FormField)
	dim UserName, Password

	if len(qsUsername) > 0 then
		UserName = qsUsername
	else
		UserName = Replace(request.form("username"), "'", "''")
	end if
		
	if len(qsSecret) > 0 then
		Password = qsSecret
	else
		Password = request.form("password")
	end if
	
	On Error Resume Next
		Database.Close
	On Error GoTo 0

	Database.Open MySql
	Set dbQuery = Database.Execute("Select userPassword, userID From tbl_users Where userName = '" & UserName & "'")
	
	Select Case FormField
		Case "username"
			if UserName = "" then
				CheckVMSLogin = errImage & " Username is required "
			Else
				CheckVMSLogin = ""
			end if
		Case "password"
			if Password = "" then
				CheckVMSLogin = errImage & " Password is required "
			Elseif dbQuery.eof then
				CheckVMSLogin = errImage & " Invalid Username or Password "
			Elseif Trim(Password) = Trim(dbQuery("userPassword")) then
				session("userID") = dbQuery("userID")
				CheckVMSLogin = ""
			Else 
				CheckVMSLogin = errImage & " Invalid Username or Password "
			end if
	End Select
	
	if request.form("formSignInAction") <> "Sign In" then  CheckVMSLogin = ""
	Set dbQuery = Nothing
	Database.Close
End Function
%>
