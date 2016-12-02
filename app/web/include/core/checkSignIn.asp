<%

dim qsSecret, qsUsername
	qsSecret = request.querystring("secret")
	qsUsername = request.querystring("token")

Sub ShowVMSLogin 
	if not is_mobile then
		showLeftSideMenu = true
	elseif is_mobile then
		showLeftSideMenu = false
	end if	
	
	dim Username
	dim Password
	dim LoginPreference
	dim SavedLogin
	dim x
	
	if global_debug then
		output_debug("* ShowVMSLogin: Starting Sub *")
		output_debug("*               formSignInAction: " & formSignInAction & " *")
		output_debug("*               formSignInAction: " & formSignInAction & " *")
	end if
	
	
	response.write header_response & ie_ifs
	
	if session("no-flush") <> true then response.Flush()

	header_response = ""
	ie_ifs = ""

		
	'debugging override, also possibly other collaborative uses with debugging client and employee perspectives
	if len(qsUsername) > 0 and len(qsSecret) > 0 then
		UserName = qsUsername
		Password = qsSecret
	else
		UserName = request.form("username")
		Password = request.form("password")
	end if 
	
	if global_debug then 
		output_debug("* Username from form is: " & UserName & " *")
		output_debug("* Password from form is: " & Password & " *")
		output_debug("* --- Beggining Form Data Iteration --- *")
		
		dim debug_form_data
		For debug_form_data = 1 to Request.Form.Count
			output_debug(Request.Form.Key(debug_form_data) & " = " & Request.Form.Item(debug_form_data))
		Next
		output_debug("* --- Done Form Data Iteration --- *")
	end if
	
	dim SubmitOnce, noGuest, noYou, noYouBody
	
	noYou = get_session("heading")
	if len(noYou) > 0 then
		
		if global_debug then output_debug("* Len(noYou) is greater than Zero *")

		noYouBody = decorateTop("SubmitOnce", "marLRB10", "")
		noYouBody = noYouBody & get_message(noYou)
		
		response.Write noYouBody
		response.write(decorateBottom())

	elseif global_debug then
		output_debug("* Len(noYou) IS Zero *")
	end if

	if len(no_you_heading ) > 0 then
		response.write decorateTop("SubmitOnce", "marLRB10", no_you_heading)
		response.Write no_you_body
		response.write decorateBottom()
	end if

	noGuest = len(noGuestHead) + len(session("noGuestHead"))
	'break noGuest
	if noGuest > 0 then
		
		if global_debug then output_debug("* noGuest is greater than Zero *")
		
		noGuestBody = get_message(noGuestHead) & session("noGuestBody")
		
		SubmitOnce = "<div id=""betaTesting"" style=""background: url('" & imageURL & "/include/system/tools/images/testing.png')" &_
			"no-repeat top left; padding-left:11em; height:6.5em""><p>" &_
			noGuestBody & "</div>"
		
		response.write(decorateTop("SubmitOnce", "marLRB10", ""))
		response.write(SubmitOnce)
		response.write(decorateBottom())

	else 
		if global_debug then output_debug("* noGuest is Zero *")
	end if

	if global_debug then output_debug("* Showing Loggin Form *")
%>
<%=decorateTop("", "marLRB10 checkSignIn", "Create A Personnel Plus Account?")%>

      <p> Employees and employers both can benefit by registering! Manage timecards, jobs, resumes and more!</p>
	  <p><input id="signUpAccountButton" type="submit" value="Sign Up" class="btn" onclick="document.location='/include/user/create/';"></p>
<%=decorateBottom()%>
<%=decorateTop("getSignedIn", "marLRB10 checkSignIn", "Log in to your account.")%>
    <form name="SignIn" id="SignIn" method="post" action="#">
      <p>Username:<br>
        <input class="credential" type="text" id="username" name="username" size="38" value="<%=UserName%>">
        <br />
        <span style="font-style:italic; color:#999999">(This is typically your email address)</span></p>
      <p class="formErrMsg"><%=CheckVMSLogin("username")%>&nbsp;</p>
      <p>Password:<br >
        <input class="credential" type="password" name="password" size="38" value="<%=Password%>"></p>
      <p class="formErrMsg"><%=CheckVMSLogin("password")%></p>
     <p><input name="signinbtn" value="Log In" type="submit" class="btn" onclick="doSignIn()"></p>
	 <p><a href="/include/user/password/reset/">Forgot my username or password?</a></p>
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
		
if len(noGuestBody) > 0 then

	if global_debug then output_debug("* len(noGuestBody) IS > 0 *")

	dim rtemp : rtemp = set_session("noGuestBody", "")

Else
		
	dim guestVerbiage
	guestVerbiage = "<p>Continue without signing in and create an account later.</p>" &_
		"<p><input id=""signInGuestButton"" value=""Continue as a guest"" type=""button"" class=""btn"" onclick=""signInGuest();return true;""></p>"
	
	response.write decorateTop("", "marLRB10 checkSignIn", "Continue without creating an account.")
	response.write(guestVerbiage)
	response.write(decorateBottom())
end if

noSocial = true %>
 
<script type="text/javascript" src="/include/js/global.js"></script>
<script type="text/javascript" src="/include/js/jquery-1.9.1.min.js"></script>

<script type="text/javascript"><!--

function setCookie(c_name,value,exdays) {
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	document.cookie=c_name + "=" + c_value;
}

function doSignIn() {
	grayOut(true);
	setCookie("signin", "true", 1);
	document.forms['SignIn'].formSignInAction.value='Sign In';
	document.forms['SignIn'].submit();
}

function signInGuest() {
	setCookie("signin", "true", 1)
	document.forms['SignIn'].username.value="Guest";
	document.forms['SignIn'].password.value="guest";
	document.forms['SignIn'].formSignInAction.value="Sign In";
	document.forms['SignIn'].submit();
}

document.SignIn.username.focus() //-->

</script>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
<%

if global_debug then output_debug("* ShowVMSLogin done *")

response.End()
End Sub


Function CheckVMSLogin (FormField)
	if global_debug then output_debug("* CheckVMSLogin called *")
	
	dim UserName, Password

	if len(qsUsername) > 0 then
		UserName = qsUsername
		if global_debug then output_debug("* CheckVMSLogin: qsUsername > 0; UserName set from QueryString: [" & UserName & "] *")
	else
		UserName = Replace(request.form("username"), "'", "''")
		if global_debug then output_debug("* CheckVMSLogin: qsUsername NOT > 0; UserName set from Form: [" & UserName & "] *")
	end if
		
	if len(qsSecret) > 0 then
		Password = qsSecret
		if global_debug then output_debug("* CheckVMSLogin: qsSecret > 0; Password set from QueryString: [" & Password & "] *")
	else
		Password = request.form("password")
		if global_debug then output_debug("* CheckVMSLogin: qsSecret NOT > 0; Password set from Form: [" & Password & "] *")
	end if
	
	On Error Resume Next
		Database.Close
	On Error GoTo 0

	Database.Open MySql
	Set dbQuery = Database.Execute("Select userPassword, userID From tbl_users Where userName = '" & UserName & "'")
	
	Select Case FormField
		Case "username"
			if UserName = "" then
				if global_debug then output_debug("* CheckVMSLogin: ""FormField"" Case = ""username""; Returning value: ""Username is required"" *")
				CheckVMSLogin = errImage & " Username is required "
			Else
				if global_debug then output_debug("* CheckVMSLogin: ""FormField"" Case = ""username""; Returning value: """" [is not = """"] *")
				CheckVMSLogin = ""
			end if
		Case "password"
			if Password = "" then
				if global_debug then output_debug("* CheckVMSLogin: ""FormField"" Case = ""password"";  Returning value: ""Password is required"" *")
				CheckVMSLogin = errImage & " Password is required "
			elseif dbQuery.eof then
				if global_debug then output_debug("* CheckVMSLogin: dbQuery.eof IS true; Return error ""Invalid Username or Password"" *")
				CheckVMSLogin = errImage & " Invalid Username or Password "
			elseif Trim(Password) = Trim(dbQuery("userPassword")) then
				if global_debug then output_debug("* CheckVMSLogin: User_Auth is good, set: user_id *")

				user_id = dbQuery("userID")
				CheckVMSLogin = ""
			Else 
				if global_debug then 
					output_debug("* CheckVMSLogin: Select Case FormField [Value " & FormField & "]:  *")
					output_debug("*              : Case Else True:  = "" *")
					output_debug("*              : CheckVMSLogin returned ""Invalid Username or Password"" *")
				end if
				
				CheckVMSLogin = errImage & " Invalid Username or Password "
			end if
	End Select
	
	'if request.form("formSignInAction") <> "Sign In" then
	if formSignInAction <> "Sign In" then
		if global_debug then output_debug("* CheckVMSLogin: formSignInAction IS NOT ""Sign In"" *")

		CheckVMSLogin = ""
	elseif global_debug then 
		output_debug("* CheckVMSLogin: formSignInAction IS ""Sign In"" *")
	end if

	Set dbQuery = Nothing
	Database.Close

	if global_debug then output_debug("* CheckVMSLogin: Finished *")

End Function
%>
