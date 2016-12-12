<% 
dim global_debug
select case request.querystring("debugging")
case "1"
	global_debug = true
case else
	global_debug = false
end select

dim qsUsername, qsSecret
qsUsername = replace(request.QueryString("qsuser"), "'", "''")

qsSecret   = replace(request.QueryString("qssecret"), "'", "''")


if global_debug then
	dim  objFS, debug_log
	set objFS=Server.CreateObject("Scripting.FileSystemObject")
	const FilePath = "c:\vmsDebug\vms_debug.txt"
	if objFS.FileExists(FilePath) then
		set debug_log=objFS.OpenTextFile(FilePath, 8) '8 = Appending
	else
		set debug_log=objFS.CreateTextFile("c:\vmsDebug\vms_debug.txt",true)
	end if
		
	debug_log.WriteLine("--- Start Logging ---")
	debug_log.WriteLine(time())
end if
%>

<!-- #INCLUDE VIRTUAL='include/core/html_header.asp' -->
<% if global_debug then output_debug("* Finished html_header.asp *") %>

<!-- #INCLUDE VIRTUAL='include/core/checkSignIn.asp' -->
<% if global_debug then output_debug("* Finished checkSignIn.asp *") %>

<%
if not gResettingPassword then 
	
	'debug tracing
	if global_debug then output_debug("* NOT resetting password. *")
	
	Response.Buffer = true
	
	dim errImage, LoginCookie, formSignInAction
	
	errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Information'>"
	
	if len(qsUsername) > 0 and len(qsSecret) > 0 Then
		if not session_signed_in then 
			formSignInAction = "Sign In"
			response.cookies("signin") = "false"
		end if
	else
		if request.cookies("signin") = "true"  then
			if session_signed_in and user_id = guest_account then 
				response.cookies("signin") = "false"
				formSignInAction = "Sign In"
			elseif not session_signed_in then
				response.cookies("signin") = "false"
				formSignInAction = "Sign In"
			end if
		end if
	end if
	'print len(qsSecret) & " - len - " & len(qsUsername)
	
	if not session_signed_in or (session_signed_in and formSignInAction = "Sign In") then
		'print "session_not signed in"
		
		if formSignInAction = "Sign In" And CheckVMSLogin("password") = "" And CheckVMSLogin("username") = "" then 
			begin_session(user_id)
			if global_debug then output_debug("* init_secure_session: begin_session finished *")
			dim referringURL, referringQuery
			referringURL = request.serverVariables("URL")
			referringQuery = request.serverVariables("QUERY_STRING")
			if len(Trim(referringQuery)) > 0 then 
				if global_debug then
					output_debug("* init_secure_session: Len(referringQuery) > 0; redirecting here: *")
					output_debug("* URL: " & referringURL & "?" & referringQuery & " *")
				end if
				
				referringURL = referringURL & "?" & referringQuery
				Response.Redirect(referringURL)
			elseif user_id = guest_account then
				if global_debug then output_debug("* init_secure_session: Len(referringQuery) = 0; user_id = 367 [Guest] *")
				begin_session(guest_account)
				if global_debug then output_debug("* init_secure_session: complete begin_session(guest_account) *")
			end if
		else
			if global_debug then output_debug("* init_secure_session: formSignInAction NOT ""Sign In""; show_login = true *")
			Response.Expires = -1000 'Makes the browser not cache this page
			show_login = true
		end if
	else
		dim reqUserLevel
			reqUserLevel = session("required_user_level")
		
		if len(session("noGuestHead")) > 0 and user_id = guest_account then 'no Guest code
				Response.Expires = -1000 'Makes the browser not cache this page
				show_login = true
				session_signed_in = false
		elseif len(reqUserLevel) > 0 then
			if userLevelRequired(reqUserLevel) <> true then
				Response.Expires = -1000 'Makes the browser not cache this page
				show_login = true
				session_signed_in = false
			end if	
		end if
	end if

elseif global_debug then
	output_debug("* IS Resetting password. *")
end if

%>

<!-- #INCLUDE VIRTUAL='include/core/html_styles.asp' -->
<% if global_debug then output_debug("* Finished html_styles.asp *") %>

<!-- #INCLUDE VIRTUAL='include/core/navi_top_menu.asp' -->
<% if global_debug then output_debug("* Finished navi_top_menu.asp *") %>

<%
if show_login = true then
	show_login = false
	ShowVMSLogin
	Response.End()
end if

if session("no_header") <> true then 

	response.write header_response & ie_ifs
	response.Flush()
else
	session("no_header") = false
end if 
	

if global_debug then output_debug("* Core: System init done *")

%>
